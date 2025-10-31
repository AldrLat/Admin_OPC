unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Winapi.Windows, Data.DB,
  Data.Win.ADODB, System.Variants, Vcl.ComCtrls, Registry, WinSvc, OPCDA, OPCHDA, Vcl.StdCtrls,
  Vcl.Graphics, Winapi.Messages, Printers, VCLTee.Chart, Vcl.Dialogs, Winapi.ShellAPI,
  tlhelp32, RudaGlobals;

const
      DefaultColorEdit = $00DEC4B0; //clCream; //цвет объектов в режиме редактирования
                                    //$00DEC4B0 LightSteelBlue
                                    //$0042AEFF оранжевый
      DefaultColorEditBackView = $0042AEFF;//clYellow; //$0042AEFF оранжевый
      DefaultColorEditBackAuto = clWindow;

      DefaultColorMB5: array [1..2] of TColor = (clRed, clBlue);
      DefaultColorWeigher: TColor = clBlack;
      DefaultColorOther: TColor = clGreen;

      RPC_C_AUTHN_LEVEL_NONE = 1;
      RPC_C_IMP_LEVEL_IMPERSONATE = 3;
      EOAC_NONE = 0;

      //временные задержки чтения из COM порта
      defTimeChannelFind = 30;  //задержка при переборе (выборе) канала

      //GUID для получения списка COM портов
      GUID_DEVICEINTERFACE_COMPORT:TGUID=(
        D1 : $86E0D1E0;
        D2 : $8089;
        D3 : $11D0;
        D4 : ($9C,$E4,$08,$00,$3E,$30,$1F,$73);
      );
      GUID_DEVICEINTERFACE_MODEM:TGUID=(
        D1 : $2C7089AA;
        D2 : $2E0E;
        D3 : $11D1;
        D4 : ($B1,$14,$00,$C0,$4F,$C2,$AA,$E4);
      );

type
  TSettingsCOMPort = packed record
    Caption: string;
    Volume: integer;
  end;

const
  ListBaudRate: array [0..7] of TSettingsCOMPort =
    ((Caption: '1200';   Volume: CBR_1200),
     (Caption: '2400';   Volume: CBR_2400),
     (Caption: '4800';   Volume: CBR_4800),
     (Caption: '9600';   Volume: CBR_9600),
     (Caption: '19200';  Volume: CBR_19200),
     (Caption: '38400';  Volume: CBR_38400),
     (Caption: '57600';  Volume: CBR_57600),
     (Caption: '115200'; Volume: CBR_115200));

const
  ListDataBits: array [0..4] of TSettingsCOMPort =
    ((Caption: '4'; Volume: 4),
     (Caption: '5'; Volume: 5),
     (Caption: '6'; Volume: 6),
     (Caption: '7'; Volume: 7),
     (Caption: '8'; Volume: 8));

const
  ListParity: array [0..2] of TSettingsCOMPort =
    ((Caption: 'Нет';   Volume: NOPARITY),
     (Caption: 'Нечет'; Volume: ODDPARITY),
     (Caption: 'Чет';   Volume: EVENPARITY));

const
  ListStopBits: array [0..1] of TSettingsCOMPort =
    ((Caption: '1';   Volume: ONESTOPBIT),
     (Caption: '2';   Volume: TWOSTOPBITS));



