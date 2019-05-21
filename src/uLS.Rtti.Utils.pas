unit uLS.Rtti.Utils;

interface

uses
  System.Rtti;

type
  TLSRttyUtils = class
  public
    class function CreateInstance(pClass: TClass; pParams: TArray<TValue>): TValue;
    class function IsFactory(pClass: TClass): boolean;
    class function GetInstanceFromFactory(pClass: TClass; pParams: TArray<TValue>): TValue;

    class function IsAutoInjectMethod(pMethod: TRttiMethod): boolean;
  end;

implementation


uses
  uLS.Rtti.Attributes;

{ TLSRttyUtils }

class function TLSRttyUtils.GetInstanceFromFactory(pClass: TClass; pParams: TArray<TValue>): TValue;
var
  lFactory: TObject;
  lGetInstance: TRttiMethod;
  lRttiContext: TRttiContext;
  lRttiType: TRttiType;
begin
  lFactory := Self.CreateInstance(pClass, pParams).AsType<TObject>;
  try
    lRttiContext := TRttiContext.Create;
    lRttiType := lRttiContext.GetType(pClass);
    lGetInstance := lRttiType.AsInstance.getMethod('GetInstance');

    Result := lGetInstance.Invoke(lFactory, []);
  finally
    lFactory.Free;
  end;
end;

class function TLSRttyUtils.IsAutoInjectMethod(pMethod: TRttiMethod): boolean;
var
  lAttributes: TArray<TCustomAttribute>;
  lAttribute: TCustomAttribute;
begin
  Result := false;
  lAttributes := pMethod.GetAttributes;

  for lAttribute in lAttributes do
    if lAttribute is TLSInjectable then
      exit(true);
end;

class function TLSRttyUtils.IsFactory(pClass: TClass): boolean;
var
  lAttributes: TArray<TCustomAttribute>;
  lAttribute: TCustomAttribute;
  lRttiContext: TRttiContext;
  lRttiType: TRttiType;
begin
  lRttiContext := TRttiContext.Create;
  lRttiType := lRttiContext.GetType(pClass);

  lAttributes := lRttiType.GetAttributes;
  Result := false;
  for lAttribute in lAttributes do
    if lAttribute is TLSFactory then
      exit(true);
end;

class function TLSRttyUtils.CreateInstance(pClass: TClass; pParams: TArray<TValue>): TValue;
var
  lCreate: TRttiMethod;
  lRttiContext: TRttiContext;
  lRttiType: TRttiType;
begin
  lRttiContext := TRttiContext.Create;

  lRttiType := lRttiContext.GetType(pClass);

  lCreate := lRttiType.AsInstance.getMethod('Create');

  Result := lCreate.Invoke(pClass, pParams);
end;

end.
