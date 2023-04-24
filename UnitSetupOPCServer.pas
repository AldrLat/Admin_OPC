unit UnitSetupOPCServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormSetupOpcServer = class(TForm)
    Label1: TLabel;
    EditServerName: TEdit;
    ButtonRegisterServer: TButton;
    ButtonUnregisterServer: TButton;
    ButtonClose: TButton;
    procedure ButtonCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSetupOpcServer: TFormSetupOpcServer;

implementation

{$R *.dfm}

procedure TFormSetupOpcServer.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

end.
