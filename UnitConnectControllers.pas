unit UnitConnectControllers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Grids, UnitDM,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Buttons, UnitMyForm, RudaGlobals,
  tlhelp32, Vcl.ComCtrls, Vcl.ExtCtrls{обязательно ПОСЛЕДНИМ};

type
  PCOMPort = ^TCOMPort;
  TCOMPort = record
    PortName : string;
    BaudRate : integer;
    DataBits : integer;
    Parity   : integer;
    StopBits : integer;
  end;

type
  TFormConnectControllers = class(TForm)
    DataSourceConnectControllers: TDataSource;
    ADODataSetConnectControllers: TADODataSet;
    PanelMain: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label6: TLabel;
    LabelNumCh: TLabel;
    Label2: TLabel;
    ComboBoxControllersList: TComboBox;
    comboBoxLineConnection: TComboBox;
    SpinEditNumCh: TSpinEdit;
    EditСontrollerNameInSystem: TEdit;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ButtonClose: TButton;
    Panel1: TPanel;
    DBGridConnectControllers: TDBGrid;
    Panel3: TPanel;
    SpeedButtonAddConnect: TSpeedButton;
    SpeedButtonDeleteConnect: TSpeedButton;
    SpeedButtonSettingsCommunication: TSpeedButton;
    PanelSettingsCommunication: TPanel;
    ButtonBack: TButton;
    ButtonCancelSettingsCommunication: TButton;
    ButtonNext: TButton;
    LabelText: TLabel;
    LabelInfoCommunication: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StringGridParamControllers: TStringGrid;
    StringGridParamLineConnection: TStringGrid;
    ADODataSetConnectControllersLc_Code: TAutoIncField;
    ADODataSetConnectControllersPlata: TWordField;
    ADODataSetConnectControllersCn_Code: TWordField;
    ADODataSetConnectControllersSp_Code: TIntegerField;
    ADODataSetConnectControllersNameController: TWideStringField;
    ADODataSetConnectControllersPlataAddress: TWordField;
    ADODataSetConnectControllersSel: TBooleanField;
    ADODataSetConnectControllersNameConnection: TWideStringField;
    TabSheetDataController: TTabSheet;
    Label5: TLabel;
    EditTotalWorkTime: TEdit;
    ButtonRefreshDataController: TButton;
    Label7: TLabel;
    EditDateTimeLastData: TEdit;
    LabelErrDataController: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    EditCountReceivedPacketsWithError: TEdit;
    Label4: TLabel;
    EditCountCRCError: TEdit;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    EditNumberRequests: TEdit;
    EditNumberRequestsNoAnswer: TEdit;
    EditNumberRequestsCRCErr: TEdit;
    Label10: TLabel;
    TimerShowButtonRefreshDataController: TTimer;
    LabelStatusRequest: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ControllersList;
    procedure ConnectControllersList(all: boolean = true);
    procedure RefreshDataDBGrid(all: boolean = true);
    procedure ClearAllData;
    procedure EnabledDisebledField(param: boolean);
    procedure ComboBoxControllersListChange(Sender: TObject);
    procedure StringGridParamControllersDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure SpinEditNumChKeyPress(Sender: TObject; var Key: Char);
    procedure SpinEditNumChChange(Sender: TObject);
    procedure SaveDataInBD;
    procedure ADOQueryConnectControllersBeforeScroll(DataSet: TDataSet);
    procedure UpdateConnectControllersList(SetCursorPosition: boolean; all: boolean = true);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure SpeedButtonAddConnectClick(Sender: TObject);
    procedure SpeedButtonDeleteConnectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
    procedure comboBoxLineConnectionChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ADODataSetConnectControllersAfterScroll(DataSet: TDataSet);
    procedure EditСontrollerNameInSystemKeyPress(Sender: TObject;
      var Key: Char);
    function CheckConnectController(Lc_Code: Int64; var MeasurerName: string): boolean;
    procedure ADODataSetConnectControllersPlataAddressGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure LineConnectList(TypeController: integer);
    procedure DBGridConnectControllersDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGridConnectControllersCellClick(Column: TColumn);
    procedure DBGridConnectControllersColEnter(Sender: TObject);
    procedure DBGridConnectControllersColExit(Sender: TObject);
    procedure DBGridConnectControllersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADODataSetConnectControllersSelGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    function CheckFreeCOMPort(Sp_Code: Int64; Address: integer): integer;
    procedure SpeedButtonSettingsCommunicationClick(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    function CheckExistMK003: boolean;
    procedure ButtonCancelSettingsCommunicationClick(Sender: TObject);
    procedure ExitSettingsCommunication;
    function ExistSelectController: boolean;
    procedure ButtonBackClick(Sender: TObject);
    procedure ResetSelectController;
    procedure SetNewSettingsCommunication;
    function OpenComPort(itemCOMPort: TCOMPort; var hPort: THandle): boolean;
    procedure StringGridParamLineConnectionDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure ClearStringGridParamLineConnection;
    procedure ADODataSetConnectControllersBeforeScroll(DataSet: TDataSet);
    procedure AddData(TransferDataController: TTransferDataController);
    function CheckControllerPolled(Lc_Code: int64): boolean;
    procedure ButtonRefreshDataControllerClick(Sender: TObject);
    procedure ClearFieldDataController;
    procedure ShowInfoAboutStateRequest(txt: string; flag: boolean = true);
    procedure ReadAllData;
    procedure TimerShowButtonRefreshDataControllerTimer(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);    //получаем все необходимые данные по фабрике
  private
    { Private declarations }

    GridOriginalOptions : TDBGridOptions; //для check DBGrid
    procedure WMCopyData(var MessageData: TWMCopyData); message WM_COPYDATA;
    const
      ColWidths0 = 50;     //Ширина колонки 0 в % StringGridUserList
      ColWidths1 = 50;     //Ширина колонки 1 в % StringGridUserList

    var
    ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                            //измененные данные записать в базу данных
  public
    { Public declarations }
  end;

type
  TConnectControllersList = class
  private
    fCn_Code: Int64;
    fController: string;
    fTypeController: integer;
    fNumberAnalogInput: integer;
    fSizeWeightCounter: integer;
    fVersion_Hi: integer;
    fVersion_Lo: integer;
    fAddressCorrection: integer;
  public
    property Cn_Code : Int64 read fCn_Code;
    property Controller : string read fController;
    property TypeController : integer read fTypeController;
    property NumberAnalogInput : integer read fNumberAnalogInput;
    property SizeWeightCounter : integer read fSizeWeightCounter;
    property Version_Hi : integer read fVersion_Hi;
    property Version_Lo : integer read fVersion_Lo;
    property AddressCorrection : integer read fAddressCorrection;

    constructor Create(const Cn_Code: Int64; const Controller: string;
      const TypeController: integer; const NumberAnalogInput: integer; const SizeWeightCounter: integer; const Version_Hi : integer;
      const Version_Lo: integer; const AddressCorrection : integer);
  end;

type
  TLineConnectionList = class
  private
    fSp_Code: Int64;
    fPortName: string;
    fPortNum: integer;
    fBaudRate: integer;
    fDataBits: integer;
    fParity: integer;
    fStopBits: integer;
  public
    property Sp_Code : Int64 read fSp_Code;
    property PortName : string read fPortName;
    property PortNum : integer read fPortNum;
    property BaudRate : integer read fBaudRate;
    property DataBits : integer read fDataBits;
    property Parity : integer read fParity;
    property StopBits : integer read fStopBits;

    constructor Create(const Sp_Code: Int64;
      const PortNum: integer; const BaudRate: integer; const DataBits: integer; const Parity : integer;
      const StopBits: integer);
  end;

var
  FormConnectControllers: TFormConnectControllers;
  CodeConnectСontrollers: integer;
  pMassTransfer_DataController: PMassTransferDataController;
  IndexText: integer;
  LinesChannels: TLinesChannels;
  UsedChannels: TUsedChannels;
  ReceivingData: boolean;       //true - данные принемаются, false - данные ожидаются
  Lines: TLines;  //список кодов подключенных конвейеров (по порядку), последний байт - общее число конвейеров
  Controllers: TControllers;
  NumberRequests: Int64 = 0;         //Общее число запросов к контроллеру
  NumberRequestsNoAnswer: Int64 = 0; //Число запросов с ошибкой "Нет ответа"
  NumberRequestsCRCErr: Int64 = 0;   //Число запросов с ошибкой CRC
  StateVisebleButtonRefreshData: boolean = false; //true - состояние отображения изменилось, false - не изменилось
  NumPage: integer;                               //для запоминания номера вкладки PageControl с характеристиками контроллера
  TextMsg: array[0..4] of string = (
    'На всех контроллерах, у которых необходимо настроить параметры связи последовательного' +
    ' порта, необходимо установить перемычку "Параметры связи" в значение "По умолчанию".',

    'В таблице с контроллерами отметьте флажками те контроллеры, у которых была ' +
    'переключена перемычка "Параметры связи" в значение "По умолчанию".',

    'Проверьте правильность выбранных контроллеров.' + #10#13#10#13 + 'Если все контроллеры выбраны верно, ' +
    'нажмите кнопку "Далее". Программа пропишет новые значения параметров линий связи в выбранные контроллеры.',

    '',

    'Изменения параметров связи завершены.' + #10#13#10#13 + 'Если больше никаких изменений параметров связи в ' +
    'выбранных контроллерах не будут производиться, перемычку "Параметры связи" в контроллерах ' +
    'необходимо вернуть в исходное состояние.');

implementation
uses MainUnit, UnitSettingsProgramm, EnumSerialPorts;
{$R *.dfm}

constructor TConnectControllersList.Create(const Cn_Code : Int64; const Controller : string;
      const TypeController : integer; const NumberAnalogInput : integer; const SizeWeightCounter : integer;
      const Version_Hi : integer; const Version_Lo : integer; const AddressCorrection : integer);
begin
  inherited Create;
  fCn_Code:= Cn_Code;
  fController:= Controller;
  fTypeController:= TypeController;
  fNumberAnalogInput:= NumberAnalogInput;
  fSizeWeightCounter:= SizeWeightCounter;
  fVersion_Hi:= Version_Hi;
  fVersion_Lo:= Version_Lo;
  fAddressCorrection:= AddressCorrection;
end;

constructor TLineConnectionList.Create(const Sp_Code: Int64;
    const PortNum: Integer; const BaudRate: Integer; const DataBits: Integer;
    const Parity: Integer; const StopBits: Integer);
begin
  inherited Create;
  fSp_Code:= Sp_Code;
  fPortName:= 'COM' + inttostr(PortNum);
  fPortNum:= PortNum;
  fBaudRate:= BaudRate;
  fDataBits:= DataBits;
  fParity:= Parity;
  fStopBits:= StopBits;
end;

procedure TFormConnectControllers.WMCopyData(var MessageData: TWMCopyData);
  var i: integer;
begin
  if MessageData.CopyDataStruct.dwData = CMD_DATCON then
    begin
      pMassTransfer_DataController:= MessageData.CopyDataStruct.lpData;
      for i := Low(pMassTransfer_DataController.MassTransferDataControllers) to High(pMassTransfer_DataController.MassTransferDataControllers) do
        if CodeConnectСontrollers = integer(pMassTransfer_DataController^.MassTransferDataControllers[i].Lc_Code) then
          begin
            AddData(TTransferDataController(pMassTransfer_DataController^.MassTransferDataControllers[i]));
            ButtonRefreshDataController.Visible:= false;
          end;
    end;
end;

procedure TFormConnectControllers.AddData(TransferDataController: TTransferDataController);
begin
  ReceivingData:= true; //признак обработки данных

  EditDateTimeLastData.Text:= FormatDateTime('dd.mm.yyyy hh:nn:ss', TransferDataController._Date);
  EditNumberRequests.Text:= inttostr(TransferDataController.NumberRequests);
  EditNumberRequestsNoAnswer.Text:= inttostr(TransferDataController.NumberRequestsNoAnswer);
  EditNumberRequestsCRCErr.Text:= inttostr(TransferDataController.NumberRequestsCRCErr);

  if TransferDataController.Err = Err_None then
    begin
      EditCountReceivedPacketsWithError.Text:= inttostr(TransferDataController.CountReceivedPacketsWithError);
      EditCountCRCError.Text:= inttostr(TransferDataController.CountCRCError);
      EditTotalWorkTime.Text:= inttostr(TransferDataController.TotalWorkTime);
      LabelErrDataController.Caption:= '';
    end
    else begin
      EditTotalWorkTime.Clear;
      EditCountReceivedPacketsWithError.Clear;
      EditCountCRCError.Clear;
      ShowInfoAboutStateRequest('ОШИБКА: ' + TErrRudaMonitorName[TransferDataController.Err]);
    end;

  ReceivingData:= false; //признак данные обработаны
end;

function ListControllers(var Controllers: TControllers): TErrRudaMonitor;
  var lName: string;
begin
  result:= Err_None;
  FillChar(Controllers, sizeof(Controllers), 0);
  //формируем список контроллеров с параметрами
  if not DM.QueryWorkStation('SELECT LinkContr.*, SettingsCOMPort.* ' +
    'FROM LinkContr INNER JOIN SettingsCOMPort ON LinkContr.Sp_Code = SettingsCOMPort.Sp_Code',
    'FormConnectControllers', 'ListControllers', true) then
    begin
      DM.log('Ошибка базы "WorkStation" таблица "LinkContr".', 2);
      result:= Err_СonnectingToDatabase;
      exit;
    end;
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      if not DM.QueryServer('SELECT * FROM Controllers WHERE Cn_Code = ' +
               trim(DM.ADOQueryWorkStationMDB.FieldByName('Cn_Code').AsString),
                        'FormConnectControllers', 'ListControllers', true) then
        begin
          DM.log('Ошибка базы "Server" таблица "Controllers".', 2);
          result:= Err_СonnectingToDatabase;
          exit;
        end;
      if not DM.ADOQueryServerMDB.EOF then
        begin
          Controllers[DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger].Echo1:=
            DM.ADOQueryServerMDB.FieldByName('Cn_Echo1').AsInteger;
          Controllers[DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger].Echo2:=
            DM.ADOQueryServerMDB.FieldByName('Cn_Echo2').AsInteger;
          Controllers[DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger].EEPROM:= $40;      //по умолчанию стираем данные из EEPROM
          Controllers[DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger].SizeAnswer:=
            DM.ADOQueryServerMDB.FieldByName('Cn_SizeAnswer').AsInteger;
          Controllers[DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger].SizeCh:=
            DM.ADOQueryServerMDB.FieldByName('Cn_SizeCh').AsInteger;
          Controllers[DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger].Address:=
            DM.ADOQueryServerMDB.FieldByName('Cn_Address').AsInteger;
          Controllers[DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger].LcCode:=
            DM.ADOQueryWorkStationMDB.FieldByName('Lc_Code').AsInteger;

          Controllers[DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger].AddressMODBUS:=
            DM.ADOQueryWorkStationMDB.FieldByName('PlataAddress').AsInteger + 1;

          lName:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('NameController').AsString);
          StrPCopy(Controllers[DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger].NameController, lName);
        end;

      DM.ADOQueryWorkStationMDB.Next;
    end;
