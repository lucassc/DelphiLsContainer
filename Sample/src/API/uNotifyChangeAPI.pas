unit uNotifyChangeAPI;

interface

type
  INotifyChangeAPI = interface(IInvokable)
    ['{F038F3A5-C312-4826-9467-CB1F5F4B2072}']
    procedure Notify(const oCdDocumento: Integer);
  end;

implementation

end.
