unit uStoreDocument;

interface

uses
  uStoreDocumentAPI, uDocumentParamsAPI;

type
  TStoreDocument = class(TinterfacedObject, IStoreDocumentAPI)
  private
    FParams: IDocumentParamsAPI;
  public
    function Store: string;
    constructor Create(pParams: IDocumentParamsAPI);
  end;

implementation

{ TStoreDocument }

constructor TStoreDocument.Create(pParams: IDocumentParamsAPI);
begin
  FParams := pParams;
end;

function TStoreDocument.Store: string;
begin
  result := 'Arquivo salvo no servidor 154.545.44.66';
end;

end.
