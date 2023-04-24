unit UnitTestState;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  UnitDM, Vcl.StdCtrls, UnitMyForm{обязательно ПОСЛЕДНИМ};

//const

//      IND_TRM = 2;  //порядковый номер строки в табл. ListViewConnect резервирование мин. значений в *.txt  (TxtReserveMin)
//      IND_TRH = 3;  //порядковый номер строки в табл. ListViewConnect резервирование часовых значений в *.txt (TxtReserveHour)
//      IND_SRM = 4;  //порядковый номер строки в табл. ListViewConnect резервирование мин. значений в SQL (SQLReserveMin)
//      IND_SRH = 5;  //порядковый номер строки в табл. ListViewConnect резервирование часовых значений в SQL (SQLReserveHour)
//      IND_DRM = 0;  //порядковый номер строки в табл. ListViewConnect резервирование мин. значений в *.dbf  (DbfReserveMin)
//      IND_DRH = 1;  //порядковый номер строки в табл. ListViewConnect резервирование часовых значений в *.dbf (DbfReserveHour)
//      IND_MRH = 6;  //порядковый номер строки в табл. ListViewConnect резервирование часовых значений в *.mdb (MdbReserveHour)
//      IND_SARH = 7; //порядковый номер строки в табл. ListViewConnect резервирование часовых значений в SQL-A (SQL-AReserveHour)
type
  TFormTestState = class(TForm)
    TabControlLines: TTabControl;
    ListViewSign: TListView;
    Splitter1: TSplitter;
    Panel1: TPanel;
    ListViewConnect: TListView;
    Splitter2: TSplitter;
    ListViewParam: TListView;
    ButtonClose: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FullTsAll(num: integer);
    function FullListAllSign(L_Code: integer): integer;       //получаем полный список всего что подключено к конвейеру
    function FullControlParam(L_Code: integer): integer;
    procedure ColumnHeadersSign(num: integer);   //формируем название колонок в ListViewSign
    procedure ColumnHeadersParam(num: integer);
    procedure ColumnHeadersConnect(num: integer);
    procedure FullLwSign(L_Code, num: integer);
    procedure FullLwParam(L_Code, num: integer);
    procedure FullLwConnect;
    procedure TabControlLinesChange(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure Splitter2CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure CheckWeigher(L_Code: integer);
    procedure AddDataC;
    procedure AddDataNull;  //принятое новое значение нуля
    procedure AddDataCM;  //минутные значения
    procedure AddDataM;  //минутные значения параметры
    procedure AddDataH;  //часовые значения параметры
    procedure AddDataStateFile; //состояние файла
    procedure ListViewSignResize(Sender: TObject);
    procedure ListViewParamResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ListViewConnectResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabControlLinesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    
  private
    { Private declarations }
    procedure WMCopyData(var MessageData: TWMCopyData); message WM_COPYDATA;

  public
    { Public declarations }
  end;

//var
//  FormTestState: TFormTestState;

implementation

{$R *.dfm}

uses MainUnit, RudaGlobals;

var
  MassL_Code: array [0..MAXLINE] of integer;    //массив с номерами кодов конвейеров
  ControlP: array [1..MAXPARAM] of TContolParam;
  CountSign: integer;
  CountParam: integer;
  CountParamConnect: integer;
  pTransfer_Data: PTransferData;
  pTransfer_DataParam: PTransferDataParam;
  pTransfer_DataNull: PTransferDataNull;
  LinesChannels: TMapLines;
  bReserv: boolean;         //True - включено резервирование мин. значений в *.dbf
  bReservHour: boolean;     //True - включено резервирование часовых значений в *.dbf
  bReservMdbHour: boolean;  //True - включено резервирование часовых значений в *.mdb
  bReservSqlAHour: boolean; //True - включено резервирование часовых значений в SQLA
  bReservTxt: boolean;      //True - включено резервирование мин. значений в *.txt
  bReservTxtHour: boolean;  //True - включено резервирование часовых значений в *.txt
  bReservSql: boolean;      //True - включено резервирование мин. значений в SQL
  bReservSqlHour: boolean;  //True - включено резервирование часовых значений в SQL
  bReservOPC: boolean;      //True - включено резервирование мин. значений в OPC
  bReservOPCHour: boolean;  //True - включено резервирование часовых значений в OPC
  FPriorIndexLines: integer;

function CheckModesTransferData(mode: TIndexStrListViewConnect): boolean;
begin
  result:= false;
  case mode of
    IND_TRM: result:= bReservTxt;
    IND_TRH: result:= bReservTxtHour;
    IND_SRM: result:= bReservSql;
    IND_SRH: result:= bReservSqlHour;
    IND_ORM: result:= bReservOPC;
    IND_ORH: result:= bReservOPCHour;
    IND_DRM: result:= bReserv;
    IND_DRH: result:= bReservHour;
    IND_MRH: result:= bReservMdbHour;
    IND_SARH: result:= bReservSqlAHour;
  end;
end;

procedure ReadModesTransferData;
  var rCode: variant;
      Reserv: boolean;
begin
  //проверяем на разные виды режимы работы предриятия
  //если разные режимы, запретить запись в dbf
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

  DM.QueryWorkStation('SELECT * FROM ParamStation', FormTestState.Caption, 'FormShow', true);
  if not DM.ADOQueryWorkStationMDB.EOF then
    begin
      bReserv        := DM.ADOQueryWorkStationMDB.FieldByName('Reserv').AsBoolean AND (not Reserv);
      bReservHour    := DM.ADOQueryWorkStationMDB.FieldByName('ReservHour').AsBoolean AND (not Reserv);
      bReservTxt     := DM.ADOQueryWorkStationMDB.FieldByName('ReservTxt').AsBoolean;
      bReservTxtHour := DM.ADOQueryWorkStationMDB.FieldByName('ReservTxtHour').AsBoolean;
      bReservSql     := DM.ADOQueryWorkStationMDB.FieldByName('ReservSql').AsBoolean;
      bReservSqlHour := DM.ADOQueryWorkStationMDB.FieldByName('ReservSqlHour').AsBoolean;
      bReservSqlAHour:= DM.ADOQueryWorkStationMDB.FieldByName('ReservSqlAHour').AsBoolean;
      bReservMdbHour := DM.ADOQueryWorkStationMDB.FieldByName('ReservMdbHour').AsBoolean;
      if NoErrСreateNewField then
        begin
          bReservOPC    := DM.ADOQueryWorkStationMDB.FieldByName('ReservOPC').AsBoolean;
          bReservOPCHour:= DM.ADOQueryWorkStationMDB.FieldByName('ReservOPCHour').AsBoolean;
        end
        else begin
          bReservOPC    := false;
          bReservOPCHour:= false;
        end;
    end;
end;

procedure TFormTestState.WMCopyData(var MessageData: TWMCopyData);
  var lCode: integer;
begin
  lCode:= MassL_Code[TabControlLines.TabIndex];
  case MessageData.CopyDataStruct.dwData of
    CMD_C,
    CMD_CM: begin
              pTransfer_Data:= MessageData.CopyDataStruct.lpData;
              case MessageData.CopyDataStruct.dwData of
                CMD_C: if lCode = integer(pTransfer_Data^.L_Code) then AddDataC;
               CMD_CM: if lCode = integer(PTransfer_Data^.L_Code) then AddDataCM;
              end;
            end;
     CMD_M,
     CMD_H: begin
              pTransfer_DataParam:= MessageData.CopyDataStruct.lpData;
              case MessageData.CopyDataStruct.dwData of
                CMD_M: if lCode = integer(pTransfer_DataParam^.L_Code) then AddDataM;
                CMD_H: if lCode = integer(pTransfer_DataParam^.L_Code) then AddDataH;
              end;
            end;
     CMD_NULL: begin
                pTransfer_DataNull:= MessageData.CopyDataStruct.lpData;
                if lCode = integer(pTransfer_DataNull^.L_Code) then AddDataNull;

               end;
     CMD_DRM..CMD_OPCH: begin
                          pTransfer_DataParam:= MessageData.CopyDataStruct.lpData;
                          AddDataStateFile;
                        end;
  end;
end;

function IND_from_CMD(CMD: DWORD): TIndexStrListViewConnect;
begin
  case CMD of
    CMD_DRM: result:= IND_DRM;   //мин. значений в *.dbf  (DbfReserveMin)
    CMD_DRH: result:= IND_DRH;   //часовых значений в *.dbf (DbfReserveHour)
    CMD_TRM: result:= IND_TRM;   //мин. значений в *.txt  (TxtReserveMin)
    CMD_TRH: result:= IND_TRH;   //часовых значений в *.txt (TxtReserveHour)
    CMD_SRM: result:= IND_SRM;   //мин. значений в SQL (SQLReserveMin)
    CMD_SRH: result:= IND_SRH;   //часовых значений в SQL (SQLReserveHour)
    CMD_MRH: result:= IND_MRH;   //часовых значений в *.mdb (MdbReserveHour)
    CMD_SARH: result:= IND_SARH; //часовых значений в SQL-A (SQL-AReserveHour)
    CMD_OPCM: result:= IND_ORM;  //мин. значений в OPC  (OPCReserveMin)
    CMD_OPCH: result:= IND_ORH;  //часовых значений в OPC (OPCReserveHour)
  end;
end;

procedure TFormTestState.AddDataStateFile;
var lCode, i, k, num, ind: integer;
    mode: TIndexStrListViewConnect;
begin
  lCode:= MassL_Code[TabControlLines.TabIndex];
  ind:= 0; //строка в таблице
  for mode:= Low(TxtListViewConnect) to High(TxtListViewConnect) do
    begin
      if mode in [IND_DRM..IND_SARH] then continue;      //заглушка. данные режимы не используются

      if not CheckModesTransferData(mode) then continue;  //если данный режим передачи данных не выбран, пропускаем

      if IND_from_CMD(pTransfer_DataParam^.StateWritingExtFile.СMD) = mode then break;
      inc(ind);
    end;

//  case pTransfer_DataParam^.StateWritingExtFile.CMD of
//    CMD_TRM: ind:= Ord(IND_TRM);
//    CMD_TRH: ind:= Ord(IND_TRH);
//    CMD_SRM: ind:= Ord(IND_SRM);
//    CMD_SRH: ind:= Ord(IND_SRH);
//    CMD_OPCM: ind:= Ord(IND_ORM);
//    CMD_OPCH: ind:= Ord(IND_ORH);
//  end;

  if pTransfer_DataParam^.StateWritingExtFile.AddErrCode = 0 then //нет дополнительной ошибки
      ListViewConnect.Items.Item[ind].SubItems[ListViewConnect.Columns.Count - 2]:=
        StateWritingExtFileName[pTransfer_DataParam^.StateWritingExtFile.MainErrCode]
      else ListViewConnect.Items.Item[ind].SubItems[ListViewConnect.Columns.Count - 2]:=
            StateWritingExtFileName[pTransfer_DataParam^.StateWritingExtFile.MainErrCode] + ' (' +
            PChar(@pTransfer_DataParam^.StateWritingExtFile.TxtAddErrCode) + ')';
  if lCode = integer(pTransfer_DataParam^.L_Code) then
    begin
      ListViewConnect.Items.Item[ind].SubItems[0]:= FormatDateTime('dd.mm.yyyy hh:nn:ss', pTransfer_DataParam^._Date);
      for i:= 1 to CountParam do
        begin
          num:= ControlP[i].num;
          for k := 0 to ListViewConnect.Columns.Count - 1 do   //ищем колонку в Tag записна номер num
            if ListViewConnect.Columns[k].Tag = num then        //k- 1 с учетом колонки LI.Caption
              begin
                if (pTransfer_DataParam^.Param[num] < 0)
                    {or (pTransfer_DataParam^.StateWritingExtFile.MainErrCode <> NoData)}
                  then ListViewConnect.Items.Item[ind].SubItems[k - 1]:= 'н/д'
                  else ListViewConnect.Items.Item[ind].SubItems[k - 1]:= Format('%.2n', [pTransfer_DataParam^.Param[num]]);
              end;
        end;
    end;
end;

procedure TFormTestState.AddDataM;  //минутные значения параметры
  var i, k, num: integer;
begin
  ListViewParam.Items.Item[0].SubItems[0]:= FormatDateTime('dd.mm.yyyy hh:nn:ss', pTransfer_DataParam^._Date);
  for i:= 1 to CountParam do
    begin
       num:= ControlP[i].num;
       for k := 0 to ListViewParam.Columns.Count - 1 do   //ищем колонку в Tag записна номер num
        if ListViewParam.Columns[k].Tag = num then        //k- 1 с учетом колонки LI.Caption
              ListViewParam.Items.Item[0].SubItems[k - 1]:= Format('%.2n', [pTransfer_DataParam^.Param[num]]);
    end;
  for k := 0 to ListViewParam.Columns.Count - 1 do   //ищем колонку в Tag записна идентификатор колонки
    case ListViewParam.Columns[k].Tag of
      100: ListViewParam.Items.Item[0].SubItems[k - 1]:= Format('%.3n', [pTransfer_DataParam^.CurDisp]);
      101: ListViewParam.Items.Item[0].SubItems[k - 1]:= IntToStr(pTransfer_DataParam^.count);
    end;
end;

procedure TFormTestState.AddDataH;  //часовые значения параметры
  var i, k, num: integer;
begin
  ListViewParam.Items.Item[1].SubItems[0]:= FormatDateTime('dd.mm.yyyy hh:nn:ss', pTransfer_DataParam^._Date);
  for i:= 1 to CountParam do
    begin
       num:= ControlP[i].num;
       for k := 0 to ListViewParam.Columns.Count - 1 do   //ищем колонку в Tag записна номер num
        if ListViewParam.Columns[k].Tag = num then        //k- 1 с учетом колонки LI.Caption
              ListViewParam.Items.Item[1].SubItems[k - 1]:= Format('%.2n', [pTransfer_DataParam^.Param[num]]);
    end;
  for k := 0 to ListViewParam.Columns.Count - 1 do   //ищем колонку в Tag записна идентификатор колонки
    case ListViewParam.Columns[k].Tag of
      100: ListViewParam.Items.Item[1].SubItems[k - 1]:= '';   //дисперсия
      101: ListViewParam.Items.Item[1].SubItems[k - 1]:= IntToStr(pTransfer_DataParam^.count);
    end;
end;

procedure TFormTestState.AddDataC;  //мгновенные значения
  var i, n, k, num: integer;
      bCPW: DWORD;
begin
  //первая строка "Последнее значение (без вычета нуля)"
  ListViewSign.Items.Item[0].SubItems[0]:= FormatDateTime('dd.mm.yyyy hh:nn:ss', pTransfer_Data^._Date);
  for i:= 0 to CountSign - 1 do
    begin
      if LinesChannels.Measurer[i] in [1..4] then
        begin
          num:= LinesChannels.Num[i];
          for k := 0 to ListViewSign.Columns.Count - 1 do   //ищем колонку в Tag записна номер Measurer
           if ListViewSign.Columns[k].Tag = LinesChannels.Measurer[i] then     //k- 1 с учетом колонки LI.Caption
              ListViewSign.Items.Item[0].SubItems[k - 1]:= Format('%.2n', [pTransfer_Data^.InfSign[num]]);
        end;

      if LinesChannels.Measurer[i] in [10, 11] then
        begin
          for k := 0 to ListViewSign.Columns.Count - 1 do   //ищем колонку в Tag записна номер Measurer
           if ListViewSign.Columns[k].Tag = LinesChannels.Measurer[i] then     //k- 1 с учетом колонки LI.Caption
             if pTransfer_Data^.StateDigIn then
               ListViewSign.Items.Item[0].SubItems[k - 1]:= 'Движется'
               else ListViewSign.Items.Item[0].SubItems[k - 1]:= 'Стоит'
        end;

      if LinesChannels.Measurer[i] = 12 then
        begin
          bCPW:= 0;
          for n := 1 to 4 do
            bCPW:= (bCPW shl 8) or pTransfer_Data^.StatePulsW[5 - n];

          for k := 0 to ListViewSign.Columns.Count - 1 do   //ищем колонку в Tag записна номер Measurer
           if ListViewSign.Columns[k].Tag = LinesChannels.Measurer[i] then     //k- 1 с учетом колонки LI.Caption
              ListViewSign.Items.Item[0].SubItems[k - 1]:= inttostr(bCPW);
        end;
    end;
end;

procedure TFormTestState.AddDataNull;  //принятое новое значение нуля
  var row, i, k: integer;
begin
  row:= 1;   //вторая строка "Значение нуля"
  ListViewSign.Items.Item[row].SubItems[0]:= FormatDateTime('dd.mm.yyyy hh:nn:ss', pTransfer_DataNull^._Date);
  for i:= 0 to CountSign - 1 do
    begin
      for k := 0 to ListViewSign.Columns.Count - 1 do   //ищем колонку в Tag записна тип Measurer
        if ListViewSign.Columns[k].Tag = pTransfer_DataNull^.Measurer then     //k- 1 с учетом колонки LI.Caption
          ListViewSign.Items.Item[row].SubItems[k - 1]:= Format('%.2n', [pTransfer_DataNull^.Unull]);
    end;
end;

procedure TFormTestState.AddDataCM;  //минутные значения
  var i, n, k, num, row: integer;
      bCPW: DWORD;
begin
  row:= 2;   //третья строка "За минуту расчетное (с вычтеным нулем)"
  ListViewSign.Items.Item[row].SubItems[0]:= FormatDateTime('dd.mm.yyyy hh:nn:ss', pTransfer_Data^._Date);
  for i:= 0 to CountSign - 1 do
    begin
      if LinesChannels.Measurer[i] in [1..4] then
        begin
          num:= LinesChannels.Num[i];
          for k := 0 to ListViewSign.Columns.Count - 1 do   //ищем колонку в Tag записна номер Measurer
           if ListViewSign.Columns[k].Tag = LinesChannels.Measurer[i] then     //k- 1 с учетом колонки LI.Caption
              ListViewSign.Items.Item[row].SubItems[k - 1]:= Format('%.2n', [pTransfer_Data^.InfSign[num]]) + ' / (' +
                                                             inttostr(pTransfer_Data^.count[num]) + ' отсч.)';
        end;

      if LinesChannels.Measurer[i] in [10, 11] then
        begin
          for k := 0 to ListViewSign.Columns.Count - 1 do   //ищем колонку в Tag записна номер Measurer
           if ListViewSign.Columns[k].Tag = LinesChannels.Measurer[i] then     //k- 1 с учетом колонки LI.Caption
             if pTransfer_Data^.StateDigIn then
               ListViewSign.Items.Item[row].SubItems[k - 1]:= 'Движется'
               else ListViewSign.Items.Item[row].SubItems[k - 1]:= 'Стоит'
        end;

      if LinesChannels.Measurer[i] = 12 then
        begin
          bCPW:= 0;
          for n := 1 to 4 do
            bCPW:= (bCPW shl 8) or pTransfer_Data^.StatePulsW[5 - n];

          for k := 0 to ListViewSign.Columns.Count - 1 do   //ищем колонку в Tag записна номер Measurer
           if ListViewSign.Columns[k].Tag = LinesChannels.Measurer[i] then     //k- 1 с учетом колонки LI.Caption
              ListViewSign.Items.Item[row].SubItems[k - 1]:= inttostr(bCPW);
        end;
    end;
end;

procedure TFormTestState.ButtonCloseClick(Sender: TObject);
begin
  FormTestState.Close;
end;

procedure TFormTestState.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
  var param: integer;
begin
  if not FormTestState.Active then exit;

  //чтобы не "заплывала" главная форма на TabControlLines
  param:= 28 +        //высота "шапки" TabControlLines
          ListViewSign.Height +
          Splitter1.Height +
          ListViewParam.Height +
          Splitter2.Height +
          ListViewConnect.Constraints.MinHeight +
          93 + 1;     //высота панели с кнопкой +1
  Resize:= (param < NewHeight);
end;

procedure TFormTestState.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
  FormTestState:= nil;
end;

procedure TFormTestState.FormCreate(Sender: TObject);
begin
  FormTestState.Caption:= ProgName_ShortStringVersion + FormTestState.Caption;
end;

procedure TFormTestState.FormShow(Sender: TObject);
  var i: integer;
begin
  TabControlLines.Tabs.Clear;
  FillChar(MassL_Code, SizeOf(MassL_Code), #0);
  if not DM.QueryServer('SELECT * FROM Lines WHERE [Connect]',
                                FormTestState.Caption, 'FormShow', true) then exit;
  i:= 0;
  while not DM.ADOQueryServerMDB.EOF do
    begin
//      TabControlLines.Tabs.AddObject('Конвейер "' + DM.ADOQueryServerMDB.FieldByName('L_Name').AsString + '"',
//                                     TObject(integer(DM.ADOQueryServerMDB.FieldByName('L_CodeLine').AsInteger)));
      TabControlLines.Tabs.AddObject('Конвейер "' + DM.ADOQueryServerMDB.FieldByName('L_Name').AsString + '"',
                                     TObject(integer(DM.ADOQueryServerMDB.FieldByName('L_Code').AsInteger)));
      MassL_Code[i]:= DM.ADOQueryServerMDB.FieldByName('L_Code').AsInteger;
      inc(i);
      DM.ADOQueryServerMDB.Next;
    end;
  FullTsAll(TabControlLines.TabIndex);
  ListViewSignResize(Sender);
  ListViewParamResize(Sender);
  ListViewConnectResize(Sender);

  Timer1Timer(Sender);
  FPriorIndexLines:= TabControlLines.TabIndex;
end;

procedure TFormTestState.FullTsAll(num: integer);  //num - TabControlLines.TabIndex
  var lCode: integer;
      Sender: TObject;
begin
  lCode:= MassL_Code[num];
  CountSign:= FullListAllSign(lCode);
  CountParam:= FullControlParam(lCode);
  DM.FullDD(FormTestState.Caption);
  ColumnHeadersSign(num);
  ColumnHeadersParam(num);
  ColumnHeadersConnect(num);
  FullLwSign(lCode, num);
  FullLwParam(lCode, num);
  ReadModesTransferData;
  FullLwConnect;
  ListViewSignResize(Sender);
  ListViewParamResize(Sender);
  ListViewConnectResize(Sender);
end;

procedure TFormTestState.ListViewConnectResize(Sender: TObject);
const col0 = 2;    //во столько раз первая колонка шире обычных
      col1 = 1.5;  //во столько раз вторая колонка шире обычных
      lastCol = 3; //во столько раз последняя колонка шире обычных

  var i: integer;
      cof: double;
begin
  if ListViewConnect.Columns.Count = 0 then exit;
  cof:= ListViewConnect.Width/(ListViewConnect.Columns.Count + (col0 - 1) + (col1 - 1) + (lastCol - 1));
  for i := 0 to ListViewConnect.Columns.Count - 2 do  //без последний колонки
    case i of
      0: ListViewConnect.Columns[i].Width:= Trunc(col0*cof);
      1: ListViewConnect.Columns[i].Width:= Trunc(col1*cof);
      else ListViewConnect.Columns[i].Width:= Trunc(cof);
    end;
  ListViewConnect.Columns[ListViewConnect.Columns.Count - 1].Width:= Trunc(lastCol*cof); //последняя колонка
end;

procedure TFormTestState.ListViewParamResize(Sender: TObject);
const col0 = 2;    //во столько раз первая колонка шире обычных
      col1 = 1.5;    //во столько раз вторая колонка шире обычных
      lastCol = 1.7; //во столько раз последняя колонка шире обычных

  var i, last: integer;
      cof: double;
begin
  if ListViewParam.Columns.Count = 0 then exit;
  cof:= ListViewParam.Width/(ListViewParam.Columns.Count + (col0 - 1) + (col1 - 1) + (lastCol - 1));
  for i := 0 to ListViewParam.Columns.Count - 2 do  //без последний колонки
    case i of
      0: ListViewParam.Columns[i].Width:= Trunc(col0*cof);
      1: ListViewParam.Columns[i].Width:= Trunc(col1*cof);
      else ListViewParam.Columns[i].Width:= Trunc(cof);
    end;
  ListViewParam.Columns[ListViewParam.Columns.Count - 1].Width:= Trunc(lastCol*cof); //последняя колонка
end;

procedure TFormTestState.ListViewSignResize(Sender: TObject);
  const col0 = 2.3;    //во столько раз первая колонка шире обычных
        col1 = 1.2;    //во столько раз вторая колонка шире обычных
  var i: integer;
      cof: double;
begin
  if ListViewSign.Columns.Count = 0 then exit;
  cof:= ListViewSign.Width/(ListViewSign.Columns.Count + (col0 - 1) + (col1 - 1));
  for i := 0 to ListViewSign.Columns.Count - 1 do
    case i of
      0: ListViewSign.Columns[i].Width:= Trunc(col0*cof);
      1: ListViewSign.Columns[i].Width:= Trunc(col1*cof);
      else ListViewSign.Columns[i].Width:= Trunc(cof);
    end;
end;

procedure TFormTestState.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  //чтобы панели не "заплывали" друг на друга при перемещении сплиттера
  Accept:= ((ListViewConnect.Constraints.MinHeight + 80 +
            Splitter2.Height +
            ListViewParam.Height +
            Splitter1.Height +
            NewSize) < FormTestState.ClientHeight);
end;

procedure TFormTestState.Splitter2CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  //чтобы панели не "заплывали" друг на друга при перемещении сплиттера
  Accept:= ((ListViewConnect.Constraints.MinHeight + 5 +
            Splitter2.Height +
            NewSize) < Panel1.ClientHeight);
end;

procedure TFormTestState.TabControlLinesChange(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;//проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
//  if FormRudaAdmin.StateProcessCompressDBinProcessing then //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
//    begin
//      TabControlLines.TabIndex:= FPriorIndexLines;    //восстанавливаем предыдущее состояние
//      exit;
//    end;
  FPriorIndexLines:= TabControlLines.TabIndex;        //запоминаем текущее состояние
  FullTsAll(TabControlLines.TabIndex);
end;

procedure TFormTestState.TabControlLinesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing(false) then //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
    begin
      TabControlLines.TabIndex:= FPriorIndexLines;    //восстанавливаем предыдущее состояние
      exit;
    end;
end;

procedure TFormTestState.Timer1Timer(Sender: TObject);
begin
  Label1.Caption:= TimeToStr(now);
end;

function TFormTestState.FullControlParam(L_Code: integer): integer;
  var ind: integer;
begin
  for ind := 1 to MAXPARAM do ControlP[ind].num:= -1;

  result:= 0;
  CountParamConnect:= 0;
  DM.QueryServer('SELECT * FROM ControlParam WHERE L_Code = ' + IntToStr(L_Code) +
                 ' ORDER BY Num', FormTestState.Caption, 'FullControlParam', true);

  while not DM.ADOQueryServerMDB.Eof do
    begin
      inc(result);
      ControlP[result].num    := DM.ADOQueryServerMDB.FieldByName('num').AsInteger;
      StrPCopy(ControlP[result].name, DM.ADOQueryServerMDB.FieldByName('Cp_Name').AsString);
      ControlP[result].connect:= DM.ADOQueryServerMDB.FieldByName('connect').AsBoolean;
      ControlP[result].status := DM.ADOQueryServerMDB.FieldByName('Status').AsInteger AND 7;
      if ControlP[result].status = 2 then
        begin
          DM.QueryWorkStation('SELECT * FROM LinkW WHERE Ms_Code_W = (SELECT Ms_Code FROM Link WHERE Cp_Code = ' +
             DM.ADOQueryServerMDB.FieldByName('Cp_Code').AsString + ')', FormTestState.Caption, 'FullControlParam', true);
          if not DM.ADOQueryWorkStationMDB.Eof then ControlP[result].link:= true;
        end;
      ControlP[result].bHour:= IsBitSet(DM.ADOQueryServerMDB.FieldByName('Status').AsInteger, 3);
      ControlP[result].bArchiv:= IsBitSet(DM.ADOQueryServerMDB.FieldByName('Status').AsInteger, 4);
      if ControlP[result].connect then inc(CountParamConnect);
      DM.ADOQueryServerMDB.Next;
    end;
end;

function TFormTestState.FullListAllSign(L_Code: integer): integer;
  var i, n, param_MsPoint, msStatusW, AnalogOrPulse: integer;
      lName: string;
      TypeController: integer;
begin
  FillChar(LinesChannels, sizeof(LinesChannels), 0);

  TypeController:= DM.FunTypeController;
  if TypeController < 0 then exit; //значит ошибка

  LinesChannels.TypeController:= TypeController;

  LinesChannels.L_Code:= L_Code;
  DM.QueryServer('SELECT L_Name FROM Lines WHERE [Connect] AND L_Code = ' + IntToStr(L_Code),
                    FormTestState.Caption, 'FullListAllSign', true);
  if not DM.ADOQueryServerMDB.EOF then
    begin
      lName:= Trim(DM.ADOQueryServerMDB.FieldByName('L_Name').AsString);
      StrPCopy(LinesChannels.L_Name, lName);
    end;

  n:= 0;
  msStatusW:= -1;
  //получаем данные по весам
  DM.QueryWorkStation('SELECT Measurer.L_Code, Measurer.Ms_Status, Measurer.Connect, Measurer.Code1 ' +
                          'FROM Measurer INNER JOIN LinkW ON Measurer.Ms_Code = LinkW.Ms_Code_W ' +
                          'WHERE (((Measurer.L_Code)=' + IntToStr(L_Code) + ') AND ((Measurer.Connect)=True))',
                          FormTestState.Caption, 'FullListAllSign', true);
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
//      DM.QueryWorkStation('SELECT Points.*, Measurer.Ms_Name ' +
//                          'FROM LinkW INNER JOIN (Points INNER JOIN Measurer ON Points.Ms_Code = Measurer.Ms_Code) ON LinkW.Ms_Code_MB = Measurer.L_Code ' +
//                          'WHERE (((Measurer.Connect)=True) AND ((Points.L_Code)=' + IntToStr(L_Code) +
//                          ') AND ((Status < 3) OR (Status = 4) OR ((Status = 3) AND (Measurer.Ms_Code = LinkW.Ms_Code_W)))) ORDER BY Point',
//                         FormTestState.Caption, 'FullListAllSign', true);
//      while not DM.ADOQueryWorkStationMDB.EOF do
//        begin
//          LinesChannels.Channel[n] := DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger + 1;
//          LinesChannels.Point[n]   := DM.ADOQueryWorkStationMDB.FieldByName('Point').AsInteger + 1;
//          LinesChannels.Unull[n]   := DM.ADOQueryWorkStationMDB.FieldByName('Null_I').AsFloat;
//          LinesChannels.DateNull[n]:= DM.ADOQueryWorkStationMDB.FieldByName('DateNull').AsDateTime;
//          LinesChannels.Umin[n]    := DM.ADOQueryWorkStationMDB.FieldByName('Min_I').AsFloat;
//          LinesChannels.Umax[n]    := DM.ADOQueryWorkStationMDB.FieldByName('Max_I').AsFloat;
//          LinesChannels.Num[n]     := DM.ADOQueryWorkStationMDB.FieldByName('NUM').AsInteger;
//          LinesChannels.Measurer[n]:= DM.ADOQueryWorkStationMDB.FieldByName('Status').AsInteger;
//          lName:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Ms_Name').AsString);
//          case LinesChannels.Measurer[n] of
//            1: lName:= lName + ' U1';
//            2: lName:= lName + ' U2';
//          end;
//          StrPCopy(LinesChannels.NameMeasurer[n], lName);
//          inc(n);
//          DM.ADOQueryWorkStationMDB.Next;
//        end;

  DM.QueryTempWorkStation('SELECT * FROM Measurer WHERE [Connect] AND L_Code = ' + IntToStr(L_Code),
          FormTestState.Caption, 'FullListAllSign', true);
      while not DM.ADOQueryTempWS.EOF do
        begin
//          DM.QueryWorkStation('SELECT * FROM Points WHERE MS_Code = ' +
//            DM.ADOQueryTempWS.FieldByName('MS_Code').AsString, FormTestState.Caption, 'FullListAllSign', true);

          DM.QueryWorkStation('SELECT Points.*, LinkContr.*, SettingsCOMPort.* ' +
            'FROM (Points INNER JOIN LinkContr ON Points.Lc_Code = LinkContr.Lc_Code) INNER JOIN SettingsCOMPort ON LinkContr.Sp_Code = SettingsCOMPort.Sp_Code ' +
            'WHERE MS_Code = ' + DM.ADOQueryTempWS.FieldByName('MS_Code').AsString,
            FormTestState.Caption, 'FullListAllSign', true);

          while not DM.ADOQueryWorkStationMDB.EOF do
            begin
              DM.DataSetWS('SELECT * FROM LinkW WHERE Ms_Code_W = ' + DM.ADOQueryTempWS.FieldByName('MS_Code').AsString,
                             FormTestState.Caption, 'FullListAllSign');
              if (DM.ADOQueryWorkStationMDB.FieldByName('Status').AsInteger in [1,2,4]) or
                 ((DM.ADOQueryWorkStationMDB.FieldByName('Status').AsInteger = 3) and (not DM.ADODataSetWS.Eof)) then
                begin
                  if DM.SelectionByControllerType(DM.ADOQueryWorkStationMDB.FieldByName('Cn_Code').AsInteger, TypeController) then
                    begin
                      lName:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('NameController').AsString);
                      StrPCopy(LinesChannels.NameController[n], lName);
                      LinesChannels.PortNumber[n]:= DM.ADOQueryWorkStationMDB.FieldByName('PortNum').AsInteger;
                      LinesChannels.Channel[n] := DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger + 1;
                      LinesChannels.Point[n]   := DM.ADOQueryWorkStationMDB.FieldByName('Point').AsInteger + 1;
                      LinesChannels.Unull[n]   := DM.ADOQueryWorkStationMDB.FieldByName('Null_I').AsFloat;
                      LinesChannels.DateNull[n]:= DM.ADOQueryWorkStationMDB.FieldByName('DateNull').AsDateTime;
                      LinesChannels.Umin[n]    := DM.ADOQueryWorkStationMDB.FieldByName('Min_I').AsFloat;
                      LinesChannels.Umax[n]    := DM.ADOQueryWorkStationMDB.FieldByName('Max_I').AsFloat;
                      LinesChannels.Num[n]     := DM.ADOQueryWorkStationMDB.FieldByName('NUM').AsInteger;
                      LinesChannels.Measurer[n]:= DM.ADOQueryWorkStationMDB.FieldByName('Status').AsInteger;
                      lName:= Trim(DM.ADOQueryTempWS.FieldByName('Ms_Name').AsString);
                      case LinesChannels.Measurer[n] of
                        1: lName:= lName + ' U1';
                        2: lName:= lName + ' U2';
                      end;
                      StrPCopy(LinesChannels.NameMeasurer[n], lName);
                      inc(n);
                    end;
                end;
              DM.ADOQueryWorkStationMDB.Next;
            end;
          DM.ADOQueryTempWS.Next;
        end;

      //получаем список подключенных: датчик движения и импульсные весы
//      DM.QueryWorkStation('SELECT * FROM Measurer' +
//                         ' WHERE (L_Code = ' + IntToStr(L_Code) + ') AND ((Measurer.Connect)=True) AND (((Measurer.Ms_Status)=3) OR ((Measurer.Ms_Status)>4)) ORDER BY Ms_Status',
//                         FormTestState.Caption, 'FullListAllSign', true);
      DM.QueryWorkStation('SELECT Measurer.*, LinkContr.*, SettingsCOMPort.* ' +
        'FROM (Measurer INNER JOIN LinkContr ON Measurer.Lc_Code = LinkContr.Lc_Code) INNER JOIN SettingsCOMPort ON LinkContr.Sp_Code = SettingsCOMPort.Sp_Code ' +
        ' WHERE (L_Code = ' + IntToStr(L_Code) + ') AND ((Measurer.Connect)=True) AND (((Measurer.Ms_Status)=3) OR ((Measurer.Ms_Status)>4)) ORDER BY Ms_Status',
                         FormTestState.Caption, 'FullListAllSign', true);

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
              if DM.SelectionByControllerType(DM.ADOQueryWorkStationMDB.FieldByName('Cn_Code').AsInteger, TypeController) then
                begin
                  lName:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('NameController').AsString);
                  StrPCopy(LinesChannels.NameController[n], lName);
                  LinesChannels.PortNumber[n]:= DM.ADOQueryWorkStationMDB.FieldByName('PortNum').AsInteger;
                  LinesChannels.Channel[n]:= DM.ADOQueryWorkStationMDB.FieldByName('Code1').AsInteger + 1;
                  LinesChannels.Measurer[n]:= param_MsPoint;
                  LinesChannels.Num[n]:= DM.ADOQueryWorkStationMDB.FieldByName('NUM').AsInteger;
                  inc(n);
                end;
            end;
          DM.ADOQueryWorkStationMDB.Next;
        end;
    result:= n;
end;

procedure TFormTestState.FullLwParam(L_Code, num: integer);
  var i, j, code, SizeMB, nw: integer;
      sName: string;
      fParam1, fParam2: real;
      n: array [1..MAXPARAM] of integer;
      bParam: boolean;
begin
  sName:= 'M' + IntToStr(L_Code);
  ListViewParam.Items.Clear;
  LI:= ListViewParam.Items.Add;
  LI.Caption:= 'Последнее значение мин.';
    DM.QueryDataWS('SELECT Max(M_Code) as code FROM ' + sName, FormTestState.Caption, 'FullLwParam', true);
    code:= DM.ADOQueryDataWSMDB.FieldByName('code').AsInteger;
    if not DM.ADOQueryDataWSMDB.Eof and (code > 0) then
      begin
        DM.QueryDataWS('SELECT * FROM ' + sName + ' WHERE M_Code = ' + IntToStr(code),
                              FormTestState.Caption, 'FullLwParam', true);
        if not DM.ADOQueryDataWSMDB.Eof then
          begin
            LI.SubItems.Add(FormatDateTime('dd.mm.yyyy hh.nn.ss', DM.ADOQueryDataWSMDB.FieldByName('M_Date').AsDateTime));
            for i := 1 to CountParam do
              begin
                if ControlP[i].connect and CheckNumeric(Trim(DM.ADOQueryDataWSMDB.Fields[ControlP[i].num + 10].AsString))
                  then LI.SubItems.Add(Format('%.2n', [DM.ADOQueryDataWSMDB.Fields[ControlP[i].num + 10].AsFloat]))
                  else LI.SubItems.Add('');
              end;
            //записываем в предпоследний столбец Дисперсия
            if CheckNumeric(Trim(DM.ADOQueryDataWSMDB.FieldByName('ValDisp').AsString))
              then LI.SubItems.Add(Format('%.3n',[DM.ADOQueryDataWSMDB.FieldByName('ValDisp').AsFloat]))
              else LI.SubItems.Add('');
            //записываем в последний столбец Кол-во знач., учавств. в расчете
            if CheckNumeric(Trim(DM.ADOQueryDataWSMDB.FieldByName('M_Size').AsString))
              then LI.SubItems.Add(Trim(DM.ADOQueryDataWSMDB.FieldByName('M_Size').AsString))
              else LI.SubItems.Add('');
          end;
      end
      else begin   //если нет данных создаем пустые столбцы, чтобы при поступлении данных было куда вписывать
        LI.SubItems.Add('');        //столбец дата время
        for i := 1 to CountParam do
          LI.SubItems.Add('');      //столбцы контролируемые параметры
        LI.SubItems.Add('');        //столбец Дисперсия
        LI.SubItems.Add('');        //столбец Кол-во знач., учавств. в расчете
      end;

  CheckWeigher(L_Code);
  SizeMB:= 1;
  bParam:= false;
  for i := 1 to MAXPARAM do
    begin
      if ControlP[i].num > 0 then
        begin
          if (ControlP[i].status = 1) and (not ControlP[i].bArchiv) then //MB5
            begin
              n[SizeMB]:= ControlP[i].num;
              inc(SizeMB);
            end
            else begin
              if (ControlP[i].status = 2) and ControlP[i].link then //весы
                nw:= ControlP[i].num
                else begin
                  if ControlP[i].status = 6 then
                    try
                      j:= -1;
                      j:= DM.ValueList(clDDW, 'D' + inttostr(L_Code));
                      if j>=0 then
                        begin
                          j:= -1;
                          j:= DM.ValueList(clDDCW, 'D' + inttostr(L_Code));
                          if j >= 0 then
                            begin
                              nw:= ControlP[i].num;
                              bParam:= true;
                            end;
                        end;
                    finally

                    end;
                end;
            end;
        end;
    end;

  sName:= 'H' + IntToStr(L_Code);
  LI:= ListViewParam.Items.Add;
  LI.Caption:= 'Последнее значение час.';
    DM.QueryDataWS('SELECT Max(H_Code) as code FROM ' + sName, FormTestState.Caption, 'FullLwParam', true);
    code:= DM.ADOQueryDataWSMDB.FieldByName('code').AsInteger;
    if not DM.ADOQueryDataWSMDB.Eof and (code > 0) then
      begin
        DM.QueryDataWS('SELECT * FROM ' + sName + ' WHERE H_Code = ' + IntToStr(code),
                              FormTestState.Caption, 'FullLwParam', true);
        if not DM.ADOQueryDataWSMDB.Eof then
          begin
            LI.SubItems.Add(FormatDateTime('dd.mm.yyyy hh.nn.ss', DM.ADOQueryDataWSMDB.FieldByName('H_Date').AsDateTime));
            for i:= 1 to ListViewParam.Columns.Count - 1 do //формируем пустые строки, считая что колонки уже сформировались в минутных расчетах
              LI.SubItems.Add('');

            for i := 1 to CountParam do
              begin
                if CheckNumeric(Trim(DM.ADOQueryDataWSMDB.Fields[ControlP[i].num + 5].AsString)) then
                  begin
                    if LI.SubItems[i] <> '' then
                      begin
                        if (ControlP[i].status = 2) or (ControlP[i].status = 6) then
                          begin
                            LI.SubItems[i]:= Format('%.2n',[StrToFloat(DM.ValNumeric(trim(LI.SubItems[i]))) +
                                                        StrToFloat(DM.ADOQueryDataWSMDB.Fields[ControlP[i].num + 5].AsString)]);
                          end
                          else begin
                            if (nw > 0) and (SizeMB > 1) and (ControlP[i].status = 1) then    //значит есть весы и средневзвешенные параметры, считаем средневзвешенные
                              begin
                                if (StrToFloat(trim(LI.SubItems[nw])) +
                                   StrToFloat(DM.ADOQueryDataWSMDB.Fields[ControlP[nw].num + 5].AsString)) > 0 then
                                  begin
                                    LI.SubItems[i]:= Format('%.2n', [(StrToFloat(trim(LI.SubItems[i]))*StrToFloat(trim(LI.SubItems[nw])) +
                                      StrToFloat(DM.ADOQueryDataWSMDB.Fields[ControlP[i].num + 5].AsString)*StrToFloat(DM.ADOQueryDataWSMDB.Fields[ControlP[nw].num + 5].AsString))/
                                      (StrToFloat(trim(LI.SubItems[nw])) + StrToFloat(DM.ADOQueryDataWSMDB.Fields[ControlP[nw].num + 5].AsString)) ]);
                                  end;
                              end
                              else begin
                                LI.SubItems[i]:= Format('%.2n', [(StrToFloat(trim(LI.SubItems[i])) +
                                                              StrToFloat(DM.ADOQueryDataWSMDB.Fields[ControlP[i].num + 5].AsString))/2]);
                              end;
                          end
                      end
                      else begin
                        LI.SubItems[i]:= Format('%.2n', [StrToFloat(DM.ADOQueryDataWSMDB.Fields[ControlP[i].num + 5].AsString)]);
                      end;
                  end;
              end;
            if CheckNumeric(Trim(DM.ADOQueryDataWSMDB.FieldByName('H_Size').AsString)) then    //количество значений, участвующих в расчете
              begin
                if LI.SubItems[ListViewParam.Columns.Count - 2] = '' then
                  LI.SubItems[ListViewParam.Columns.Count - 2]:= Trim(DM.ADOQueryDataWSMDB.FieldByName('H_Size').AsString)
                  else //сумма
                  LI.SubItems[ListViewParam.Columns.Count - 2]:= FloatToStr(StrToFloat(DM.ValNumeric(trim(LI.SubItems[ListViewParam.Columns.Count - 2]))) +
                      StrToFloat(DM.ValNumeric(Trim(DM.ADOQueryDataWSMDB.FieldByName('H_Size').AsString))));
              end;
          end;
      end
      else begin   //если нет данных создаем пустые столбцы, чтобы при поступлении данных было куда вписывать
        LI.SubItems.Add('');        //столбец дата время
        for i := 1 to CountParam do
          LI.SubItems.Add('');      //столбцы контролируемые параметры
        LI.SubItems.Add('');        //столбец Дисперсия
        LI.SubItems.Add('');        //столбец Кол-во знач., учавств. в расчете
      end;
end;

procedure TFormTestState.FullLwSign(L_Code, num: integer);
  var i, code, n: integer;
      sName: string;
      bCPW: DWORD;          //счетчик импульсных весов 1,2,3 и 4 байты Ch1, Ch2, Ch3, Ch4
      lastDate: tDateTime;
begin
  sName:= 'C' + IntToStr(L_Code);
  ListViewSign.Items.Clear;
  LI:= ListViewSign.Items.Add; //добавили элемент списка
  LI.Caption:= 'Последнее значение (без вычета нуля)';
    DM.QueryWorkStation('SELECT Max(C_Code) as code FROM ' + sName, FormTestState.Caption, 'FullLwSign', true);
    code:= DM.ADOQueryWorkStationMDB.FieldByName('code').AsInteger;
    if not DM.ADOQueryWorkStationMDB.Eof and (code > 0) then
     begin
        DM.QueryWorkStation('SELECT * FROM ' + sName + ' WHERE C_Code = ' + IntToStr(code),
                              FormTestState.Caption, 'FullLwSign', true);
        if not DM.ADOQueryWorkStationMDB.Eof then
          begin
            LI.SubItems.Add(FormatDateTime('dd.mm.yyyy hh.nn.ss', DM.ADOQueryWorkStationMDB.FieldByName('C_Date').AsDateTime));
            for i:= 0 to CountSign - 1 do
              begin
                n:= LinesChannels.Num[i];
                if LinesChannels.Measurer[i] in [1..4] then
                  if CheckNumeric(Trim(DM.ADOQueryWorkStationMDB.Fields[n + 5].AsString))
                    then LI.SubItems.Add(Format('%.2n', [DM.ADOQueryWorkStationMDB.Fields[n + 5].AsFloat]))
                    else LI.SubItems.Add('');

                if LinesChannels.Measurer[i] in [10, 11] then       //есть дискретный вход
                  if DM.ADOQueryWorkStationMDB.FieldByName('Move').AsBoolean then
                    LI.SubItems.Add('Двигался') else LI.SubItems.Add('Стоял');

                if LinesChannels.Measurer[i] = 12 then
                  begin
                    bCPW:= 0;
                    for n := 1 to 4 do
                      bCPW:= (bCPW shl 8) or DM.ADOQueryWorkStationMDB.Fields[5 + 8 + (n)].AsInteger;
                    LI.SubItems.Add(inttostr(bCPW));
                  end;
              end;
          end;
      end;

  LI:= ListViewSign.Items.Add; //добавили элемент списка
  LI.Caption:= 'Нулевые значения';
    LI.SubItems.Add('333 ');
    lastDate:= 0;
    for i:= 0 to CountSign - 1 do
      if LinesChannels.Measurer[i] in [1..4] then
        begin
          LI.SubItems.Add(Format('%.2n', [LinesChannels.Unull[i]]));
          //выбираем самую старшую дату
          if LinesChannels.DateNull[i] > lastDate then lastDate:= LinesChannels.DateNull[i];
        end;
    LI.SubItems[0]:= FormatDateTime('dd.mm.yyyy hh.nn.ss', lastDate);

  LI:= ListViewSign.Items.Add; //добавили элемент списка
  LI.Caption:= 'За минуту расчетное (с вычтенным нулем)';
    for i := 1 to ListViewSign.Columns.Count - 1 do
      LI.SubItems.Add('');               //формируем пустые поля
end;

procedure TFormTestState.FullLwConnect;
  var n: integer;
      i: TIndexStrListViewConnect;
begin
  ListViewConnect.Items.Clear;
  for i:= Low(TxtListViewConnect) to High(TxtListViewConnect) do
    begin
      if i in [IND_DRM..IND_SARH] then continue;      //заглушка. данные режимы не используются

      if not CheckModesTransferData(i) then continue;  //если данный режим передачи данных не выбран, пропускаем

      LI:= ListViewConnect.Items.Add; //добавили элемент списка
      LI.Caption:= TxtListViewConnect[i];
      for n:= 1 to ListViewConnect.Columns.Count - 1 do
        LI.SubItems.Add('');               //формируем пустые поля
    end;
end;

procedure TFormTestState.ColumnHeadersConnect(num: integer); //формируем название колонок в ListViewConnect  в версии 4.0 - GridLwConnect(numb As Integer)
  var i: integer;                                            //num - TabControlLines.TabIndex
begin
  with ListViewConnect.Columns do //готовим колонки списка
    begin
      Clear;   //удаляем все старые колонки
      LC:=Add;
        LC.Caption:= 'Формат резервирования';
        LC.Width:= 180;
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Дата/Время';
        LC.Width:= 100;
      for i := 1 to CountParam do
        begin
          LC:=Add; //добавляем новую колонку
            LC.Caption:= ControlP[i].name;
            LC.Tag:= ControlP[i].num;
            if ControlP[i].connect then LC.Width:= 100 else LC.Width:= 0;
        end;
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Состояние';
        LC.Width:= 100;
    end;
end;

procedure TFormTestState.ColumnHeadersParam(num: integer);   //формируем название колонок в ListViewParam  в версии 4.0 - GridLwPrm(numb As Integer)
  var i: integer;                                            //num - TabControlLines.TabIndex
begin
  with ListViewParam.Columns do //готовим колонки списка
    begin
      Clear;   //удаляем все старые колонки
      LC:=Add;
        LC.Caption:= 'Контролируемый параметр';
        LC.Width:= 180;
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Дата/Время';
        LC.Width:= 100;
      for i := 1 to CountParam do
        begin
          LC:=Add; //добавляем новую колонку
            LC.Caption:= ControlP[i].name;
            LC.Tag:= ControlP[i].num;
            if ControlP[i].connect then LC.Width:= 100 else LC.Width:= 0;
        end;
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Дисперсия';
        LC.Tag:= 100; //значит дисперсия (для внешних программ)
        LC.Width:= 100;
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Кол-во знач., учавств. в расчете';
        LC.Tag:= 101; //значит количество отсчетов (для внешних программ)
        LC.Width:= 180;
    end;
end;

procedure TFormTestState.ColumnHeadersSign(num: integer);   //формируем название колонок в ListViewSign  в версии 4.0 - GridLwSign(numb As Integer)
  var i: integer;                                           //num - TabControlLines.TabIndex
begin
  with ListViewSign.Columns do //готовим колонки списка
    begin
      Clear;   //удаляем все старые колонки
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Информационные сигналы';
        LC.Width:= 180;
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Дата/Время';
        LC.Width:= 100;
      for i := 0 to CountSign - 1 do
        begin
          LC:= Add;  //добавляем новую колонку
            if LinesChannels.Measurer[i] in [1..4] then
              begin
                LC.Caption:= LinesChannels.NameController[i] + //'Канал' + IntToStr(LinesChannels.Channel[i]) +
                             ' - Вход' +  IntToStr(LinesChannels.Point[i]);
                LC.Width:= 100;
              end;
            if LinesChannels.Measurer[i] in [10, 11] then  //дискретные входы
              begin
                LC.Caption:= 'Дис. выход';
                LC.Width:= 100;
              end;
            if LinesChannels.Measurer[i] = 12 then         //имп. весы
              begin
                LC.Caption:= 'Сч. имп. весов';
                LC.Width:= 100;
              end;
            LC.Tag:= LinesChannels.Measurer[i];
        end;
    end;
end;

procedure TFormTestState.CheckWeigher(L_Code: integer);
  var i: integer;
begin
  for i := 1 to MAXPARAM do
    begin
      if ControlP[i].num > 0 then
        if (ControlP[i].status = 2) and ControlP[i].link then exit; //значит весы
    end;
  try
    i:= -1;
    i:= DM.ValueList(clDDW, 'D' + inttostr(L_Code));
    if i >= 0 then   //есть весы
      begin
        i:= -1;
        i:= DM.ValueList(clDDCW, 'D' + inttostr(L_Code));
        if i>= 0 then exit;   //есть импульсные связанные весы
      end;
  finally

  end;

  //если нет веса, все параметры считать средними
  for i := 1 to MAXPARAM do
    begin
      if ControlP[i].num > 0 then
        if ControlP[i].status = 1 then  //MB5
          begin
            ControlP[i].bArchiv:= true;
            ControlP[i].bHour:= true;
          end;
    end;
end;

end.
