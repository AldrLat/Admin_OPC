unit UnitSelectRegServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, OPCEnum;

type
  TFormRegOPCServers = class(TForm)
    Label1: TLabel;
    CheckBoxDA: TCheckBox;
    CheckBoxHDA: TCheckBox;
    ButtonOK: TButton;
    ButtonExit: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBoxDAClick(Sender: TObject);
    procedure CheckBoxHDAClick(Sender: TObject);
  private
    procedure SetEnabledButtonOK;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRegOPCServers: TFormRegOPCServers;

implementation

{$R *.dfm}

uses UnitDM, UnitSettingsWorkStation, UnitSetupOPCServer, RudaGlobals;

procedure TFormRegOPCServers.ButtonExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRegOPCServers.ButtonOKClick(Sender: TObject);
  //Если ошибка регистрации возвращает - TRUE, если нет ошибок - FALSE
  function RegistrationOPCDAServer(): boolean;
    var hProcess: THandle;
    begin
      if DM.RunAsAdmin(Handle, PathFileNameOPCDAServer, ' /regserver /OPC_DA', hProcess) then
      begin
        if hProcess <> 0 then
          if WaitForSingleObject(hProcess, 5000) <> WAIT_OBJECT_0 then
            begin
              CloseHandle(hProcess);
              Application.MessageBox(PChar('Не удалось зарегистрировать OPC-сервер "' + OPCDAUserServerName +
                        '". Истекло время ожидания на регистрацию сервера.'), 'Ошибка', MB_OK or MB_ICONERROR);
              result:= true;
            end
            else result:= false;
      end
      else
      begin
        Application.MessageBox(PChar('Ошибка регистрации OPC-сервера "' + OPCDAUserServerName + '"'),
                    'Ошибка', MB_OK or MB_ICONERROR);
        result:= true;
      end;
    end;

  //Если ошибка регистрации возвращает - TRUE, если нет ошибок - FALSE
  function RegistrationOPCHDAServer(): boolean;
    var hProcess: THandle;
  begin
    if DM.RunAsAdmin(Handle, PathFileNameOPCHDAServer, ' /regserver /OPC_HDA', hProcess) then
    begin
      if hProcess <> 0 then
        if WaitForSingleObject(hProcess, 5000) <> WAIT_OBJECT_0 then
        begin
          CloseHandle(hProcess);
          Application.MessageBox(PChar('Не удалось зарегистрировать OPC-сервер "' + OPCHDAUserServerName +
                        '". Истекло время ожидания на регистрацию сервера.'), 'Ошибка', MB_OK or MB_ICONERROR);
          result:= true;
        end
        else result:= false;
    end
    else
    begin
      Application.MessageBox(PChar('Ошибка регистрации OPC-сервера "' + OPCHDAUserServerName + '"'),
                    'Ошибка', MB_OK or MB_ICONERROR);
      result:= true;
    end;
  end;

  var tempServerName: AnsiString;
      e:TOPCEnum;
      strText: string;
      bErrDA, bErrHDA: boolean;    //TRUE - значит есть ошибка
      SrvRun: boolean;
      hProcess: THandle;
      i: integer;
      waitendprocess: boolean;
