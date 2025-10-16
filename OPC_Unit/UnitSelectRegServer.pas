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
  private
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
  var tempServerName: AnsiString;
      e:TOPCEnum;
      hProcess: THandle;
      strText: string;
      bErrDA, bErrHDA: boolean;    //TRUE - значит есть ошибка
begin
  if (not CheckBoxDA.Checked) and (not CheckBoxHDA.Checked) then
    begin
      Application.MessageBox(PChar('Для регистрации нет выбранного сервера.'),
                             PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'),
                             MB_OK + MB_ICONERROR);
      exit;
    end;

  strText:= '';
  if CheckBoxDA.Checked then strText:= '"' + OPCDAUserServerName + '"';
  if CheckBoxHDA.Checked then
    begin
      if CheckBoxDA.Checked then strText:= strText + ' и "' + OPCHDAUserServerName + '"'
                            else strText:= '"' + OPCHDAUserServerName + '"'
    end;

  if Application.MessageBox(PChar('Зарегистрировать OPC-сервер(ы) ' + strText + '?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      //для того чтобы не зарегистрировать второй сервер
      strText:= '';
      bErrDA:= false;
      bErrHDA:= false;

      if CheckBoxDA.Checked and (e.ProgIDFromCLSID(GUID_RudaOPCDA, tempServerName) = S_OK) then
        begin
          strText:= 'СКРП OPC DA - сервер уже зарегистрирован.' + #10#13;
          bErrDA:= true;
        end;

      if CheckBoxHDA.Checked and (e.ProgIDFromCLSID(GUID_RudaOPCHDA, tempServerName) = S_OK) then
        begin
          strText:= strText + 'СКРП OPC HDA - сервер уже зарегистрирован.' + #10#13;
          bErrHDA:= true;
        end;

      if strText <> '' then
        begin
          Application.MessageBox(PChar(strText +
            'Чтобы перерегистрировать СКРП OPC-сервер(ы) необходимо удалить предыдущий(е) сервер(ы).'),
            'ВНИМАНИЕ!!!', MB_OK or MB_ICONERROR);
        end;

      if CheckBoxDA.Checked and (not bErrDA) then //регистрируем DA сервер
        if FileExists(PathFileNameOPCDAServer) then
          begin
            if DM.RunAsAdmin(Handle, PathFileNameOPCDAServer, ' /regserver /OPC_DA', hProcess) then
              begin
                if hProcess <> 0 then
                  if WaitForSingleObject(hProcess, 5000) <> WAIT_OBJECT_0 then
                    begin
                      CloseHandle(hProcess);
                      Application.MessageBox(PChar('Не удалось зарегистрировать OPC-сервер "' + OPCDAUserServerName +
                        '". Истекло время ожидания на регистрацию сервера.'), 'Ошибка', MB_OK or MB_ICONERROR);
                    end;
              end
              else begin
                Application.MessageBox(PChar('Ошибка регистрации OPC-сервера "' + OPCDAUserServerName + '"'),
                    'Ошибка', MB_OK or MB_ICONERROR);
              end;
          end
          else begin
            Application.MessageBox(PChar('Файл "' + PathFileNameOPCDAServer +
              '" не найден. Невозможно зарегистрировать OPC DA сервер.'),
              'Ошибка', MB_OK or MB_ICONERROR);
          end;

      if CheckBoxHDA.Checked and (not bErrHDA) then //регистрируем HDA сервер
        if FileExists(PathFileNameOPCHDAServer) then
          begin
            if DM.RunAsAdmin(Handle, PathFileNameOPCHDAServer, ' /regserver /OPC_HDA', hProcess) then
              begin
                if hProcess <> 0 then
                  if WaitForSingleObject(hProcess, 5000) <> WAIT_OBJECT_0 then
                    begin
                      CloseHandle(hProcess);
                      Application.MessageBox(PChar('Не удалось зарегистрировать OPC-сервер "' + OPCHDAUserServerName +
                        '". Истекло время ожидания на регистрацию сервера.'), 'Ошибка', MB_OK or MB_ICONERROR);
                    end;
              end
              else begin
                Application.MessageBox(PChar('Ошибка регистрации OPC-сервера "' + OPCHDAUserServerName + '"'),
                    'Ошибка', MB_OK or MB_ICONERROR);
              end;
          end
          else begin
            Application.MessageBox(PChar('Файл "' + PathFileNameOPCHDAServer +
              '" не найден. Невозможно зарегистрировать OPC HDA сервер.'),
              'Ошибка', MB_OK or MB_ICONERROR);
          end;

      FormSettingsWorkStation.ReadOPCServerName;
      FormSetupOpcServer.ToolButtonRefreshListOPCServersClick(Sender);

      strText:= '';
      if (CheckBoxDA.Checked and (not bErrDA)) or (CheckBoxHDA.Checked and (not bErrHDA)) then
        begin
          if CheckBoxDA.Checked and (not bErrDA) then
            strText:= '"' + OPCDAUserServerName + '"';
          if CheckBoxHDA.Checked and (not bErrHDA) then
            begin
              if strText = '' then strText:= '"' + OPCHDAUserServerName + '"'
                              else strText:= strText + ' и "' + OPCHDAUserServerName + '"';
            end;
          if strText <> '' then
            if Application.MessageBox(PChar('СКРП OPC-сервер(ы) ' + strText +
               ' успешно зарегистрирован(ы).'), PChar(Caption),
               MB_OK or MB_ICONINFORMATION) = IDOK then close;
        end;

    end;

end;

procedure TFormRegOPCServers.FormCreate(Sender: TObject);
begin
  Caption:= ProgName_ShortStringVersion + Caption;
end;

end.
