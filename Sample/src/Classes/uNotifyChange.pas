unit uNotifyChange;

interface

uses
  uNotifyChangeAPI;

type

  TNotifyChange = class(TInterfacedObject, INotifyChangeAPI)
  public
    procedure Notify(const oCdDocumento: Integer);
  end;

implementation

{ TNotifyChange }

procedure TNotifyChange.Notify(const oCdDocumento: Integer);
begin
  /// Notificar aqui a  mudança do arquivo
end;

end.
