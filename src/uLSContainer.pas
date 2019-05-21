unit uLSContainer;

interface

uses
  System.Rtti, System.Generics.Collections;

type
  TLSContainer = class(TInterfacedobject)
  private
    FClasses: TDictionary<TGUID, TClass>;
    FInstances: TDictionary<TGUID, IInterface>;
    FNewLikeGetInstance: Boolean;
    procedure InjectDependencies(pInstance: TObject);
    procedure InjectDependency(pInstance: TObject; pMethod: TRttiMethod);
  public
    procedure Add<T: IInterface>(pInstance: T); Overload;
    procedure Add(pInterface: TGUID; pClass: TClass); Overload;

    function New<T: IInterface>: T; Overload;
    function New<T: IInterface>(pParams: TArray<TValue>): T; Overload;

    function GetInstance<T: IInterface>: T;

    Constructor Create;
    destructor Destroy; override;

    property NewAsGetInstance: Boolean read FNewLikeGetInstance write FNewLikeGetInstance;
  end;

implementation

uses
  System.TypInfo, uLS.Rtti.Utils, uLS.Rtti.Attributes;

{ TLSContainer }

procedure TLSContainer.Add<T>(pInstance: T);
begin
  FInstances.AddOrSetValue(GetTypeData(TypeInfo(T))^.Guid, pInstance);
end;

constructor TLSContainer.Create;
begin
  FClasses := TDictionary<TGUID, TClass>.Create;
  FInstances := TDictionary<TGUID, IInterface>.Create;
end;

destructor TLSContainer.Destroy;
begin
  FClasses.Free;
  FInstances.Free;
  inherited;
end;

function TLSContainer.GetInstance<T>: T;
var
  lGUID: TGUID;
  lInstance: IInterface;
begin
  lGUID := GetTypeData(TypeInfo(T))^.Guid;
  if not FInstances.TryGetValue(lGUID, lInstance) then
  begin
    lInstance := Self.New<T>([]);
    FInstances.Add(lGUID, lInstance);
  end;
  Result := T(lInstance);
end;

function TLSContainer.New<T>: T;
begin
  Result := Self.New<T>([]);
end;

procedure TLSContainer.Add(pInterface: TGUID; pClass: TClass);
begin
  FClasses.Add(pInterface, pClass);
end;

function TLSContainer.New<T>(pParams: TArray<TValue>): T;
var
  lClass: TClass;
  lIsFactory: Boolean;
  lInstance: TValue;
begin
  if FNewLikeGetInstance then
    exit(Self.GetInstance<T>);

  lClass := FClasses.Items[GetTypeData(TypeInfo(T))^.Guid];

  lIsFactory := TLSRttyUtils.IsFactory(lClass);

  if lIsFactory then
    exit(TLSRttyUtils.GetInstanceFromFactory(lClass, pParams).AsType<T>);

  lInstance := TLSRttyUtils.CreateInstance(lClass, pParams);

  InjectDependencies(lInstance.AsType<TObject>);

  Result := lInstance.AsType<T>
end;

procedure TLSContainer.InjectDependencies(pInstance: TObject);
var
  lRttiContext: TRttiContext;
  lRttiType: TRttiType;
  lMethods: TArray<TRttiMethod>;

  lMethod: TRttiMethod;
begin
  lRttiContext := TRttiContext.Create;
  lRttiType := lRttiContext.GetType(pInstance.ClassType);

  lMethods := lRttiType.GetMethods;
  for lMethod in lMethods do
    if TLSRttyUtils.IsAutoInjectMethod(lMethod) then
      InjectDependency(pInstance, lMethod);
end;

procedure TLSContainer.InjectDependency(pInstance: TObject; pMethod: TRttiMethod);
var
  lParams: TArray<TRttiParameter>;
  lClasse: TClass;
  lNewParam: TValue;
  lGUID: TGUID;
begin
  lParams := pMethod.GetParameters;
  lGUID := GetTypeData(lParams[0].ParamType.Handle)^.Guid;
  lClasse := FClasses.Items[lGUID];

  lNewParam := TLSRttyUtils.CreateInstance(lClasse, []);
  pMethod.Invoke(pInstance, [lNewParam]);

  InjectDependencies(lNewParam.AsType<TObject>);
end;

end.
