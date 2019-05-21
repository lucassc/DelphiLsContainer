unit fMeetupDelphi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmMeetupDelphi = class(TForm)
    btnSave: TButton;
    memContent: TMemo;
    cbSecrecy: TCheckBox;
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMeetupDelphi: TfrmMeetupDelphi;

implementation

uses
  uMDContainerSingleton, uDocumentParamsAPI, uDocumentManagerAPI;

{$R *.dfm}


procedure TfrmMeetupDelphi.btnSaveClick(Sender: TObject);
var
  lDocumentManager: IDocumentManagerAPI;
  lDocumentParams: IDocumentParamsAPI;
begin
  lDocumentParams := TMDCSingleton.DefaultInstance.new<IDocumentParamsAPI>;
  lDocumentParams.Content := memContent.Lines.Text;
  lDocumentParams.IsInSecrecy := cbSecrecy.Checked;

  lDocumentManager := TMDCSingleton.DefaultInstance.new<IDocumentManagerAPI>;
  ShowMessage(lDocumentManager.Save(lDocumentParams));
end;

end.
