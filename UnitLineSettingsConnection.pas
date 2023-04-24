unit UnitLineSettingsConnection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, Vcl.ExtCtrls;

type
  TFormLineSettingsConnection = class(TForm)
    DBGridListLineConnection: TDBGrid;
    SpeedButtonAddLineConnection: TSpeedButton;
    SpeedButtonDeleteLineConnection: TSpeedButton;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ButtonClose: TButton;
    Label1: TLabel;
    EditLineConnectionName: TEdit;
    comboBoxPortName: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    comboBoxBaudRate: TComboBox;
    Label8: TLabel;
    comboBoxDataBits: TComboBox;
    Label9: TLabel;
    comboBoxParity: TComboBox;
    Label10: TLabel;
    comboBoxStopBits: TComboBox;
    ADODataSetLineSettingsConnection: TADODataSet;
    DataSourceLineSettingsConnection: TDataSource;
    ADODataSetLineSettingsConnectionSp_Code: TAutoIncField;
    ADODataSetLineSettingsConnectionPortNum: TIntegerField;
    ADODataSetLineSettingsConnectionBaudRate: TIntegerField;
    ADODataSetLineSettingsConnectionDataBits: TIntegerField;
    ADODataSetLineSettingsConnectionParity: TIntegerField;
    ADODataSetLineSettingsConnectionStopBits: TIntegerField;
    ADODataSetLineSettingsConnectionNameConnection: TWideStringField;
    RadioGroupSelectTypeController: TRadioGroup;
    ADODataSetLineSettingsConnectionTypeController: TIntegerField;
    ButtonSettingsCOMportDefault: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClearAllData;
    procedure LoadDataSettingsCOMPort;
    procedure LineConnectionList;
    procedure ADODataSetLineSettingsConnectionPortNumGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure SpeedButtonDeleteLineConnectionClick(Sender: TObject);
    procedure UpdateLineConnectionList(SetCursorPosition: boolean = true);
    procedure ADODataSetLineSettingsConnectionAfterScroll(DataSet: TDataSet);
    procedure EnabledDisebledField(param: boolean = true);
    procedure ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
    function NumPortByIndexListCOMport(PortNum: integer): integer;
    procedure SpeedButtonAddLineConnectionClick(Sender: TObject);
    procedure SaveDataInBD;
    procedure EditLineConnectionNameKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure RadioGroupSelectTypeControllerClick(Sender: TObject);
    procedure comboBoxPortNameChange(Sender: TObject);
    procedure comboBoxBaudRateChange(Sender: TObject);
    procedure comboBoxDataBitsChange(Sender: TObject);
    procedure comboBoxParityChange(Sender: TObject);
    procedure comboBoxStopBitsChange(Sender: TObject);
    procedure ButtonSettingsCOMportDefaultClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function PortWithThisNumberBusy(Code, PortNum: integer; var LineConnectionName: string): integer;
    function CheckConnectLineCommunication(Sp_Code: integer; var NameControllers: string): boolean;
    procedure ADODataSetLineSettingsConnectionBeforeScroll(DataSet: TDataSet);
  private
    { Private declarations }
    var
    ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                          //измененные данные записать в базу данных
  public
    { Public declarations }
  end;

var
  FormLineSettingsConnection: TFormLineSettingsConnection;
  CodeLineSettingsConnection: integer;
implementation
uses UnitDM, EnumSerialPorts, UnitSettingsProgramm, RudaGlobals, MainUnit;

{$R *.dfm}

//по номеру COM порта получить индекс в списке всех COM портов
function TFormLineSettingsConnection.NumPortByIndexListCOMport(PortNum: integer): integer;
  var i: integer;
begin
  result:= -1;
  for i := 0 to comboBoxPortName.Items.Count - 1 do
    begin
      if pos('COM' + inttostr(PortNum), comboBoxPortName.Items[i]) > 0 then
        begin
          result:= i;
          break;
        end;
    end;
end;

procedure TFormLineSettingsConnection.ADODataSetLineSettingsConnectionAfterScroll(
  DataSet: TDataSet);
  var Sender: TObject;
