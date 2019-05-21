unit uMDContainerSingleton;

interface

uses
  uLSContainer;

type
  TMDCSingleton = class(TLSContainer)
  private
    class var FDefault: TMDCSingleton;
    class function GetDefaultIntance: TMDCSingleton; static;

  public
    class property DefaultInstance: TMDCSingleton read GetDefaultIntance;
    class Destructor Destroy;
  end;

implementation

{ TMDContainerSingleton }

class function TMDCSingleton.GetDefaultIntance: TMDCSingleton;
begin
  if not assigned(FDefault) then
    FDefault := TMDCSingleton.Create;

  result := FDefault;
end;

class destructor TMDCSingleton.Destroy;
begin
  FDefault.Free;
end;

end.
