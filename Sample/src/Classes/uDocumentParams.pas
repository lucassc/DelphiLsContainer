unit uDocumentParams;

interface

uses
  uDocumentParamsAPI;

type
  TDocumentParams = class(TInterfacedObject, IDocumentParamsAPI)
  private
    FcdDocumento: integer;
    FIsInSecrecy: Boolean;
    FContent: string;
    function GetcdDocumento: integer;
    function GetIsInSecrecy: Boolean;
    procedure SetcdDocumento(const Value: integer);
    procedure SetIsInSecrecy(const Value: Boolean);
    function GetContent: string;
    procedure SetContent(const Value: string);
  public
    property cdDocumento: integer read GetcdDocumento write SetcdDocumento;
    property Content: string read GetContent write SetContent;
    property IsInSecrecy: Boolean read GetIsInSecrecy write SetIsInSecrecy;
  end;

implementation

{ TDocumentParameters }

function TDocumentParams.GetcdDocumento: integer;
begin
  Result := FcdDocumento;
end;

function TDocumentParams.GetContent: string;
begin
  Result := FContent;
end;

function TDocumentParams.GetIsInSecrecy: Boolean;
begin
  Result := FIsInSecrecy;
end;

procedure TDocumentParams.SetcdDocumento(const Value: integer);
begin
  FcdDocumento := Value;
end;

procedure TDocumentParams.SetContent(const Value: string);
begin
 FContent := Value ;
end;

procedure TDocumentParams.SetIsInSecrecy(const Value: Boolean);
begin
  FIsInSecrecy := Value;
end;

end.
