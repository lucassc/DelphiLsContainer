unit uMDContainerLinks;

interface

type
  TMDContainerLinks = class
  public
    class procedure Link;
  end;

implementation

uses
  uMDContainerSingleton, uDocumentParamsAPI, uDocumentParams,
  uStoreDocumentAPI, uStoreDocument, uStoreDocumentFactory,
  uDocumentManagerAPI, uDocumentManager, uNotifyChangeAPI, uNotifyChange;


{ TMDContainerInject }

class procedure TMDContainerLinks.Link;
begin
  TMDCSingleton.DefaultInstance.Add(IDocumentManagerAPI, TDocumentManager);
  TMDCSingleton.DefaultInstance.Add(IDocumentParamsAPI, TDocumentParams);
  TMDCSingleton.DefaultInstance.Add(IStoreDocumentAPI, TStoreDocumentFactory);
  TMDCSingleton.DefaultInstance.Add(INotifyChangeAPI, TNotifyChange);
end;

end.
