unit UnitCreateOPCserver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TFormCreateOPCserver = class(TForm)
    EditNewServerName: TEdit;
    Label1: TLabel;
    ButtonClose: TButton;
    EditOPCVender: TEdit;
    EditOPCNameWS: TEdit;
    EditOPCVer: TEdit;
    LabelVer: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    SpeedButtonRegisterServer: TSpeedButton;
    SpeedButtonUnregisterServer: TSpeedButton;
    Label3: TLabel;
    EditGUIDNewServerName: TEdit;
    procedure FormShow(Sender: TObject);
    procedure EnterServerName;
    procedure EditOPCVenderKeyPress(Sender: TObject; var Key: Char);
    procedure EditOPCVenderChange(Sender: TObject);
    procedure EditOPCNameWSKeyPress(Sender: TObject; var Key: Char);
    procedure EditOPCNameWSChange(Sender: TObject);
    procedure EditOPCVerKeyPress(Sender: TObject; var Key: Char);
    procedure EditOPCVerChange(Sender: TObject);
    procedure SpeedButtonRegisterServerClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCreateOPCserver: TFormCreateOPCserver;

implementation

{$R *.dfm}

uses UnitSettingsWorkStation, UnitDM, comcat, OPCDA, RudaMonitor_TLB,
  UnitSetupOPCServer, OPCEnum, RudaGlobals;

procedure TFormCreateOPCserver.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCreateOPCserver.EditOPCNameWSChange(Sender: TObject);
begin
  EnterServerName;
end;

procedure TFormCreateOPCserver.EditOPCNameWSKeyPress(Sender: TObject;
  var Key: Char);
begin
  DM.CheckSpecialSymbolPressKey('"' + Label4.Caption + '"', EditOPCNameWS.Text, Key);
end;

procedure TFormCreateOPCserver.EditOPCVenderChange(Sender: TObject);
begin
  EnterServerName;
end;

procedure TFormCreateOPCserver.EditOPCVenderKeyPress(Sender: TObject;
  var Key: Char);
begin
  DM.CheckSpecialSymbolPressKey('"' + Label2.Caption + '"', EditOPCVender.Text, Key);
end;

procedure TFormCreateOPCserver.EditOPCVerChange(Sender: TObject);
begin
  EnterServerName;
end;

procedure TFormCreateOPCserver.EditOPCVerKeyPress(Sender: TObject;
  var Key: Char);
begin
  DM.CheckSpecialSymbolPressKey('"' + LabelVer.Caption + '"', EditOPCVer.Text, Key);
end;

procedure TFormCreateOPCserver.EnterServerName;
begin
  if EditOPCNameWS.Text = '' then
    EditNewServerName.Text:= EditOPCVender.Text + '.' + EditOPCVer.Text
    else EditNewServerName.Text:= EditOPCVender.Text + '.' +
                                  EditOPCNameWS.Text + '.' +
                                  EditOPCVer.Text;
  SpeedButtonRegisterServer.Enabled:= (Trim(EditOPCVender.Text) <> '') and (Trim(EditOPCVer.Text) <> '');
end;

procedure TFormCreateOPCserver.FormCreate(Sender: TObject);
begin
  Caption:= ProgName_ShortStringVersion + Caption;
end;

procedure TFormCreateOPCserver.FormShow(Sender: TObject);
begin
  SpeedButtonRegisterServer.Enabled:= false;
  EditOPCVender.Text:= ProgrammName;
  EditOPCNameWS.Text:= Trim(FormSettingsWorkStation.EditName.Text);
  EditOPCVer.Text:= ProgrammNameVerShort;
  EditGUIDNewServerName.Text:= GUIDToString(GUID_RudaOPCDA);
  EnterServerName;
end;

procedure TFormCreateOPCserver.SpeedButtonRegisterServerClick(Sender: TObject);
  var tempServerName: AnsiString;
      e:TOPCEnum;
      hProcess: THandle;
begin
  if e.ProgIDFromCLSID(GUID_RudaOPCDA, tempServerName) = S_OK then
    if tempServerName <> EditNewServerName.Text then     //для того чтобы не зарегистрировать второй сервер
      begin
        Application.MessageBox(PChar('СКРП OPC-сервер уже зарегистрирован под именем "' + tempServerName +
          '". Чтобы зарегистрировать СКРП OPC-сервер под именем "' + EditNewServerName.Text +
          '" необходимо удалить предыдущий сервер.'), 'ВНИМАНИЕ!!!', MB_OK or MB_ICONERROR);
        exit;
      end;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Path', 'RudaMonitor', asString, ParamVariant)
    then PathFileNameOPCDAServer:= ParamVariant
    else PathFileNameOPCDAServer:= FileNameOPCServer;

  if not FileExists(PathFileNameOPCDAServer) then
    begin
      Application.MessageBox(PChar('Файл "' + PathFileNameOPCDAServer +
       '" не найден. Зарегистрировать OPC сервер невозможно.'),
       'Ошибка', MB_OK or MB_ICONERROR);
      exit;
    end;

//  if not FileExists(PathApp + FileNameOPCServer) then
//    begin
//      Application.MessageBox(PChar('Файл "' + PathApp + FileNameOPCServer +
//       '" не найден. Зарегистрировать OPC сервер "' + EditNewServerName.Text +
//       '" невозможно.'), 'Ошибка', MB_OK or MB_ICONERROR);
//      exit;
//    end;

//  OPCServerName:= EditNewServerName.Text;
//  DM.WriteToRegVariant(RootKey_HKCU, SubKey, 'OPC', 'ServerName', OPCServerName);
//  CreateGUID(OPCServerGUID);
//  EditGUIDNewServerName.Text:= GUIDToString(OPCServerGUID);
//  DM.WriteToRegVariant(RootKey_HKCU, SubKey, 'OPC', 'GUID', GUIDToString(OPCServerGUID));
//  if DM.RunAsAdmin(Handle, FileNameOPCServer, EditNewServerName.Text + ' ' +
//                                              GUIDToString(CLASS_DA3) +
//                                              ' /regserver', hProcess) then
  if DM.RunAsAdmin(Handle, PathFileNameOPCDAServer, ' /regserver', hProcess) then
    begin
      if hProcess <> 0 then
        if WaitForSingleObject(hProcess, 5000) <> WAIT_OBJECT_0 then
          begin
            CloseHandle(hProcess);
            Application.MessageBox(PChar('Не удалось зарегистрировать OPC-сервера "' + EditNewServerName.Text +
              '". Истекло время ожидания на регистрацию сервера.'), 'Ошибка', MB_OK or MB_ICONERROR);
            exit;
          end;
    end
    else begin
      DM.log('Ошибка регистрации OPC-сервера "' + OPCDAServerName + '"', 0);
      exit;
    end;

//  if {RegisterTheServer(EditNewServerName.Text)} true then OPCServerName:= EditNewServerName.Text
//    else begin
//      DM.WriteToRegVariant(RootKey_HKCU, SubKey, 'OPC', 'ServerName', '');
//      DM.WriteToRegVariant(RootKey_HKCU, SubKey, 'OPC', 'GUID', '');
//    end;
//  sleep(1000); //ждем когда сервер зарегистрируется. Потом надо будет поставить WiteObject
//  OPCServerName:= EditNewServerName.Text;
  FormSettingsWorkStation.ReadOPCServerName;
  FormSetupOpcServer.ToolButtonRefreshListOPCServersClick(Sender);
end;

end.
