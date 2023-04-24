unit UnitTableInformationSignals;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Math,
  Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ExtDlgs,
  VCLTee.TeCanvas, Vcl.Buttons, Data.Win.ADODB, UnitMyForm{обязательно ПОСЛЕДНИМ};

type
  TFormTableInformationSignals = class(TForm)
    Panel1: TPanel;
    DBGridTableInformationSignals: TDBGrid;
    PanelSpliter: TPanel;
    ImageON: TImage;
    ImageOFF: TImage;
    Label1: TLabel;
    EditNull: TEdit;
    Label2: TLabel;
    EditMax: TEdit;
    Label3: TLabel;
    EditMin: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    PanelColor: TPanel;
    ColorDialog1: TColorDialog;
    ADOQueryTableInformationSignals: TADOQuery;
    DataSourceTableInformationSignals: TDataSource;
    DataSourceLines: TDataSource;
    ADOQueryTableInformationSignalsMeasurerMs_Code: TAutoIncField;
    ADOQueryTableInformationSignalsMeasurerL_Code: TIntegerField;
    ADOQueryTableInformationSignalsMs_Name: TWideStringField;
    ADOQueryTableInformationSignalsMs_Status: TWordField;
    ADOQueryTableInformationSignalsMeasurerNum: TWordField;
    ADOQueryTableInformationSignalsConnect: TBooleanField;
    ADOQueryTableInformationSignalsCode1: TIntegerField;
    ADOQueryTableInformationSignalsDt_Code: TAutoIncField;
    ADOQueryTableInformationSignalsPointsMs_Code: TIntegerField;
    ADOQueryTableInformationSignalsPointsL_Code: TIntegerField;
    ADOQueryTableInformationSignalsPlata: TWordField;
    ADOQueryTableInformationSignalsPoint: TWordField;
    ADOQueryTableInformationSignalsPointsNum: TWordField;
    ADOQueryTableInformationSignalsStatus: TWordField;
    ADOQueryTableInformationSignalsNull_I: TFloatField;
    ADOQueryTableInformationSignalsMax_I: TFloatField;
    ADOQueryTableInformationSignalsMin_I: TFloatField;
    ADOQueryTableInformationSignalsDateNull: TDateTimeField;
    ADOQueryTableInformationSignalsColor: TIntegerField;
    ADOQueryTableInformationSignalsWidth: TWordField;
    ADOQueryTableInformationSignalsNameLines: TStringField;
    ADOQueryTableInformationSignalsColorBack: TIntegerField;
    PanelColorBack: TPanel;
    PanelWidthLine: TPanel;
    ButtonClose: TButton;
    PanelButtonWidth: TPanel;
    BitBtn_1Pt: TBitBtn;
    BitBtn_2Pt: TBitBtn;
    BitBtn_3Pt: TBitBtn;
    BitBtn_4Pt: TBitBtn;
    BitBtn_5pt: TBitBtn;
    ADOQueryLines: TADOQuery;
    ADOQueryTableInformationSignalsNameController: TWideStringField;
    ADOQueryTableInformationSignalsCn_Code: TWordField;
    ADOQueryTableInformationSignalsSp_Code: TIntegerField;
    ADOQueryTableInformationSignalsPlataAddress: TWordField;
    ADOQueryTableInformationSignalsUminNull: TFloatField;
    ADOQueryTableInformationSignalsUmaxNull: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImageOFFClick(Sender: TObject);
    procedure ImageONClick(Sender: TObject);
    procedure PanelColorClick(Sender: TObject);
    procedure PanelWidthLineClick(Sender: TObject);
    function LeftTopPanelWidht: integer;
    procedure BitBtn_1PtClick(Sender: TObject);
    procedure BitBtn_2PtClick(Sender: TObject);
    procedure BitBtn_3PtClick(Sender: TObject);
    procedure BitBtn_4PtClick(Sender: TObject);
    procedure BitBtn_5ptClick(Sender: TObject);
    procedure DBGridTableInformationSignalsList;
    procedure DBGridTableInformationSignalsDblClick(Sender: TObject);
    procedure ADOQueryTableInformationSignalsAfterScroll(DataSet: TDataSet);
    procedure EditNullKeyPress(Sender: TObject; var Key: Char);
    procedure EditMaxKeyPress(Sender: TObject; var Key: Char);
    procedure EditMinKeyPress(Sender: TObject; var Key: Char);
    procedure SaveDataInBD;
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure UpdateTableInformationSignals(SetCursorPosition: boolean);
    procedure ADOQueryTableInformationSignalsBeforeScroll(DataSet: TDataSet);
    procedure PanelColorBackClick(Sender: TObject);
    procedure ADOQueryTableInformationSignalsPointGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOQueryTableInformationSignalsPlataAddressGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
  private
    { Private declarations }
    ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                            //измененные данные записать в базу данных
    Row_Count: integer;
  public
    { Public declarations }
  end;