type
  // Определение класса клиента
  TParam = class
    private
      // Поля данных этого нового класса
      ParamNumber : Integer;
      ParamName   : String;

    public
      // Свойства для чтения значений этих данных
      property Name : String
          read ParamName;
      property Number : Integer
          read ParamNumber;

      // Коструктор
      constructor Create(const ParamNumber : Integer;
                         const ParamName   : String);
  end;

  POPCServerProperty = ^OPCServerProperty;
  OPCServerProperty = record
    TypeServer:         Integer;
    ServerName:         string;
    Description:        string;
    GUID:               TGUID;
    StartTime:          TDateTime;
    CurrentTime:        TDateTime;
    LastUpdateTime:     TDateTime;
    ServerState:        string;
    MajorVersion:       Word;
    MinorVersion:       Word;
    BuildNumber:        Word;
    VendorInfo:         string;
  end;

  PMarker = ^TMarker;
  TMarker = packed record
    Color: integer;
    Width: integer;
    Style: TPenStyle;
  end;

  TCopyDataStruct = packed record
    dwData: DWORD; // до 32 бит, которые нужно передать
                   // приложению-получателю
    cbData: DWORD; // размер, в байтах данных, указателя lpData
    lpData: Pointer; // Указатель на данные, которые нужно передать
                     // приложению-получателю. Может быть NIL.
   end;

  //список подключенных контроллеров
  PLinkContr = ^TLinkContr;
  TLinkContr = packed record
    Plata: byte;
    ContrName: array [0..255] of Char;          //имя контроллера
  end;

  TLinesChannels = array [0.. MAXCHANNEL - 1] of TMapLines;
  TUsedChannels  = array [0..MAXCHANNEL] of word;         //список каналов (если канал задействован ставим 1), последнее значение - общее число используемых каналов
  TLines = array [0.. MAXLINE] of byte;                   //список кодов подключенных конвейеров (по порядку), последний байт - общее число конвейеров
  TControllers = array [0..MAXCHANNEL - 1] of TController;

  TDM = class(TDataModule)
    DataSourceServerMDB: TDataSource;
    ADOConnectionServerMDB: TADOConnection;
    ADOQueryServerMDB: TADOQuery;
    ADOConnectionAccessMDB: TADOConnection;
    ADOQueryAccessMDB: TADOQuery;
    DataSourceAccessMDB: TDataSource;
    ADOConnectionDataMDB: TADOConnection;
    ADOQueryDataMDB: TADOQuery;
    DataSourceDataMDB: TDataSource;
    ADOConnectionWorkStationMDB: TADOConnection;
    ADOQueryWorkStationMDB: TADOQuery;
    DataSourceWorkStationMDB: TDataSource;
    ADOConnectionDataWSMDB: TADOConnection;
    ADOQueryDataWSMDB: TADOQuery;
    DataSourceDataWSMDB: TDataSource;
    ADOQueryTempWS: TADOQuery;
    DataSourceTempWS: TDataSource;
    ADOCommandWS: TADOCommand;
    ADOCommandServer: TADOCommand;
    ADODataSetWS: TADODataSet;
    DataSourceDataSetWS: TDataSource;
    ADOConnectionNetSQL: TADOConnection;
    PrintDialog1: TPrintDialog;
    ADODataSetServer: TADODataSet;
    DataSourceDataSetServer: TDataSource;
    procedure GetVersionProgramm(var MajorVersion, MinorVersion,
                                        ReleaseVersion, BuildVersion: word);
    function QueryAccess(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
    function QueryData(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
    function QueryDataWS(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
    function QueryServer(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
    function QueryWorkStation(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
    function QueryTempWorkStation(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
    function CommandWS(TextSQL, CaptionDlg, ProcedureName: string): boolean;
    function DataSetWS(TextSQL, CaptionDlg, ProcedureName: string): boolean;
    function DataSetServer(TextSQL, CaptionDlg, ProcedureName: string): boolean;
    function ConnectBDAccess(var ErrSQLState: string): integer;
    function ConnectBDData(var ErrSQLState: string): integer;
    function ConnectBDDataWS(var ErrSQLState: string): integer;
    function ConnectBDServer(var ErrSQLState: string): integer;
    function ConnectBDWorkStation(var ErrSQLState: string): integer;
    procedure CheckHexPressKey(NameLabel: string; var Key: Char);
    function CheckIntPressKey(NameLabel: string; var Key: Char): boolean;
    procedure CheckFloatPressKey(NameLabel: string; var Edit: TEdit; var Key: Char; Precision: integer = 6);
    procedure CheckSignFloatPressKey(NameLabel, CheckDblText: string; var Key: Char);
    procedure CheckSpecialSymbolPressKey(NameLabel, CheckDblText: string; var Key: Char);
    function CheckTime(StrTime: string): boolean;
    function HexToInt(Str : string): integer;
    function ValNumeric(StrNum: string): string;
    function BitOn(const val: longint; const BitNum: byte): LongInt;
    function FromDSNgetPathBase(NameDSN, KeyRead: string): string;
    procedure DataModuleCreate(Sender: TObject);
    function EmptyStringSQL(str: string; quotes: boolean): string;
    function ValueList(ParamList:TList; ParamName: string): integer;
    procedure FullDD(FormCaption: string);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CloseAllWin(tagWin: integer);
    procedure CloseAllWinClassName(ClassName, WindowName: PWideChar);
    function CountWin: integer;
    function ServiceGetStatus(sMachine, sService: PChar): DWORD;
    function ServiceRunning(sMachine, sService: PChar): boolean;
    procedure RebootMonitor;
    procedure ListLineChannel(Lines: TLines; var LinesChannels: TLinesChannels; var UsedChannels: TUsedChannels; sCaption: string);
    procedure ListLine(var Lines: TLines; sCaption: string);     //список конвейеров по порядку (номера L_Code)
    procedure PrintChart(Chart: TChart; sTitle1, sTitle2, sTitle3, PrinTitle: string);
    procedure PrintListview(oListView: TListView; sTitle1, sTitle2, sTitle3, PrinTitle: string);
    function RunAsAdmin(HWND: hWnd; lpFile,lpParameters: string; out hProcess: THandle): boolean;
    procedure log(aStr: string; LevelRec: integer = 0);  //запись в лог файл работы системы
    function FunTypeController: integer;
    function SelectionByControllerType(ControllerID: Int64; TypeController: integer): boolean;   //выбор по типу контроллера
    function SendDataSet(CDS: TCopyDataStruct): integer;  //передать собщение всем окнам
    function IsRunning(sName: string): boolean;
  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  DM: TDM;
  MajorVersion, MinorVersion, ReleaseVersion, BuildVersion: word;
  ShortStringVersion, FullStringVersion, ProgName_ShortStringVersion, ProgName_FullStringVersion: string;
  PathApp: string;    //путь к exe файлу. на конце пути присутсвует символа слеш "\"
  Admin: boolean;     //работаем под правами Администратора
  CountUser: integer; //число пользователей
  UserName: string;   //имя пользователя вошедшего в программу
  LC: TListColumn;    //экземпляр колонки
  LI: TListItem;      //элемент списка
  LG: TListGroup;     //экземпляр группы
  clDDW : TList;      //есть импульсные
  clDDCW: TList;      //импульсные связанные весы
  myFormatDateTime: TFormatSettings;
  registry: TRegistry;
  //пустые параметры, чтобы работала функции WriteToReg и ReadFromReg
  ParamVariant: Variant;
  ParamString: string;
  ParamInteger: integer;
  ParamFloat: double;
  ParamBoolean: boolean;
  PathWorkStationMDB, PathDataMDB, PathDataWSMDB, PathAccessMDB, PathServerMDB: string;
  PathServiceRudaWS: string;
  NoErrСreateNewField: boolean; //true - удалось создать поля и таблицы для работы с новой версией СКРП (поддержка OPC)
                                //false - не удалось создать поля и таблицы для работы с новой версией СКРП (поддержка OPC)
                                //Создавать поля и таблицы необходимо, чтобы была совместимость с предыдущими версиями BD
  LevelRecLogRudaMonitor: integer;
  OPCServerGUID: TGUID;
  PathFileNameOPCDAServer: string;   //путь + имя файла OPC DA сервера
  PathFileNameOPCHDAServer: string;  //путь + имя файла OPC HDA сервера
  ServerIfDA: IOPCServer;
  ServerIfHDA: IOPCHDA_Server;
  StateProcessCompressDB: TStateCompressDB;     //статус процесса сжатия баз данных

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses MainUnit;

{$R *.dfm}
var
  param : TParam;

// Конструктор
// --------------------------------------------------------------------------
constructor TParam.Create(const ParamNumber : integer;
                          const ParamName   : string);
begin
  // Сохранение переданных параметров
  self.ParamNumber := ParamNumber;
  self.ParamName   := ParamName;
end;

function TDM.QueryAccess(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
  const FunctionName = 'DM.QueryAccess';  //имя функции
begin
  result:= true;
  ADOQueryAccessMDB.Close;
  ADOQueryAccessMDB.SQL.Clear;
  ADOQueryAccessMDB.SQL.Text:= TextSQL;
  try
    log(Format('[RudaAdmin][%s] %s', [FunctionName, TextSQL]), 4);
    if ActiveOrExecSQL then ADOQueryAccessMDB.Open else ADOQueryAccessMDB.ExecSQL;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[' + ProcedureName + ']' + #13#10 +
                                     e.Message + #13#10 +
                                     '"' + TextSQL +'"'),
                               PChar(CaptionDlg),
                               MB_OK + MB_ICONSTOP);
        result:= false;
      end;
  end;
end;

//Data на сервере DBCD RudaDataDubl
function TDM.QueryData(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
  const FunctionName = 'DM.QueryData';  //имя функции
begin
  result:= true;
  ADOQueryDataMDB.Close;
  ADOQueryDataMDB.SQL.Clear;
  ADOQueryDataMDB.SQL.Text:= TextSQL;
  try
    log(Format('[RudaAdmin][%s] %s', [FunctionName, TextSQL]), 4);
    if ActiveOrExecSQL then ADOQueryDataMDB.Open else ADOQueryDataMDB.ExecSQL;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[' + ProcedureName + ']' + #13#10 +
                                     e.Message + #13#10 +
                                     '"' + TextSQL +'"'),
                               PChar(CaptionDlg),
                               MB_OK + MB_ICONSTOP);
        result:= false;
      end;
  end;
end;

//Data на раб станции DBCD1  RudaData
function TDM.QueryDataWS(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
  const FunctionName = 'DM.QueryDataWS';  //имя функции
begin
  result:= true;
  ADOQueryDataWSMDB.Close;
  ADOQueryDataWSMDB.SQL.Clear;
  ADOQueryDataWSMDB.SQL.Text:= TextSQL;
  try
    log(Format('[RudaAdmin][%s] %s', [FunctionName, TextSQL]), 4);
    if ActiveOrExecSQL then ADOQueryDataWSMDB.Open else ADOQueryDataWSMDB.ExecSQL;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[' + ProcedureName + ']' + #13#10 +
                               e.Message + #13#10 + '"' + TextSQL +'"'),
                               PChar(CaptionDlg), MB_OK + MB_ICONSTOP);
        result:= false;
      end;
  end;
end;

function TDM.QueryServer(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
  const FunctionName = 'DM.QueryServer';  //имя функции
begin
  result:= true;
  ADOQueryServerMDB.Close;
  ADOQueryServerMDB.SQL.Clear;
  ADOQueryServerMDB.SQL.Text:= TextSQL;
  try
    log(Format('[RudaAdmin][%s] %s', [FunctionName, TextSQL]), 4);
    if ActiveOrExecSQL then ADOQueryServerMDB.Open else ADOQueryServerMDB.ExecSQL;
  except
    on e: Exception do
      begin

        Application.MessageBox(PChar('[' + ProcedureName + ']' + #13#10 +
                               e.Message + #13#10 + '"' + TextSQL +'"'),
                               PChar(CaptionDlg), MB_OK + MB_ICONSTOP);
//        MessageBox(handle, PChar(e.Message + #13#10 + '"' + TexSQL +'"'),
//                           PChar(CaptionDlg), MB_ICONERROR+MB_OK);
        result:= false;
      end;
  end;
end;

function TDM.QueryWorkStation(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
  const FunctionName = 'DM.QueryWorkStation';  //имя функции
begin
  result:= true;
  ADOQueryWorkStationMDB.Close;
  ADOQueryWorkStationMDB.SQL.Clear;
  ADOQueryWorkStationMDB.SQL.Text:= TextSQL;
  try
    log(Format('[RudaAdmin][%s] %s', [FunctionName, TextSQL]), 4);
    if ActiveOrExecSQL then ADOQueryWorkStationMDB.Open else ADOQueryWorkStationMDB.ExecSQL;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[' + ProcedureName + ']' + #13#10 +
                               e.Message + #13#10 + '"' + TextSQL +'"'),
                               PChar(CaptionDlg), MB_OK + MB_ICONSTOP);
        result:= false;
      end;
  end;
end;

function TDM.QueryTempWorkStation(TextSQL, CaptionDlg, ProcedureName: string; ActiveOrExecSQL: boolean): boolean;
  const FunctionName = 'DM.QueryTempWorkStation';  //имя функции
begin
  result:= true;
  ADOQueryTempWS.Close;
  ADOQueryTempWS.SQL.Clear;
  ADOQueryTempWS.SQL.Text:= TextSQL;
  try
    log(Format('[RudaAdmin][%s] %s', [FunctionName, TextSQL]), 4);
    if ActiveOrExecSQL then ADOQueryTempWS.Open else ADOQueryTempWS.ExecSQL;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[' + ProcedureName + ']' + #13#10 +
                               e.Message + #13#10 + '"' + TextSQL +'"'),
                               PChar(CaptionDlg), MB_OK + MB_ICONSTOP);
        result:= false;
      end;
  end;
end;

function TDM.CommandWS(TextSQL, CaptionDlg, ProcedureName: string): boolean;
  const FunctionName = 'DM.CommandWS';  //имя функции
begin
  result:= true;
  ADOCommandWS.CommandText:= TextSQL;
  try
    log(Format('[RudaAdmin][%s] %s', [FunctionName, TextSQL]), 4);
    ADOCommandWS.Execute;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[' + ProcedureName + ']' + #13#10 +
                               e.Message + #13#10 + '"' + TextSQL +'"'),
                               PChar(CaptionDlg), MB_OK + MB_ICONSTOP);
        result:= false;
      end;
  end;
end;

function TDM.DataSetWS(TextSQL, CaptionDlg, ProcedureName: string): boolean;
  const FunctionName = 'DM.DataSetWS';  //имя функции
begin
  result:= true;
  ADODataSetWS.Close;
  ADODataSetWS.CommandText:= TextSQL;
  try
    log(Format('[RudaAdmin][%s] %s', [FunctionName, TextSQL]), 4);
    ADODataSetWS.Open;
//    ADODataSetWS.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[' + ProcedureName + ']' + #13#10 +
                               e.Message + #13#10 + '"' + TextSQL +'"'),
                               PChar(CaptionDlg), MB_OK + MB_ICONSTOP);
        result:= false;
      end;
  end;
end;

function TDM.DataSetServer(TextSQL, CaptionDlg, ProcedureName: string): boolean;
  const FunctionName = 'DM.DataSetServer';  //имя функции
begin
  result:= true;
  ADODataSetServer.Close;
  ADODataSetServer.CommandText:= TextSQL;
  try
    log(Format('[RudaAdmin][%s] %s', [FunctionName, TextSQL]), 4);
    ADODataSetServer.Open;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[' + ProcedureName + ']' + #13#10 +
                               e.Message + #13#10 + '"' + TextSQL +'"'),
                               PChar(CaptionDlg), MB_OK + MB_ICONSTOP);
        result:= false;
      end;
  end;
end;

function TDM.ConnectBDAccess(var ErrSQLState: string): integer;
begin
  result:= 0;
  try
    ADOconnectionAccessMDB.Connected:=false;
    ADOconnectionAccessMDB.ConnectionString:= Format(DSNstring, [DSNNameRudaAdmin, 'admin', '']);//s1_DSN + DSNName + s2_DSN; //s1 + path + s2;
    ADOconnectionAccessMDB.Connected:=true;
  except
    on E: EDataBaseError do
      begin
        result:= ADOconnectionAccessMDB.Errors[0].Number;
        ErrSQLState:= ADOconnectionDataWSMDB.Errors[0].SQLState;
      end;
  end;
end;

////аналог DBCD. На сервере "RudaDataDubl"
function TDM.ConnectBDData(var ErrSQLState: string): integer;
begin
  result:= 0;
  try
    ADOconnectionDataMDB.Connected:=false;
    ADOconnectionDataMDB.ConnectionString:= Format(DSNstring, [DSNNameRudaDataDubl, 'admin', '']);//s1_DSN + DSNName + s2_DSN; //s1 + path + s2;
    ADOconnectionDataMDB.Connected:=true;
  except
    on E: EDataBaseError do
        result:= ADOconnectionDataMDB.Errors[0].Number;
  end;
end;

//аналог DBCD1. На рабочей станции "RudaData"
function TDM.ConnectBDDataWS(var ErrSQLState: string): integer;
begin
  result:= 0;
  ErrSQLState:= 'none';
  try
    ADOConnectionDataWSMDB.Connected:=false;
    ADOconnectionDataWSMDB.ConnectionString:= Format(DSNstring, [DSNNameRudaData, 'admin', '']);//s1_DSN + DSNName + s2_DSN; //s1 + path + s2;
    ADOconnectionDataWSMDB.Connected:=true;
  except
    on E: EDataBaseError do
      begin
        result:= ADOconnectionDataWSMDB.Errors[0].NativeError;
        ErrSQLState:= ADOconnectionDataWSMDB.Errors[0].SQLState;
//        result:= ADOconnectionDataWSMDB.Errors[0].Errors[0].Number;
      end;
  end;
end;

function TDM.ConnectBDServer(var ErrSQLState: string): integer;
begin
  result:= 0;
  try
    ADOconnectionServerMDB.Connected:=false;
    ADOconnectionServerMDB.ConnectionString:= Format(DSNstring, [DSNNameRudaServer, 'admin', '']);//s1_DSN + DSNName + s2_DSN; //s1 + path + s2;
    ADOconnectionServerMDB.Connected:=true;
  except
    on E: EDataBaseError do
        result:= ADOconnectionServerMDB.Errors[0].Number;
  end;
end;

function TDM.ConnectBDWorkStation(var ErrSQLState: string): integer;
begin
  result:= 0;
  try
    ADOconnectionWorkStationMDB.Connected:=false;
    ADOconnectionWorkStationMDB.ConnectionString:= Format(DSNstring, [DSNNameRudaWS, 'admin', '']);//s1_DSN + DSNName + s2_DSN; //s1 + path + s2;
    ADOconnectionWorkStationMDB.Connected:=true;
  except
    on E: EDataBaseError do
        result:= ADOconnectionWorkStationMDB.Errors[0].Number;
  end;
end;

//узнаем версию программы
procedure TDM.GetVersionProgramm(var MajorVersion, MinorVersion,
                                        ReleaseVersion, BuildVersion: word);
  type
    TVerInfo=packed record
      Nevazhno: array[0..47] of byte; // ненужные нам 48 байт
      Minor,Major,Build,Release: word; // а тут версия
  end;
var
  s:TResourceStream;
  v:TVerInfo;
begin
  try
    s:= TResourceStream.Create(HInstance,'#1',RT_VERSION); // достаём ресурс
    if s.Size > 0 then begin
      s.Read(v,SizeOf(v)); // читаем нужные нам байты
      MajorVersion  := v.Major;
      MinorVersion  := v.Minor;
      ReleaseVersion:= v.Release;
      BuildVersion  := v.Build;
    end;
    s.Free;
  except; end;

end;

//из ODBC DSN извлекаем путь к базе
function TDM.FromDSNgetPathBase(NameDSN, KeyRead: string): string;
  const SubKey = 'Software\ODBC\ODBC.INI';
//        KeyRead = 'DBQ';
  var registry: TRegistry;
      KeyOpen: string;
begin
  result:= '';
  if Trim(NameDSN) = '' then exit;

  Registry := TRegistry.Create(KEY_READ or KEY_WRITE);

  try
    Registry.RootKey:= RootKey_HKCU;
    KeyOpen:= SubKey + '\' + NameDSN;

    Registry.OpenKeyReadOnly(KeyOpen);// OpenKey(Key_Open, False);
    if registry.ValueExists(KeyRead) then result:= Registry.ReadString(KeyRead)
  finally
    Registry.Free;
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  GetVersionProgramm(MajorVersion, MinorVersion, ReleaseVersion, BuildVersion);
  ShortStringVersion:= Format('%d.%d', [MajorVersion, MinorVersion]);
  FullStringVersion := Format('%d.%d.%d.%d', [MajorVersion, MinorVersion,
                                              ReleaseVersion, BuildVersion]);
  ProgName_ShortStringVersion:= ProgrammName + ' ' + ShortStringVersion;
  ProgName_FullStringVersion := ProgrammName + ' ' + FullStringVersion;
  PathApp:= IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));

  myFormatDateTime.ShortDateFormat:= 'dd.mm.yyyy';
  myFormatDateTime.LongDateFormat:= 'dd.mm.yyyy hh:nn:ss';
  myFormatDateTime.ShortTimeFormat:= 'hh:nn:ss';
  myFormatDateTime.LongTimeFormat:= 'hh:nn:ss.zzz';
  myFormatDateTime.DateSeparator:= '.';
  myFormatDateTime.TimeSeparator:= ':';

  //  myFormatDateTime.ShortDateFormat:= 'dd.mm.yyyy hh:mm:ss';
