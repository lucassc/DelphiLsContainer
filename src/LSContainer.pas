unit LSContainer;

interface

uses
  System.Rtti, System.Generics.Collections;

type

  TLSContainer = class(TInterfacedobject)
  private
    FClasses: TDictionary<TGUID, TClass>;
    FInstances: TDictionary<TGUID, IInterface>;
  public
    procedure Add(pInterface: TGUID; pClass: TClass); Overload;
    procedure Add<T: IInterface>(pInstance: T); Overload;

    function New<T: IInterface>: T; Overload;
    function New<T: IInterface>(pParams: TArray<TValue>): T; Overload;

    function GetInstance<T: IInterface>: T;

    Constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  System.TypInfo, uLS.Rtti.Utils;

{ TLSContainer }

procedure TLSContainer.Add<T>(pInstance: T);
begin
  FInstances.Add(GetTypeData(TypeInfo(T))^.Guid, pInstance);
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
    lInstance := self.New<T>([]);
    FInstances.Add(lGUID, lInstance);
  end;
  //Result := T((@lInstance)^);
 Result:= T(lInstance);
end;

function TLSContainer.New<T>: T;
begin
  Result := self.New<T>([]);
end;

procedure TLSContainer.Add(pInterface: TGUID; pClass: TClass);
begin
  FClasses.Add(pInterface, pClass);
end;

function TLSContainer.New<T>(pParams: TArray<TValue>): T;
var
  lRttiContext: TRttiContext;
  lClass: TClass;
  lRttiType: TRttiType;
  lCreate: TRttiMethod;
begin
{$MESSAGE warn 'Subtiruir pela implementacao em uLS.Rtti.Utils'}
  lRttiContext := TRttiContext.Create;
  lClass := FClasses.Items[GetTypeData(TypeInfo(T))^.Guid];

  lRttiType := lRttiContext.GetType(lClass.ClassInfo);

  lCreate := lRttiType.AsInstance.GetMethod('Create');

  Result := lCreate.Invoke(lClass, pParams).AsType<T>;

end;


 //TLSOrmContainer.Instance.Container.Add(ILSOrmCommandSQL, TLSOrmFireBirdSQL);

end.
