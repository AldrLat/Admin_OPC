unit UnitSettingsWorkStation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, FileCtrl, Vcl.Samples.Spin, ThreadConnectNetSQL, DateUtils;

type
  TFormSettingsWorkStation = class(TForm)
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ButtonClose: TButton;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EditInt: TEdit;
    EditSaveSec: TEdit;
    EditSaveMin: TEdit;
    EditOffsetRun: TEdit;
    EditPercent: TEdit;
    GroupBox1: TGroupBox;
    CheckBoxChangePasswordUser: TCheckBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EditConfirmNewPassword: TEdit;
    EditNewPassword: TEdit;
    EditOldPassword: TEdit;
    BitBtnEyePassword: TBitBtn;
    LabelKeyboardLayout: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    CheckBoxStoryMin: TCheckBox;
    CheckBoxStoryHour: TCheckBox;
    CheckBoxAdjustmentZero: TCheckBox;
    CheckBoxResetOptions: TCheckBox;
    EditPathLog: TEdit;
    Label8: TLabel;
    ButtonPathLog: TButton;
    EditName: TEdit;
    TimerNameLang: TTimer;
    Label2: TLabel;
    ComboBoxTypeControllers: TComboBox;
    GroupBox4: TGroupBox;
    GroupBox10: TGroupBox;
    PageControlReservation: TPageControl;
    TabSheet_DBF: TTabSheet;
    Label9: TLabel;
    Label14: TLabel;
    RadioGroupWeightPeriodDBF: TRadioGroup;
    EditArch: TEdit;
    GroupBox5: TGroupBox;
    CheckBoxReservDBF: TCheckBox;
    CheckBoxReservHourDBF: TCheckBox;
    TabSheet_TXT: TTabSheet;
    Label16: TLabel;
    Label17: TLabel;
    EditPathReservTXT: TEdit;
    RadioGroupWeightPeriodTXT: TRadioGroup;
    ButtonPathReservTXT: TButton;
    GroupBox7: TGroupBox;
    CheckBoxReservTXT: TCheckBox;
    CheckBoxReservHourTXT: TCheckBox;
    TabSheet_SQL: TTabSheet;
    Label18: TLabel;
    Label20: TLabel;
    RadioGroupWeightPeriodSQL: TRadioGroup;
    EditDsnSQL: TEdit;
    BitBtnConnectRudaSQL: TBitBtn;
    GroupBox6: TGroupBox;
    CheckBoxReservSQL: TCheckBox;
    CheckBoxReservHourSQL: TCheckBox;
    TabSheet_OPC: TTabSheet;
    Label32: TLabel;
    Label33: TLabel;
    GroupBox11: TGroupBox;
    CheckBoxReservOPC: TCheckBox;
    CheckBoxReservHourOPC: TCheckBox;
    RadioGroupWeightPeriodOPC: TRadioGroup;
    ButtonSetupOPCserver: TButton;
    EditServerName: TEdit;
    Label15: TLabel;
    EditNetInterval: TEdit;
    SpinEditTimeTestConnection: TSpinEdit;
    Label34: TLabel;
    SpeedButtonTestConnection: TSpeedButton;
    TimerConnectNetSQL: TTimer;
    Label25: TLabel;
    EditUserSQL: TEdit;
    EditPasswordSQL: TEdit;
    Label26: TLabel;
    BitBtnEyePasswordSQL: TBitBtn;
    LabelKeyboardLayoutSQL: TLabel;
    BitBtnStopConnectRudaSQL: TBitBtn;
    GroupBox8: TGroupBox;
    CheckBoxAutoOffStart: TCheckBox;
    EditTimeOffStart: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBoxChangePasswordUserClick(Sender: TObject);
    procedure DBFEnabled(param: boolean);
    procedure TimerNameLangTimer(Sender: TObject);
    procedure BitBtnEyePasswordMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtnEyePasswordMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonPathLogClick(Sender: TObject);
    procedure ButtonPathReservTXTClick(Sender: TObject);
    procedure EditNumPortKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSaveClick(Sender: TObject);
    procedure SaveDataInBD;
    procedure EditIntKeyPress(Sender: TObject; var Key: Char);
    procedure EditSaveSecKeyPress(Sender: TObject; var Key: Char);
    procedure EditSaveMinKeyPress(Sender: TObject; var Key: Char);
    procedure EditOffsetRunKeyPress(Sender: TObject; var Key: Char);
    procedure EditPercentKeyPress(Sender: TObject; var Key: Char);
    procedure EditNetIntervalKeyPress(Sender: TObject; var Key: Char);
    procedure EditNameKeyPress(Sender: TObject; var Key: Char);
    procedure EditArchKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxReservTXTClick(Sender: TObject);
    procedure CheckBoxReservHourTXTClick(Sender: TObject);
    procedure ConnectDBSQL;
    procedure CheckBoxReservSQLClick(Sender: TObject);
    procedure CheckBoxReservHourSQLClick(Sender: TObject);
    procedure EditDsnSQLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ClearAllData;
    procedure ButtonCloseClick(Sender: TObject);
    procedure EditPathLogChange(Sender: TObject);
    procedure BitBtnConnectRudaSQLClick(Sender: TObject);
    procedure EditDsnSQLKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSetupOPCserverClick(Sender: TObject);
    procedure EditServerNameChange(Sender: TObject);
    procedure ReadOPCServerName;
    procedure FormActivate(Sender: TObject);
    procedure CheckBoxReservOPCClick(Sender: TObject);
    procedure CheckBoxReservHourOPCClick(Sender: TObject);
    procedure SpeedButtonTestConnectionClick(Sender: TObject);
    procedure SpinEditTimeTestConnectionChange(Sender: TObject);
    procedure ChangeDataTrue(Sender: TObject);  //событие Change:= true;
    procedure ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
    procedure SettingDefaultFields();
    procedure TimerConnectNetSQLTimer(Sender: TObject);
    procedure BitBtnEyePasswordSQLMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BitBtnEyePasswordSQLMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GetSecondStringConnectSQL;
    procedure EditDsnSQLChange(Sender: TObject);
    procedure BitBtnStopConnectRudaSQLClick(Sender: TObject);
    procedure StopThreadConnectNetSQL;
    procedure ThreadTerminate(Sender: TObject);
    procedure EditTimeOffStartKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxAutoOffStartClick(Sender: TObject);

  private
    { Private declarations }

    

    var
    ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                            //измененные данные записать в базу данных
    FOnceActivated: boolean;  //форма первоначально создана и запущена
  public
    { Public declarations }
  end;
const
  TestConnectionHintEnabled = 'Отключить режим "Настройка передачи данных контролируемых'#13'параметров во внешние интерфейсы"';
  TestConnectionHintDisable = 'Включить режим "Настройка передачи данных контролируемых'#13'параметров во внешние интерфейсы"';
var
  FormSettingsWorkStation: TFormSettingsWorkStation;
  dCode: variant;
  UserPassword: string;
  TxtForEditDsnSQL, TxtForMsg: string;
  ErrConnectNetSQL: boolean = false;    //ошибка соединения с SQL Server
  PressButtonBitBtnConnectRudaSQL: boolean; //нажата кнопка проверки соединения с SQL Server
  ThreadConnectNetSQL: ConnectNetSQL;
  StartTime: TDateTime;
  DSNConnectSQL: string;

