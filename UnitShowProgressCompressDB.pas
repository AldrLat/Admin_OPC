unit UnitShowProgressCompressDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TFormShowProgressCompressDB = class(TForm)
    ProgressBarCompressDB: TProgressBar;
    StaticTextCompressDB: TStaticText;
    TimerCompressDB: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure TimerCompressDBTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormShowProgressCompressDB: TFormShowProgressCompressDB;

implementation

{$R *.dfm}
uses MainUnit;

procedure TFormShowProgressCompressDB.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TimerCompressDB.Enabled:= false;
end;

procedure TFormShowProgressCompressDB.FormCreate(Sender: TObject);
begin
  with FormShowProgressCompressDB do  //чтобы она была поверх всех окон
    SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height,
        SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

  Caption:= FormRudaAdmin.Caption;
  StaticTextCompressDB.Caption:= 'Запущен процесс сжатия баз данных';
  ProgressBarCompressDB.Min:= 0;
  ProgressBarCompressDB.Max:= 5;
  ProgressBarCompressDB.Position:= 0;
  ProgressBarCompressDB.Step:= 1;
  Application.ProcessMessages;
  TimerCompressDB.Enabled:= true;
end;

procedure TFormShowProgressCompressDB.TimerCompressDBTimer(Sender: TObject);
begin
  if ProgressBarCompressDB.Position = ProgressBarCompressDB.Max then
    ProgressBarCompressDB.Position:= ProgressBarCompressDB.Min
      else ProgressBarCompressDB.StepIt;
  Application.ProcessMessages;    //надо
end;

end.
