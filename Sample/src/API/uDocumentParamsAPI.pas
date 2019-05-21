unit uDocumentParamsAPI;

interface

type
  IDocumentParamsAPI = interface(IInvokable)
    ['{5FD5DBE9-2F12-4B1D-87D5-BE6F534C8602}']
    function GetcdDocumento: integer;
    function GetIsInSecrecy: Boolean;
    procedure SetcdDocumento(const Value: integer);
    procedure SetIsInSecrecy(const Value: Boolean);
        function GetContent: string;
    procedure SetContent(const Value: string);

    property cdDocumento: integer read GetcdDocumento write SetcdDocumento;
    property Content: string read GetContent write SetContent;
    property IsInSecrecy: Boolean read GetIsInSecrecy write SetIsInSecrecy;
  end;

implementation

end.