begin
  ClearAllData;
  if DBGridListLineConnection.DataSource.DataSet.RecordCount > 0 then
    begin
      EnabledDisebledField;
      SpeedButtonDeleteLineConnection.Enabled:= true;
      CodeLineSettingsConnection:= DBGridListLineConnection.DataSource.DataSet.FieldByName('Sp_Code').AsInteger;
      EditLineConnectionName.Text:= Trim(DBGridListLineConnection.DataSource.DataSet.FieldByName('NameConnection').AsString);
      RadioGroupSelectTypeController.ItemIndex:= DBGridListLineConnection.DataSource.DataSet.FieldByName('TypeController').AsInteger - 1;
      RadioGroupSelectTypeControllerClick(Sender);

      comboBoxPortName.ItemIndex:= NumPortByIndexListCOMport(DBGridListLineConnection.DataSource.DataSet.FieldByName('PortNum').AsInteger);

      comboBoxBaudRate.ItemIndex:= comboBoxBaudRate.Items.IndexOfObject(TObject(DBGridListLineConnection.DataSource.DataSet.FieldByName('BaudRate').AsInteger));
      comboBoxDataBits.ItemIndex:= comboBoxDataBits.Items.IndexOfObject(TObject(DBGridListLineConnection.DataSource.DataSet.FieldByName('DataBits').AsInteger));
      comboBoxParity.ItemIndex:= comboBoxParity.Items.IndexOfObject(TObject(DBGridListLineConnection.DataSource.DataSet.FieldByName('Parity').AsInteger));
      comboBoxStopBits.ItemIndex:= comboBoxStopBits.Items.IndexOfObject(TObject(DBGridListLineConnection.DataSource.DataSet.FieldByName('StopBits').AsInteger));
    end
    else begin
      EnabledDisebledField(false);
      SpeedButtonDeleteLineConnection.Enabled:= false;
    end;

  ProcedureChangeData(false);  //чтобы не зафиксировать изменения при прокрутки скролом и данные не записывались в базу данных
end;

procedure TFormLineSettingsConnection.ADODataSetLineSettingsConnectionBeforeScroll(
  DataSet: TDataSet);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormLineSettingsConnection.ADODataSetLineSettingsConnectionPortNumGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger = 0 then Text:= ''
    else
    begin
      if Sender.AsInteger = -1 then Text:= 'н/д'
                               else Text:= 'COM' + Sender.AsString;
    end;
end;

procedure TFormLineSettingsConnection.ButtonCancelClick(Sender: TObject);
begin
  UpdateLineConnectionList;
end;

procedure TFormLineSettingsConnection.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormLineSettingsConnection.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

procedure TFormLineSettingsConnection.ButtonSettingsCOMportDefaultClick(
  Sender: TObject);
begin
  if RadioGroupSelectTypeController.ItemIndex = 2 then  //значит MK003
    begin
      comboBoxBaudRate.ItemIndex:= comboBoxBaudRate.Items.IndexOfObject(TObject(DefaultSettingsCOMPortMK003.BaudRate));
      comboBoxDataBits.ItemIndex:= comboBoxDataBits.Items.IndexOfObject(TObject(DefaultSettingsCOMPortMK003.ByteSize));
      comboBoxParity.ItemIndex:= comboBoxParity.Items.IndexOfObject(TObject(DefaultSettingsCOMPortMK003.Parity));
      comboBoxStopBits.ItemIndex:= comboBoxStopBits.Items.IndexOfObject(TObject(DefaultSettingsCOMPortMK003.StopBits));
    end
    else
    begin
      comboBoxBaudRate.ItemIndex:= comboBoxBaudRate.Items.IndexOfObject(TObject(DefaultSettingsCOMPortMK001_002.BaudRate));
      comboBoxDataBits.ItemIndex:= comboBoxDataBits.Items.IndexOfObject(TObject(DefaultSettingsCOMPortMK001_002.ByteSize));
      comboBoxParity.ItemIndex:= comboBoxParity.Items.IndexOfObject(TObject(DefaultSettingsCOMPortMK001_002.Parity));
      comboBoxStopBits.ItemIndex:= comboBoxStopBits.Items.IndexOfObject(TObject(DefaultSettingsCOMPortMK001_002.StopBits));
    end;
  ProcedureChangeData;
end;