begin
  strText:= '';
  bErrDA:= false;
  bErrHDA:= false;

  if CheckBoxDA.Checked then strText:= #10#13 + '"' + OPCDAUserServerName + '"';
  if CheckBoxHDA.Checked then
    begin
      if CheckBoxDA.Checked then strText:= strText + #10#13 + '"' + OPCHDAUserServerName + '"'
                            else strText:= #10#13 + '"' + OPCHDAUserServerName + '"'
    end;

  if Application.MessageBox(PChar('Зарегистрировать OPC-сервер(ы) ' + strText + '?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      if CheckBoxDA.Checked then //регистрируем DA сервер
        if FileExists(PathFileNameOPCDAServer) then
          begin
            //проверяем запущен ли опрос
            if DM.IsRunning(FileNameRudaMonitor) then
            begin
              Application.MessageBox(PChar('Для регистрации OPCDA сервера ' +
                '"' + OPCDAUserServerName + '"' + ', необходимо закрыть программу ' +
              'Сбор и обработка данных - "' + ChangeFileExt(FileNameRudaMonitor,'') + '"!!!'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_OK or MB_ICONWARNING);
              bErrDA:= true;
//              //проверяем запущен ли сервис
//              SrvRun:= DM.ServiceRunning(nil, ServiceName);
//              //если запущен -> приостанавливаем
//              if SrvRun then DM.RunAsAdmin(Handle, 'net', 'pause ' + ServiceName, hProcess);
//              //даем команду опросу RudaMonitor завершить работу
//              DM.RebootMonitor();
//              //ожидаем завершение RudaMonitor
//              i:= 0;
//              waitendprocess:= true;
//              while DM.IsRunning(FileNameRudaMonitor) and waitendprocess do
//              begin
//                waitendprocess:= i < 20;
//                sleep(100);
//                Application.ProcessMessages();
//                inc(i);
//              end;


//              bErrDA:= RegistrationOPCDAServer();
            end
            else
            begin
              bErrDA:= RegistrationOPCDAServer();
            end;
          end
          else
          begin
            Application.MessageBox(PChar('Файл "' + PathFileNameOPCDAServer +
              '" не найден. Невозможно зарегистрировать OPC DA сервер.'),
              'Ошибка', MB_OK or MB_ICONERROR);
            bErrDA:= true;
          end;

      if CheckBoxHDA.Checked then //регистрируем HDA сервер
        if FileExists(PathFileNameOPCHDAServer) then
          begin
            bErrHDA:= RegistrationOPCHDAServer();
          end
          else
          begin
            Application.MessageBox(PChar('Файл "' + PathFileNameOPCHDAServer +
              '" не найден. Невозможно зарегистрировать OPC HDA сервер.'),
              'Ошибка', MB_OK or MB_ICONERROR);
            bErrHDA:= true;
          end;

      FormSettingsWorkStation.ReadOPCServerName;
      FormSetupOpcServer.ToolButtonRefreshListOPCServersClick(Sender);

      strText:= '';
      if (CheckBoxDA.Checked and (not bErrDA)) or (CheckBoxHDA.Checked and (not bErrHDA)) then
        begin
          if CheckBoxDA.Checked and (not bErrDA) then
            strText:= #10#13 + '"' + OPCDAUserServerName + '"';
          if CheckBoxHDA.Checked and (not bErrHDA) then
            begin
              if strText = '' then strText:= #10#13 + '"' + OPCHDAUserServerName + '"'
                              else strText:= strText + #10#13 + '"' + OPCHDAUserServerName + '"';
            end;
          if strText <> '' then
            if Application.MessageBox(PChar('СКРП OPC-сервер(ы) ' + strText + #10#13 +
               ' успешно зарегистрирован(ы).'), PChar(Caption),
               MB_OK or MB_ICONINFORMATION) = IDOK then close;
        end;

    end;

end;

procedure TFormRegOPCServers.SetEnabledButtonOK;
  begin
    ButtonOK.Enabled:= CheckBoxDA.Checked or CheckBoxHDA.Checked;
  end;

procedure TFormRegOPCServers.CheckBoxDAClick(Sender: TObject);
begin
  SetEnabledButtonOK();
end;

procedure TFormRegOPCServers.CheckBoxHDAClick(Sender: TObject);
begin
  SetEnabledButtonOK();
end;

procedure TFormRegOPCServers.FormCreate(Sender: TObject);
begin
  Caption:= ProgName_ShortStringVersion + Caption;
end;

procedure TFormRegOPCServers.FormShow(Sender: TObject);
var
  i: Integer;
  tempServerName: AnsiString;
  e:TOPCEnum;
begin
  CheckBoxDA.Enabled:= e.ProgIDFromCLSID(GUID_RudaOPCDA, tempServerName) <> S_OK;
  CheckBoxDA.Checked:= false;
  CheckBoxHDA.Enabled:= e.ProgIDFromCLSID(GUID_RudaOPCHDA, tempServerName) <> S_OK;
  CheckBoxHDA.Checked:= false;
  SetEnabledButtonOK();
end;

end.
