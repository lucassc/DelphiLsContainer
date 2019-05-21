unit uMDContainerLinksTest;

interface

type
  TMDContainerLinksTest = class
  public
    class procedure Link;
  end;

implementation

uses
  uMDContainerSingleton, uDocumentParamsAPI, uStoreDocumentAPI, System.Rtti;

{ TMDContainerInject }

class procedure TMDContainerLinksTest.Link;
begin
  TMDCSingleton.DefaultInstance.NewAsGetInstance := True;

  TMDCSingleton.DefaultInstance.Add<IDocumentParamsAPI>
    (TVirtualInterface.Create(TypeInfo(IDocumentParamsAPI), nil) as IDocumentParamsAPI);

  TMDCSingleton.DefaultInstance.Add<IStoreDocumentAPI>
    (TVirtualInterface.Create(TypeInfo(IStoreDocumentAPI), nil) as IStoreDocumentAPI);
end;

end.