//  myFormatDateTime.LongTimeFormat:= 'hh:mm:ss';
//  myFormatDateTime.DateSeparator:= '.';
//  myFormatDateTime.TimeSeparator:= ':

  // Создание объекта TList для хранения набора объектов клиент
  clDDW := TList.Create;
  clDDCW:= TList.Create;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  clDDW.Free;
  clDDCW.Free;
end;

procedure TDM.CheckHexPressKey(NameLabel: string; var Key: Char);
begin
  if not ((Key in ['0'..'9', 'a'..'f', 'A'..'F', #8, #13]) or (Key = ^C) or (Key = ^V)) then
    begin
      Application.MessageBox(PChar('В поле ' + NameLabel + ' вводится значение байта в шестнадцатиричном виде (hex).'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                             MB_OK + MB_ICONSTOP);
      Key:= #0;
    end;
end;

function TDM.CheckIntPressKey(NameLabel: string; var Key: Char): boolean;
begin
  result:= true;
  if not ((Key in ['0'..'9', #8, #13]) or (Key = ^C) or (Key = ^V)) then
    begin
      Application.MessageBox(PChar('В поле ' + NameLabel + ' допускается ввод только чисел.'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                             MB_OK + MB_ICONSTOP);
      Key:= #0;
      result:= false;
    end;
end;

procedure TDM.CheckFloatPressKey(NameLabel: string; var Edit: TEdit; var Key: Char; Precision: integer = 6);
  var indexDecimalSeparator: integer;
      s: string;
begin
  if Key in ['.', ','] then
    if key <> FormatSettings.DecimalSeparator then key:= FormatSettings.DecimalSeparator;

  indexDecimalSeparator:= pos(FormatSettings.DecimalSeparator, Edit.Text);
  //проверка нет ли повторных запятых или знаков минус
  if (Key = FormatSettings.DecimalSeparator) and (indexDecimalSeparator > 0) then
    begin
      Key:= #0;
      exit;
    end;

  //проверка на разрешенные символы
  s:= Edit.Text;
  if (Key in ['0'..'9', FormatSettings.DecimalSeparator, #8, #13]) or (Key = ^C) or (Key = ^V) then
    begin
      //проверка на ограничение ввода чисел после запятой
      if ((Key in ['0'..'9']) and                                 //если это число
          (indexDecimalSeparator > 0) and                         //если есть символ разделителя дробной части
          (Edit.SelStart >= indexDecimalSeparator) and            //если вводимый символ находится справа от разделителя, т.е. в дробной части
          (Edit.SelLength = 0) and                                //если не идет замены нескольких символов
          (s.Length - indexDecimalSeparator + 1 > Precision)) or  //если число знаков после запятой привышает разряда точности
         ((Key = FormatSettings.DecimalSeparator) and             //если хотят вставить разделитель дробной части
          (Edit.SelStart < s.Length - Precision - Edit.SelLength))//если вставка разделительного символа отделяет больше знаков справа, чем количество символов точности
         then
        begin
          Key:= #0;
          exit;
        end;
    end
    else begin
      Application.MessageBox(PChar('В поле ' + NameLabel + ' допускается ввод числа или одного знака запятой или точки.'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                             MB_OK + MB_ICONSTOP);
      Key:= #0;
    end;
end;

procedure TDM.CheckSignFloatPressKey(NameLabel, CheckDblText: string; var Key: Char);
begin
  if Key in ['.', ','] then
    if key <> FormatSettings.DecimalSeparator then key:= FormatSettings.DecimalSeparator;

  //проверка нет ли повторных запятых или знаков минус
  if ((Key = ',') and (pos(',', CheckDblText) > 0)) or
     ((Key = '-') and (pos('-', CheckDblText) > 0)) then
        key:= #0;

  if not ((Key in ['0'..'9', FormatSettings.DecimalSeparator, '-', #08, #13]) or
          (Key = ^C) or (Key = ^V)) then
    begin
      Application.MessageBox(PChar('В поле ' + NameLabel + ' допускается ввод чисел, одной запятой (точки) или одного знака "минус".'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                             MB_OK + MB_ICONSTOP);
      key:= #0;
    end;
end;

procedure TDM.CheckSpecialSymbolPressKey(NameLabel, CheckDblText: string; var Key: Char);
begin
  if (Key in ['.', ',', '/', '\', '?']) then
    begin
      Application.MessageBox(PChar('В поле ' + NameLabel + ' не допускается ввод следующих символов: ".", ",", "/", "\", "?"'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                             MB_OK + MB_ICONSTOP);
      key:= #0;
    end;
end;

function TDM.EmptyStringSQL(str: string; quotes: boolean): string;
begin
  if Trim(str) = '' then result:= 'null'
                    else begin
                      if quotes then result:= '''' + Trim(str) + ''''
                                else result:= Trim(str);
                    end;
end;

function TDM.CheckTime(StrTime: string): boolean;
  var TempStr: string;
begin
  result:= false;
  TempStr:= Copy(Trim(StrTime), 1, 2);
  try
    if StrToInt(TempStr) > 23 then exit;
  except
    exit;
  end;
  TempStr:= Copy(Trim(StrTime), 4, 2);
  try
    if StrToInt(TempStr) > 59 then exit;
  except
    exit;
  end;
  result:= true;
end;

function TDM.HexToInt(Str : string): integer;
var i, r : integer;
begin
  val('$'+Trim(Str),r, i);
  if i<>0 then HexToInt := 0 {была ошибка в написании числа}
  else HexToInt := r;
end;

function TDM.ValNumeric(StrNum: string): string;
begin
  try
    result:= FloatToStr(StrToFloat(StrNum));
  except
    result:= '0';
  end;
end;
// установка бита
function TDM.BitOn(const val: longint; const BitNum: byte): LongInt;
  begin
    result:= val or (1 shl BitNum);
  end;

function TDM.ValueList(ParamList:TList; ParamName: string): integer;
  var i: integer;
begin
  result:= -1;
  for i:= 0 to ParamList.Count - 1 do
    if TParam(ParamList[i]).Name = ParamName then
      begin
        result:= TParam(ParamList[i]).Number;
        break;
      end;
end;

procedure TDM.FullDD(FormCaption: string);
  var Ms_Code, L_Code: string;
begin
  QueryWorkStation('SELECT * FROM ParamLines WHERE [Connect] AND Num > 0 ORDER BY Num',
                                FormCaption, 'FullDD', true);

  while not ADOQueryWorkStationMDB.Eof do
    begin
      QueryTempWorkStation('SELECT * FROM Measurer WHERE L_Code = ' +
                            ADOQueryWorkStationMDB.FieldByName('L_Code').AsString +
                            ' AND Num > 0 AND Ms_Status = 6 AND [Connect]',
                                FormCaption, 'FullDD', true);

      Ms_Code:= ADOQueryTempWS.FieldByName('Ms_Code').AsString;
      L_Code:=  ADOQueryTempWS.FieldByName('L_Code').AsString;
      if not ADOQueryTempWS.Eof and CheckNumeric(ADOQueryTempWS.FieldByName('Code1').AsString) then
        begin
          clDDW.Add(TParam.Create(ADOQueryTempWS.FieldByName('Code1').AsInteger,
                                  'D' + L_Code));

          QueryTempWorkStation('SELECT * FROM LinkW WHERE Ms_Code_W = ' + Ms_Code,
                                FormCaption, 'FullDD', true);
          if not ADOQueryTempWS.Eof then
            clDDCW.Add(TParam.Create(ADOQueryTempWS.FieldByName('Ms_Code_MB').AsInteger,
                                  'D' + L_Code));
        end;
      ADOQueryWorkStationMDB.Next;
    end;
end;

procedure TDM.CloseAllWinClassName(ClassName, WindowName: PWideChar);
  var H : HWND;
begin
  repeat
    H:= FindWindow(ClassName, WindowName);
    if H <> 0 then DestroyWindow(h);
//    if H <> 0 then SendMessage(H, wm_quit{WM_CLOSE}, 0, 0);
  until H = 0;
end;

procedure TDM.CloseAllWin(tagWin: integer);
  var i, OldComponentCount: integer;
begin
  repeat
    OldComponentCount:= Application.ComponentCount;
    for i := 0 to OldComponentCount - 1 do
      if (Application.Components[i] is TForm) and (Application.Components[i].Tag = tagWin) then
        begin
          Application.Components[i].Free;
          break;
        end;
  until OldComponentCount = Application.ComponentCount; //значит уже нет заданного окна
end;

function TDM.CountWin: integer;
var wnd: hwnd;
    buff: array [0..127] of char;
    Handle:THandle;
begin
  result:= 0;
  wnd := GetWindow(Handle, gw_hwndfirst);
  while wnd <> 0 do
    begin // Не показываем:
      if (wnd <> Application.Handle) // Собственное окно
          and IsWindowVisible(wnd) // Невидимые окна
          and (GetWindow(wnd, gw_owner) = 0) // Дочерние окна
          and (GetWindowText(wnd, buff, SizeOf(buff)) <> 0) then
        begin
          inc(result);
        end;
      wnd:= GetWindow(wnd, gw_hwndnext);
    end;
end;

procedure TDM.ListLine(var Lines: TLines; sCaption: string);     //список конвейеров по порядку (номера L_Code)
  var i: integer;
begin
  FillChar(Lines, sizeof(Lines), 0);
  i:= 0;
  if DM.QueryServer('SELECT L_Code FROM Lines', sCaption, 'ListLine', true) then
    begin
      while not DM.ADOQueryServerMDB.EOF do
        begin
          Lines[i]:= DM.ADOQueryServerMDB.FieldByName('L_Code').AsInteger;
          inc(i);
          Lines[MAXLINE]:= i;
          DM.ADOQueryServerMDB.Next;
        end;
    end;
end;

function TDM.FunTypeController: integer;
begin
  result:= -1;
  //узнаем какой тип контроллеров используется на данной станции
  if not DM.QueryWorkStation('SELECT TypeController FROM ParamStation',
        'DM', 'TypeController', true) then exit;

  if DM.DataSourceWorkStationMDB.DataSet.RecordCount = 0 then exit;  //если запись не найдена
  try
    result:= DM.ADOQueryWorkStationMDB.FieldByName('TypeController').AsInteger;  //тип контроллера MK001 - 1, MK002 - 2, MK003 - 3
  except
    result:= -1;
  end;
end;

//проверяет соответсвует ли тип данного контроллера типу устройств системы (фабрике)
function TDM.SelectionByControllerType(ControllerID: Int64; TypeController: integer): boolean;   //выбор по типу контроллера
  begin
    result:= false;
      //определяем тип контроллера, чтобы отсеить те, которые не используются на данной станции
    if not QueryServer('SELECT Controllers.*, TypeControllers.* ' +
        'FROM Controllers LEFT JOIN TypeControllers ON Controllers.Cn_TypeController = TypeControllers.Nc_Code ' +
        'WHERE Cn_Code = ' + inttostr(ControllerID),
        'DM', 'SelectionByControllerType', true) then exit;

    if DataSourceServerMDB.DataSet.RecordCount > 0 then   //если запись найдена
    if TypeController = ADOQueryServerMDB.FieldByName('Cn_TypeController').AsInteger then result:= true;
  end;

procedure TDM.ListLineChannel(Lines: TLines; var LinesChannels: TLinesChannels; var UsedChannels: TUsedChannels; sCaption: string);
  var i, n, param_MsPoint, msStatusW, AnalogOrPulse: integer;
      lName: string;
      TypeController: integer;
begin
  FillChar(LinesChannels, sizeof(LinesChannels), 0);
  FillChar(UsedChannels, sizeof(UsedChannels), 0);

  TypeController:= FunTypeController;
  if TypeController < 0 then exit; //значит ошибка

  for i:= 0 to Lines[MAXLINE] - 1 do   //в Lines[MAXLINE] общее число конвейеров . Было MAXCHANNEL
    begin
      LinesChannels[i].L_Code:= Lines[i];
      LinesChannels[i].TypeController:= TypeController;
      DM.QueryServer('SELECT L_Name, Connect FROM Lines WHERE L_Code = ' + IntToStr(Lines[i]),
                    sCaption, 'ListLineChannel', true);
      if not DM.ADOQueryServerMDB.EOF then
        begin
          lName:= Trim(DM.ADOQueryServerMDB.FieldByName('L_Name').AsString);
          StrPCopy(LinesChannels[i].L_Name, lName);
          LinesChannels[i].ConnectLine:= DM.ADOQueryServerMDB.FieldByName('Connect').AsBoolean;
        end;

      n:= 0;
      msStatusW:= -1;
      //получаем данные по весам
      DM.QueryWorkStation('SELECT Measurer.L_Code, Measurer.Ms_Status, Measurer.Connect, Measurer.Code1 ' +
                          'FROM Measurer INNER JOIN LinkW ON Measurer.Ms_Code = LinkW.Ms_Code_W ' +
                          'WHERE (((Measurer.L_Code)=' + IntToStr(Lines[i]) + ') AND ((Measurer.Connect)=True))',
                          sCaption, 'ListLineChannel', true);
      if not DM.ADOQueryWorkStationMDB.EOF then
        begin
          msStatusW:= DM.ADOQueryWorkStationMDB.FieldByName('Ms_Status').AsInteger;
        end;

      case msStatusW of
        -1,2: AnalogOrPulse:= 4; //значит используются аналоговые весы (если -1 - весов нет)
           6: AnalogOrPulse:= 3; //значит используются импульсные весы
      end;

      //получаем данные подключенного MB-5 и если есть аналоговые весы, то и их
      //Points.Point, Points.Plata, Points.Status, Points.NUM, Points.Max_I
//      DM.QueryWorkStation('SELECT DISTINCT Points.*, Measurer.Ms_Name ' +
//                          'FROM LinkW, Points INNER JOIN Measurer ON (Points.L_Code = Measurer.L_Code) AND (Points.Ms_Code = Measurer.Ms_Code) ' +
//                          'WHERE (((Measurer.Connect)=True) AND ((Points.L_Code)=' + IntToStr(Lines[i]) +
//                          ') AND ((Status < 3) OR (Status = 4) OR ((Status = 3) AND (Measurer.Ms_Code = LinkW.Ms_Code_W))))',
//                          FormViewEquipment.Caption, 'ListLineChannel', true);
//      while not DM.ADOQueryWorkStationMDB.EOF do
//        begin
//          LinesChannels[i].Channel[n] := DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger + 1;
//          LinesChannels[i].Point[n]   := DM.ADOQueryWorkStationMDB.FieldByName('Point').AsInteger + 1;
//          LinesChannels[i].Unull[n]   := DM.ADOQueryWorkStationMDB.FieldByName('Null_I').AsFloat;
//          LinesChannels[i].Umin[n]    := DM.ADOQueryWorkStationMDB.FieldByName('Min_I').AsFloat;
//          LinesChannels[i].Umax[n]    := DM.ADOQueryWorkStationMDB.FieldByName('Max_I').AsFloat;
//          LinesChannels[i].Num[n]     := DM.ADOQueryWorkStationMDB.FieldByName('NUM').AsInteger;
//          LinesChannels[i].Measurer[n]:= DM.ADOQueryWorkStationMDB.FieldByName('Status').AsInteger;
//          lName:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Ms_Name').AsString);
//          StrPCopy(LinesChannels[i].NameMeasurer[n], lName);
//          LinesChannels[i].ColorLine[n]:= DM.ADOQueryWorkStationMDB.FieldByName('Color').AsInteger;
//          inc(n);
//          DM.ADOQueryWorkStationMDB.Next;
//        end;

     //получаем данные подключенного MB-5 и если есть аналоговые весы, то и их
      DM.QueryTempWorkStation('SELECT * FROM Measurer WHERE [Connect] AND L_Code = ' + IntToStr(Lines[i]),
          sCaption, 'ListLineChannel', true);

      while not DM.ADOQueryTempWS.EOF do
        begin
//          DM.QueryWorkStation('SELECT * FROM Points WHERE MS_Code = ' +
//            DM.ADOQueryTempWS.FieldByName('MS_Code').AsString, sCaption, 'ListLineChannel', true);

          DM.QueryWorkStation('SELECT Points.*, LinkContr.*, SettingsCOMPort.* ' +
            'FROM (Points INNER JOIN LinkContr ON Points.Lc_Code = LinkContr.Lc_Code) INNER JOIN SettingsCOMPort ON LinkContr.Sp_Code = SettingsCOMPort.Sp_Code ' +
            'WHERE MS_Code = ' + DM.ADOQueryTempWS.FieldByName('MS_Code').AsString,
            sCaption, 'ListLineChannel', true);

          while not DM.ADOQueryWorkStationMDB.EOF do
            begin
              DM.DataSetWS('SELECT * FROM LinkW WHERE Ms_Code_W = ' + DM.ADOQueryTempWS.FieldByName('MS_Code').AsString,
                             sCaption, 'ListLineChannel');
              if (DM.ADOQueryWorkStationMDB.FieldByName('Status').AsInteger in [1,2,4]) or
                 ((DM.ADOQueryWorkStationMDB.FieldByName('Status').AsInteger = 3) and (not DM.ADODataSetWS.Eof)) then
                begin
                  if SelectionByControllerType(DM.ADOQueryWorkStationMDB.FieldByName('Cn_Code').AsInteger, TypeController) then
                    begin
                      lName:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('NameController').AsString);
                      StrPCopy(LinesChannels[i].NameController[n], lName);
                      LinesChannels[i].PortNumber[n]:= DM.ADOQueryWorkStationMDB.FieldByName('PortNum').AsInteger;
                      LinesChannels[i].Channel[n]   := DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger + 1;
                      UsedChannels[DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger]:= 1;
                      LinesChannels[i].Point[n]     := DM.ADOQueryWorkStationMDB.FieldByName('Point').AsInteger + 1;
                      LinesChannels[i].Unull[n]     := DM.ADOQueryWorkStationMDB.FieldByName('Null_I').AsFloat;
                      LinesChannels[i].Umin[n]      := DM.ADOQueryWorkStationMDB.FieldByName('Min_I').AsFloat;
                      LinesChannels[i].Umax[n]      := DM.ADOQueryWorkStationMDB.FieldByName('Max_I').AsFloat;
                      LinesChannels[i].Num[n]       := DM.ADOQueryWorkStationMDB.FieldByName('NUM').AsInteger;
                      LinesChannels[i].Measurer[n]  := DM.ADOQueryWorkStationMDB.FieldByName('Status').AsInteger;
                      lName:= Trim(DM.ADOQueryTempWS.FieldByName('Ms_Name').AsString);
                      StrPCopy(LinesChannels[i].NameMeasurer[n], lName);
                      LinesChannels[i].ColorLine[n]:= DM.ADOQueryWorkStationMDB.FieldByName('Color').AsInteger;
                      inc(n);
                    end;
                end;
              DM.ADOQueryWorkStationMDB.Next;
            end;
          DM.ADOQueryTempWS.Next;
        end;

      //получаем список подключенных: датчик движения и импульсные весы
//      DM.QueryWorkStation('SELECT * FROM Measurer' +
//                         ' WHERE (L_Code = ' + IntToStr(Lines[i]) + ') AND ((Measurer.Connect)=True) AND (((Measurer.Ms_Status)=3) OR ((Measurer.Ms_Status)>4)) ORDER BY Ms_Status',
//                         sCaption, 'ListLineChannel', true);

      DM.QueryWorkStation('SELECT Measurer.*, LinkContr.*, SettingsCOMPort.* ' +
        'FROM (Measurer INNER JOIN LinkContr ON Measurer.Lc_Code = LinkContr.Lc_Code) INNER JOIN SettingsCOMPort ON LinkContr.Sp_Code = SettingsCOMPort.Sp_Code ' +
        ' WHERE (L_Code = ' + IntToStr(Lines[i]) + ') AND ((Measurer.Connect) = True) AND (((Measurer.Ms_Status) = 3) OR ((Measurer.Ms_Status)>4)) ORDER BY Ms_Status',
                         sCaption, 'ListLineChannel', true);

      while not DM.ADOQueryWorkStationMDB.EOF do
        begin
          case DM.ADOQueryWorkStationMDB.FieldByName('Ms_Status').AsInteger of
                    3: param_MsPoint:= 10; //дискр. датчик 1
                    5: param_MsPoint:= 11; //дискр. датчик 2
                    6: param_MsPoint:= 12; //импульсные весы
          end;
          if (param_MsPoint = 10) or (param_MsPoint = 11) or
             ((param_MsPoint = 12) and (AnalogOrPulse = 3)) then
            begin
              if SelectionByControllerType(DM.ADOQueryWorkStationMDB.FieldByName('Cn_Code').AsInteger, TypeController) then
                begin
                  lName:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('NameController').AsString);
                  StrPCopy(LinesChannels[i].NameController[n], lName);
                  LinesChannels[i].PortNumber[n]:= DM.ADOQueryWorkStationMDB.FieldByName('PortNum').AsInteger;
                  LinesChannels[i].Channel[n]:= DM.ADOQueryWorkStationMDB.FieldByName('Code1').AsInteger + 1;
                  UsedChannels[DM.ADOQueryWorkStationMDB.FieldByName('Code1').AsInteger]:= 1;
                  LinesChannels[i].Measurer[n]:= param_MsPoint;
                  LinesChannels[i].Num[n]:= DM.ADOQueryWorkStationMDB.FieldByName('NUM').AsInteger;
                  lName:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Ms_Name').AsString);
                  StrPCopy(LinesChannels[i].NameMeasurer[n], lName);
                  inc(n);
                end;
            end;
          DM.ADOQueryWorkStationMDB.Next;
        end;
    end;

  for i := 0 to High(UsedChannels) - 1 do      //подсчитываем количество задействованных каналов
    if UsedChannels[i] > 0 then inc(UsedChannels[High(UsedChannels)]);
end;

function TDM.RunAsAdmin(HWND: hWnd; lpFile,lpParameters: string; out hProcess: THandle): boolean;
var
 sei: SHELLEXECUTEINFO;
begin
  try
    ZeroMemory ( @sei, SizeOf(sei) );
    sei.cbSize := SizeOf(SHELLEXECUTEINFOW);
    sei.Wnd := hWnd;
    sei.fMask := SEE_MASK_NOCLOSEPROCESS; //SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
    sei.lpVerb := 'runas';
    sei.lpFile := PWideChar(lpFile);
    sei.lpParameters := PWideChar(lpParameters);
    sei.nShow := SW_HIDE; //SW_SHOWNORMAL;
    if ( not ShellExecuteEx ( @sei ) ) then begin
      Application.MessageBox(PChar(SysErrorMessage(GetLastError) + ' ' + lpFile), 'Ошибка', MB_OK or MB_ICONERROR);
//      ShowMessage( 'Ошибка: ShellExecuteEx код ' + IntToStr(GetLastError) );
      Result := False;
      Exit;
    end;
    hProcess:= sei.hProcess;
    Result := True;
  except
    else Result := False;
  end;
end;

//procedure TDM.RebootMonitor; //устанавливаем 1 - признак для перезагрузки Монитора
//  var
//    receiverHandle : THandle;
//    copyDataStruct : TCopyDataStruct;
//    peremen, res: integer;
//begin
//  peremen:= 1; //перезагруз
//  copyDataStruct.dwData:= 2; //RudaMonitor - перезагруз
//  copyDataStruct.cbData:= SizeOf(peremen);
//  copyDataStruct.lpData:= @peremen;
//  receiverHandle := FindWindow(PChar('TFormRudaMonitor'), nil);
//  if receiverHandle = 0 then
//    begin
//      //передать данные не удалось
//      Exit;
//    end;
//  res:= SendMessage(receiverHandle, WM_COPYDATA, Application.Handle,
//        Integer(@copyDataStruct)) ;
//
////  DM.WriteToReg(RootKey, SubKey, 'Settings', 'ChangeSetting', asInteger,
////        ParamString, 1, ParamFloat, ParamBoolean);
//end;

procedure TDM.RebootMonitor; //устанавливаем 1 - признак для перезагрузки Монитора
begin
  WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'ChangeSetting', 1);
end;

function TDM.ServiceGetStatus(sMachine, sService: PChar): DWORD;
  {******************************************}
  {*** Parameters: ***}
  {*** sService: specifies the name of the service to open
  {*** sMachine: specifies the name of the target computer
  {*** ***}
  {*** Return Values: ***}
  {*** -1 = Error opening service ***}
  {*** 1 = SERVICE_STOPPED ***}
  {*** 2 = SERVICE_START_PENDING ***}
  {*** 3 = SERVICE_STOP_PENDING ***}
  {*** 4 = SERVICE_RUNNING ***}
  {*** 5 = SERVICE_CONTINUE_PENDING ***}
  {*** 6 = SERVICE_PAUSE_PENDING ***}
  {*** 7 = SERVICE_PAUSED ***}
  {******************************************}
var
  SCManHandle, SvcHandle: SC_Handle;
  SS: TServiceStatus;
  dwStat: DWORD;
begin
  dwStat := 0;
  // Open service manager handle.
  SCManHandle := OpenSCManager(sMachine, nil, SC_MANAGER_CONNECT);
  if (SCManHandle > 0) then
  begin
    SvcHandle := OpenService(SCManHandle, sService, SERVICE_QUERY_STATUS);
    // if Service installed
    if (SvcHandle > 0) then
    begin
      // SS structure holds the service status (TServiceStatus);
      if (QueryServiceStatus(SvcHandle, SS)) then
        dwStat := ss.dwCurrentState;
      CloseServiceHandle(SvcHandle);
    end;
    CloseServiceHandle(SCManHandle);
  end;
  Result := dwStat;
end;

//Приверить, запущен ли сервис
function TDM.ServiceRunning(sMachine, sService: PChar): boolean;
begin
  Result:= SERVICE_RUNNING = ServiceGetStatus(sMachine, sService);
end;

function TDM.SendDataSet(CDS: TCopyDataStruct): integer;  //передать собщение всем окнам
  var receiverHandle: THandle;
      s: string;
begin
  result:=0;

  //для тест-состояния
  s:= ProgName_ShortStringVersion + ' Тест-Состояние';
  receiverHandle:= FindWindow(PChar('TFormTestState'), PChar(s));
  if receiverHandle <> 0 then
    result:= SendMessage(receiverHandle, WM_COPYDATA, Application.Handle, Integer(@CDS));
end;

procedure TDM.log(aStr: string; LevelRec: integer = 0);  //запись в лог файл работы системы
var ParamVariant: Variant;
    PathLogFiles: string;
    f: TextFile;
begin
  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Path', KeyReadLogFiles, asString,
              ParamVariant)
    then PathLogFiles:= ParamVariant
    else PathLogFiles:= '';

  if PathLogFiles = ''
    then PathLogFiles:= ExtractFilePath(ParamStr(0))
    else PathLogFiles:= IncludeTrailingPathDelimiter(PathLogFiles);

  if not ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'LevelRecLogRudaMonitor', asInteger,
              ParamVariant)
    then ParamVariant:= 0;
  if (ParamVariant >= 0) and (ParamVariant < 5) then LevelRecLogRudaMonitor:= ParamVariant
                                                else LevelRecLogRudaMonitor:= 0;

  if LevelRec > LevelRecLogRudaMonitor then exit;

  try
    AssignFile(f,PathLogFiles + logFileName);
    try
      if FileExists(PathLogFiles + logFileName) then append(f)//если файл есть откроем его для дозаписи
        else rewrite(f);//если нет, для записи
      Writeln(f, FormatDateTime('[dd.mm.yyyy hh:nn:ss.zzz]', now) + aStr);
    finally
      CloseFile(F);
    end;

  except
    on E: EInOutError do
      // Произошла ошибка - обработаем. В данном случае - показом сообщения, но в общем случае это может быть что угодно. Код ошибки доступен в E.ErrorCode
//      Application.MessageBox(PChar(E.Message), 'Ошибка', MB_OK or MB_ICONERROR);
  end;

end;

procedure TDM.PrintChart(Chart: TChart; sTitle1, sTitle2, sTitle3, PrinTitle: string);
  var rect: TRect;
begin
  Printer.PrinterIndex:=Printer.Printers.IndexOf(PrinterName); //Вытащил

  if PrintDialog1.Execute then
    begin
      Printer.Title := PrinTitle;   //выводится в свойства принтера
      Printer.Orientation := poLandscape; //poPortrait;
      Printer.BeginDoc;
      Printer.Canvas.Font.Size := 12;
      Printer.Canvas.Font.Style := [];

          // print report title1
      Printer.Canvas.TextOut(500, 100, sTitle1);

          // print report title2
      Printer.Canvas.TextOut(500, 250, sTitle2);

          // print report title3
      Printer.Canvas.TextOut(500, 400, sTitle3);

      rect.Left:= 500;
      rect.Top:= 700;
      rect.Right:= Printer.PageWidth - 200;
      rect.Bottom:= Printer.PageHeight - 500;
      Chart.PrintPartial(rect);
      Printer.EndDoc;
    end;
end;

procedure TDM.PrintListview(oListView: TListView; sTitle1, sTitle2, sTitle3, PrinTitle: string);
var
  pWidth, pHeight, i: Integer;
  v, h: Real;
  CurItem, iColumnCount: Integer;
  //aCols: array[0..50] of Integer; // Delphi 3
  aCols: array of Integer; // Delphi 5
  iTotColsWidth, iInnerWidth, TopMarg, LinesOnPage, CurLine, TekstHeight, CurCol: Integer;
  CurRect: TRect;
  CurStr: string;
  CurLeft, NumPages, TmpPos: Integer;

begin
  Printer.PrinterIndex:=Printer.Printers.IndexOf(PrinterName); //Вытащил

  if PrintDialog1.Execute then
  begin
    //запомнил в глобальной переменной и в реестре
//    DM.WriteToReg(RootKey, SubKey, 'Settings', 'PrinterName', asString,
//                 Trim(Printer.Printers.Strings[Printer.PrinterIndex]), ParamInteger, ParamFloat, ParamBoolean);
//    PrinterName:=Trim(Printer.Printers.Strings[Printer.PrinterIndex]);

    iColumnCount := oListview.Columns.Count;
    SetLength(aCols, iColumnCount + 1); // + 1 nodig ??? Delphi 5
    Printer.Title := PrinTitle;   //выводится в свойства принтера
    Printer.Copies := PrintDialog1.Copies;
    Printer.Orientation := poPortrait;
    Printer.BeginDoc;
    pHeight := Printer.PageHeight;
    pWidth := Printer.PageWidth;

    v := (pHeight + (2 * GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY))) / (29.7 * 0.95);    //было 0.95
    //0.95 is a strange correction factor on the clients printer
    h := (pWidth + (2 * GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX))) / 21;

    // calculate total width
    iTotColsWidth := 0;
    for i := 0 to iColumnCount - 1 do
      iTotColsWidth := iTotColsWidth + oListView.Columns[i].Width;

    // calculate space between lMargin and rMargin
    aCols[0] := Round(1.5 * h); //left margin ?
    aCols[iColumnCount + 0] := pWidth - Round(1.2 * h); //rigth margin ?   // было 1.5
    iInnerWidth := aCols[iColumnCount + 0] - aCols[0]; // space between margins ?

    //calculate start of each column
    for i := 0 to iColumnCount - 1 do
      aCols[i + 1] := aCols[i] + Round(oListView.Columns[i].Width / iTotColsWidth * iInnerWidth);
    TopMarg := Round(2.5 * v);
    with Printer.Canvas do
    begin
      Font.Size := 10;
      Font.Style := [];
      Font.Name := 'Times New Roman';
      Font.Color := RGB(0, 0, 0);
      TekstHeight := Printer.Canvas.TextHeight('dummy');
      LinesOnPage := Round((PHeight - (4 * v)) / TekstHeight);   //было 5
      NumPages := 1;

      // gather number of pages to print
      while (NumPages * LinesOnPage) < oListView.Items.Count do
        inc(NumPages);
      // start
      CurLine := 0;
      for CurItem := 0 to oListView.Items.Count - 1 do
      begin
        if (CurLine > LinesOnPage) or (CurLine = 0) then
        begin
          if (CurLine > LinesOnPage) then Printer.NewPage;
          CurLine := 1;
          if Printer.PageNumber = NumPages then
          begin
            MoveTo(aCols[1], topMarg);
            for i := 1 to iColumnCount - 1 do
            begin
              LineTo(aCols[i], TopMarg + (TekstHeight * (oListView.Items.Count - CurItem + 2)));
              MoveTo(aCols[i + 1], topMarg);
            end;
          end
          else
          begin
            // draw vertical lines between data
            for i := 1 to iColumnCount - 1 do
            begin
              MoveTo(aCols[i], topMarg);
              LineTo(aCols[i], TopMarg + (TekstHeight * (LinesOnPage + 1)));
            end;
          end;

          Font.Style := [fsBold];
          // print column headers
          for i := 0 to iColumnCount - 1 do
          begin
            TextRect(Rect(aCols[i] + Round(0.1 * h), TopMarg - Round(0.1 * v), aCols[i + 1] - Round(0.1 * h)
              , TopMarg + TekstHeight - Round(0.1 * v)), ((aCols[i + 1] - aCols[i]) div 2) +
              aCols[i] - (TextWidth(oListview.Columns.Items[i].Caption) div 2),
              TopMarg - Round(0.1 * v), oListview.Columns.Items[i].Caption);
            //showmessage('print kolom: '+IntToStr(i));
          end;

          // draw horizontal line beneath column headers
          MoveTo(aCols[0] - Round(0.1 * h), TopMarg + TekstHeight - Round(0.05 * v));
          LineTo(aCols[iColumnCount] + Round(0.1 * h), TopMarg + TekstHeight - Round(0.05 * v));

          // print date and page number
          Font.Size := 8;
          Font.Style := [];
          TmpPos := (TextWidth('Дата: ' + DateToStr(Date) + '  Страница: ' +
            IntToStr(Printer.PageNumber) + ' / ' + IntToStr(NumPages))) div 2;

          TmpPos := PWidth - Round(1.5 * h) - (TmpPos * 2);

          Font.Size := 8;
          Font.Style := [];
          TextOut(TmpPos, Round(0.5 * v), 'Дата: ' + DateToStr(Date) +
            '  Страница: ' + IntToStr(Printer.PageNumber) + ' / ' + IntToStr(NumPages));

          // print report title1
          Font.Size := 12;
          if TmpPos < ((PWidth + TextWidth(sTitle1)) div 2 + Round(0.75 * h)) then
            TextOut((PWidth - TextWidth(sTitle1)) div 2, Round(0.5 * v), sTitle1)
          else
            TextOut(Round(1.5 * h), Round(0.5 * v), sTitle1);

          // print report title2
          TextOut(Round(1.5 * h), Round(1 * v), sTitle2);

          // print report title3
          TextOut(Round(1.5 * h), Round(1.5 * v), sTitle3);

          Font.Size := 10;
          Font.Style := [];
        end;

        CurRect.Top := TopMarg + (CurLine * TekstHeight);
        CurRect.Bottom := TopMarg + ((CurLine + 1) * TekstHeight);

        // print contents of Listview
        for CurCol := -1 to iColumnCount - 2 do
        begin
          CurRect.Left := aCols[CurCol + 1] + Round(0.1 * h);
          CurRect.Right := aCols[CurCol + 2] - Round(0.1 * h);
          try
            if CurCol = -1 then
              CurStr := oListView.Items[CurItem].Caption
            else
              CurStr := oListView.Items[CurItem].SubItems[CurCol];
          except
            CurStr := '';
          end;
          CurLeft := CurRect.Left; // align left side
          // write string in TextRect
          TextRect(CurRect, CurLeft, CurRect.Top, CurStr);
        end;
        Inc(CurLine);
      end;
    end;
    Printer.EndDoc;
  end;
end;

function TDM.IsRunning(sName: string): boolean; // проверяет, запущен ли процесс sName
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

end.