var
  FormTableInformationSignals: TFormTableInformationSignals;
  CodeTableInformationSignals: integer;
  TypeController: integer;
  current_L_Code: LongWord; //текущий (на котором стоит курсор) код конвейера
  current_Status: BYTE;     //текущий (на котором стоит курсор) код оборудования
  current_UminNull: double; //текущее (на котором стоит курсор) минимальное значение нуля для текущего конвейера
  current_UmaxNull: double; //текущее (на котором стоит курсор) максимальное значение нуля для текущего конвейера
  current_NameLines: string; //текущее (на котором стоит курсор) название конвейера

implementation
uses MainUnit, UnitDM, RudaGlobals;
{$R *.dfm}


procedure TFormTableInformationSignals.ADOQueryTableInformationSignalsAfterScroll(
  DataSet: TDataSet);
begin
  if Row_Count > 0 then
    begin
      CodeTableInformationSignals:= DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Dt_Code').AsInteger;
      current_L_Code:= DBGridTableInformationSignals.DataSource.DataSet.FieldByName('L_Code').AsInteger;
      current_Status:= DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Status').AsInteger;
      current_NameLines:= DBGridTableInformationSignals.DataSource.DataSet.FieldByName('NameLines').AsString;

      if CheckNumeric(DBGridTableInformationSignals.DataSource.DataSet.FieldByName('UminNull').AsString) then
        current_UminNull:= SimpleRoundTo(DBGridTableInformationSignals.DataSource.DataSet.FieldByName('UminNull').AsFloat, -2)
        else current_UminNull:= DefaultUminNull;

      if CheckNumeric(DBGridTableInformationSignals.DataSource.DataSet.FieldByName('UmaxNull').AsString) then
        current_UmaxNull:= SimpleRoundTo(DBGridTableInformationSignals.DataSource.DataSet.FieldByName('UmaxNull').AsFloat, -2)
        else current_UmaxNull:= DefaultUmaxNull;

      if CheckNumeric(DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Null_I').AsString) then
          EditNull.Text:= Format('%.2n', [DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Null_I').AsFloat])
          else EditNull.Text:= '0';

      if CheckNumeric(DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Max_I').AsString) then
          EditMax.Text:= Format('%.2n', [DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Max_I').AsFloat])
          else EditMax.Text:= '0';

      if CheckNumeric(DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Min_I').AsString) then
          EditMin.Text:= Format('%.2n', [DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Min_I').AsFloat])
          else EditMin.Text:= '0';

      try
        PanelColor.Color:= DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Color').AsInteger;
        PanelWidthLine.Color:= DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Color').AsInteger;
      except
        PanelColor.Color:= 0;
        PanelWidthLine.Color:= 0;
      end;
       //для показа цвета фона на графике
      try
        PanelColorBack.Color:= DBGridTableInformationSignals.DataSource.DataSet.FieldByName('ColorBack').AsInteger;
      except
        PanelColorBack.Color:= 0;
      end;

      try
        PanelWidthLine.Height:= DBGridTableInformationSignals.DataSource.DataSet.FieldByName('Width').AsInteger;
      except
        PanelWidthLine.Height:= 1;
      end;
    end
    else begin
      current_L_Code:= 0;
      current_Status:= 0;
    end;
  ProcedureChangeData(false);  //чтобы не зафиксировать изменения при прокрутки скролом и данные не записывались в базу данных
end;

procedure TFormTableInformationSignals.ADOQueryTableInformationSignalsBeforeScroll(
  DataSet: TDataSet);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormTableInformationSignals.ADOQueryTableInformationSignalsPlataAddressGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString = '' then Text:= ''
                          else Text:= IntToStr(Sender.AsInteger + 1);
end;

procedure TFormTableInformationSignals.ADOQueryTableInformationSignalsPointGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString = '' then Text:= ''
                          else Text:= IntToStr(Sender.AsInteger + 1);
end;

procedure TFormTableInformationSignals.BitBtn_1PtClick(Sender: TObject);
begin
  PanelWidthLine.Height:= 1;
  PanelButtonWidth.Visible:= false;
  PanelWidthLine.Top:= LeftTopPanelWidht;
end;

procedure TFormTableInformationSignals.BitBtn_2PtClick(Sender: TObject);
begin
  PanelWidthLine.Height:= 2;
  PanelButtonWidth.Visible:= false;
  PanelWidthLine.Top:= LeftTopPanelWidht;
end;

procedure TFormTableInformationSignals.BitBtn_3PtClick(Sender: TObject);
begin
  PanelWidthLine.Height:= 3;
  PanelButtonWidth.Visible:= false;
  PanelWidthLine.Top:= LeftTopPanelWidht;
end;

procedure TFormTableInformationSignals.BitBtn_4PtClick(Sender: TObject);
begin
  PanelWidthLine.Height:= 4;
  PanelButtonWidth.Visible:= false;
  PanelWidthLine.Top:= LeftTopPanelWidht;
end;

procedure TFormTableInformationSignals.BitBtn_5ptClick(Sender: TObject);
begin
  PanelWidthLine.Height:= 5;
  PanelButtonWidth.Visible:= false;
  PanelWidthLine.Top:= LeftTopPanelWidht;
end;

procedure TFormTableInformationSignals.ButtonCancelClick(Sender: TObject);
begin
  UpdateTableInformationSignals(true);
end;

procedure TFormTableInformationSignals.ButtonCloseClick(Sender: TObject);
begin
  FormTableInformationSignals.Close;
end;

procedure TFormTableInformationSignals.UpdateTableInformationSignals(SetCursorPosition: boolean);
  var TempCodeRegime: integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  TempCodeRegime:= CodeTableInformationSignals; //запоминаем позицию курсора в DBGrid
  DBGridTableInformationSignalsList;
  if SetCursorPosition then
    begin
      CodeTableInformationSignals:= TempCodeRegime;
      //восстанавливаем позицию курсора
      DBGridTableInformationSignals.DataSource.DataSet.Locate('Dt_Code', CodeTableInformationSignals, []);
    end;
  DBGridTableInformationSignals.SetFocus;
end;

procedure TFormTableInformationSignals.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

procedure TFormTableInformationSignals.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ChangeData then SaveDataInBD;
  UpdateTableInformationSignals(false);
end;

procedure TFormTableInformationSignals.FormCreate(Sender: TObject);
begin
  FormTableInformationSignals.Caption:= ProgName_ShortStringVersion +
                                        FormTableInformationSignals.Caption;
  FormTableInformationSignals.Tag:= tagWinTabInfSign;
  current_L_Code:= 0;
  current_Status:= 0;
end;

procedure TFormTableInformationSignals.FormShow(Sender: TObject);
begin
  TypeController:= DM.FunTypeController;
  case TypeController of
     -1: ADOQueryTableInformationSignalsPlata.DisplayLabel:= 'Канал/Адрес'; //значит была ошибка
    1,2: ADOQueryTableInformationSignalsPlata.DisplayLabel:= 'Канал';       //значит MK001, MK002
      3: ADOQueryTableInformationSignalsPlata.DisplayLabel:= 'Адрес';       //значит MK003
  end;

  //чтобы фон картинки был прозрачным
  ImageON.Transparent:= true;
  ImageON.Picture.Bitmap.TransparentColor:= clWhite;
  ImageOFF.Transparent:= true;
  ImageOFF.Picture.Bitmap.TransparentColor:= clWhite;

  ImageOFF.Visible:= false;
  ImageON.Visible:= true;

  Panel1.Width:= 12;
  PanelButtonWidth.Visible:= false;
  FormTableInformationSignals.Width:= 837;
  PanelWidthLine.Top:= LeftTopPanelWidht;

  DBGridTableInformationSignalsList;
  DBGridTableInformationSignals.SetFocus;

  ProcedureChangeData(false);
end;

procedure TFormTableInformationSignals.DBGridTableInformationSignalsDblClick(
  Sender: TObject);
begin
  if ImageON.Visible then ImageONClick(Sender)
                     else ImageOFFClick(Sender);
end;

procedure TFormTableInformationSignals.DBGridTableInformationSignalsList;
  var DataSet: TDataSet;
      Sender: TObject;
            i: integer;
            Cn_Code_String: string;
begin

  //узнаем какие контроллеры имеют тип, который используется на данной станции
  //создаем строку для запроса вида WHERE Cn_Code = xx OR Cn_Code = XX OR ......
  if not DM.QueryServer('SELECT Controllers.*, TypeControllers.* ' +
    'FROM Controllers LEFT JOIN TypeControllers ON Controllers.Cn_TypeController = TypeControllers.Nc_Code ' +
    'WHERE Cn_TypeController = ' + inttostr(TypeController),
    FormTableInformationSignals.Caption, 'DBGridTableInformationSignalsList', true) then exit;

  if DM.DataSourceServerMDB.DataSet.RecordCount > 0 then Cn_Code_String:= ' WHERE Cn_Code = '
    else Cn_Code_String:= '';

  for i := 0 to DM.DataSourceServerMDB.DataSet.RecordCount - 1 do
    begin
      Cn_Code_String:= Cn_Code_String + DM.ADOQueryServerMDB.FieldByName('Cn_Code').AsString + ' ';
      if i <> DM.DataSourceServerMDB.DataSet.RecordCount - 1 then
        Cn_Code_String:= Cn_Code_String + 'OR Cn_Code = ';
      DM.ADOQueryServerMDB.Next;;
    end;

  //получаем имя конвейера
  try
    ADOQueryLines.SQL.Clear;
    ADOQueryLines.SQL.Add('SELECT * FROM Lines');
    ADOQueryLines.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[DBGridTableInformationSignalsList]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryLines.SQL.Text +'"'),
                               PChar(FormTableInformationSignals.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;

  //получаем список всех информационных сигналов
  try
    ADOQueryTableInformationSignals.SQL.Clear;
    ADOQueryTableInformationSignals.SQL.Add('SELECT Points.*, Measurer.*, ' +
    'ParamLines.ColorBack, ParamLines.UminNull, ParamLines.UmaxNull, LinkContr.* ' +
      'FROM ((Points LEFT JOIN Measurer ON Points.Ms_Code = Measurer.Ms_Code) ' +
      'INNER JOIN LinkContr ON Points.Lc_Code = LinkContr.Lc_Code) ' +
      'LEFT JOIN ParamLines ON Points.L_Code = ParamLines.L_Code ' +
      Cn_Code_String +
      'ORDER BY Measurer.L_Code, Points.Status, Points.Plata, Points.Point');
//    ADOQueryTableInformationSignals.SQL.Add('SELECT Measurer.*, Points.*, ParamLines.ColorBack ' +
//      'FROM Measurer, Points, ParamLines ' +
//      'WHERE Measurer.Ms_Code = Points.Ms_Code AND Points.L_Code = ParamLines.L_Code ' +
//      'ORDER BY Measurer.L_Code, Points.Status, Points.Plata, Points.Point');
    ADOQueryTableInformationSignals.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[DBGridTableInformationSignalsList]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryTableInformationSignals.SQL.Text +'"'),
                               PChar(FormTableInformationSignals.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;

  Row_Count:= DataSourceTableInformationSignals.DataSet.RecordCount;
  ADOQueryTableInformationSignals.First;

//  DataSourceTableInformationSignals.DataSet.DisableControls;
//  DataSourceTableInformationSignals.DataSet.First;
//  try
//    while not DataSourceTableInformationSignals.DataSet.Eof do
//      begin
//
//        if not DM.SelectionByControllerType(DataSourceTableInformationSignals.DataSet.FieldByName('Cn_Code').AsInteger, TypeController) then
//          begin
//            DataSourceTableInformationSignals.DataSet.Delete;
//          end;
//
//        DataSourceTableInformationSignals.DataSet.Next;
//      end;
//  finally
//    DataSourceTableInformationSignals.DataSet.EnableControls;
//  end;

  with DBGridTableInformationSignals do
    begin
      for i := 0 to 8 do
        Columns[i].Title.Alignment:= taCenter;

      for i := 9 to DBGridTableInformationSignals.Columns.Count - 1 do
        Columns[i].Visible:= false;  //скрываем колонки
    end;

  ADOQueryTableInformationSignalsAfterScroll(DataSet);
end;

procedure SendCMD(CMD: word; pTransferDataNull: PTransferDataNull);
  var CDS: TCopyDataStruct;
     TransferDataNull: TTransferDataNull;
begin
  CDS.dwData:= CMD;
  if pTransferDataNull <> nil then
    begin
      TransferDataNull:= pTransferDataNull^;
      CDS.cbData:= sizeof(TransferDataNull);
      CDS.lpData:= @TransferDataNull;
    end;
  DM.SendDataSet(CDS);
end;

procedure TFormTableInformationSignals.SaveDataInBD;
  var param: extended;
     TransferDataNull: TTransferDataNull; //для передачи во внешнию программу тест-состояние
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Сохранить изменения?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      try
        param:= StrToFloat(EditNull.Text);
        if (current_Status in [1,2]) and
           ((param < current_UminNull) or (param > current_UmaxNull)) then
          begin
            Application.MessageBox(PChar('Ошибка при вводе значения в поле: "' + Label1.Caption + '".' + #13#10#13#10 +
              'Значение нуля информационного сигнала от зондового устройства для конвейера "' + current_NameLines +
              '", должно находиться в диапазоне от '+
              Format('%.2n', [current_UminNull]) + ' до ' + Format('%.2n', [current_UmaxNull]) + '.' + #10#13#13#10 +
              'Настройки диапазона значения нуля находятся: "Рабочая станция" -> "Настройка технических параметров" -> ' +
              '"Конфигурация рабочей станции" -> "Настройки нулевого сигнала".'),
                                     PChar(ProgName_ShortStringVersion + ' Ошибка !!!'),
                                     MB_OK + MB_ICONERROR);
            exit;
          end;
      except
        Application.MessageBox(PChar('Ошибка при вводе значения в поле: "' + Label1.Caption + '".' + #13#10 +
                                    'Разрешено вводить цифы или запятую.'),
                                     PChar(ProgName_ShortStringVersion + ' Ошибка !!!'),
                                     MB_OK + MB_ICONERROR);
        exit;
      end;

      try
        param:= StrToFloat(EditMax.Text);
      except
        Application.MessageBox(PChar('Ошибка при вводе значения в поле: "' + Label2.Caption + '".' + #13#10 +
                                    'Разрешено вводить цифы или запятую.'),
                                     PChar(ProgName_ShortStringVersion + ' Ошибка !!!'),
                                     MB_OK + MB_ICONERROR);
        exit;
      end;

      try
        param:= StrToFloat(EditMin.Text);
      except
        Application.MessageBox(PChar('Ошибка при вводе значения в поле: "' + Label3.Caption + '".' + #13#10 +
                                    'Разрешено вводить цифы или запятую.'),
                                     PChar(ProgName_ShortStringVersion + ' Ошибка !!!'),
                                     MB_OK + MB_ICONERROR);
        exit;
      end;

      if not DM.QueryWorkStation('UPDATE Points SET Null_I = ''' + EditNull.Text +
                                  ''', Max_I = ''' + EditMax.Text +
                                  ''', Min_I = ''' + EditMin.Text +
                                  ''', DateNull = ''' + FormatDateTime('dd.mm.yy hh:nn:ss', now) +
                                  ''', Color = ''' + IntToStr(PanelWidthLine.Color) +
                                  ''', Width = ''' + IntToStr(PanelWidthLine.Height) +
                                  ''' WHERE Dt_Code = ' + IntToStr(CodeTableInformationSignals),
                                  FormTableInformationSignals.Caption, 'SaveDataInBD', false) then exit;
      //---------------- передаем во внешнию программу тест-состояния -----------------------
      TransferDataNull.L_Code:= current_L_Code;
      TransferDataNull._Date:= now;
      TransferDataNull.Measurer:= current_Status;
      TransferDataNull.Unull:= strtofloat(EditNull.Text);
//      EventSendData.WaitFor(INFINITE);           //надо
      SendCMD(CMD_NULL, @TransferDataNull);
      //-------------------------------------------------------------------------------------
    end;
  ProcedureChangeData(false);
  UpdateTableInformationSignals(true);
end;

procedure TFormTableInformationSignals.EditMaxKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Copy(Label2.Caption, 1 ,Length(Label2.Caption)-1) + '"', EditMax, Key, 2);
end;

procedure TFormTableInformationSignals.EditMinKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Copy(Label3.Caption, 1 ,Length(Label3.Caption)-1) + '"', EditMin, Key, 2);
end;

procedure TFormTableInformationSignals.EditNullKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Copy(Label1.Caption, 1 ,Length(Label1.Caption)-1) + '"', EditNull, Key, 2);
end;

procedure TFormTableInformationSignals.ImageOFFClick(Sender: TObject);
begin
  ImageOFF.Visible:= false;
  ImageON.Visible:= true;
  Panel1.Width:= 12;
  FormTableInformationSignals.Width:= FormTableInformationSignals.Width - 293 + 12;
end;

procedure TFormTableInformationSignals.ImageONClick(Sender: TObject);
begin
  ImageON.Visible:= false;
  ImageOFF.Visible:= true;
  FormTableInformationSignals.Width:= FormTableInformationSignals.Width + 293 - 12;
  Panel1.Width:= 293;
end;

procedure TFormTableInformationSignals.PanelWidthLineClick(Sender: TObject);
begin
  ProcedureChangeData;
  PanelButtonWidth.Visible:= true;
  case PanelWidthLine.Height of
    1: BitBtn_1Pt.SetFocus;
    2: BitBtn_2Pt.SetFocus;
    3: BitBtn_3Pt.SetFocus;
    4: BitBtn_4Pt.SetFocus;
    5: BitBtn_5Pt.SetFocus;
  end;
end;

procedure TFormTableInformationSignals.PanelColorBackClick(Sender: TObject);
begin
  ProcedureChangeData;
  PanelButtonWidth.Visible:= true;
  case PanelWidthLine.Height of
    1: BitBtn_1Pt.SetFocus;
    2: BitBtn_2Pt.SetFocus;
    3: BitBtn_3Pt.SetFocus;
    4: BitBtn_4Pt.SetFocus;
    5: BitBtn_5Pt.SetFocus;
  end;
end;

procedure TFormTableInformationSignals.PanelColorClick(Sender: TObject);
begin
  ProcedureChangeData;
  ColorDialog1.Color:= PanelColor.Color;
  if ColorDialog1.Execute then
    PanelColor.Color:= ColorDialog1.Color;

  PanelWidthLine.Color:= PanelColor.Color;
  PanelColor.SetFocus;
end;

function TFormTableInformationSignals.LeftTopPanelWidht: integer;  //вычисляет верхний левый угол панели толщины линии
begin
  result:= (PanelColorBack.Height - PanelWidthLine.Height) div 2;
end;

procedure TFormTableInformationSignals.ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //если данные были изменены, разрешаем кнопку "Применить"
end;

end.
