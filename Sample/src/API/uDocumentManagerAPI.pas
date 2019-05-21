unit uDocumentManagerAPI;

interface

uses
  uDocumentParamsAPI;

type

  IDocumentManagerAPI = interface(IInvokable)
    ['{86BAC6BE-071E-4F25-A6B7-6EAC86AC471E}']
    function Save(pParams: IDocumentParamsAPI): string;
  end;

implementation

end.