end;

procedure TFormConnectControllers.ReadAllData;    //получаем все необходимые данные по фабрике
begin
  DM.ListLine(Lines, Caption);
  DM.ListLineChannel(Lines, LinesChannels, UsedChannels, Caption);
  ListControllers(Controllers);
end;

function IsRunning(sName: string): boolean; // проверяет, запущен ли процесс sName
var
  han: THandle;
  ProcStruct: PROCESSENTRY32; // from "tlhelp32" in uses clause
  sID: string;
begin
  Result := false;
  // Get a snapshot of the system
  han := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
  if han = 0 then exit;
  // Loop thru the processes until we find it or hit the end
  ProcStruct.dwSize := sizeof(PROCESSENTRY32);
  if Process32First(han, ProcStruct) then
  begin
    repeat
      sID := ExtractFileName(ProcStruct.szExeFile);
      // Check only against the portion of the name supplied, ignoring case
      if uppercase(copy(sId, 1, length(sName))) = uppercase(sName) then
      begin
        // Report we found it
        Result := true;
        Break;
      end;
    until not Process32Next(han, ProcStruct);
  end;
  // clean-up
  CloseHandle(han);
end;

//используется ли данный канал контроллера на конвейере, который подключен к системе (конвейер подключен к системе)
function ByChannelNumberUsedOnLine(NumberChannel: byte): boolean;
  var i, j: integer;
begin
  result:= false;
  for i := Low(Lines) to Lines[High(Lines)] do
    if LinesChannels[i].ConnectLine then    //если конвейер подключен, смотрим указанный канал используется на нем
      for j := Low(LinesChannels[i].Channel) to High(LinesChannels[i].Channel) do
        begin
          if LinesChannels[i].Channel[j] = NumberChannel + 1 then
            begin
              result:= true;
              exit;
            end;
        end;
end;

//проверяем находится ли контроллер в состоянии опроса true - находится в состоянии опроса
function TFormConnectControllers.CheckControllerPolled(Lc_Code: int64): boolean;
  var HM: THandle;
      i: integer;
begin
  result:= false;
  if DM.FunTypeController <> 3 then exit;  //если не MK003 - выходим.

  //проверяем запущен ли опрос
  if not IsRunning(FileNameRudaMonitor) then exit;  //если опрос не запущен

  for i := Low(Controllers) to High(Controllers) do
    if Lc_Code = Controllers[i].LcCode then   //нужный контроллер найден
      begin
//        if UsedChannels[i] = 1 then  result:= true;   //контроллер задействован
        result:= ByChannelNumberUsedOnLine(i);
        break;
      end;
end;

//сбрасываем флаги выбора контроллеров
procedure TFormConnectControllers.ResetSelectController;
begin
  DBGridConnectControllers.DataSource.DataSet.First;
  while not DBGridConnectControllers.DataSource.DataSet.Eof do
    begin
      DBGridConnectControllers.DataSource.DataSet.Edit;
      DBGridConnectControllers.DataSource.DataSet.FieldByName('Sel').AsBoolean:= false;
      DBGridConnectControllers.DataSource.DataSet.Post;
      DBGridConnectControllers.DataSource.DataSet.Next;
    end;
end;

procedure TFormConnectControllers.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ChangeData then SaveDataInBD;

  if PanelSettingsCommunication.Visible then
    ExitSettingsCommunication;

  UpdateConnectControllersList(false);
end;

procedure TFormConnectControllers.FormCreate(Sender: TObject);
begin
  FormConnectControllers.Caption:= ProgName_ShortStringVersion + FormConnectControllers.Caption;

  StringGridParamControllers.RowCount:= 6;
  StringGridParamControllers.ColWidths[0]:= Trunc(StringGridParamControllers.Width * ColWidths0 / 100);
  StringGridParamControllers.ColWidths[1]:= StringGridParamControllers.Width - StringGridParamControllers.ColWidths[0];

  StringGridParamLineConnection.RowCount:= 6;
  StringGridParamLineConnection.ColWidths[0]:= Trunc(StringGridParamLineConnection.Width * ColWidths0 / 100);
  StringGridParamLineConnection.ColWidths[1]:= StringGridParamLineConnection.Width - StringGridParamLineConnection.ColWidths[0];
  with StringGridParamLineConnection do
    begin
      Cells[0, 1]:= 'Имя порта';
      Cells[0, 2]:= 'Скорость';
      Cells[0, 3]:= 'Биты данных';
      Cells[0, 4]:= 'Четность';
      Cells[0, 5]:= 'Стоповые биты';
    end;
