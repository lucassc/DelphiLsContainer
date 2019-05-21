unit uStoreDocumentFactory;

interface

uses
  uDocumentParamsAPI, uStoreDocumentAPI, uLS.Rtti.Attributes;

type

  [TLSFactory()]
  TStoreDocumentFactory = class
  private
    FParams: IDocumentParamsAPI;
  public

    constructor Create(pParams: IDocumentParamsAPI);
    function GetInstance: IStoreDocumentAPI;
  end;

implementation

uses
  uStoreDocumentInSecrecy, uStoreDocument;

{ TStoreDocumentFactory }

function TStoreDocumentFactory.GetInstance: IStoreDocumentAPI;
begin
  if FParams.IsInSecrecy then
    exit(TStoreDocumentInSecrecy.Create(FParams));

  exit(TStoreDocument.Create(FParams))
end;

constructor TStoreDocumentFactory.Create(pParams: IDocumentParamsAPI);
begin
  FParams := pParams;
end;

end.
