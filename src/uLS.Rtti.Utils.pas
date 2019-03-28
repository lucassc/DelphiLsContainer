unit uLS.Rtti.Utils;

interface

uses
  System.Rtti;

type
  TLSRttyUtils = class
  private
    class function getCreate(pClass: TClass): TRttiMethod;
  public
    class function CreateInstance<T: Constructor>: T; Overload;
    class function CreateInstance(pClass: TClass): TObject; Overload;
    class function CreateInstance<T: Constructor>(pParams: TArray<TValue>): T; Overload;
    class function CreateInstance(pClass: TClass; pParams: TArray<TValue>): TObject; Overload;
  end;

implementation


{ TLSRttyUtils }

class function TLSRttyUtils.CreateInstance<T>(pParams: TArray<TValue>): T;
var
  lClass: TClass;
  lCreate: TRttiMethod;
begin
  lClass := TypeInfo(T);

  lCreate := Self.getCreate(lClass);
  Result := lCreate.Invoke(lClass, pParams).AsType<T>;

end;

class function TLSRttyUtils.getCreate(pClass: TClass): TRttiMethod;
var
  lRttiContext: TRttiContext;
  lRttiType: TRttiType;
begin
  lRttiContext := TRttiContext.Create;

  lRttiType := lRttiContext.GetType(pClass);

  Result := lRttiType.AsInstance.GetMethod('Create');
end;

class function TLSRttyUtils.CreateInstance<T>: T;
begin
  Result := Self.CreateInstance<T>([]);
end;

class function TLSRttyUtils.CreateInstance(pClass: TClass): TObject;
begin
  Result := Self.CreateInstance(pClass, []);
end;

class function TLSRttyUtils.CreateInstance(pClass: TClass; pParams: TArray<TValue>): TObject;
var
  lCreate: TRttiMethod;
begin
  lCreate := Self.getCreate(pClass);
  Result := lCreate.Invoke(pClass, pParams).AsType<TObject>;

end;

end.
