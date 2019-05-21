unit uStoreDocumentInSecrecy;

interface

uses
  uStoreDocumentAPI, uDocumentParamsAPI;

type
  TStoreDocumentInSecrecy = class(TinterfacedObject, IStoreDocumentAPI)
  private
    FParams: IDocumentParamsAPI;
  public
    function Store: string;
    constructor Create(pParams: IDocumentParamsAPI);
  end;

implementation

{ TStoreDocumentInSecrecy }

constructor TStoreDocumentInSecrecy.Create(pParams: IDocumentParamsAPI);
begin
  FParams := pParams;
end;

function TStoreDocumentInSecrecy.Store: string;
begin
  result := 'Arquivo salvo no servidor *******';
end;

end.