implementation

{$R *.dfm}

uses UnitDM, UnitSetupOPCServer, RudaMonitor_TLB, OPCEnum, RudaGlobals,
  MainUnit;

procedure TFormSettingsWorkStation.BitBtnConnectRudaSQLClick(Sender: TObject);
begin
  BitBtnConnectRudaSQL.Enabled:= false;
  BitBtnStopConnectRudaSQL.Enabled:= true;
  PressButtonBitBtnConnectRudaSQL:= true;
  ConnectDBSQL;
end;

procedure TFormSettingsWorkStation.BitBtnEyePasswordMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      EditOldPassword.PasswordChar:= #0;
      EditNewPassword.PasswordChar:= #0;
      EditConfirmNewPassword.PasswordChar:= #0;
    end;
end;

procedure TFormSettingsWorkStation.BitBtnEyePasswordMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      EditOldPassword.PasswordChar:= Char('*');
      EditNewPassword.PasswordChar:= Char('*');
      EditConfirmNewPassword.PasswordChar:= Char('*');
    end;
end;

procedure TFormSettingsWorkStation.BitBtnEyePasswordSQLMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    EditPasswordSQL.PasswordChar:= #0;
end;

procedure TFormSettingsWorkStation.BitBtnEyePasswordSQLMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    EditPasswordSQL.PasswordChar:= Char('*');
end;

procedure TFormSettingsWorkStation.StopThreadConnectNetSQL;   //остановить поток проверки подключения к SQL серверу
begin
  if ThreadConnectNetSQL <> nil then
    begin
      try
        ThreadConnectNetSQL.Terminate;   //удаляем нежно поток подключения к SQL серверу
      except
        TerminateThread(ThreadConnectNetSQL.Handle, 0);    //если не удалось удалить нежно, удаляем жестко
//        ThreadConnectNetSQL.Free;
//        ThreadConnectNetSQL:= nil;
      end;


//      TimerConnectNetSQL.Enabled:= false;
    end;
end;

procedure TFormSettingsWorkStation.BitBtnStopConnectRudaSQLClick(
  Sender: TObject);
begin
  StopThreadConnectNetSQL;
end;

procedure TFormSettingsWorkStation.ButtonPathReservTXTClick(Sender: TObject);
  var chosenDirectory : string;
begin
  if Trim(EditPathReservTXT.Text) = '' then chosenDirectory:= PathApp
                                 else chosenDirectory:= EditPathReservTXT.Text;

  if SelectDirectory(ProgName_ShortStringVersion + ' Выберите каталог', '', chosenDirectory, [sdNewFolder, sdNewUI]) then
    begin
      EditPathReservTXT.Text:= chosenDirectory;
      ProcedureChangeData;
    end;
end;

procedure TFormSettingsWorkStation.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

procedure TFormSettingsWorkStation.ButtonSetupOPCserverClick(Sender: TObject);
begin
  FormSetupOpcServer.ShowModal;
end;

