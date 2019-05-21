program MeetupDelphi;

uses
  Vcl.Forms,
  fMeetupDelphi in 'fMeetupDelphi.pas' {Form2},
  uMDContainerSingleton in 'Classes\uMDContainerSingleton.pas',
  uMDContainerLinks in 'Classes\uMDContainerLinks.pas',
  uDocumentManager in 'Classes\uDocumentManager.pas',
  uDocumentParamsAPI in 'API\uDocumentParamsAPI.pas',
  uDocumentParams in 'Classes\uDocumentParams.pas',
  uStoreDocumentAPI in 'API\uStoreDocumentAPI.pas',
  uStoreDocument in 'Classes\uStoreDocument.pas',
  uStoreDocumentFactory in 'Classes\uStoreDocumentFactory.pas',
  uStoreDocumentInSecrecy in 'Classes\uStoreDocumentInSecrecy.pas',
  uDocumentManagerAPI in 'API\uDocumentManagerAPI.pas',
  uNotifyChangeAPI in 'API\uNotifyChangeAPI.pas',
  uNotifyChange in 'Classes\uNotifyChange.pas',
  uLS.Rtti.Attributes in '..\..\src\uLS.Rtti.Attributes.pas',
  uLS.Rtti.Utils in '..\..\src\uLS.Rtti.Utils.pas',
  uLSContainer in '..\..\src\uLSContainer.pas';

{$R *.res}

begin
  Application.Initialize;
  TMDContainerLinks.Link();
  ReportMemoryLeaksOnShutdown := true;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMeetupDelphi, frmMeetupDelphi);
  Application.Run;
end.
