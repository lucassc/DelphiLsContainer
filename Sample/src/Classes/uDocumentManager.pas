unit uDocumentManager;

interface

uses
  uDocumentParamsAPI, uMDContainerSingleton, uDocumentManagerAPI,
  uLS.Rtti.Attributes, uNotifyChangeAPI;

type
  TDocumentManager = class(TinterfacedObject, IDocumentManagerAPI)
  private
    FNotifyChange: INotifyChangeAPI;
  public
    function Save(pParams: IDocumentParamsAPI): string;
    [TLSInjectable()]
    procedure setNotifyChange(pNotifyChange: INotifyChangeAPI);
  end;

implementation

uses
  System.Rtti, SysUtils, uStoreDocumentAPI;

{ TDocumentManagemnt }

function TDocumentManager.Save(pParams: IDocumentParamsAPI): string;
var
  lStoreDocument: IStoreDocumentAPI;
begin
  if pParams.Content.Trim.IsEmpty then
    exit('O documento está vazio.');

  lStoreDocument := TMDCSingleton.DefaultInstance.New<IStoreDocumentAPI>
    ([TValue.From(pParams)]);

  result := lStoreDocument.Store;

  FNotifyChange.Notify(pParams.cdDocumento);
end;

procedure TDocumentManager.setNotifyChange(pNotifyChange: INotifyChangeAPI);
begin
  FNotifyChange := pNotifyChange;
end;

end.