end;

//список назначенных линий связи
procedure TFormConnectControllers.LineConnectList(TypeController: integer);
begin
  comboBoxLineConnection.Clear;
  //получаем список всех прописанных линий связи
  if not DM.DataSetWS('SELECT * FROM SettingsCOMPort WHERE TypeController = ' + inttostr(TypeController),
    Caption, 'LineConnectList') then exit;
  DM.ADODataSetWS.First;
  while not DM.ADODataSetWS.Eof do
    begin
      comboBoxLineConnection.Items.AddObject(DM.ADODataSetWS.FieldByName('NameConnection').AsString,
        TObject(TLineConnectionList.Create(DM.ADODataSetWS.FieldByName('Sp_Code').AsInteger,
                                           DM.ADODataSetWS.FieldByName('PortNum').AsInteger,
                                           DM.ADODataSetWS.FieldByName('BaudRate').AsInteger,
                                           DM.ADODataSetWS.FieldByName('DataBits').AsInteger,
                                           DM.ADODataSetWS.FieldByName('Parity').AsInteger,
                                           DM.ADODataSetWS.FieldByName('StopBits').AsInteger)));;
      DM.ADODataSetWS.Next;
    end;
end;

procedure TFormConnectControllers.FormDestroy(Sender: TObject);
  var i: integer;
begin
  //освобождаем память
  for i := 0 to ComboBoxControllersList.Items.Count - 1 do
    TConnectControllersList(ComboBoxControllersList.Items.Objects[i]).Free;

  for i := 0 to comboBoxLineConnection.Items.Count - 1 do
    TLineConnectionList(comboBoxLineConnection.Items.Objects[i]).Free;
end;

procedure TFormConnectControllers.FormShow(Sender: TObject);
begin
  Screen.Cursor:= crHourGlass;

  ClearAllData;

  ControllersList;

  ConnectControllersList;

  FormRudaAdmin.GridClean(StringGridParamControllers, true);  //убираем синий фокус из StringGridParamControllers
  FormRudaAdmin.GridClean(StringGridParamLineConnection, true);  //убираем синий фокус из StringGridParamLineConnection

  DBGridConnectControllers.SetFocus;
  ProcedureChangeData(false);

  Screen.Cursor:= crDefault;
  NumPage:= PageControl1.TabIndex;
  DBGridConnectControllers.DataSource.DataSet.First;            //ставим курсор в DBGridConnectControllers на первую позицию
  ReadAllData;    //получаем все необходимые данные по фабрике
end;

procedure TFormConnectControllers.SpeedButtonAddConnectClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if ChangeData then SaveDataInBD;

  ClearAllData;
  EnabledDisebledField(true);

  SpeedButtonDeleteConnect.Enabled:= false;
  SpeedButtonAddConnect.Enabled:= false;
  DBGridConnectControllers.Enabled:= false;
  SpeedButtonSettingsCommunication.Enabled:= false;

  FormConnectControllers.Color:= ColorEdit;
//  ComboBoxControllersList.Color:= ColorEdit;
//  SpinEditNumCh.Color:= ColorEdit;

  EditСontrollerNameInSystem.SetFocus;
end;

//проверяем задействован ли данный контроллер в системе
function TFormConnectControllers.CheckConnectController(Lc_Code: Int64; var MeasurerName: string): boolean;
  var txtSQL, NameLine: string;
begin
  result:= false;
  MeasurerName:='';
  txtSQL:= 'SELECT distinct(Ms_Status), Ms_Name, Measurer.L_Code ' +
    'FROM Measurer LEFT JOIN Points ON Measurer.Ms_Code = Points.Ms_Code ' +
    'WHERE (Measurer.Lc_Code = ' + inttostr(Lc_Code) + ' OR Points.Lc_Code = ' + inttostr(Lc_Code) +
    ') AND [Connect] ORDER BY Ms_Status';
  if not DM.QueryWorkStation(txtSQL, FormConnectControllers.Caption, 'CheckConnectController', true) then exit;

  DM.ADOQueryWorkStationMDB.First;
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      result:= true;

      //получаем имя конвейера, к которому подключено оборудование
      if not DM.QueryServer('Select L_Name FROM Lines Where L_Code = ' + Trim(DM.ADOQueryWorkStationMDB.FieldByName('L_Code').AsString),
        FormConnectControllers.Caption, 'CheckConnectController', true) then
        begin
          result:= false;
          MeasurerName:= '';
          exit;
        end;

      if DM.DataSourceServerMDB.DataSet.RecordCount > 0 then   //если запись найдена
        NameLine:= Trim(DM.ADOQueryServerMDB.FieldByName('L_Name').AsString)
        else NameLine:= 'н/д';

      MeasurerName:= MeasurerName + #9 + 'конвейер: ' + NameLine +
        ', оборудование: ' + Trim(DM.ADOQueryWorkStationMDB.FieldByName('Ms_Name').AsString) + #13#10;
      DM.ADOQueryWorkStationMDB.Next;
    end;
end;

procedure TFormConnectControllers.SpeedButtonDeleteConnectClick(
  Sender: TObject);
  var MeasurerName: string;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Удалить подключенный контроллер: "' +
                                  EditСontrollerNameInSystem.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if CheckConnectController(CodeConnectСontrollers, MeasurerName) then
        if Application.MessageBox(PChar('Контроллер: "' + ComboBoxControllersList.Text +
            '" используется с оборудованием: ' + #13#10 + MeasurerName + #13#10 +
            'при его удалении, оборудование будет не подключено, потребуется переподключение.' + #13#10 +
            'Продолжить ?'), PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
            MB_YESNO + MB_ICONWARNING) = IDNO then exit;

      if not DM.QueryWorkStation('DELETE FROM LinkContr WHERE Lc_Code = ' + IntToStr(CodeConnectСontrollers),
                  FormConnectControllers.Caption, 'SpeedButtonDeleteConnectClick', false) then exit;
      UpdateConnectControllersList(false);
      ReadAllData;    //получаем все необходимые данные по фабрике
    end;
end;

