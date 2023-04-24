unit About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFormAbout = class(TForm)
    Button1: TButton;
    Image1: TImage;
    LabelVersion: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MemoInfoOS: TMemo;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation
uses MainUnit, UnitDM, RudaGlobals;
{$R *.dfm}

procedure TFormAbout.Button1Click(Sender: TObject);
begin
  FormAbout.Close;
end;

procedure TFormAbout.FormCreate(Sender: TObject);
 var BitWindows: string;
begin
  MemoInfoOS.Clear;
  if FormRudaAdmin.WinInfo(HKEY_LOCAL_MACHINE,WinVers,'ProductName') <> '' then
    MemoInfoOS.Lines.Add(FormRudaAdmin.WinInfo(HKEY_LOCAL_MACHINE,WinVers,'ProductName'));

  if FormRudaAdmin.WinInfo(HKEY_LOCAL_MACHINE,WinVers,'CSDVersion') <> '' then
    MemoInfoOS.Lines.Add(FormRudaAdmin.WinInfo(HKEY_LOCAL_MACHINE,WinVers,'CSDVersion'));

  if FormRudaAdmin.WinInfo(HKEY_LOCAL_MACHINE,WinVers,'CurrentVersion') <> '' then
    MemoInfoOS.Lines.Add('Version: ' + FormRudaAdmin.WinInfo(HKEY_LOCAL_MACHINE,WinVers,'CurrentVersion'));

  if FormRudaAdmin.WinInfo(HKEY_LOCAL_MACHINE,WinVers,'CurrentBuild') <> '' then
    MemoInfoOS.Lines.Add('Build: ' + FormRudaAdmin.WinInfo(HKEY_LOCAL_MACHINE,WinVers,'CurrentBuild'));

  if FormRudaAdmin.IsWindows64 then BitWindows:= ' 64-bit'
                       else BitWindows:= ' 32-bit';

  MemoInfoOS.Lines.Add('Windows version: ' + BitWindows + ' Edition');

  FormAbout.Caption:= FormAbout.Caption + ProgName_ShortStringVersion;
  LabelVersion.Caption:= 'Версия программ: ' + ProgName_FullStringVersion;
end;

end.