procedure TFormLineSettingsConnection.EditLineConnectionNameKeyPress(
  Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
end;

procedure TFormLineSettingsConnection.EnabledDisebledField(param: boolean = true);
begin
  EditLineConnectionName.Enabled:= param;
  RadioGroupSelectTypeController.Enabled:= param;
  comboBoxPortName.Enabled:= param;
  comboBoxBaudRate.Enabled:= param;
  //comboBoxDataBits.Enabled:= param; //всегда Diseble
  comboBoxParity.Enabled:= param;
  comboBoxStopBits.Enabled:= param;

  ButtonSettingsCOMportDefault.Enabled:= param;
end;

procedure TFormLineSettingsConnection.ClearAllData;
begin
  CodeLineSettingsConnection:= 0;
  EditLineConnectionName.Clear;

  comboBoxPortName.ItemIndex:= -1;
  comboBoxBaudRate.ItemIndex:= -1;
  comboBoxDataBits.ItemIndex:= 4;     //устанавливаем 8 бит, т.к. другие значения не используются
  comboBoxParity.ItemIndex:= -1;
  comboBoxStopBits.ItemIndex:= -1;

  RadioGroupSelectTypeController.ItemIndex:= 2;   //по умолчанию ставим на MK003

  EnabledDisebledField(false);
end;

procedure TFormLineSettingsConnection.comboBoxBaudRateChange(Sender: TObject);
begin
  ProcedureChangeData;
end;

procedure TFormLineSettingsConnection.comboBoxDataBitsChange(Sender: TObject);
begin
  ProcedureChangeData;
end;

procedure TFormLineSettingsConnection.comboBoxParityChange(Sender: TObject);
begin
  ProcedureChangeData;
end;

procedure TFormLineSettingsConnection.comboBoxPortNameChange(Sender: TObject);
begin
  ProcedureChangeData;
end;

procedure TFormLineSettingsConnection.comboBoxStopBitsChange(Sender: TObject);
begin
  ProcedureChangeData;
end;

procedure TFormLineSettingsConnection.LineConnectionList;
  var i: integer;
      DataSet: TDataSet;
begin
   //получаем список всех подключенных контроллеров
  try
    ADODataSetLineSettingsConnection.Close;
    ADODataSetLineSettingsConnection.CommandText:= 'select  * from SettingsCOMPort ORDER BY PortNum';
    ADODataSetLineSettingsConnection.Open;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[RefreshDataDBGrid]' + #13#10 + e.Message + #13#10 +
                               '"' + ADODataSetLineSettingsConnection.CommandText +'"'),
                               PChar(Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;

  with DBGridListLineConnection do
    begin
      Columns[0].Title.Alignment:= taCenter;
      Columns[0].Width:= 253;
      Columns[1].Title.Alignment:= taCenter;
      Columns[1].Width:= 60;

      //скрываем колонки
      for i := 2 to Columns.Count - 1 do
        Columns[i].Visible:= false;
    end;

  ADODataSetLineSettingsConnectionAfterScroll(DataSet);
end;

//загружаем данные настроек COM порта в ComboBox
procedure TFormLineSettingsConnection.LoadDataSettingsCOMPort;
  var i: integer;
begin
  comboBoxBaudRate.Clear;
  for i := 0 to High(ListBaudRate) do
    comboBoxBaudRate.Items.AddObject(ListBaudRate[i].Caption, TObject(ListBaudRate[i].Volume));

  comboBoxDataBits.Clear;
  for i := 0 to High(ListDataBits) do
    comboBoxDataBits.Items.AddObject(ListDataBits[i].Caption, TObject(ListDataBits[i].Volume));

  comboBoxParity.Clear;
  for i := 0 to High(ListParity) do
    comboBoxParity.Items.AddObject(ListParity[i].Caption, TObject(ListParity[i].Volume));

  comboBoxStopBits.Clear;
  for i := 0 to High(ListStopBits) do
    comboBoxStopBits.Items.AddObject(ListStopBits[i].Caption, TObject(ListStopBits[i].Volume));
end;

procedure TFormLineSettingsConnection.UpdateLineConnectionList(SetCursorPosition: boolean = true);
  var TempCodeConnect: integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  Color:= clBtnFace;

  SpeedButtonDeleteLineConnection.Enabled:= true;
  SpeedButtonAddLineConnection.Enabled:= true;
  DBGridListLineConnection.Enabled:= true;

  TempCodeConnect:= CodeLineSettingsConnection; //запоминаем позицию курсора в DBGrid

  LineConnectionList;

  if SetCursorPosition then
    begin
      CodeLineSettingsConnection:= TempCodeConnect;
      //восстанавливаем позицию курсора
      DBGridListLineConnection.DataSource.DataSet.Locate('Sp_Code', CodeLineSettingsConnection, []);
    end;
  DBGridListLineConnection.SetFocus;
end;

procedure TFormLineSettingsConnection.SpeedButtonAddLineConnectionClick(
  Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if ChangeData then SaveDataInBD;

  ClearAllData;
  EnabledDisebledField;

  SpeedButtonDeleteLineConnection.Enabled:= false;
  SpeedButtonAddLineConnection.Enabled:= false;
  DBGridListLineConnection.Enabled:= false;

  Color:= ColorEdit;

  EditLineConnectionName.SetFocus;
end;

//из полного имени COM-порта получаем его номер
function PortNumByLongNamePort(NamePort: string): integer;
  var index: integer;
begin
  index:= pos(' ', NamePort);   //ищем первый пробел. Это и будет граница имени порта
  try
    result:= strtoint(trim(copy(NamePort, 4, index - 4)));   //4, т.к. пропускаем слово COM
  except
    result:= -1;
  end;
end;

//проверяем настройки COM порта сочитания Parity - StopBit для MK003
function CheckSettingsParityStopBit(Parity, StopBit: byte): boolean;
begin
  if ((Parity = NOPARITY) and (StopBit = ONESTOPBIT)) or
     ((Parity = NOPARITY) and (StopBit = TWOSTOPBITS)) or
     ((Parity = EVENPARITY) and (StopBit = ONESTOPBIT)) or
     ((Parity = ODDPARITY) and (StopBit = ONESTOPBIT))
     then result:= true
     else result:= false;
end;

//проверям свободен ли порт стаким номером
// -1 - ошибка базы данных
// 0 - номер порта свободен
// 1 - номер порта занят
function TFormLineSettingsConnection.PortWithThisNumberBusy(Code, PortNum: integer;
            var LineConnectionName: string): integer;
begin
  LineConnectionName:= '';
  if not DM.DataSetWS('SELECT * FROM SettingsCOMPort WHERE PortNum = ' + inttostr(PortNum),
                                  Caption, 'PortWithThisNumberBusy') then
    begin
      result:= -1;
      exit;
    end;
  if DM.DataSourceDataSetWS.DataSet.RecordCount > 0 then
    begin
      LineConnectionName:= DM.ADODataSetWS.FieldByName('NameConnection').AsString;
      if code = DM.ADODataSetWS.FieldByName('Sp_Code').AsInteger then
        begin
          //значит редактировали существующую запись. ничего страшного, что с тем же номером порта
          result:= 0;
          exit;
        end
        else
        begin
          //значит данный COM порт занят
          result:= 1;
          exit;
        end;
    end
    else result:= 0;

end;

procedure TFormLineSettingsConnection.SaveDataInBD;
  var codeErr: integer;
      LineConnectionName, NameControllers: string;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Сохранить изменения для линии связи: "' +
                                  EditLineConnectionName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if Trim(EditLineConnectionName.Text) = '' then
        begin
          Application.MessageBox(PChar('Не присвоено имя линии связи.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditLineConnectionName.SetFocus;
          exit;
        end;

      if comboBoxPortName.Text = '' then
        begin
          Application.MessageBox(PChar('Не назначен COM-порт.'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
          comboBoxPortName.SetFocus;
          exit;
        end;

      if comboBoxBaudRate.Text = '' then
        begin
          Application.MessageBox(PChar('Не выбрана скорость COM-порта.'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
          comboBoxBaudRate.SetFocus;
          exit;
        end;

      if comboBoxDataBits.Text = '' then
        begin
          Application.MessageBox(PChar('Не выбрано значение бит данных для COM-порта.'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
          comboBoxDataBits.SetFocus;
          exit;
        end;

      if comboBoxParity.Text = '' then
        begin
          Application.MessageBox(PChar('Не выбрано значение четности для COM-порта.'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
          comboBoxParity.SetFocus;
          exit;
        end;

      if comboBoxStopBits.Text = '' then
        begin
          Application.MessageBox(PChar('Не выбрано значение стоповых битов для COM-порта.'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
          comboBoxStopBits.SetFocus;
          exit;
        end;

      if RadioGroupSelectTypeController.ItemIndex = 2 then //для MK003
        if not CheckSettingsParityStopBit(byte(comboBoxParity.Items.Objects[comboBoxParity.ItemIndex]),
            byte(comboBoxStopBits.Items.Objects[comboBoxStopBits.ItemIndex])) then
            begin
              Application.MessageBox(PChar('Можно задать только следующие сочетание значений "Четность" и "Стоповых бит":' + #10#13#10#13#09 +
                'Четность - НЕТ, Стоповый бит - 1' + #10#13#09 +
                'Четность - НЕТ, Стоповый бит - 2' + #10#13#09 +
                'Четность - ЧЕТ, Стоповый бит - 1' + #10#13#09 +
                'Четность - НЕЧЕТ, Стоповый бит - 1'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
              comboBoxParity.SetFocus;
              exit;
            end;

      codeErr:= PortWithThisNumberBusy(CodeLineSettingsConnection,
                  PortNumByLongNamePort(comboBoxPortName.Text),
                  LineConnectionName);
      case codeErr of
        -1: exit;   //ошибка базы данных
         1: begin
              Application.MessageBox(PChar('"COM' + inttostr(PortNumByLongNamePort(comboBoxPortName.Text)) +
                '" уже назначен на линию связи "' + LineConnectionName + '".'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
              comboBoxPortName.SetFocus;
              exit;
            end;
      end;

      if CodeLineSettingsConnection = 0 then        //заносим новую запись
        begin
          if not DM.CommandWS('INSERT INTO SettingsCOMPort (PortNum, BaudRate, DataBits, Parity, StopBits, NameConnection, TypeController) VALUES (''' +
              inttostr(PortNumByLongNamePort(comboBoxPortName.Text)) + ''', ''' +
              IntToStr(integer(comboBoxBaudRate.Items.Objects[comboBoxBaudRate.ItemIndex])) + ''', ''' +
              IntToStr(integer(comboBoxDataBits.Items.Objects[comboBoxDataBits.ItemIndex])) + ''', ''' +
              IntToStr(integer(comboBoxParity.Items.Objects[comboBoxParity.ItemIndex])) + ''', ''' +
              IntToStr(integer(comboBoxStopBits.Items.Objects[comboBoxStopBits.ItemIndex])) + ''', ''' +
              Trim(EditLineConnectionName.Text) + ''', ''' +
              inttostr(RadioGroupSelectTypeController.ItemIndex + 1) + ''')',
                Caption, 'SaveDataInBD') then exit;

              //узнаем номер уникальной записи (последней записи)
              if not DM.DataSetWS('SELECT MAX(Sp_Code) as cod FROM SettingsCOMPort',
                                  Caption, 'SaveDataInBD') then exit;
              if not DM.ADODataSetWS.Eof then CodeLineSettingsConnection:= DM.ADODataSetWS.FieldByName('cod').AsInteger;
        end
        else
        begin
          //если данная линия связи используется и в нее внесены изменения,
          //выводим сообщение о необходимости настройки параметров связи для контроллеров,
          //которые используют данную линию связи
          if CheckConnectLineCommunication(CodeLineSettingsConnection, NameControllers) then
            Application.MessageBox(PChar('Линия связи "' + EditLineConnectionName.Text +
            '" используется с контроллерам(и): ' + #13#10#13#10 + NameControllers + #13#10 +
            'при изменении ее настроек, необходимо записать новые парметры линии связи в контроллер(ы):' + #13#10 +
            '"Рабочая станция" -> "Настройка технических параметров" -> "Подключение контроллеров" -> ' +
            '"Настроить параметры связи".'),
                            PChar(ProgName_ShortStringVersion + ' Внимание !!!'),
                            MB_OK + MB_ICONWARNING);


          if not DM.CommandWS('UPDATE SettingsCOMPort SET PortNum = ''' + inttostr(PortNumByLongNamePort(comboBoxPortName.Text)) +
              ''', BaudRate = ''' + IntToStr(integer(comboBoxBaudRate.Items.Objects[comboBoxBaudRate.ItemIndex])) +
              ''', DataBits = ''' + IntToStr(integer(comboBoxDataBits.Items.Objects[comboBoxDataBits.ItemIndex])) +
              ''', Parity = ''' + IntToStr(integer(comboBoxParity.Items.Objects[comboBoxParity.ItemIndex])) +
              ''', StopBits = ''' + IntToStr(integer(comboBoxStopBits.Items.Objects[comboBoxStopBits.ItemIndex])) +
              ''', NameConnection = ''' + Trim(EditLineConnectionName.Text) +
              ''', TypeController = ''' + inttostr(RadioGroupSelectTypeController.ItemIndex + 1) +
              ''' WHERE Sp_Code = ' + inttostr(CodeLineSettingsConnection),
                Caption, 'SaveDataInBD') then exit;
        end;
    end;

  ProcedureChangeData(false);
  UpdateLineConnectionList;
end;

//проверяем назначена ли удаляемая линия связи к какому-либо контроллеру и если назначена, получаем имена контроллеров
function TFormLineSettingsConnection.CheckConnectLineCommunication(Sp_Code: integer; var NameControllers: string): boolean;
begin
  result:= false;
  NameControllers:= '';
  if not DM.DataSetWS('SELECT * FROM LinkContr WHERE Sp_Code = ' + inttostr(Sp_Code),
   Caption, 'CheckConnectLineCommunication') then exit;

  if DM.DataSourceDataSetWS.DataSet.RecordCount > 0 then
    begin
      result:= true;
      DM.ADODataSetWS.First;
      while not DM.ADODataSetWS.Eof do
        begin
          NameControllers:= NameControllers + #9 +
            DM.ADODataSetWS.FieldByName('NameController').AsString + #13#10;
          DM.ADODataSetWS.Next;
        end;
    end;
end;

procedure TFormLineSettingsConnection.SpeedButtonDeleteLineConnectionClick(
  Sender: TObject);
  var NameController: string;
begin
  if Application.MessageBox(PChar('Удалить линию связи: "' +
                                  EditLineConnectionName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
      if CheckConnectLineCommunication(CodeLineSettingsConnection, NameController) then
        if Application.MessageBox(PChar('Линия связи "' + EditLineConnectionName.Text +
            '" используется с контроллерам(и): ' + #13#10#13#10 + NameController + #13#10 +
            'при ее удалении, оборудование будет не подключено!!!' + #13#10 +
            'Продолжить ?'), PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
            MB_YESNO + MB_ICONWARNING) = IDNO then exit;

      if not DM.QueryWorkStation('DELETE FROM SettingsCOMPort WHERE Sp_Code = ' + IntToStr(CodeLineSettingsConnection),
                  Caption, 'SpeedButtonDeleteConnectClick', false) then exit;
      UpdateLineConnectionList(false);
    end;
end;

procedure TFormLineSettingsConnection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ChangeData then SaveDataInBD;
  UpdateLineConnectionList(false);
end;

procedure TFormLineSettingsConnection.FormCreate(Sender: TObject);
begin
  Caption:= ProgName_ShortStringVersion + Caption;
end;

// из вида "Prolific USB-to-Serial Comm Port (COM4)" преобразуем в вид "COM4 - Prolific USB-to-Serial Comm Port"
function TrnsformCaptionNameCOMport(CaptionNamePort: string): string;
var index: integer;
begin
  index:= pos('(COM', CaptionNamePort);
  result:= Trim(copy(CaptionNamePort, index + 1, CaptionNamePort.Length - 1 - index)) + ' - ' + Trim(copy(CaptionNamePort, 1, index - 1));
end;

procedure TFormLineSettingsConnection.FormShow(Sender: TObject);
  var
    PortInfo: TSerialPortInfo;
    PortEnum: TSerialPortEnum;
begin
  Screen.Cursor:= crHourGlass;
  ClearAllData;
  //получаем список всех COM портов
  comboBoxPortName.Clear;
  PortEnum := TSerialPortEnum.Create;
  try
    for PortInfo in PortEnum do
      if pos('(COM', PortInfo.Caption) <> 0 then   //выбираем только COM порты, т.к. после запроса могут быть еще и LPT порты
        comboBoxPortName.Items.Add(TrnsformCaptionNameCOMport(PortInfo.Caption));
  finally
    PortEnum.Free;
  end;

  LoadDataSettingsCOMPort;      //загружаем данные настроек COM порта в ComboBox
  LineConnectionList;

  Screen.Cursor:= crDefault;
end;

procedure TFormLineSettingsConnection.ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //если данные были изменены, разрешаем кнопку "Применить"
end;

procedure TFormLineSettingsConnection.RadioGroupSelectTypeControllerClick(
  Sender: TObject);
begin
  ProcedureChangeData;
  if RadioGroupSelectTypeController.ItemIndex in [0,1] then    //MK001, MK002
    begin                                                      //запрещаем изменять настройки порта для MK001, MK002
      ButtonSettingsCOMportDefaultClick(Sender);
      comboBoxBaudRate.Enabled:= false;
      comboBoxDataBits.Enabled:= false;
      comboBoxParity.Enabled:= false;
      comboBoxStopBits.Enabled:= false;
      ButtonSettingsCOMportDefault.Visible:= false;
    end
    else begin
      comboBoxBaudRate.Enabled:= true;
      comboBoxDataBits.Enabled:= false;  //всегда отключено
      comboBoxParity.Enabled:= true;
      comboBoxStopBits.Enabled:= true;
      ButtonSettingsCOMportDefault.Visible:= true;
    end;
end;

end.