procedure TFormConnectControllers.SpeedButtonSettingsCommunicationClick(
  Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Перейти в настройки параметров связи контроллеров?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      UpdateConnectControllersList(false, false);

      SpeedButtonAddConnect.Enabled:= false;
      SpeedButtonDeleteConnect.Enabled:= false;
      SpeedButtonSettingsCommunication.Enabled:= false;
      ButtonBack.Enabled:= false;
      IndexText:= -1;

      PanelMain.Visible:= false;
      PanelSettingsCommunication.Visible:= true;
      ButtonNextClick(Sender);

      DBGridConnectControllers.Columns[0].Visible:= true;  //check
      DBGridConnectControllers.Columns[1].Width:=
        DBGridConnectControllers.Columns[1].Width - DBGridConnectControllers.Columns[0].Width;
    end;
end;

procedure TFormConnectControllers.SpinEditNumChChange(Sender: TObject);
begin
  ProcedureChangeData;
end;

procedure TFormConnectControllers.SpinEditNumChKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then ButtonSaveClick(Sender);
  if not (Key in ['1'..'8', #8, #13]) then
    begin
      Application.MessageBox(PChar('Диапазон значений номера канала должен быть от 1 до 8'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
      key:= #0;
      exit;
    end;
  ProcedureChangeData;
end;

procedure TFormConnectControllers.StringGridParamControllersDrawCell(
  Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  var   s: string;
     Flag: Cardinal;
begin
  if (ACol=0) and (ARow=0) then
    begin
      s:= 'Параметр';
      Flag:= DT_VCENTER or DT_CENTER or DT_SINGLELINE;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridParamControllers.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;

  if (ACol=1) and (ARow=0) then
    begin
      s:= 'Значение';
      //Если нет переноса слов, то выровнять по центру вертикали и горизонтали можно так
      Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_SINGLELINE;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridParamControllers.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;
end;

procedure TFormConnectControllers.StringGridParamLineConnectionDrawCell(
  Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  var   s: string;
     Flag: Cardinal;
begin
  if (ACol=0) and (ARow=0) then
    begin
      s:= 'Параметр';
      Flag:= DT_VCENTER or DT_CENTER or DT_SINGLELINE;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridParamLineConnection.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;

  if (ACol=1) and (ARow=0) then
    begin
      s:= 'Значение';
      //Если нет переноса слов, то выровнять по центру вертикали и горизонтали можно так
      Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_SINGLELINE;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridParamLineConnection.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;
end;

procedure TFormConnectControllers.TimerShowButtonRefreshDataControllerTimer(
  Sender: TObject);
  var tmpBool: boolean;
begin
  tmpBool:= CheckControllerPolled(CodeConnectСontrollers);  //если контроллер задействован и находится в опросе
  ButtonRefreshDataController.Visible:= not tmpBool;        //запретить ручное обновление параметров

  if tmpBool then
    begin
      if ReceivingData then LabelStatusRequest.Caption:= 'Обработка данных...'
        else LabelStatusRequest.Caption:= 'Ожидание данных...';
    end
    else begin
      LabelStatusRequest.Caption:= '';
      //если состояние кнопки видимости сменилось, обнуляем первоначальные данные числа запросов
      if StateVisebleButtonRefreshData <> tmpBool then
        begin
          NumberRequests:= 0;         //Общее число запросов к контроллеру
          NumberRequestsNoAnswer:= 0; //Число запросов с ошибкой "Нет ответа"
          NumberRequestsCRCErr:= 0;   //Число запросов с ошибкой CRC
        end;
    end;
end;

procedure TFormConnectControllers.ADODataSetConnectControllersAfterScroll(
  DataSet: TDataSet);
  var i: integer;
      ccl: TConnectControllersList;
      lcl: TLineConnectionList;
      Sender: TObject;

begin
  ClearAllData;
  if DBGridConnectControllers.DataSource.DataSet.RecordCount > 0 then
    begin
      EnabledDisebledField(true);
      CodeConnectСontrollers:= DBGridConnectControllers.DataSource.DataSet.FieldByName('Lc_Code').AsInteger;
      SpinEditNumCh.Value:= DBGridConnectControllers.DataSource.DataSet.FieldByName('PlataAddress').AsInteger + 1;
      EditСontrollerNameInSystem.Text:= Trim(DBGridConnectControllers.DataSource.DataSet.FieldByName('NameController').AsString);

      for i := 0 to ComboBoxControllersList.Items.Count - 1 do
        begin
          ccl:= ComboBoxControllersList.Items.Objects[i] as TConnectControllersList;

          if DBGridConnectControllers.DataSource.DataSet.FieldByName('Cn_Code').AsInteger = ccl.Cn_Code then
            begin
              ComboBoxControllersList.ItemIndex:= i;
              ComboBoxControllersListChange(Sender);
              break;
            end;
        end;

      for i := 0 to comboBoxLineConnection.Items.Count - 1 do
        begin
          lcl:= comboBoxLineConnection.Items.Objects[i] as TLineConnectionList;

          if DBGridConnectControllers.DataSource.DataSet.FieldByName('Sp_Code').AsInteger = lcl.Sp_Code then
            begin
              comboBoxLineConnection.ItemIndex:= i;
              comboBoxLineConnectionChange(Sender);
              break;
            end;
        end;

    end
    else begin
      EnabledDisebledField(false);
    end;

  if PageControl1.Pages[2].TabVisible then  //если страница с параметрами контроллера MK003 видимая
    begin
      TimerShowButtonRefreshDataController.Enabled:= true;
      PageControl1.TabIndex:= NumPage;
    end
    else begin
      TimerShowButtonRefreshDataController.Enabled:= false;
      if NumPage = 2 then PageControl1.TabIndex:= 0
        else PageControl1.TabIndex:= NumPage;
    end;

  ProcedureChangeData(false);  //чтобы не зафиксировать изменения при прокрутки скролом и данные не записывались в базу данных
end;

procedure TFormConnectControllers.ADODataSetConnectControllersBeforeScroll(
  DataSet: TDataSet);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormConnectControllers.ADODataSetConnectControllersPlataAddressGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString = '' then Text:= ''
                          else Text:= IntToStr(Sender.AsInteger + 1);
end;

procedure TFormConnectControllers.ADODataSetConnectControllersSelGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text:= '';     //чтобы не было название False или True
end;

procedure TFormConnectControllers.ADOQueryConnectControllersBeforeScroll(
  DataSet: TDataSet);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormConnectControllers.ButtonBackClick(Sender: TObject);
begin
  dec(IndexText);
  LabelText.Caption:= TextMsg[IndexText];

  case IndexText of
                0: ButtonBack.Enabled:= false;
                3: LabelText.Caption:= 'Для повторного изменения параметров связи нажмите "Назад"';
    High(TextMsg): ButtonNext.Caption:= 'Закончить';
    else ButtonNext.Caption:= 'Далее';
  end;

  LabelInfoCommunication.Caption:= '';
end;

procedure TFormConnectControllers.ButtonCancelClick(Sender: TObject);
begin
  UpdateConnectControllersList(true);
end;

procedure TFormConnectControllers.ButtonCancelSettingsCommunicationClick(
  Sender: TObject);
begin
  if Application.MessageBox(PChar('Выйти из настроек параметров связи контроллера?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      ExitSettingsCommunication;
    end;
end;

procedure TFormConnectControllers.ButtonCloseClick(Sender: TObject);
begin
  FormConnectControllers.Close;
end;

procedure TFormConnectControllers.ExitSettingsCommunication;
begin
  PanelSettingsCommunication.Visible:= false;
  PanelMain.Visible:= true;
  DBGridConnectControllers.Columns[0].Visible:= false;  //check
  DBGridConnectControllers.Columns[1].Width:=
     DBGridConnectControllers.Columns[1].Width + DBGridConnectControllers.Columns[0].Width;

  ResetSelectController;  //сбрасываем флаги выбора контроллеров
  UpdateConnectControllersList(false);
end;

function TFormConnectControllers.ExistSelectController: boolean;
begin
  result:= false;
  DBGridConnectControllers.DataSource.DataSet.First;
  while not DBGridConnectControllers.DataSource.DataSet.Eof do
    begin
      if DBGridConnectControllers.DataSource.DataSet.FieldByName('Sel').AsBoolean then
        begin
          result:= true;
          break;
        end;
      DBGridConnectControllers.DataSource.DataSet.Next;
    end;
end;

function TFormConnectControllers.OpenComPort(itemCOMPort: TCOMPort; var hPort: THandle): boolean;
  var Dcb: TDcb;
begin
  result:= true;
  hPort:= 0;
   //открываем порт
  hPort:= CreateFile(PChar('\\.\' + itemCOMPort.PortName),
			                GENERIC_READ or GENERIC_WRITE,
                      0,nil,OPEN_EXISTING,
			                FILE_ATTRIBUTE_NORMAL or FILE_FLAG_OVERLAPPED,0);

  if hPort <> INVALID_HANDLE_VALUE then
    begin
          //сброс порта
      if not PurgeComm(hPort, PURGE_RXABORT or PURGE_RXCLEAR or PURGE_TXCLEAR or PURGE_TXABORT) then
        begin
          result:= false;
          exit;
        end;

      if not GetCommState(hPort, Dcb) then
        begin
          result:= false;
          exit;
        end;

      Dcb.BaudRate:= itemCOMPort.BaudRate; // CBR_9600;
      Dcb.ByteSize:= itemCOMPort.DataBits; //8
      Dcb.Parity  := itemCOMPort.Parity;   // NOPARITY;
      Dcb.StopBits:= itemCOMPort.StopBits; //TWOSTOPBITS;

      Dcb.Flags:= Dcb.Flags And $FFFFC481;

      if not SetCommState(hPort, Dcb) then
        begin
          result:= false;
          exit;
        end;

          // установка маски
      if not SetCommMask(hPort, EV_RXCHAR) then
        begin
          result:= false;
          exit;
        end;

    end
    else begin
       result:= false;
    end;
end;

//заносим значение по умолчанию
procedure SettingsCOMportDefault(var itemCOMPort: TCOMPort);
begin
  itemCOMPort.BaudRate:= DefaultSettingsCOMPortMK003.BaudRate;
  itemCOMPort.DataBits:= DefaultSettingsCOMPortMK003.ByteSize;
  itemCOMPort.Parity:= DefaultSettingsCOMPortMK003.Parity;
  itemCOMPort.StopBits:= DefaultSettingsCOMPortMK003.StopBits;
end;

//hComm — хэндл порта
//Buff — указатель на массив байт для передачи
//Count — количество байт для передачи
//Writed — количество байт, записанных в буфер передачи драйвера
//Wait — если = True, то Writed = Count (других вариантов не встречал), в противном случае Writed = 0, для асинхронного режима.
function WriteComm(hComm : THandle; Buff : array of byte; Count : integer;
                   Wait : boolean) : cardinal; //возвращает число записанных байт
var
  Ovr : TOverlapped;
begin
  PurgeComm(hComm, PURGE_RXABORT or PURGE_RXCLEAR or PURGE_TXCLEAR or PURGE_TXABORT);
  EscapeCommFunction(hComm, CLRRTS);    // RTS=0;
  Sleep(50);  //50
  //инициализируем TOverlapped структуру
  FillChar(Ovr,SizeOf(TOverlapped),0);
  Ovr.hEvent := CreateEvent(nil,TRUE,FALSE,nil);

  //пытаемся записывать в порт
  if not WriteFile(hComm, Buff, Count, Result, @Ovr) and Wait then begin
    //обрабатываем случай "отложенной" записи
    if (GetLastError() = ERROR_IO_PENDING) and
       (WaitForSingleObject(Ovr.hEvent, INFINITE) = Wait_Object_0)
     then GetOverlappedResult(hComm, Ovr, Result, Wait);
  end;

  Sleep(20);   //20
  if Ovr.hEvent <> 0 then CloseHandle(Ovr.hEvent);
end;

function SendMODBUS(Send: array of byte; hPort: THandle; var Otvet; sizeOtvet: integer; timeOut: DWORD): TErrRudaMonitor;
  var Ovr: TOverlapped;
      dwMask, dwRet, dwError: DWORD;
      Stat: TComStat;
      ErrMODBUS: TOtvetWithError;
      CheckSum: WORD;
      stepTimeOut, totalTimeOut: DWORD;
begin
  inc(NumberRequests);  //Общее число запросов к контроллеру для передачи во внешнюю программу подключение контроллера
  dwMask:= 0;
  // передача команды
  FillChar(Ovr, SizeOf(TOverlapped), 0);
  Ovr.hEvent:= CreateEvent(nil, TRUE, FALSE, nil);

  //очищает приемный (или передающий) буфер с полной потерей данных
  PurgeComm(hPort, PURGE_RXABORT or PURGE_RXCLEAR or PURGE_TXCLEAR or PURGE_TXABORT);

  dwRet:= WriteComm(hPort, Send, SizeOf(Send), true); //записали в порт
  WaitCommEvent(hPort, dwMask, @Ovr);      //ждем прихода байт

  dwRet:= WAIT_OBJECT_0;
  if GetLastError = ERROR_IO_PENDING then
    dwRet:= WaitForSingleObject(Ovr.hEvent, 500);

  if (dwRet = WAIT_OBJECT_0) and ((dwMask and EV_RXCHAR) = EV_RXCHAR) then
    begin
      if(Ovr.hEvent <> 0) then
        begin
          CloseHandle(Ovr.hEvent);
          Ovr.hEvent:= 0;
        end;
      FillChar(Ovr,SizeOf(TOverlapped),0);
      Ovr.hEvent:= CreateEvent(nil, TRUE, FALSE, nil);
      FillChar(Otvet, sizeOf(Otvet), 0);

//      sleep(100);   //было 100  чтобы все данные поступили в порт

      //организовываем ожидания получения данных из COM порта
      dwRet:= 0;
      totalTimeOut:= 0;
      stepTimeOut:= 10;   //шаг паузы
      while (dwRet <> sizeOtvet) and (totalTimeOut < timeOut) do
        begin
          sleep(stepTimeOut);
          // Узнаем сколько байт данных находится в буфере передачи последовательного порта
          ClearCommError(hPort, dwError, @Stat);
          dwRet:= Stat.cbInQue;
          inc(totalTimeOut, stepTimeOut); //увеличиваем общее время на шаг паузы  пока не превысит времени таймаута
        end;

      if dwRet = sizeOtvet then    //если размер ответа равен ожидаемому
        begin
          ReadFile(hPort, Otvet, sizeOtvet, dwRet ,@Ovr);
          if GetLastError = ERROR_IO_PENDING then
            WaitForSingleObject(Ovr.hEvent, timeOut);

          dwRet:= 0;
          GetOverlappedResult(hPort, Ovr, dwRet, false);
          if dwRet = sizeOtvet then
            begin
              //значит считали все байты
              //проверяем контрольную сумму принятых данных
              CheckSum:= 0;
              CheckSum:= byte(PAnsiChar(@Otvet)[sizeOtvet - 1]);     //предпоследний байт из ответа - младший байт CRC
              CheckSum:= (CheckSum shl 8) or byte(PAnsiChar(@Otvet)[sizeOtvet - 2]); //последний байт
              if CheckSum = SwapWord(CalculateCRC16(Otvet, sizeOtvet - 2)) then
                begin
                  result:= Err_None;
                end
                else result:= Err_CRC;
            end
            else result:= Err_WrongSizeReceivedDataFromCOMport;
        end
        else
        begin
          if dwRet = 0 then
            begin
              //никаких данных нет в COM порту - ошибка
              result:= Err_NoDataFromCOMPort;
            end
            else
            begin
              if dwRet = sizeOf(ErrMODBUS) then //размер принятых байт равен размеру ответа ошибки MODBUS
                begin
                  //считываем информацию об ошибки
                  ReadFile(hPort, ErrMODBUS, sizeOf(ErrMODBUS), dwRet ,@Ovr);
                  if GetLastError = ERROR_IO_PENDING then
                    WaitForSingleObject(Ovr.hEvent, 300);

                  dwRet:= 0;
                  GetOverlappedResult(hPort, Ovr, dwRet, false);

                  if dwRet = sizeOf(ErrMODBUS) then
                    begin
                      if ErrMODBUS.CheckSum = SwapWord(CalculateCRC16(ErrMODBUS, sizeOf(ErrMODBUS) - 2)) then
                        begin
                          //значит все данные пришли верные
                          //ошибка MODBUS - разбираем ошибку
                          if (ErrMODBUS.FunctionCode and $80) > 0 then  //значит действительно есть ошибка MODBUS
                            result:= GetErrCodeMODBUS(ErrMODBUS.ErrCode);
                        end
                        else result:= Err_CRC;

                    end
                    else result:= Err_WrongSizeReceivedDataFromCOMport;
                end
                else result:= Err_WrongSizeReceivedDataFromCOMport;
            end;
        end;
    end
    else result:= Err_NoAnswerFromController;

  if result = Err_NoAnswerFromController then inc(NumberRequestsNoAnswer);  //Число запросов с ошибкой "Нет ответа"
  if result = Err_CRC then inc(NumberRequestsCRCErr);  //Число запросов с ошибкой CRC

  if Ovr.hEvent <> 0 then
    begin
      CloseHandle(Ovr.hEvent);
      Ovr.hEvent:= 0;
    end;
end;

//формируем команду чтения 25-ти адресов заголовка (каждый адрес имеет размер WORD)
function ReadHeader(AddressMODBUS: Byte; hPort: THandle; var OtvetMainData: TOtvetMainData): TErrRudaMonitor;
  var Send: array [0..7] of byte;
      MODBUSCRC16: WORD;

begin
  Send[0]:= AddressMODBUS;                        //Адрес устройства
  Send[1]:= 4;                                    //Функциональный код Modbus RTU на чтение аналогового ввода
  Send[2]:= 0;                                    //Адрес первого регистра Hi байт
  Send[3]:= 0;                                    //Адрес первого регистра Lo байт
  Send[4]:= 0;                                    //Количество регистров Hi байт
  Send[5]:= 25;                                   //Количество регистров Lo байт
  MODBUSCRC16:= CalculateCRC16(Send, 6);
  Send[6]:= MODBUSCRC16 shr 8;                    //Контрольная сумма CRC
  Send[7]:= MODBUSCRC16;                          //Контрольная сумма CRC

  result:= SendMODBUS(Send, hPort, OtvetMainData, sizeOf(OtvetMainData), 5000);
end;

//установить новые значения ностроек последовательного порта регистр 21
function SettingsCommunication(AddressMODBUS: Byte; hPort: THandle; value: WORD): TErrRudaMonitor;
  var Send: array [0..7] of byte;
      OtvetWithoutError: TOtvetWithoutError_06;
      MODBUSCRC16: WORD;
begin
  result:= Err_None;
  //формируем посылку
  Send[0]:= AddressMODBUS; //Адрес устройства
  Send[1]:= 6;                                   //Функциональный код Modbus RTU на запись нескольких аналоговых выводов
  Send[2]:= 0;                                   //Адрес первого регистра Hi байт
  Send[3]:= 21;                                  //Адрес первого регистра Lo байт
  Send[4]:= value shr 8;                         //Значение Hi
  Send[5]:= value;                               //Значение Lo

  MODBUSCRC16:= CalculateCRC16(Send, 6);
  Send[6]:= MODBUSCRC16 shr 8;                    //Контрольная сумма CRC
  Send[7]:= MODBUSCRC16;                          //Контрольная сумма CRC

  result:= SendMODBUS(Send, hPort, OtvetWithoutError, sizeOf(OtvetWithoutError), 5000);
end;

//по настройкам COM порта получаем слово для отправки в контроллер
function ParamCOMPortToData(COMPort: TCOMPort): word;
begin
  result:= 0;
  case COMPort.BaudRate of
    CBR_1200: result:= result or $03;
    CBR_2400: result:= result or $04;
    CBR_4800: result:= result or $05;
    CBR_9600: result:= result or $06;
    CBR_19200: result:= result or $07;
    CBR_38400: result:= result or $08;
    CBR_57600: result:= result or $09;
    CBR_115200: result:= result or $0A;
  end;

  if (COMPort.Parity = NOPARITY) and (COMPort.StopBits = TWOSTOPBITS) then      //нет, 2 - стопбита
    begin
      result:= result or ($01 shl 6);
    end
    else
    begin
      if (COMPort.Parity = EVENPARITY) and (COMPort.StopBits = ONESTOPBIT) then    //чет, 1 - стопбит
        begin
          result:= result or ($02 shl 6);
        end
        else
        begin
          if (COMPort.Parity = ODDPARITY) and (COMPort.StopBits = ONESTOPBIT) then    //нечет, 1 - стопбит
            begin
              result:= result or ($03 shl 6);
            end;
        end;
    end;
end;

//из базы данных считываем настройки COM порта
function ReadParamCOMPort(Sp_Code:Int64; var COMPort: TCOMPort): boolean;
begin
  if not DM.DataSetWS('SELECT * FROM SettingsCOMPort WHERE Sp_Code = ' + inttostr(Sp_Code),
    FormConnectControllers.Caption, 'ReadParamCOMPort') then
    begin
      result:= false;
      exit;
    end;

  if DM.DataSourceDataSetWS.DataSet.RecordCount > 0 then   //если запись найдена значит канал и порт заняты
    begin
      COMPort.PortName:= 'COM' + DM.ADODataSetWS.FieldByName('PortNum').AsString;
      COMPort.BaudRate:= DM.ADODataSetWS.FieldByName('BaudRate').AsInteger;
      COMPort.DataBits:= DM.ADODataSetWS.FieldByName('DataBits').AsInteger;
      COMPort.Parity:= DM.ADODataSetWS.FieldByName('Parity').AsInteger;
      COMPort.StopBits:= DM.ADODataSetWS.FieldByName('StopBits').AsInteger;
      result:= true;
    end
    else result:= false;
end;

//заносим в контроллер новые значения последовательного порта
procedure TFormConnectControllers.SetNewSettingsCommunication;
  var COMPort, COMPortDef: TCOMPort;
      hPort: THandle;
      ParamCOMPort: WORD;
      ErrRudaMonitor: TErrRudaMonitor;
      txtErr: string;
begin
  LabelText.Caption:= 'Запись в контроллер новых значений настроек последовательного порта' + #10#13;

  DBGridConnectControllers.DataSource.DataSet.First;
  while not DBGridConnectControllers.DataSource.DataSet.Eof do
    begin
      if DBGridConnectControllers.DataSource.DataSet.FieldByName('Sel').AsBoolean then
        begin
          if ReadParamCOMPort(DBGridConnectControllers.DataSource.DataSet.FieldByName('Sp_Code').AsInteger,
                              COMPort) then
            begin
              COMPortDef.PortName:= COMPort.PortName;
              SettingsCOMportDefault(COMPortDef);  //устанавливаем значение COM порта по умолчанию

              if OpenComPort(COMPortDef, hPort) then
                begin
                  ParamCOMPort:= ParamCOMPortToData(COMPort);
                  ErrRudaMonitor:= SettingsCommunication(DBGridConnectControllers.DataSource.DataSet.FieldByName('PlataAddress').AsInteger + 1,
                                    hPort,
                                    ParamCOMPort);

                end
                else ErrRudaMonitor:= Err_OpeningCOMport;

              if ErrRudaMonitor = Err_None then txtErr:= 'успешно'
                else txtErr:= 'ОШИБКА (' + AnsiLowerCase(TErrRudaMonitorName[ErrRudaMonitor]) + ')';

              LabelInfoCommunication.Caption:= LabelInfoCommunication.Caption + 'Контроллер "' +
                DBGridConnectControllers.DataSource.DataSet.FieldByName('NameController').AsString +
                '" - ' + txtErr + #10#13;

              //закрываем порт
              if (hPort <> 0) and (hPort <> INVALID_HANDLE_VALUE) then
                CloseHandle(hPort);
            end;
        end;
      DBGridConnectControllers.DataSource.DataSet.Next;
    end;
end;

procedure TFormConnectControllers.ButtonNextClick(Sender: TObject);
begin
  if IndexText < High(TextMsg) then
    begin
      if IndexText = 1 then //проверяем на то, что хотябы один контроллер выбран
        begin
          if not ExistSelectController then
            begin
              Application.MessageBox(PChar('Ни один из контроллеров не выбран.' + #10#13 +
                'Отметьте флажком контроллеры, в которых необходимо изменить параметры связи.'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка данных !!!'),
                            MB_OK + MB_ICONSTOP);
              exit;
            end;
        end;

      inc(IndexText);
      LabelText.Caption:= TextMsg[IndexText];

      if IndexText = 3 then SetNewSettingsCommunication
        else LabelInfoCommunication.Caption:= '';

      if IndexText = High(TextMsg) then
        ButtonNext.Caption:= 'Закончить'
        else ButtonNext.Caption:= 'Далее';
    end
    else ExitSettingsCommunication;

    if IndexText > 0 then
      ButtonBack.Enabled:= true;
end;

//flag = true - выводится текст ошибки
//flag = false - выводится обычный текст
procedure TFormConnectControllers.ShowInfoAboutStateRequest(txt: string; flag: boolean = true);
begin
  if flag then
    begin
      LabelErrDataController.Font.Color:= clRed;
      LabelErrDataController.Font.Style:= [fsBold];
    end
    else begin
      LabelErrDataController.Font.Color:= clWindowText;
      LabelErrDataController.Font.Style:= [];
    end;
  LabelErrDataController.Caption:= txt;
end;

procedure TFormConnectControllers.ButtonRefreshDataControllerClick(
  Sender: TObject);
  var COMPort: TCOMPort;
      hPort: THandle;
      ErrRudaMonitor: TErrRudaMonitor;
      OtvetMainData: TOtvetMainData;
      DataController: TTransferDataController;
begin
  ClearFieldDataController;
  TimerShowButtonRefreshDataController.Enabled:= false;  //останавливаем таймер, чтобы прервать обновление статуса опроса
  LabelStatusRequest.Caption:= 'Ожидание данных...';
  Application.ProcessMessages;
  //из базы данных считываем настройки COM порта
  if ReadParamCOMPort(DBGridConnectControllers.DataSource.DataSet.FieldByName('Sp_Code').AsInteger,
                              COMPort) then
    begin
      if OpenComPort(COMPort, hPort) then //открываем порт и получаем его хэндл
        begin
          ErrRudaMonitor:= ReadHeader(DBGridConnectControllers.DataSource.DataSet.FieldByName('PlataAddress').AsInteger + 1,
                                    hPort,
                                    OtvetMainData);
          if ErrRudaMonitor = Err_None then
            begin
              DataController.Lc_Code:= DBGridConnectControllers.DataSource.DataSet.FieldByName('Lc_Code').AsInteger;
              DataController._Date:= now;
              DataController.CountReceivedPacketsWithError:= SwapWord(OtvetMainData.MainData.CountReceivedPacketsWithError);
              DataController.CountCRCError:= SwapWord(OtvetMainData.MainData.CountCRCError);
              DataController.TotalWorkTime:= TwoWordToDWORD(OtvetMainData.MainData.TotalWorkTime_Hi, OtvetMainData.MainData.TotalWorkTime_Lo);

              DataController.NumberRequests:= NumberRequests;                 //Общее число запросов к контроллеру
              DataController.NumberRequestsNoAnswer:= NumberRequestsNoAnswer; //Число запросов с ошибкой "Нет ответа"
              DataController.NumberRequestsCRCErr:= NumberRequestsCRCErr;

              DataController.Err:= ErrRudaMonitor;

              AddData(DataController);
            end
            else ShowInfoAboutStateRequest('ОШИБКА: ' + TErrRudaMonitorName[ErrRudaMonitor]);
        end
        else ShowInfoAboutStateRequest('ОШИБКА: ' + TErrRudaMonitorName[Err_OpeningCOMport]);

      //закрываем порт
      if (hPort <> 0) and (hPort <> INVALID_HANDLE_VALUE) then CloseHandle(hPort);
    end
    else ShowInfoAboutStateRequest('ОШИБКА: Невозможно считать из базы данных настройки COM-порта.');

  TimerShowButtonRefreshDataController.Enabled:= true;
end;

procedure TFormConnectControllers.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

procedure TFormConnectControllers.EditСontrollerNameInSystemKeyPress(
  Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
end;

procedure TFormConnectControllers.EnabledDisebledField(param: boolean);
begin
  EditСontrollerNameInSystem.Enabled:= param;
  ComboBoxControllersList.Enabled:= param;
  SpinEditNumCh.Enabled:= param;
  comboBoxLineConnection.Enabled:= param;
end;

//очищаем поля таблицами пареметров линии связи
procedure TFormConnectControllers.ClearStringGridParamLineConnection;
begin
  with StringGridParamLineConnection do
    begin
      cells[1, 1]:= '';
      cells[1, 2]:= '';
      cells[1, 3]:= '';
      cells[1, 4]:= '';
      cells[1, 5]:= '';
    end;
end;

procedure TFormConnectControllers.ClearFieldDataController;
begin
  EditDateTimeLastData.Clear;
  EditTotalWorkTime.Clear;
  EditCountReceivedPacketsWithError.Clear;
  EditCountCRCError.Clear;
  EditNumberRequests.Clear;
  EditNumberRequestsNoAnswer.Clear;
  EditNumberRequestsCRCErr.Clear;
  LabelErrDataController.Caption:= '';
  LabelStatusRequest.Caption:= '';
  ReceivingData:= false;
end;

procedure TFormConnectControllers.ClearAllData;
  var Sender: TObject;
begin
  CodeConnectСontrollers:= 0;

  EditСontrollerNameInSystem.Clear;
  comboBoxLineConnection.Clear;
  ClearStringGridParamLineConnection;
  ComboBoxControllersList.ItemIndex:= -1;
  ComboBoxControllersListChange(Sender);

  SpinEditNumCh.Value:= 1;
  StringGridParamControllers.RowCount:= 1;

  ClearFieldDataController;     //чистим поля страницы с настройками контроллера MK003

  EnabledDisebledField(false);
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

procedure TFormConnectControllers.ComboBoxControllersListChange(
  Sender: TObject);
  var ccl: TConnectControllersList;
begin
  //очищаем даблицу оставляем только заголовок
  StringGridParamControllers.RowCount:= 1;

 //заполняем таблицу с параметрами
 if ComboBoxControllersList.ItemIndex >= 0 then
  begin
    ccl:= ComboBoxControllersList.Items.Objects[ComboBoxControllersList.ItemIndex] as TConnectControllersList;

    if ccl.TypeController = 3 then   //значит MK003
      begin
        with StringGridParamControllers do
          begin
            SpinEditNumCh.MaxValue:= 247;
            LabelNumCh.Caption:= 'Адрес контроллера:';

            RowCount:= 6;   //учитываем заголовок

            Cells[0, 1]:= 'Тип контроллера';
            Cells[0, 2]:= 'Номер версии';
            Cells[0, 3]:= 'Номер подверсии';
            Cells[0, 4]:= 'Количество аналоговых входов';
            Cells[0, 5]:= 'Счетчик весов';

            cells[1, 1]:= ccl.Controller;
            cells[1, 2]:= Format('%.2d', [ccl.Version_Hi]);
            cells[1, 3]:= Format('%.2d', [ccl.Version_Lo]);
            cells[1, 4]:= inttostr(ccl.NumberAnalogInput);
            if ccl.SizeWeightCounter = 4 then cells[1, 5]:= 'есть' else cells[1, 5]:= 'нет';
          end;
        //открываем вкладку с данными по контроллеру MK003
        PageControl1.Pages[2].TabVisible:= true;
      end
      else
      begin
        with StringGridParamControllers do                 //значит MK001 или MK002
          begin
            SpinEditNumCh.MaxValue:= 8;
            LabelNumCh.Caption:= 'Канал:';

            RowCount:= 7;   //учитываем заголовок

            Cells[0, 1]:= 'Тип контроллера';
            Cells[0, 2]:= 'Номер версии (hex)';
            Cells[0, 3]:= 'Номер подверсии (hex)';
            Cells[0, 4]:= 'Количество аналоговых входов';
            Cells[0, 5]:= 'Коррекция адреса (байт)';
            Cells[0, 6]:= 'Счетчик весов';

            cells[1, 1]:= ccl.Controller;
            cells[1, 2]:= Format('%.2x', [ccl.Version_Hi]);
            cells[1, 3]:= Format('%.2x', [ccl.Version_Lo]);
            cells[1, 4]:= inttostr(ccl.NumberAnalogInput);
            cells[1, 5]:= inttostr(ccl.AddressCorrection);
            if ccl.SizeWeightCounter = 4 then cells[1, 6]:= 'есть' else cells[1, 6]:= 'нет';
          end;
        //скрываем вкладку с данными по контроллеру MK003
        PageControl1.Pages[2].TabVisible:= false;
      end;

    NumberRequests:= 0;         //Общее число запросов к контроллеру
    NumberRequestsNoAnswer:= 0; //Число запросов с ошибкой "Нет ответа"
    NumberRequestsCRCErr:= 0;   //Число запросов с ошибкой CRC

    LineConnectList(ccl.TypeController);
    comboBoxLineConnectionChange(Sender);
  end
  else begin
    LabelNumCh.Caption:= 'Канал / Адрес контроллера:';
    //скрываем вкладку с данными по контроллеру MK003
    PageControl1.Pages[2].TabVisible:= false;
  end;

  //если в режиме ввода нового контроллера, запрещаем обновлять данные в ручном режиме по контроллеру MK003
  if CodeConnectСontrollers = 0 then ButtonRefreshDataController.Visible:= false;

  ProcedureChangeData;
end;

procedure TFormConnectControllers.comboBoxLineConnectionChange(Sender: TObject);
  var lcl: TLineConnectionList;
      s: string;
begin
  ClearStringGridParamLineConnection;
  if comboBoxLineConnection.ItemIndex > -1 then
    begin
      lcl:= comboBoxLineConnection.Items.Objects[comboBoxLineConnection.ItemIndex] as TLineConnectionList;
      with StringGridParamLineConnection do
        begin
          cells[1, 1]:= lcl.PortName;
          cells[1, 2]:= inttostr(lcl.BaudRate);
          cells[1, 3]:= inttostr(lcl.DataBits);
          case lcl.Parity of
              NOPARITY: s:= 'нет';
             ODDPARITY: s:= 'нечет';
            EVENPARITY: s:= 'чет';
            else s:= '';
          end;
          cells[1, 4]:= s;

          case lcl.StopBits of
             ONESTOPBIT: s:= '1';
            TWOSTOPBITS: s:= '2';
            else s:= '';
          end;
          cells[1, 5]:= s;
        end;
    end;

  ProcedureChangeData;
end;

//проверяем свободный порт и канал/адрес
//возвращает: -1 - общая ошибка (ошибка базы данных)
//             0 - порт или канал/адрес свободны
//             1 - порт или канал/адрес заняты
// NamePort - имя порта COM2
// Address - адрес контроллера для MK003 или номер канала для MK001 и MK002
// NewRecord - true - новый подключаемый контроллер, false - контроллер уже есть идет его update
function TFormConnectControllers.CheckFreeCOMPort(Sp_Code: Int64; Address: integer): integer;
  var txt: string;
      txtSQL: string;
begin
  result:= -1;

  txtSQL:= 'SELECT LinkContr.*, SettingsCOMPort.* FROM LinkContr LEFT JOIN SettingsCOMPort ON LinkContr.Sp_Code = SettingsCOMPort.Sp_Code' +
    ' WHERE PlataAddress = ' + IntToStr(Address - 1) + ' AND LinkContr.Sp_Code = ' + inttostr(Sp_Code);

  if not DM.DataSetWS(txtSQL, FormConnectControllers.Caption, 'CheckFreeCOMPort') then exit;

  if DM.DataSourceDataSetWS.DataSet.RecordCount > 0 then   //если запись найдена значит канал и порт заняты
    begin
      if CodeConnectСontrollers <> 0 then   //если не новая запись, а редактируемая
        begin
          if DM.ADODataSetWS.FieldByName('Lc_Code').AsInteger = CodeConnectСontrollers then  //Значит запись редактируется
            begin
              result:= 0;
              exit;
            end;
        end;

      result:= 1;
    end
    else result:= 0;
end;

//присваиваем условный номер платы (По порядку) для контроллера MK003 начиная с номера 8
//номера плат с 0-7 зарезервированы для контроллеров MK001, MK002
function SetNumPlataForMK003: integer;
  var i: integer;
      FindNum: boolean;
begin
  result:= -1;  //значит ошибка
  if not DM.DataSetWS('SELECT * FROM LinkContr', FormConnectControllers.Caption, 'SetNumPlataForMK003') then exit;

  result:= 8;
  while True do
    begin
      FindNum:= false;
      DM.ADODataSetWS.First;
      while not DM.ADODataSetWS.Eof do
        begin
          if DM.ADODataSetWS.FieldByName('Plata').AsInteger = result then //значит такой номер существует
            begin
              FindNum:= true;
              break;
            end;

          DM.ADODataSetWS.Next;
        end;

      if FindNum then inc(result) else break;
    end;
end;

procedure TFormConnectControllers.SaveDataInBD;
  var ccl: TConnectControllersList;
      lcl: TLineConnectionList;
    Plata, PlataAddress: byte;
    TempString: string;
    Err_CheckFreeCOMPort: integer;
begin
  if Application.MessageBox(PChar('Сохранить изменения для подключеного контроллера: "' +
                                  EditСontrollerNameInSystem.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if Trim(EditСontrollerNameInSystem.Text) = '' then
        begin
          Application.MessageBox(PChar('Не назван контроллер в системе.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditСontrollerNameInSystem.SetFocus;
          exit;
        end;

      if comboBoxLineConnection.Text = '' then
        begin
          Application.MessageBox(PChar('Не назначена линия связи.'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
          comboBoxLineConnection.SetFocus;
          exit;
        end;

      ccl:= ComboBoxControllersList.Items.Objects[ComboBoxControllersList.ItemIndex] as TConnectControllersList;
      if ccl.TypeController = 3 then //если контроллер MK003
          TempString:= 'Адрес'
        else
          TempString:= 'Канал';

      lcl:= comboBoxLineConnection.Items.Objects[comboBoxLineConnection.ItemIndex] as TLineConnectionList;
      //для проверки не занят ли канал
      Err_CheckFreeCOMPort:= CheckFreeCOMPort(lcl.Sp_Code, SpinEditNumCh.Value);
      case Err_CheckFreeCOMPort of
        -1: exit;
         1: begin  //порт или канал заняты
              Application.MessageBox(PChar(TempString + ' с номером "' + IntToStr(SpinEditNumCh.Value) + '" уже используется на линии связи "' +
                comboBoxLineConnection.Text + '".' + #10#13 + 'Измените номер ' + AnsiLowerCase(TempString) + 'а или выберите другую линию связи.'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
              comboBoxLineConnection.SetFocus;
              exit;
            end;
      end;

      PlataAddress:= SpinEditNumCh.Value - 1; //реальный номер платы для MK001, MK002 или адрес для MK003

      if CodeConnectСontrollers = 0 then     //если новая запись
        begin
          //для контроллера MK003 номер платы делаем условным (по порядку)
          if ccl.TypeController = 3 then //если контроллер MK003
            Plata:= SetNumPlataForMK003
            else Plata:= PlataAddress;

          if not DM.CommandWS('INSERT INTO LinkContr (Cn_Code, Plata, Sp_Code, NameController, PlataAddress) VALUES (''' +
                                            IntToStr(ccl.Cn_Code) + ''', ''' +
                                            IntToStr(Plata)  + ''', ''' +
                                            IntToStr(lcl.Sp_Code) + ''', ''' +
                                            Trim(EditСontrollerNameInSystem.Text) + ''', ''' +
                                            inttostr(PlataAddress) + ''')',
                                  FormConnectControllers.Caption, 'SaveDataInBD') then exit;

          //узнаем номер уникальной записи подключенного контроллера (последней записи)
          if not DM.DataSetWS('SELECT MAX(Lc_Code) as cod FROM LinkContr',
                                  FormConnectControllers.Caption, 'SaveDataInBD') then exit;

          if not DM.ADODataSetWS.Eof then CodeConnectСontrollers:= DM.ADODataSetWS.FieldByName('cod').AsInteger;
          if CodeConnectСontrollers = 0 then exit;
        end
        else
        begin
          if ccl.TypeController = 3 then //если контроллер MK003 не изменяем условный номер Plata
            begin
              if not DM.CommandWS('UPDATE LinkContr SET Cn_Code = ''' + IntToStr(ccl.Cn_Code) +
                ''', Sp_Code = ''' + IntToStr(lcl.Sp_Code) +
                ''', NameController = ''' + Trim(EditСontrollerNameInSystem.Text) +
                ''', PlataAddress = ''' + inttostr(PlataAddress) +
                ''' WHERE Lc_Code = ' + IntToStr(CodeConnectСontrollers),
                  FormConnectControllers.Caption, 'SaveDataInBD') then exit;
            end
            else
            begin
              //если контроллер MK001, MK002 изменяем условный номер Plata и PlataAddress,
              //если они были изменены
              if not DM.CommandWS('UPDATE LinkContr SET Cn_Code = ''' + IntToStr(ccl.Cn_Code) +
                ''', Plata = ''' + IntToStr(SpinEditNumCh.Value - 1) +
                ''', Sp_Code = ''' + IntToStr(lcl.Sp_Code) +
                ''', NameController = ''' + Trim(EditСontrollerNameInSystem.Text) +
                ''', PlataAddress = ''' + inttostr(PlataAddress) +
                ''' WHERE Lc_Code = ' + IntToStr(CodeConnectСontrollers),
                  FormConnectControllers.Caption, 'SaveDataInBD') then exit;
            end;
        end;

      ReadAllData;    //получаем все необходимые данные по фабрике
    end;

  ProcedureChangeData(false);
  UpdateConnectControllersList(true);
end;


procedure TFormConnectControllers.UpdateConnectControllersList(SetCursorPosition: boolean; all: boolean = true);
  var DataSet: TDataSet;
      TempCodeConnect: integer;
begin
  FormConnectControllers.Color:= clBtnFace;
//  ComboBoxControllersList.Color:= clWhite;
//  SpinEditNumCh.Color:= clWhite;

  SpeedButtonAddConnect.Enabled:= true;
  DBGridConnectControllers.Enabled:= true;

  TempCodeConnect:= CodeConnectСontrollers; //запоминаем позицию курсора в DBGrid

  ConnectControllersList(all);

  if SetCursorPosition then
    begin
      CodeConnectСontrollers:= TempCodeConnect;
      //восстанавливаем позицию курсора
      DBGridConnectControllers.DataSource.DataSet.Locate('Lc_Code', CodeConnectСontrollers, []);
    end;

  DBGridConnectControllers.SetFocus;
end;

procedure TFormConnectControllers.ControllersList;
begin
  ComboBoxControllersList.Items.Clear;
  //   получаем список всех имеющихся контроллеров
  if not DM.DataSetServer('SELECT Controllers.*, TypeControllers.* ' +
      'FROM Controllers LEFT JOIN TypeControllers ON Controllers.Cn_TypeController = TypeControllers.Nc_Code',
      Caption, 'ControllersList') then exit;

  DM.ADODataSetServer.First;
  while not DM.ADODataSetServer.EOF do
    begin
      ComboBoxControllersList.Items.AddObject(DM.ADODataSetServer.FieldByName('Cn_Name').AsString,
        TObject(TConnectControllersList.Create(DM.ADODataSetServer.FieldByName('Cn_Code').AsInteger,
                                               DM.ADODataSetServer.FieldByName('Cn_Name').AsString,
                                               DM.ADODataSetServer.FieldByName('Cn_TypeController').AsInteger,
                                               DM.ADODataSetServer.FieldByName('Cn_SizeAnswer').AsInteger,
                                               DM.ADODataSetServer.FieldByName('Cn_SizeCh').AsInteger,
                                               DM.ADODataSetServer.FieldByName('Cn_Echo1').AsInteger,
                                               DM.ADODataSetServer.FieldByName('Cn_Echo2').AsInteger,
                                               DM.ADODataSetServer.FieldByName('Cn_Address').AsInteger)));
      DM.ADODataSetServer.Next; // го на следующего
    end;
end;

procedure TFormConnectControllers.DBGridConnectControllersCellClick(
  Column: TColumn);
  var ScrPt, GrdPt: TPoint;
      Cell: TGridCoord;
begin
  ScrPt := Mouse.CursorPos;
  GrdPt := DBGridConnectControllers.ScreenToClient(ScrPt);
  Cell  := DBGridConnectControllers.MouseCoord(GrdPt.X, GrdPt.Y);
  if Cell.X = 1 then
    begin
      if Column.Field.DataType=ftBoolean then        //для check DBGrid
        begin
          Column.Grid.DataSource.DataSet.Edit;
          Column.Field.Value:= not Column.Field.AsBoolean;
          Column.Grid.DataSource.DataSet.Post;
        end;
    end;
end;

procedure TFormConnectControllers.DBGridConnectControllersColEnter(
  Sender: TObject);
begin
  if Self.DBGridConnectControllers.SelectedField.DataType = ftBoolean then   //для check DBGrid
    begin
      Self.GridOriginalOptions := Self.DBGridConnectControllers.Options;
      Self.DBGridConnectControllers.Options := Self.DBGridConnectControllers.Options - [dgEditing];
    end;
end;

procedure TFormConnectControllers.DBGridConnectControllersColExit(
  Sender: TObject);
begin
  if Self.DBGridConnectControllers.SelectedField.DataType = ftBoolean then    //для check DBGrid
    Self.DBGridConnectControllers.Options := Self.GridOriginalOptions;
end;

procedure TFormConnectControllers.DBGridConnectControllersDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
   CtrlState: array[Boolean] of integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED) ;
begin
  if (Column.Field.DataType=ftBoolean) then          //для check DBGrid
    begin
      DBGridConnectControllers.Canvas.FillRect(Rect) ;
      if (VarIsNull(Column.Field.Value)) then
        DrawFrameControl(DBGridConnectControllers.Canvas.Handle,Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_INACTIVE)
        else
        DrawFrameControl(DBGridConnectControllers.Canvas.Handle,Rect, DFC_BUTTON, CtrlState[Column.Field.AsBoolean]);
    end;
end;

procedure TFormConnectControllers.DBGridConnectControllersKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin                                                          //для check DBGrid
  if ((Self.DBGridConnectControllers.SelectedField.DataType = ftBoolean) and (key = VK_SPACE)) then
    begin
      Self.DBGridConnectControllers.DataSource.DataSet.Edit;
      Self.DBGridConnectControllers.SelectedField.Value:= not Self.DBGridConnectControllers.SelectedField.AsBoolean;
      Self.DBGridConnectControllers.DataSource.DataSet.Post;
    end;
end;

//проверяем есть, ли среди подключенных контроллеров, контроллеры MK003
function TFormConnectControllers.CheckExistMK003: boolean;
  var txtSQL: string;
begin
  result:= false;
  if DBGridConnectControllers.DataSource.DataSet.RecordCount > 0 then
    begin
      DBGridConnectControllers.DataSource.DataSet.First;
      while not DBGridConnectControllers.DataSource.DataSet.Eof do
        begin
          txtSQL:= 'SELECT * FROM Controllers WHERE Cn_TypeController = 3 AND Cn_Code = ' +
            DBGridConnectControllers.DataSource.DataSet.FieldByName('Cn_Code').AsString;

          if not DM.DataSetServer(txtSQL, FormConnectControllers.Caption, 'CheckExistMK003') then exit;

          if DM.DataSourceDataSetServer.DataSet.RecordCount > 0 then  //значит есть такая запись и тип контроллера MK003
            begin
              result:= true;
              break;
            end;
          DBGridConnectControllers.DataSource.DataSet.Next;
        end;
    end;
end;

//all - true выводит в список все подключенные контроллеры
//all - false выводить в список только контроллеры MK003
procedure TFormConnectControllers.RefreshDataDBGrid(all: boolean = true);
  var  i, count: integer;
    txtSQL: string;
begin
  if all then
    txtSQL:= ''
    else
      begin
        //узнаем номера контроллеров MK003 и если они есть включаем в выборку
        txtSQL:= ' WHERE Cn_TypeController = 3';
        if not DM.DataSetServer('SELECT * FROM Controllers WHERE Cn_TypeController = 3 ', Caption, 'RefreshDataDBGrid') then exit;
        count:= DM.DataSourceDataSetServer.DataSet.RecordCount;
        if count > 0 then  //значит есть такая запись и тип контроллера MK003
          begin
            DM.ADODataSetServer.First;
            txtSQL:= ' WHERE';
            while not DM.ADODataSetServer.Eof do
              begin
                txtSQL:= txtSQL + ' Cn_Code = ' + DM.ADODataSetServer.FieldByName('Cn_Code').AsString;
                dec(count);
                if count > 0 then txtSQL:= txtSQL + ' or ';
                DM.ADODataSetServer.Next;
              end;
          end
          else txtSQL:= ' WHERE Cn_Code = -1'; //заведамо присваеиваем число которого нет
      end;

  //получаем список всех подключенных контроллеров
  try
    ADODataSetConnectControllers.Close;
    ADODataSetConnectControllers.CommandText:= 'SELECT LinkContr.*, SettingsCOMPort.NameConnection ' +
      'FROM LinkContr LEFT JOIN SettingsCOMPort ON LinkContr.Sp_Code = SettingsCOMPort.Sp_Code' + txtSQL + ' ORDER BY Lc_Code';
    ADODataSetConnectControllers.Open;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[RefreshDataDBGrid]' + #13#10 + e.Message + #13#10 +
                               '"' + ADODataSetConnectControllers.CommandText +'"'),
                               PChar(FormConnectControllers.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;

  with DBGridConnectControllers do
    begin
      //центруем название колонок
      for i := 0 to 3 do
        Columns[i].Title.Alignment:= taCenter;

      //выставляем ширину видимых колонок
      Columns[0].Width:= 20;   //check
      Columns[1].Width:= 225 + 20;  //+ Width check
      Columns[2].Width:= 75;
      Columns[3].Width:= 75;
      //скрываем колонки
      Columns[0].Visible:= false;  //check
      for i := 4 to Columns.Count - 1 do
        Columns[i].Visible:= false;
    end;
end;

//all - true выводит в список все подключенные контроллеры
//all - false выводить в список только контроллеры MK003
procedure TFormConnectControllers.ConnectControllersList(all: boolean = true);
  var DataSet: TDataSet;
      Sender: TObject;

begin
  if ComboBoxControllersList.Items.Count > 0 then
    begin
      ComboBoxControllersList.ItemIndex:= 0;
      ComboBoxControllersListChange(Sender);
//      SpeedButtonAddConnect.Enabled:= true;
    end;
//    else SpeedButtonAddConnect.Enabled:= false;

  RefreshDataDBGrid(all);
  SpeedButtonSettingsCommunication.Enabled:= CheckExistMK003;
  SpeedButtonDeleteConnect.Enabled:= (DBGridConnectControllers.DataSource.DataSet.RecordCount > 0);

  ADODataSetConnectControllersAfterScroll(DataSet);
end;

procedure TFormConnectControllers.PageControl1Change(Sender: TObject);
begin
  NumPage:= PageControl1.TabIndex;
end;

procedure TFormConnectControllers.ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //если данные были изменены, разрешаем кнопку "Применить"
end;

end.
