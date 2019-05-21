object frmMeetupDelphi: TfrmMeetupDelphi
  Left = 0
  Top = 0
  Caption = 'documento'
  ClientHeight = 367
  ClientWidth = 627
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnSave: TButton
    Left = 544
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object memContent: TMemo
    Left = 8
    Top = 8
    Width = 611
    Height = 322
    TabOrder = 1
  end
  object cbSecrecy: TCheckBox
    Left = 8
    Top = 340
    Width = 137
    Height = 17
    Caption = 'Documento em sigilo'
    TabOrder = 2
  end
end