procedure TFormSettingsWorkStation.SaveDataInBD;
  var PrintLog, Interval: integer;
      sReservWeight, sReservTxtWeight, sReservOPCWeight, sSqlWeight: string;
      Sender: TObject;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Сохранить значения для рабочей станции: "' +
                                  EditName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if Trim(EditName.Text) = '' then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                 Copy(Label1.Caption, 1 ,Length(Label1.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditName.SetFocus;
          exit;
        end;

      if ComboBoxTypeControllers.ItemIndex < 0 then
        begin
          Application.MessageBox(PChar('Не выбран тип контроллера с которым будет работать станция.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          ComboBoxTypeControllers.SetFocus;
          exit;
        end;

      if (not CheckNumeric(EditInt.Text)) or (StrToInt(EditInt.Text) < 3) then
        begin
          Application.MessageBox(PChar('Некорректные данные при вводе интервала опроса.' + #10#13 +
                                       'Значение должно быть больше 2.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditInt.SetFocus;
          exit;
        end;

      if (not CheckNumeric(EditSaveSec.Text)) or (StrToInt(EditSaveSec.Text) > 16) then
        begin
          Application.MessageBox(PChar('Некорректные данные в поле "Хранить мгновенные значения сигналов".' + #10#13 +
                                       'Значение должно быть в диапазоне от 0 до 16.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditSaveSec.SetFocus;
          exit;
        end;

      if (not CheckNumeric(EditSaveMin.Text)) or (StrToInt(EditSaveMin.Text) > 8) then
        begin
          Application.MessageBox(PChar('Некорректные данные в поле "Хранить среднеминутные значения сигналов".' + #10#13 +
                                       'Значение должно быть в диапазоне от 0 до 8.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditSaveMin.SetFocus;
          exit;
        end;

      if (not CheckNumeric(EditTimeOffStart.Text)) or (StrToInt(EditTimeOffStart.Text) > 10) then
        begin
          Application.MessageBox(PChar('Некорректные данные в поле "Отключить "Режим отбора проб".'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditTimeOffStart.SetFocus;
          exit;
        end;

      if not CheckNumeric(EditOffsetRun.Text) then
        begin
          Application.MessageBox(PChar('Некорректные данные в поле "Смещение сменной перенастройки".'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditOffsetRun.SetFocus;
          exit;
        end;

      if (not CheckNumeric(EditPercent.Text)) or
          (StrToInt(EditPercent.Text) < 10) or (StrToInt(EditPercent.Text) > 100) then
        begin
          Application.MessageBox(PChar('Некорректные данные в поле "Критерий достоверности".' + #10#13 +
                                       'Значение должно в диапазоне от 10 до 100.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditPercent.SetFocus;
          exit;
        end;

      if (CheckBoxReservDBF.Checked or CheckBoxReservTXT.Checked or CheckBoxReservSQL.Checked or
          CheckBoxReservOPC.Checked) and (not CheckNumeric(EditNetInterval.Text)) then
        begin
          Application.MessageBox(PChar('Не задан интервал резервирования данных минутных значений.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditNetInterval.SetFocus;
          exit;
        end;

      PrintLog:= 0;
      if CheckBoxAdjustmentZero.Checked then PrintLog:= DM.BitOn(PrintLog, 0);
      if CheckBoxResetOptions.Checked then PrintLog:= DM.BitOn(PrintLog, 1);

      case RadioGroupWeightPeriodDBF.ItemIndex of
        0: sReservWeight:= 'false';
        1: sReservWeight:= 'true';
      end;

      case RadioGroupWeightPeriodTXT.ItemIndex of
        0: sReservTxtWeight:= 'false';
        1: sReservTxtWeight:= 'true';
      end;

      case RadioGroupWeightPeriodSQL.ItemIndex of
        0: sSqlWeight:= 'false';
        1: sSqlWeight:= 'true';
      end;

      case RadioGroupWeightPeriodOPC.ItemIndex of
        0: sReservOPCWeight:= 'false';
        1: sReservOPCWeight:= 'true';
      end;

      Interval:= StrToInt(Trim(EditInt.Text));
      if CheckBoxStoryMin.Checked  then Interval:= DM.BitOn(Interval, 7); //$80
      if CheckBoxStoryHour.Checked then Interval:= DM.BitOn(Interval, 8); //$100

      if CheckBoxChangePasswordUser.Checked then
        begin
          //получаем пароль пользователя
          if dCode <> 0 then   //если не новая рабочая станция
            begin
              if EditOldPassword.Text <> UserPassword then
                begin
                  Application.MessageBox(PChar('Ошибка ввода пароля для пользователя: "' + UserName + '".' + #10#13 +
                                               'Неверно указан старый пароль.'),
                            PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'),
                            MB_OK + MB_ICONERROR);
                  EditOldPassword.SetFocus;
                  exit;
                end;
            end;

          if Trim(EditNewPassword.Text) = Trim(EditConfirmNewPassword.Text) then
            begin
              UserPassword:= Trim(EditNewPassword.Text);
            end
            else begin
              Application.MessageBox(PChar('Не совпадает новый пароль с его подтверждением.' ),
                            PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'),
                            MB_OK + MB_ICONERROR);
              EditNewPassword.SetFocus;
              exit;
            end;
        end;

      if dCode = 0 then     //новая рабочая станция
        begin
          if not DM.QueryServer('INSERT INTO WS (D_Name, OffsetRun, UserNameSQL, PasswordSQL) VALUES (''' +
                                Trim(EditName.Text) + ''', '''+
                                Trim(EditOffsetRun.Text) + ''', ' +
                                DM.EmptyStringSQL(EditUserSQL.Text, false) + ', ' +
                                DM.EmptyStringSQL(EditPasswordSQL.Text, false) + ')',
                                FormSettingsWorkStation.Caption, 'SaveDataInBD', false) then exit;

          if not DM.QueryServer('SELECT MAX(D_Code) as code FROM WS',
                                FormSettingsWorkStation.Caption, 'SaveDataInBD', true) then exit;
          try
            dCode:= DM.ADOQueryServerMDB.FieldByName('code').AsInteger;
          except
            on e: Exception do
              begin
                MessageBox(handle, PChar(e.Message + #13#10 + '"ADOQueryServerMDB.FieldByName..."'),
                           PChar(FormSettingsWorkStation.Caption), MB_ICONERROR+MB_OK);
                Exit;
              end;
          end;

          if NoErrСreateNewField then
            begin     //добавлены работу с полями с OPC-сервером
              if not DM.QueryWorkStation('INSERT INTO ParamStation ([D_Code],[Interval],'+
                '[ClearSec],[ClearMin],[TimeOffStart],[NumPort],[Procent],[Log],[Reserv],[ReservHour],' +
                '[ReservTxt],[ReservTxtHour],[PrintLog],[ReservWeight],[ReservTxtWeight],' +
                '[NetInterval],[Path],[ReservSql],[ReservSqlHour],[ReservSqlWeight],' +
                '[ReservMdbHour],[ReservSqlAHour],[PassWord],[ReservOPC],[ReservOPCHour],'+
                '[ReservOPCWeight], [AutoOffStart], TypeController) VALUES (''' +
                                IntToStr(dCode) + ''', ''' +
                                IntToStr(Interval) + ''', ''' +
                                Trim(EditSaveSec.Text) + ''', ''' +
                                Trim(EditSaveMin.Text) + ''', ''' +
                                Trim(EditTimeOffStart.Text) + ''', ''' +
                                IntToStr(0) + ''', ''' + //Trim(EditNumPort.Text)
                                Trim(EditPercent.Text) + ''', ' +
                                DM.EmptyStringSQL(EditPathLog.Text, true) + ', ' +
                                booltostr(CheckBoxReservDBF.Checked, true) + ', ' +
                                booltostr(CheckBoxReservHourDBF.Checked, true) + ', ' +
                                booltostr(CheckBoxReservTXT.Checked, true) + ', ' +
                                booltostr(CheckBoxReservHourTXT.Checked, true) + ', ''' +
                                IntToStr(PrintLog) + ''', ' +
                                sReservWeight + ', ' +
                                sReservTxtWeight + ', ''' +
                                DM.EmptyStringSQL(EditNetInterval.Text, false) + ''', ' +
                                DM.EmptyStringSQL(EditPathReservTXT.Text, true) + ', ' +
                                booltostr(CheckBoxReservSQL.Checked, true) + ', ' +
                                booltostr(CheckBoxReservHourSQL.Checked, true) + ', ' +
                                sSqlWeight + ', ' +
                                booltostr(false, true) + ', ' + //booltostr(CheckBoxHourMDB.Checked, true) + ', ' +
                                booltostr(false, true) + ', ' + //booltostr(CheckBoxReservHourSQLA.Checked, true) + ', ' +
                                DM.EmptyStringSQL(UserPassword, true) + ', ' +
                                booltostr(CheckBoxReservOPC.Checked, true) + ', ' +
                                booltostr(CheckBoxReservHourOPC.Checked, true) + ', ' +
                                sReservOPCWeight + ', ' +
                                booltostr(CheckBoxAutoOffStart.Checked, true) + ', ''' +
                                IntToStr(integer(ComboBoxTypeControllers.Items.Objects[ComboBoxTypeControllers.ItemIndex])) + ''')',
                                FormSettingsWorkStation.Caption, 'SaveDataInBD', false) then exit;
            end
            else begin  //если не удалось создать поля для работы с OPC - сервером
              if not DM.QueryWorkStation('INSERT INTO ParamStation ([D_Code],[Interval],' +
                '[ClearSec],[ClearMin],[NumPort],[Procent],[Log],[Reserv],[ReservHour],' +
                '[ReservTxt],[ReservTxtHour],[PrintLog],[ReservWeight],[ReservTxtWeight],' +
                '[NetInterval],[Path],[ReservSql],[ReservSqlHour],[ReservSqlWeight],' +
                '[ReservMdbHour],[ReservSqlAHour],[PassWord], TypeController) VALUES (''' +
                                IntToStr(dCode) + ''', ''' +
                                IntToStr(Interval) + ''', ''' +
                                Trim(EditSaveSec.Text) + ''', ''' +
                                Trim(EditSaveMin.Text) + ''', ''' +
                                IntToStr(0) + ''', ''' +      //Trim(EditNumPort.Text)
                                Trim(EditPercent.Text) + ''', ' +
                                DM.EmptyStringSQL(EditPathLog.Text, true) + ', ' +
                                booltostr(CheckBoxReservDBF.Checked, true) + ', ' +
                                booltostr(CheckBoxReservHourDBF.Checked, true) + ', ' +
                                booltostr(CheckBoxReservTXT.Checked, true) + ', ' +
                                booltostr(CheckBoxReservHourTXT.Checked, true) + ', ''' +
                                IntToStr(PrintLog) + ''', ' +
                                sReservWeight + ', ' +
                                sReservTxtWeight + ', ''' +
                                DM.EmptyStringSQL(EditNetInterval.Text, false) + ''', ' +
                                DM.EmptyStringSQL(EditPathReservTXT.Text, true) + ', ' +
                                booltostr(CheckBoxReservSQL.Checked, true) + ', ' +
                                booltostr(CheckBoxReservHourSQL.Checked, true) + ', ' +
                                sSqlWeight + ', ' +
                                booltostr(false, true) + ', ' + //booltostr(CheckBoxHourMDB.Checked, true) + ', ' +
                                booltostr(false, true) + ', ' + //booltostr(CheckBoxReservHourSQLA.Checked, true) + ', ' +
                                DM.EmptyStringSQL(UserPassword, true) + ', ''' +
                                IntToStr(integer(ComboBoxTypeControllers.Items.Objects[ComboBoxTypeControllers.ItemIndex])) + ''')',
                                FormSettingsWorkStation.Caption, 'SaveDataInBD', false) then exit;
            end;
        end
        else begin
          if not DM.QueryServer('UPDATE WS SET D_Name = ''' + Trim(EditName.Text) +
                ''', OffsetRun = ''' + Trim(EditOffsetRun.Text) +
                ''', UserNameSQL = ' + DM.EmptyStringSQL(EditUserSQL.Text, true) +
                ', PasswordSQL = ' + DM.EmptyStringSQL(EditPasswordSQL.Text, true) +
                ' WHERE D_Code = ' + IntToStr(dCode),
                    FormSettingsWorkStation.Caption, 'SaveDataInBD', false) then exit;

          if NoErrСreateNewField then
            begin     //добавлены работу с полями с OPC-сервером
              if not DM.QueryWorkStation('UPDATE ParamStation SET [Interval] = ''' + IntToStr(Interval) +
               ''', [ClearSec] = ''' + Trim(EditSaveSec.Text) +
               ''', [ClearMin] = ''' + Trim(EditSaveMin.Text) +
               ''', [TimeOffStart] = ''' + Trim(EditTimeOffStart.Text) +
               ''', [NumPort] = ''' + IntToStr(0) +   //Trim(EditNumPort.Text)
               ''', [Procent] = ''' + Trim(EditPercent.Text) +
               ''', [Log] = ' + DM.EmptyStringSQL(EditPathLog.Text, true) +
               ', [Path] = ' + DM.EmptyStringSQL(EditPathReservTXT.Text, true) +
               ', [NetInterval] = ''' + DM.EmptyStringSQL(EditNetInterval.Text, false) +
               ''', [Reserv] = ' + booltostr(CheckBoxReservDBF.Checked, true) +
               ', [ReservHour] = ' + booltostr(CheckBoxReservHourDBF.Checked, true) +
               ', [ReservTxt] = ' + booltostr(CheckBoxReservTXT.Checked, true) +
               ', [ReservTxtHour] = ' + booltostr(CheckBoxReservHourTXT.Checked, true) +
               ', [ReservSql] = ' + booltostr(CheckBoxReservSQL.Checked, true) +
               ', [ReservSqlHour] = ' +  booltostr(CheckBoxReservHourSQL.Checked, true) +
               ', [PrintLog] = ''' + IntToStr(PrintLog) +
               ''', [ReservWeight] = ' + sReservWeight +
               ', [ReservTxtWeight] = ' + sReservTxtWeight +
               ', [ReservSqlWeight] = ' + sSqlWeight +
               ', [ReservMdbHour] = ' + booltostr(false, true) + //booltostr(CheckBoxHourMDB.Checked, true) +
               ', [ReservSQLAHour] = ' + booltostr(false, true) + //booltostr(CheckBoxReservHourSQLA.Checked, true) +
               ', [PassWord] = ' + DM.EmptyStringSQL(UserPassword, true) +
               ', [ReservOPC] = ' + booltostr(CheckBoxReservOPC.Checked, true) +
               ', [ReservOPCHour] = ' +  booltostr(CheckBoxReservHourOPC.Checked, true) +
               ', [ReservOPCWeight] = ' + sReservOPCWeight +
               ', [AutoOffStart] = ' + booltostr(CheckBoxAutoOffStart.Checked, true) +
               ', TypeController = ''' + IntToStr(integer(ComboBoxTypeControllers.Items.Objects[ComboBoxTypeControllers.ItemIndex])) +
               ''' WHERE D_Code = ' + IntToStr(dCode),
              FormSettingsWorkStation.Caption, 'SaveDataInBD', false) then exit;
            end
            else begin //если не удалось создать поля для работы с OPC - сервером
              if not DM.QueryWorkStation('UPDATE ParamStation SET [Interval] = ''' + IntToStr(Interval) +
               ''', [ClearSec] = ''' + Trim(EditSaveSec.Text) +
               ''', [ClearMin] = ''' + Trim(EditSaveMin.Text) +
               ''', [NumPort] = ''' + IntToStr(0) +      //Trim(EditNumPort.Text)
               ''', [Procent] = ''' + Trim(EditPercent.Text) +
               ''', [Log] = ' + DM.EmptyStringSQL(EditPathLog.Text, true) +
               ', [Path] = ' + DM.EmptyStringSQL(EditPathReservTXT.Text, true) +
               ', [NetInterval] = ''' + DM.EmptyStringSQL(EditNetInterval.Text, false) +
               ''', [Reserv] = ' + booltostr(CheckBoxReservDBF.Checked, true) +
               ', [ReservHour] = ' + booltostr(CheckBoxReservHourDBF.Checked, true) +
               ', [ReservTxt] = ' + booltostr(CheckBoxReservTXT.Checked, true) +
               ', [ReservTxtHour] = ' + booltostr(CheckBoxReservHourTXT.Checked, true) +
               ', [ReservSql] = ' + booltostr(CheckBoxReservSQL.Checked, true) +
               ', [ReservSqlHour] = ' +  booltostr(CheckBoxReservHourSQL.Checked, true) +
               ', [PrintLog] = ''' + IntToStr(PrintLog) +
               ''', [ReservWeight] = ' + sReservWeight +
               ', [ReservTxtWeight] = ' + sReservTxtWeight +
               ', [ReservSqlWeight] = ' + sSqlWeight +
               ', [ReservMdbHour] = ' + booltostr(false, true) + //booltostr(CheckBoxHourMDB.Checked, true) +
               ', [ReservSQLAHour] = ' + booltostr(false, true) + //booltostr(CheckBoxReservHourSQLA.Checked, true) +
               ', [PassWord] = ' + DM.EmptyStringSQL(UserPassword, true) +
               ', TypeController = ''' + IntToStr(integer(ComboBoxTypeControllers.Items.Objects[ComboBoxTypeControllers.ItemIndex])) +
               ''' WHERE D_Code = ' + IntToStr(dCode),
              FormSettingsWorkStation.Caption, 'SaveDataInBD', false) then exit;
            end;
        end;
      DM.RebootMonitor;
    end;
  CheckBoxChangePasswordUser.Checked:= false;
  CheckBoxChangePasswordUserClick(Sender);
  ProcedureChangeData(false);
end;

procedure TFormSettingsWorkStation.SpeedButtonTestConnectionClick(
  Sender: TObject);
begin
  if SpeedButtonTestConnection.Down then
    begin
      if Application.MessageBox(PChar('Перевести программу RudaMonitor в режим ' +
          '"Настройка передачи данных контролируемых параметров во внешние интерфейсы"?' + #10#13 +
          'Если "Да", программу RudaMonitor следует перезапустить.' + #10#13 + #10#13 +
          'Данный режим служит для настройки и контроля передачи параметров ' +
          'программой RudaMonitor во внешний интерфейс.' +#10#13 +
          'При нажатии на кнопку, программа RudaMonitor прекратит опрос датчиков в реальном ' +
          'времени, перестанет вычислять реальные значения контролируемых параметров. Значения параметров будут ' +
          'генерироваться случайным образом самой программой RudaMonitor в диапазонах, указанных ' +
          'при настройке контролируемых параметров. Эти данные будут передаваться во внешние интерфейсы с ' +
          'указанным периодом.'), PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                  MB_YESNO + MB_ICONWARNING) = IDYES  then
        begin
          SpeedButtonTestConnection.Hint:= TestConnectionHintEnabled;
          WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'TestConnectionInterval', SpinEditTimeTestConnection.Value);
          WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'TestConnection', SpeedButtonTestConnection.Down);
          DM.RebootMonitor;
        end
        else SpeedButtonTestConnection.Down:= not SpeedButtonTestConnection.Down;
    end
    else begin
      if Application.MessageBox(PChar('Остановить работу программы RudaMonitor из режима ' +
          '"Проверка передачи данных контролируемых параметров во внешние интерфейсы"?' +#10#13 +
          'Если "Да", программа RudaMonitor будет перезапущена в стандартном режиме (опрос ' +
          'датчиков будет происходить в реальном времени).'), PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                            MB_YESNO + MB_ICONWARNING) = IDYES  then
        begin
          SpeedButtonTestConnection.Hint:= TestConnectionHintDisable;
          WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'TestConnectionInterval', SpinEditTimeTestConnection.Value);
          WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'TestConnection', SpeedButtonTestConnection.Down);
          DM.RebootMonitor;
        end
        else SpeedButtonTestConnection.Down:= not SpeedButtonTestConnection.Down;
    end;
end;

procedure TFormSettingsWorkStation.SpinEditTimeTestConnectionChange(
  Sender: TObject);
begin
  if SpinEditTimeTestConnection.Value < SpinEditTimeTestConnection.MinValue then
    SpinEditTimeTestConnection.Value:= SpinEditTimeTestConnection.MinValue;
  if SpinEditTimeTestConnection.Value > SpinEditTimeTestConnection.MaxValue then
    SpinEditTimeTestConnection.Value:= SpinEditTimeTestConnection.MaxValue;
  WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings',
                       'TestConnectionInterval', SpinEditTimeTestConnection.Value);
end;

procedure TFormSettingsWorkStation.ButtonCancelClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  FormShow(Sender);
end;

procedure TFormSettingsWorkStation.ButtonCloseClick(Sender: TObject);
begin
  FormSettingsWorkStation.Close;
end;

procedure TFormSettingsWorkStation.ButtonPathLogClick(Sender: TObject);
  var chosenDirectory : string;
begin
  if Trim(EditPathLog.Text) = '' then chosenDirectory:= PathApp
                                 else chosenDirectory:= EditPathLog.Text;

  if SelectDirectory (ProgName_ShortStringVersion + ' Выберите каталог', '', chosenDirectory, [sdNewFolder, sdNewUI]) then
    begin
      EditPathLog.Text:= chosenDirectory;
      ProcedureChangeData;
    end;
end;

procedure TFormSettingsWorkStation.CheckBoxChangePasswordUserClick(
  Sender: TObject);
begin
  Label10.Enabled:= CheckBoxChangePasswordUser.Checked;
  Label11.Enabled:= CheckBoxChangePasswordUser.Checked;
  Label12.Enabled:= CheckBoxChangePasswordUser.Checked;

  EditOldPassword.Enabled:= CheckBoxChangePasswordUser.Checked;
  EditNewPassword.Enabled:= CheckBoxChangePasswordUser.Checked;
  EditConfirmNewPassword.Enabled:= CheckBoxChangePasswordUser.Checked;

  EditOldPassword.Clear;
  EditNewPassword.Clear;
  EditConfirmNewPassword.Clear;

  BitBtnEyePassword.Enabled:= CheckBoxChangePasswordUser.Checked;
end;

procedure TFormSettingsWorkStation.CheckBoxAutoOffStartClick(Sender: TObject);
begin
  EditTimeOffStart.Enabled:= CheckBoxAutoOffStart.Checked;
  ProcedureChangeData;
end;

procedure TFormSettingsWorkStation.CheckBoxReservHourOPCClick(Sender: TObject);
begin
  ProcedureChangeData;
  if FOnceActivated then ReadOPCServerName;
end;

procedure TFormSettingsWorkStation.CheckBoxReservHourSQLClick(Sender: TObject);
  var msg: string;
begin
  ProcedureChangeData;
  if CheckBoxReservHourSQL.Checked and CheckBoxReservHourTXT.Checked then
    begin
      Application.MessageBox(PChar('На вкладке "' + TabSheet_TXT.Caption + '", параметр "' +
        CheckBoxReservHourTXT.Caption + '" также был включен. Одновременное использование этих двух параметров ' +
        'недопустимо. Поэтому на вкладке "' + TabSheet_TXT.Caption + '", параметр "' +
        CheckBoxReservHourTXT.Caption + '" переведен в состояние - отключен.'),
                            PChar(ProgName_ShortStringVersion + ' Внимание!!!'),
                            MB_OK + MB_ICONWARNING);
      CheckBoxReservHourTXT.Checked:= false;
    end;

  if (not CheckBoxReservSQL.Checked) and (not CheckBoxReservHourSQL.Checked) then EditDsnSQL.Clear;
  if CheckBoxReservSQL.Checked or CheckBoxReservHourSQL.Checked then ConnectDBSQL;
end;

procedure TFormSettingsWorkStation.CheckBoxReservHourTXTClick(Sender: TObject);
begin
  ProcedureChangeData;
  if CheckBoxReservHourSQL.Checked and CheckBoxReservHourTXT.Checked then
    begin
      Application.MessageBox(PChar('На вкладке "' + TabSheet_SQL.Caption + '", параметр "' +
        CheckBoxReservHourSQL.Caption + '" также был включен. Одновременное использование этих двух параметров ' +
        'недопустимо. Поэтому на вкладке "' + TabSheet_SQL.Caption + '", параметр "' +
        CheckBoxReservHourSQL.Caption + '" переведен в состояние - отключен.'),
                            PChar(ProgName_ShortStringVersion + ' Внимание!!!'),
                            MB_OK + MB_ICONWARNING);
      CheckBoxReservHourSQL.Checked:= false;
    end;
end;

procedure TFormSettingsWorkStation.CheckBoxReservOPCClick(Sender: TObject);
begin
  ProcedureChangeData;
  if FOnceActivated then ReadOPCServerName;
end;

procedure TFormSettingsWorkStation.CheckBoxReservSQLClick(Sender: TObject);
  var msg: string;
begin
  ProcedureChangeData;
  if CheckBoxReservSQL.Checked and CheckBoxReservTXT.Checked then
    begin
      Application.MessageBox(PChar('На вкладке "' + TabSheet_TXT.Caption + '", параметр "' +
        CheckBoxReservTXT.Caption + '" также был включен. Одновременное использование этих двух параметров ' +
        'недопустимо. Поэтому на вкладке "' + TabSheet_TXT.Caption + '", параметр "' +
        CheckBoxReservTXT.Caption + '" переведен в состояние - отключен.'),
                            PChar(ProgName_ShortStringVersion + ' Внимание!!!'),
                            MB_OK + MB_ICONWARNING);
      CheckBoxReservTXT.Checked:= false;
    end;
  if (not CheckBoxReservSQL.Checked) and (not CheckBoxReservHourSQL.Checked) then EditDsnSQL.Clear;
  if CheckBoxReservSQL.Checked or CheckBoxReservHourSQL.Checked then ConnectDBSQL;
end;

procedure TFormSettingsWorkStation.CheckBoxReservTXTClick(Sender: TObject);
begin
  ProcedureChangeData;
  if CheckBoxReservSQL.Checked and CheckBoxReservTXT.Checked then
    begin
      Application.MessageBox(PChar('На вкладке "' + TabSheet_SQL.Caption + '", параметр "' +
        CheckBoxReservSQL.Caption + '" также был включен. Одновременное использование этих двух параметров ' +
        'недопустимо. Поэтому на вкладке "' + TabSheet_SQL.Caption + '", параметр "' +
        CheckBoxReservSQL.Caption + '" переведен в состояние - отключен.'),
                            PChar(ProgName_ShortStringVersion + ' Внимание!!!'),
                            MB_OK + MB_ICONWARNING);
      CheckBoxReservSQL.Checked:= false;
    end;
end;

//подключение к SQL Server с отображением времени, если долгое подключение
procedure TFormSettingsWorkStation.ConnectDBSQL;
begin
  if TimerConnectNetSQL.Enabled then  exit;  //если таймер проверки соединения запущен, то выходим

  BitBtnConnectRudaSQL.Enabled:= false;
  BitBtnStopConnectRudaSQL.Enabled:= true;

  EditDsnSQL.Clear;
  EditDsnSQL.Font.Color:= clWindowText;

  StartTime:= now;
  TimerConnectNetSQL.Enabled:= true;

  if ThreadConnectNetSQL = nil then
    begin
      //формируем строку соединения с SQL сервером
      GetSecondStringConnectSQL;

      ThreadConnectNetSQL:= ConnectNetSQL.Create(true);
      ThreadConnectNetSQL.FreeOnTerminate:= true;
      ThreadConnectNetSQL.OnTerminate:= ThreadTerminate;  //процедура возникает
      ThreadConnectNetSQL.Priority:= tplower;  //tpNormal, tpHigher, tpHighest
      ThreadConnectNetSQL.Resume;
    end;
end;

procedure TFormSettingsWorkStation.ThreadTerminate(Sender: TObject);
begin
  ThreadConnectNetSQL:= nil;
end;

procedure TFormSettingsWorkStation.GetSecondStringConnectSQL;
begin
  DSNConnectSQL:= Format(DSNstring,[DSNNameRudaSQL, EditUserSQL.Text, EditPasswordSQL.Text]);
end;

procedure TFormSettingsWorkStation.FormActivate(Sender: TObject);
begin
  if not FOnceActivated then
   begin
      FOnceActivated:=true;
      ReadOPCServerName;
   end;
end;

procedure TFormSettingsWorkStation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ChangeData then SaveDataInBD;
  TimerNameLang.Enabled:= false;
  TimerConnectNetSQL.Enabled:= false;
end;

procedure TFormSettingsWorkStation.FormCreate(Sender: TObject);
begin
  FOnceActivated:= false;
  Caption:= ProgName_ShortStringVersion + Caption;
  ThreadConnectNetSQL:= nil;
end;

procedure TFormSettingsWorkStation.DBFEnabled(param: boolean);
begin
  Label9.Enabled:= param;
  Label15.Enabled:= param;
  Label14.Enabled:= param;
  CheckBoxReservDBF.Enabled:= param;
  CheckBoxReservHourDBF.Enabled:= param;
  RadioGroupWeightPeriodDBF.Enabled:= param;
  EditArch.Enabled:= param;
  EditNetInterval.Enabled:= param;
end;

procedure TFormSettingsWorkStation.EditArchKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
end;

procedure TFormSettingsWorkStation.EditDsnSQLChange(Sender: TObject);
begin
  EditDsnSQL.Hint:= EditDsnSQL.Text;
end;

procedure TFormSettingsWorkStation.EditDsnSQLKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  ProcedureChangeData;
end;

procedure TFormSettingsWorkStation.EditDsnSQLKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:= #0;
end;

procedure TFormSettingsWorkStation.EditIntKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label3.Caption, 1 ,Length(Label3.Caption)-1) + '"', Key);
end;

procedure TFormSettingsWorkStation.EditNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
end;

procedure TFormSettingsWorkStation.EditNetIntervalKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label15.Caption, 1 ,Length(Label15.Caption)-1) + '"', Key);
end;

procedure TFormSettingsWorkStation.EditNumPortKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  if not (Key in ['1'..'8', #8, #13]) then
    begin
      Application.MessageBox(PChar('Диапазон значений номера порта для связи с АЦП от 1 до 2'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
      key:= #0;
    end;
end;

procedure TFormSettingsWorkStation.EditOffsetRunKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label6.Caption, 1 ,Length(Label6.Caption)-1) + '"', Key);
end;

procedure TFormSettingsWorkStation.EditTimeOffStartKeyPress(Sender: TObject;
  var Key: Char);
  const textMsg = 'Настройки "Режима отбора проб"';
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey(Format('"%s"', [textMsg]), Key);
end;

procedure TFormSettingsWorkStation.EditPathLogChange(Sender: TObject);
begin
  ProcedureChangeData;
  EditPathLog.Hint:= EditPathLog.Text;
end;

procedure TFormSettingsWorkStation.EditPercentKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label7.Caption, 1 ,Length(Label7.Caption)-1) + '"', Key);
end;

procedure TFormSettingsWorkStation.EditSaveMinKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label5.Caption, 1 ,Length(Label5.Caption)-1) + '"', Key);
end;

procedure TFormSettingsWorkStation.EditSaveSecKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label4.Caption, 1 ,Length(Label4.Caption)-1) + '"', Key);
end;

procedure TFormSettingsWorkStation.EditServerNameChange(Sender: TObject);
begin
  EditServerName.Hint:= EditServerName.Text;
end;

procedure TFormSettingsWorkStation.ClearAllData;
  var Sender: TObject;
begin
  ComboBoxTypeControllers.ItemIndex:= -1;
  EditInt.Clear;
  EditSaveSec.Clear;
  EditSaveMin.Clear;
  EditTimeOffStart.Clear;
  EditNetInterval.Clear;
  EditPercent.Clear;
  EditPathLog.Clear;
  EditPathReservTXT.Clear;
  CheckBoxStoryMin.Checked:= false;
  CheckBoxStoryHour.Checked:= false;
  CheckBoxReservDBF.Checked:= false;
  CheckBoxReservHourDBF.Checked:= false;
  CheckBoxReservTXT.Checked:= false;
  CheckBoxReservHourTXT.Checked:= false;
  CheckBoxReservSQL.Checked:= false;
  CheckBoxReservHourSQL.Checked:= false;
  CheckBoxAdjustmentZero.Checked:= false;
  CheckBoxResetOptions.Checked:= false;
  RadioGroupWeightPeriodDBF.ItemIndex:= 0;
  RadioGroupWeightPeriodTXT.ItemIndex:= 0;
  RadioGroupWeightPeriodSQL.ItemIndex:= 0;
  EditName.Clear;
  EditOffsetRun.Clear;
  EditUserSQL.Clear;
  EditPasswordSQL.Clear;
  EditArch.Clear;
  EditDsnSQL.Clear;
  EditServerName.Clear;
  EditOldPassword.Clear;
  EditNewPassword.Clear;
  EditConfirmNewPassword.Clear;
  CheckBoxChangePasswordUser.Checked:= false;
  CheckBoxChangePasswordUserClick(Sender);
end;

//установка значений полей по умолчанию
procedure TFormSettingsWorkStation.SettingDefaultFields();
begin
  EditInt.Text                := IntToStr(defInterval);
  EditSaveSec.Text            := IntToStr(defSaveSec);
  EditSaveMin.Text            := IntToStr(defSaveMin);
  CheckBoxAutoOffStart.Checked:= defAutoOffStart;
  EditTimeOffStart.Text       := IntToStr(defTimeOffStart);
  EditOffsetRun.Text          := IntToStr(defOffsetRun);
  EditNetInterval.Text        := IntToStr(defNetInterval);
  EditPercent.Text            := IntToStr(defPercent);
end;

procedure TFormSettingsWorkStation.FormShow(Sender: TObject);
  var rCode: variant;
      Reserv: boolean;
      msg: string;
begin
  //отключаем события, чтобы не обновлялась после загрузки состояния
  CheckBoxReservSQL.OnClick:= nil;
  CheckBoxReservHourSQL.OnClick:= nil;

  ClearAllData;
  PressButtonBitBtnConnectRudaSQL:= false;
  DM.QueryServer('SELECT R_Code FROM Lines WHERE [Connect]' , FormSettingsWorkStation.Caption, 'FormShow', true);

  Reserv:= false;
  if not DM.ADOQueryServerMDB.EOF then
    begin
      rCode:= DM.ADOQueryServerMDB.FieldByName('R_Code').AsVariant;
      DM.ADOQueryServerMDB.First;
      while not DM.ADOQueryServerMDB.EOF do
        begin
          if rCode <> DM.ADOQueryServerMDB.FieldByName('R_Code').AsVariant then
            begin
              Reserv:= true;
              break;
            end;
          DM.ADOQueryServerMDB.Next;
        end;
    end;

  DBFEnabled(not Reserv);     //если разные режимы работы, запретить запись в dbf

  //получаем спискок всех контроллеров
  ComboBoxTypeControllers.Clear;
  DM.QueryServer('SELECT * FROM TypeControllers' , FormSettingsWorkStation.Caption, 'FormShow', true);
  while not DM.ADOQueryServerMDB.EOF do
    begin
      ComboBoxTypeControllers.Items.AddObject(DM.ADOQueryServerMDB.FieldByName('Nc_NameController').AsString,
        TObject(DM.ADOQueryServerMDB.FieldByName('Nc_Code').AsInteger));
      DM.ADOQueryServerMDB.Next; // го на следующего
    end;

  rCode:= 0;
  dCode:= 0;
  DM.QueryWorkStation('SELECT * FROM ParamStation', FormSettingsWorkStation.Caption, 'FormShow', true);
  if not DM.ADOQueryWorkStationMDB.EOF then
    begin
      dCode:= DM.ADOQueryWorkStationMDB.FieldByName('D_Code').AsVariant;
      ComboBoxTypeControllers.ItemIndex:= ComboBoxTypeControllers.Items.IndexOfObject(TObject(DM.ADOQueryWorkStationMDB.FieldByName('TypeController').AsInteger));
      //EditNumPort.Text:= DM.ADOQueryWorkStationMDB.FieldByName('NumPort').AsString;
      EditInt.Text:= IntToStr(DM.ADOQueryWorkStationMDB.FieldByName('Interval').AsInteger AND $7F);
      EditSaveSec.Text:= DM.ADOQueryWorkStationMDB.FieldByName('ClearSec').AsString;
      EditSaveMin.Text:= DM.ADOQueryWorkStationMDB.FieldByName('ClearMin').AsString;

      try
        EditTimeOffStart.Text:= IntToStr(strtoint(DM.ADOQueryWorkStationMDB.FieldByName('TimeOffStart').AsString));
      except
        EditTimeOffStart.Text:= inttostr(defTimeOffStart);
      end;

      CheckBoxAutoOffStart.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('AutoOffStart').AsBoolean;
      EditTimeOffStart.Enabled:= CheckBoxAutoOffStart.Checked;

      EditNetInterval.Text:= DM.ADOQueryWorkStationMDB.FieldByName('NetInterval').AsString;
      EditPercent.Text:= DM.ADOQueryWorkStationMDB.FieldByName('Procent').AsString;
      EditPathLog.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Log').AsString);
      EditPathReservTXT.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Path').AsString);
      CheckBoxStoryMin.Checked:= IsBitSet(DM.ADOQueryWorkStationMDB.FieldByName('Interval').AsInteger, 7);  // AND $80
      CheckBoxStoryHour.Checked:= IsBitSet(DM.ADOQueryWorkStationMDB.FieldByName('Interval').AsInteger, 8);  // AND $100
      CheckBoxReservDBF.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('Reserv').AsBoolean AND (not Reserv);
      CheckBoxReservHourDBF.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('ReservHour').AsBoolean AND (not Reserv);
      CheckBoxReservTXT.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('ReservTxt').AsBoolean;
      CheckBoxReservHourTXT.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('ReservTxtHour').AsBoolean;
      CheckBoxReservSQL.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('ReservSql').AsBoolean;
      CheckBoxReservHourSQL.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('ReservSqlHour').AsBoolean;

      CheckBoxAdjustmentZero.Checked:= IsBitSet(DM.ADOQueryWorkStationMDB.FieldByName('PrintLog').AsInteger, 0);  // AND $01
      CheckBoxResetOptions.Checked:= IsBitSet(DM.ADOQueryWorkStationMDB.FieldByName('PrintLog').AsInteger, 1);    // AND $02

      if DM.ADOQueryWorkStationMDB.FieldByName('ReservWeight').AsBoolean then RadioGroupWeightPeriodDBF.ItemIndex:= 1
                                                                         else RadioGroupWeightPeriodDBF.ItemIndex:= 0;
      if DM.ADOQueryWorkStationMDB.FieldByName('ReservTxtWeight').AsBoolean then RadioGroupWeightPeriodTXT.ItemIndex:= 1
                                                                            else RadioGroupWeightPeriodTXT.ItemIndex:= 0;
      if DM.ADOQueryWorkStationMDB.FieldByName('ReservSqlWeight').AsBoolean then RadioGroupWeightPeriodSQL.ItemIndex:= 1
                                                                            else RadioGroupWeightPeriodSQL.ItemIndex:= 0;
      UserPassword:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('PassWord').AsString);
      if NoErrСreateNewField then
        begin
          CheckBoxReservOPC.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('ReservOPC').AsBoolean;
          CheckBoxReservHourOPC.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('ReservOPCHour').AsBoolean;
          if DM.ADOQueryWorkStationMDB.FieldByName('ReservOPCWeight').AsBoolean then RadioGroupWeightPeriodOPC.ItemIndex:= 1
        end;
    end
    else begin     //если в первй раз - устанавливам значения по умолчанию
      SettingDefaultFields; //установка значений полей по умолчанию
      EditUserSQL.Text:= FromDSNgetPathBase(DSNNameRudaSQL, 'LastUser');  //заполняем поле пользователь
    end;

  DM.QueryServer('SELECT * FROM WS WHERE D_Code = ' + IntToStr(dCode), Caption, 'FormShow', true);
  if not DM.ADOQueryServerMDB.EOF then
    begin
      EditName.Text:= DM.ADOQueryServerMDB.FieldByName('D_Name').AsString;
      EditOffsetRun.Text:= DM.ADOQueryServerMDB.FieldByName('OffsetRun').AsString;
      if DM.ADOQueryServerMDB.FieldByName('UserNameSQL').AsVariant = 'Null'
        then EditUserSQL.Clear
        else EditUserSQL.Text:= DM.ADOQueryServerMDB.FieldByName('UserNameSQL').AsString;

      if DM.ADOQueryServerMDB.FieldByName('PasswordSQL').AsString = 'Null'
        then EditPasswordSQL.Clear
        else EditPasswordSQL.Text:= DM.ADOQueryServerMDB.FieldByName('PasswordSQL').AsString;
    end;

  //после загрузки данных - имя пользователя и пароля, подключаем события
  CheckBoxReservSQL.OnClick:= CheckBoxReservSQLClick;
  CheckBoxReservHourSQL.OnClick:= CheckBoxReservHourSQLClick;

  //здесь делаем коннект к RudaCnv
  //здесь делаем коннект к RudaSQL
  if (CheckBoxReservSQL.Checked or CheckBoxReservHourSQL.Checked) then ConnectDBSQL;

//  DM.QueryServer('SELECT * FROM WS' , Caption, 'FormShow', true);
//  if not DM.ADOQueryServerMDB.EOF then
//    begin
//
//    end;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'TestConnectionInterval', asInteger, ParamVariant)
    then SpinEditTimeTestConnection.Value:= ParamVariant
    else SpinEditTimeTestConnection.Value:= 0;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'TestConnection', asBoolean, ParamVariant)
    then SpeedButtonTestConnection.Down:= ParamVariant
    else SpeedButtonTestConnection.Down:= false;

  if SpeedButtonTestConnection.Down then SpeedButtonTestConnection.Hint:= TestConnectionHintEnabled
                                    else SpeedButtonTestConnection.Hint:= TestConnectionHintDisable;

  PageControlReservation.Pages[0].TabVisible:= false;          //не используется  DBF
  PageControlReservation.Pages[3].TabVisible:= NoErrСreateNewField; //если удалось создать поля для OPC, показываем страницу настроек OPC
  ProcedureChangeData(false);
  ReadOPCServerName;
  TimerNameLang.Enabled:= true;
end;

procedure TFormSettingsWorkStation.ReadOPCServerName;
  var e: TOPCEnum;
      tempOPCServerName: AnsiString;
      ErrorCode: HRESULT;
begin
//  sleep(1000);
  if (not CheckBoxReservOPC.Checked) and (not CheckBoxReservHourOPC.Checked) then
    begin
      EditServerName.Color:= clLime;
      EditServerName.Text:= 'Не выбраны данные для передачи (минутные и/или часовые)';
      exit;
    end;

  ErrorCode:= e.ProgIDFromCLSID(GUID_RudaOPCDA, tempOPCServerName);

  if ErrorCode <> S_OK then tempOPCServerName:= '';

  if tempOPCServerName <> '' then
    begin
      EditServerName.Color:= clWindow;
      EditServerName.Text:= tempOPCServerName + ' / ' + GUIDToString(GUID_RudaOPCDA);
    end
    else begin
      EditServerName.Color:= clRed;
      EditServerName.Text:= 'Нет данных / ' + GUIDToString(GUID_RudaOPCDA);
    end;
end;

procedure TFormSettingsWorkStation.TimerConnectNetSQLTimer(Sender: TObject);
  var msgMB: ShortInt;
begin
  EditDsnSQL.Text:= Format('Идет подключение... %d сек.', [SecondsBetween(now, StartTime)]);

//  if WaitForSingleObject(ThreadConnectNetSQL.Handle, 100) = WAIT_FAILED then   //проверяем поток уничтожился, если да - выводим результат

  if ThreadConnectNetSQL = nil then  //проверяем поток уничтожился, если да - выводим результат
    begin
      TimerConnectNetSQL.Enabled:= false;
      if ThreadConnectNetSQL <> nil then ThreadConnectNetSQL:= nil;

      EditDsnSQL.Text:= TxtForEditDsnSQL;
      if ErrConnectNetSQL then
        begin
          EditDsnSQL.Font.Color:= clRed;
          msgMB:= MB_ICONERROR;
        end
        else begin
          EditDsnSQL.Font.Color:= clWindowText;
          msgMB:= MB_ICONINFORMATION;
        end;

      if PressButtonBitBtnConnectRudaSQL then   //если проверка соединения была по кнопке
        begin
          PressButtonBitBtnConnectRudaSQL:= false;
          Application.MessageBox(PChar(TxtForMsg), PChar(ProgName_ShortStringVersion), MB_OK + msgMB);
        end;

      BitBtnConnectRudaSQL.Enabled:= true;
      BitBtnStopConnectRudaSQL.Enabled:= false;
    end;
end;

//индикация раскладки клавиатуры
procedure TFormSettingsWorkStation.TimerNameLangTimer(Sender: TObject);
begin
  LabelKeyboardLayout.Caption:= NameKeyboardLayout(GetActiveKbdLayoutWnd);
  LabelKeyboardLayoutSQL.Caption:= NameKeyboardLayout(GetActiveKbdLayoutWnd);
end;

procedure TFormSettingsWorkStation.ChangeDataTrue(Sender: TObject);  //событие Change:= true;
begin
  ProcedureChangeData;
end;

procedure TFormSettingsWorkStation.ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //если данные были изменены, разрешаем кнопку "Применить"
end;

end.
