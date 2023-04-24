unit UnitWinInfSignal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Math,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, Vcl.ExtCtrls, VCLTee.TeeProcs, UnitDM,
  VCLTee.Chart, VCLTee.Series, Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids,
  DateUtils, Vcl.Buttons, Vcl.Menus, Vcl.DdeMan, RudaGlobals, UnitMyForm,
  Vcl.Imaging.jpeg{обязательно ПОСЛЕДНИМ};


type
  TDBGrid = class(Vcl.DBGrids.TDBGrid)
    protected
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                          X, Y: Integer); override;
  end;

type
  ModeEnterOrderProba = (New_OrderProba, Edit_OrderProba);
  TMassSign = array [1..MAXPIP] of TSignals;

type
  TFormWinInfSignal = class(TForm)
    PageControl1: TPageControl;
    Таблица: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ComboBoxLine: TComboBox;
    ComboBoxWS: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ButtonChoose: TButton;
    GroupBox1: TGroupBox;
    ComboBoxListDate: TComboBox;
    DateTimePicker1: TDateTimePicker;
    RadioButtonList: TRadioButton;
    RadioButtonManual: TRadioButton;
    Chart1: TChart;
    ListView1: TListView;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Series7: TLineSeries;
    Series8: TLineSeries;
    DBGrid1: TDBGrid;
    ADOQueryJornal: TADOQuery;
    DataSourceJornal: TDataSource;
    RadioGroupView: TRadioGroup;
    Series1: TLineSeries;
    SpeedButtonAutoRefresh: TSpeedButton;
    PopupMenuLV: TPopupMenu;
    N1Proba: TMenuItem;
    N2Null: TMenuItem;
    Panel1: TPanel;
    Label3: TLabel;
    ListViewListShowSign: TListView;
    ADOQueryJornalJ_Code: TAutoIncField;
    ADOQueryJornalJ_Num: TIntegerField;
    ADOQueryJornalL_Code: TIntegerField;
    ADOQueryJornalJ_DateBeg: TDateTimeField;
    ADOQueryJornalJ_DateEnd: TDateTimeField;
    ADOQueryJornalFloatField1: TFloatField;
    ADOQueryJornalFloatField2: TFloatField;
    ADOQueryJornalFloatField3: TFloatField;
    ADOQueryJornalFloatField4: TFloatField;
    ADOQueryJornalFloatField5: TFloatField;
    ADOQueryJornalFloatField6: TFloatField;
    ADOQueryJornalFloatField7: TFloatField;
    ADOQueryJornalFloatField8: TFloatField;
    ADOQueryJornalP1: TFloatField;
    ADOQueryJornalP2: TFloatField;
    ADOQueryJornalP3: TFloatField;
    ADOQueryJornalP4: TFloatField;
    ADOQueryJornalP5: TFloatField;
    ADOQueryJornalP6: TFloatField;
    ADOQueryJornalP7: TFloatField;
    ADOQueryJornalP8: TFloatField;
    ADOQueryJornalP9: TFloatField;
    ADOQueryJornalP10: TFloatField;
    ADOQueryJornalP11: TFloatField;
    ADOQueryJornalP12: TFloatField;
    ADOQueryJornalPrim: TWideStringField;
    PopupMenuProba: TPopupMenu;
    N1DelProba: TMenuItem;
    N2ConvertInFile: TMenuItem;
    N3ViewProba: TMenuItem;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    TimerShowDateTime: TTimer;
    Timer2: TTimer;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    LabelFon: TLabel;
    LabelHint: TLabel;
    TimerRestoreScale: TTimer;
    PanelSpliter: TPanel;
    ImageON: TImage;
    ImageOFF: TImage;
    PanelNavi: TPanel;
    BitBtnForward: TBitBtn;
    BitBtnBackward: TBitBtn;
    BitBtnCurrent: TBitBtn;
    BitBtnPrint: TBitBtn;
    EditOrderProba: TMenuItem;
    EditForCellGrid: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButtonManualClick(Sender: TObject);
    procedure ComboBoxWSChange(Sender: TObject);
    procedure ButtonChooseClick(Sender: TObject);
    function FullSign: integer;
    function FullControlParam: integer;
    procedure BackgroundColorPanel(ColorPanel: TColor);
    procedure BoundList;
    procedure CreateSeries;
    procedure ListFull;
    procedure GraphFull;
    procedure JornalFull;
    procedure NaviWorkDay(NumHour: integer);
    procedure FormCreate(Sender: TObject);
    procedure ComboBoxLineChange(Sender: TObject);
    procedure DateList(cLine, View: integer);
    procedure RadioGroupViewClick(Sender: TObject);
    procedure SpeedButtonAutoRefreshClick(Sender: TObject);
    procedure ClearAllData;
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBoxListDateChange(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure ListShowSign;
    procedure ListView1Resize(Sender: TObject);
    procedure ListViewListShowSignResize(Sender: TObject);
    procedure ListViewListShowSignClick(Sender: TObject);
    procedure N1ProbaClick(Sender: TObject);
    procedure N2NullClick(Sender: TObject);
    procedure Chart1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    function Approx(MyValueDateTime: TDateTime): integer;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ClearSel;
    procedure DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ADOQueryJornalAfterScroll(DataSet: TDataSet);
    procedure N1DelProbaClick(Sender: TObject);
    procedure N2ConvertInFileClick(Sender: TObject);
    procedure N3ViewProbaClick(Sender: TObject);
    procedure TimerShowDateTimeTimer(Sender: TObject);
    procedure ViewTablCount;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure AddDataC;
    procedure LVScroll(_position: integer);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure Timer2Timer(Sender: TObject);
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TimerRestoreScaleTimer(Sender: TObject);
    procedure Chart1DblClick(Sender: TObject);
    procedure ImageONClick(Sender: TObject);
    procedure ImageOFFClick(Sender: TObject);
    procedure BitBtnForwardClick(Sender: TObject);
    procedure BitBtnBackwardClick(Sender: TObject);
    procedure BitBtnCurrentClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Chart1AfterDraw(Sender: TObject);
    procedure Chart1AllowScroll(Sender: TChartAxis; var AMin, AMax: Double;
      var AllowScroll: Boolean);
    procedure Chart1UndoZoom(Sender: TObject);
    procedure Chart1Zoom(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    function SettingsGrafik(var View, ColorBack, SizeHour: integer; L_Code: Int64): boolean;
    procedure ShowConfigStart(modeStart: boolean);
    procedure EditOrderProbaClick(Sender: TObject);
    procedure AddOrderProba(ModeEnterOrderProba: ModeEnterOrderProba);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure EditForCellGridKeyPress(Sender: TObject; var Key: Char);
    procedure EditForCellGridEnter(Sender: TObject);
    function CheckFieldNameParamAndOrder(fieldName: string): boolean;
    procedure EditForCellGridChange(Sender: TObject);
    procedure RadioButtonManualMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private

    { Private declarations }
    procedure WMCopyData(var MessageData: TWMCopyData); message WM_COPYDATA;

    type
      PParamGraf = ^TParamGraf;
      TParamGraf = packed record
        LeftOffset: TDateTime;
        RightOffset: TDateTime;
        BottomAxisMin: double;
        BottomAxisMax: double;
        LeftAxisMax: double;
        RightAxisMax: double;
      end;

    var
      FormWinInfSignal: TFormWinInfSignal;
      ParamGraf: TParamGraf;
      View: integer;
      L_Code, D_Code: Int64;
      CurrentDate: TDateTime;
      ColorBack, SizeHour: integer;
      Interval: integer;
      CountSign, CountParam: integer;
      СounterPulseWeight: boolean;      //значит есть счетчик импульсных весов
      Sign    : TMassSign; //array [1..MAXPIP] of TSignals;
      ControlP: array [1..MAXPARAM] of TContolParam;
      jCode: integer;                   //номер последней записи в журнале проб
      SelBeg, SelEnd: integer;          //первый и последний индекс выделенного диапазона
      BeginDate, EndDate: TDateTime;    //начальное и конечное время выделенного диапазона
      PTransferData: PTransferData;
      PTransferParamConfig: PTransferParamConfig;
      delta_Time: TDateTime;
      StatusBarIndexIco: integer;
      TextCaption: string;
      GraphOpen: boolean;  //true- полный график (все данные), false - по заданномк размеру окна
      sTitle1, sTitle2, sTitle3, PrinTitle: string;  //для печати
      TypeController: integer;
      DisplayLabel: string;
      Start: boolean; //   режим отбора проб
      NameLineAndWS: string;        //название подразделения и имя конвейера
      EditFildName: string;         //имя редактируемой ячейки в журнале проб
      FPriorIndexLine: integer;
      FPriorLineDate: boolean;
      FPriorLineManual: boolean;
      FPriorIndexView: integer;
      FPriorIndexWS: integer;
  public
    { Public declarations }

  end;

type
  PositionWin = record
    X: integer;
    Y: integer;
    WidthWin: integer;
    HeightWin: integer;
  end;

var
    jCodeForm: integer;       //для передачи в форму редактирования примечание пробы
    ModeEnterProba: ModeEnterOrderProba;
    CaptionForm: string;
    PositionForm: PositionWin;
//  FormWinInfSignal: TFormWinInfSignal;
//  View: integer;
//  L_Code, D_Code, CodeView: integer;
//  CurDate: TDateTime;
//  ColorBack: integer;
//  Interval: integer;
//  CountSign, CountParam: integer;
//  СounterPulseWeight: boolean;      //значит есть счетчик импульсных весов
//  Sign    : array [1..MAXPIP] of TSignals;
//  ControlP: array [1..MAXPARAM] of TContolParam;
//  jCode: integer;                   //номер последней записи в журнале проб
//  SelBeg, SelEnd: integer;          //первый и последний индекс выделенного диапазона
//  BeginDate, EndDate: TDateTime;    //начальное и конечное время выделенного диапазона
//  tempInt: integer;

implementation

{$R *.dfm}

uses MainUnit, UnitTableInformationSignals, UnitSettingsProgramm, UnitEditOrderProba;
//для корректной обработки нажатия клавиши мыши

procedure TFormWinInfSignal.WMCopyData(var MessageData: TWMCopyData);
begin
  if MessageData.CopyDataStruct.dwData = CMD_CONFIG then
    begin
      PTransferParamConfig:= MessageData.CopyDataStruct.lpData;
      if (integer(ComboBoxLine.Items.Objects[ComboBoxLine.ItemIndex]) = integer(PTransferParamConfig^.L_Code)) then
        ShowConfigStart(PTransferParamConfig^.Start);
    end;

  if SpeedButtonAutoRefresh.Down then
    begin
    //Устанавливаем свойства метки, если заданная команда совпадает
      PTransferData:= MessageData.CopyDataStruct.lpData;
      case MessageData.CopyDataStruct.dwData of
        CMD_C:begin
                if (RadioGroupView.ItemIndex = 0) and
                   (integer(ComboBoxLine.Items.Objects[ComboBoxLine.ItemIndex]) = integer(PTransferData^.L_Code))
                            then AddDataC;
              end;
       CMD_CM:begin
                if (RadioGroupView.ItemIndex = 1) and
                   (integer(ComboBoxLine.Items.Objects[ComboBoxLine.ItemIndex]) = integer(PTransferData^.L_Code))
                              then AddDataC;
              end;
       CMD_CH:begin
                if (RadioGroupView.ItemIndex = 2) and
                   (integer(ComboBoxLine.Items.Objects[ComboBoxLine.ItemIndex]) = integer(PTransferData^.L_Code))
                            then AddDataC;
              end;
      end;
    end;
end;

procedure TFormWinInfSignal.ShowConfigStart(modeStart: boolean);
  var s: string;
begin
  Start:= modeStart;
  if Start then s:= 'ВКЛ' else s:= 'ОТКЛ';
  StatusBar1.Panels.Items[3].Text:= 'Режим отбора проб: ' + s;
end;

procedure TFormWinInfSignal.LVScroll(_position: integer);  //прокручиваем скролл ListView1 на заданную позицию
  var p : TPoint;
begin
  p:= ListView1.Items.Item[_position].Position;
  ListView1.Scroll(0 ,P.Y);
end;

procedure TFormWinInfSignal.AddDataC;
  var i, n, numSer: integer;
          bCPW: DWORD;          //счетчик импульсных весов 1,2,3 и 4 байты Ch1, Ch2, Ch3, Ch4
         param{, max_Param}, ChartLeftYMin, ChartLeftYMax: double;
         LastRecord: integer;
         PreviousValueDate, paramDateTime, EndCurrentDay, BeginBottomAxis, EndBottomAxis: TDateTime;
         Sender: TObject;
begin
  if trunc(now) <> trunc(CurrentDate) then
    begin
      if TimerRestoreScale.Interval <> 0 then exit  // значит график сдвинут
        else begin
          BitBtnCurrentClick(Sender);               // значит наступили новые сутки
          exit;
        end;
    end;
//  DM.DataSetWS('SELECT * FROM C' + inttostr(L_Code) +
//               ' WHERE C_Code = (SELECT MAX(C_Code) FROM C' + inttostr(L_Code) + ')',
//                 FMas[Tag].Caption, 'AddDataC');

//  DM.DataSetWS('SELECT MAX(C_Code) as cCode FROM C' + inttostr(L_Code),
//                 FMas[Tag].Caption, 'AddDataC');
//
//  DM.DataSetWS('SELECT * FROM C' + inttostr(L_Code) +
//               ' WHERE C_Code = ' + DM.ADODataSetWS.FieldByName('cCode').AsString,
//                 FMas[Tag].Caption, 'AddDataC');

//  DM.QueryWorkStation('SELECT * FROM C' + inttostr(L_Code) +
//                      ' WHERE C_Code = (SELECT MAX(C_Code) FROM C' + inttostr(L_Code) + ')',
//                 FMas[Tag].Caption, 'AddDataC', true);
  LI:= ListView1.Items.Add; //добавили элемент списка
  LI.Caption:= FormatDateTime('dd.mm.yyyy hh:nn:ss', PTransferData^._Date);
  for i := 1 to CountSign do
    begin
      n:= Sign[i].num;
      LI.SubItems.Add(Format('%.2n', [PTransferData^.InfSign[n]]))
    end;
      //формирование DWORD из байтов счетчика импульсных весов (если импульсные весы имеются)
  bCPW:= 0;
    if СounterPulseWeight then
      begin
        for i := 1 to 4 do
          bCPW:= (bCPW shl 8) or PTransferData^.StatePulsW[5 - i];
      end;
//  LI.SubItems.Add(Format('%.8x',[bCPW]));// для HEX
  LI.SubItems.Add(inttostr(bCPW));
  LVScroll(ListView1.Items.Count - 1); //прокручиваем на последнюю строку списка
  ViewTablCount;    //выводим в ToolBar количество элементов списка

  //выводим график
  LastRecord:= ListView1.Items.Count - 1;
//  if Chart1.BottomAxis.Maximum < StrToDateTime(ListView1.Items[LastRecord].Caption, myFormatDateTime) then
//    Chart1.BottomAxis.Maximum:= StrToDateTime(ListView1.Items[LastRecord].Caption, myFormatDateTime);

//  if Chart1.BottomAxis.Minimum = 0 then
//    Chart1.BottomAxis.Minimum:= StrToDateTime(ListView1.Items[0].Caption, myFormatDateTime);



//  if GraphOpen then Chart1.BottomAxis.Minimum:= StrToDateTime(ListView1.Items[0].Caption, myFormatDateTime)
//               else begin
//                if IncHour(Chart1.BottomAxis.Maximum, -SizeHour) < StrToDateTime(ListView1.Items[0].Caption, myFormatDateTime)
//                  then Chart1.BottomAxis.Minimum:= StrToDateTime(ListView1.Items[0].Caption, myFormatDateTime)
//                  else Chart1.BottomAxis.Minimum:= IncHour(Chart1.BottomAxis.Maximum, -SizeHour);
//               end;

  EndCurrentDay:= IncSecond(IncDay(CurrentDate, 1), -1); //конец текущих суток
  if ListView1.Items.Count = 0 then
    begin
      if trunc(CurrentDate) = trunc(now) then
            Chart1.BottomAxis.SetMinMax(IncHour(now, -SizeHour), now)
            else Chart1.BottomAxis.SetMinMax(CurrentDate, IncHour(CurrentDate, SizeHour));
    end
    else begin
      if TimerRestoreScale.Interval = 0 then   //если график не сдвинут
          //если максимальное значение графика находится в зоне видимости, то ничего не меняем или когда был сдвиг
        if (StrToDateTime(ListView1.Items[ListView1.Items.Count - 1].Caption, myFormatDateTime) < Chart1.BottomAxis.Minimum) or
           (StrToDateTime(ListView1.Items[ListView1.Items.Count - 1].Caption, myFormatDateTime) > Chart1.BottomAxis.Maximum) then
          begin
            EndBottomAxis:= StrToDateTime(ListView1.Items[ListView1.Items.Count - 1].Caption, myFormatDateTime);
            //сдвигаем границу на 2 минуты, чтобы график не упирался в край оси
            EndBottomAxis:= IncMinute(EndBottomAxis, 2);
            if GraphOpen then BeginBottomAxis:= StrToDateTime(ListView1.Items[0].Caption, myFormatDateTime)
                         else BeginBottomAxis:= IncHour(EndBottomAxis, -SizeHour);
            Chart1.BottomAxis.SetMinMax(BeginBottomAxis, EndBottomAxis);
          end;
    end;

  if ListView1.Items.Count = 1 then   //предыдущее значение даты
    PreviousValueDate:= Chart1.BottomAxis.Minimum
    else PreviousValueDate:= StrToDateTime(ListView1.Items[LastRecord - 1].Caption, myFormatDateTime);

  try
    paramDateTime:= StrToDateTime(Trim(ListView1.Items[LastRecord].Caption), myFormatDateTime);
            //делаем разрыв в графике, если данные прерывались.
    while (LastRecord <> 0) and
          ((SelTime(paramDateTime) - SelTime(PreviousValueDate)) >= 1.2*SelTime(delta_Time)) do //тогда нужен разрыв
      begin
        for numSer:= 0 to CountSign - 1 do
          Chart1.Series[numSer].AddNullXY(PreviousValueDate + delta_Time, 0);

        PreviousValueDate:= PreviousValueDate + delta_Time;
      end;
    for numSer:= 0 to CountSign - 1 do
      begin
        if CheckNumeric(Trim(ListView1.Items[LastRecord].SubItems[numSer])) then
          begin
            param:= StrToFloat(Trim(ListView1.Items[LastRecord].SubItems[numSer]));
            Chart1.Series[numSer].AddXY(paramDateTime, param);
          end;
      end;
    PreviousValueDate:= paramDateTime;

    //автомасштабирование
    if not Chart1.Zoomed then
      begin
        if FormSettingsProgramm.CheckBoxAutoscalingLeftAxisYMax.Checked then
          begin
            ChartLeftYMin:= 0;
            ChartLeftYMax:= 0;
            for i := 0 to Chart1.SeriesCount - 1 do
              if Chart1.Series[i].Visible then
                begin
                  if ChartLeftYMin > Chart1.Series[i].MinYValue then ChartLeftYMin:= Chart1.Series[i].MinYValue;
                  if ChartLeftYMax < Chart1.Series[i].MaxYValue then ChartLeftYMax:= Chart1.Series[i].MaxYValue;
                end;
            if ChartLeftYMax = ChartLeftYMin then ChartLeftYMax:= 5/CoefLeftAxis; //если график пустой устаннавливаем макс оси Y = 5

            Chart1.LeftAxis.SetMinMax(ChartLeftYMin, Round(ChartLeftYMax*CoefLeftAxis));
          end
          else begin
            Chart1.LeftAxis.SetMinMax(0, FormSettingsProgramm.SpinEditLeftAxisYMax.Value);
          end;
      end;
  except

  end;

end;

procedure TDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Assigned(OnMouseDown) then OnMouseDown(Self, Button, Shift, X, Y);
end;

procedure TFormWinInfSignal.ButtonChooseClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if RadioButtonList.Checked then
    begin
      if ComboBoxListDate.Items.Count > 0 then
        CurrentDate:= StrToDate(ComboBoxListDate.Items[ComboBoxListDate.ItemIndex])
        else CurrentDate:= Trunc(now);
    end
    else CurrentDate:= Trunc(DateTimePicker1.Date);

  Caption:= TextCaption + ' ' + Label1.Caption + ' "' + ComboBoxWS.Text +
                             '", ' + Label2.Caption + ' "' + ComboBoxLine.Text +
                             '" от ' + FormatDateTime('dd.mm.yyyy', CurrentDate);

  NameLineAndWS:= Label1.Caption + ' "' + ComboBoxWS.Text + '", ' +
                  Label2.Caption + ' "' + ComboBoxLine.Text + '"';

  WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'Win' + inttostr(Tag), Caption);

  CountSign:= FullSign;
  CountParam:= FullControlParam;

  CreateSeries;
  BoundList;      //готовим колонки таблицы

  ListFull;
  GraphFull;
  JornalFull;

  if PageControl1.TabIndex = 3 then PageControl1.TabIndex:= 0;
  ListView1Resize(Sender);
  if SpeedButtonAutoRefresh.Down then BackgroundColorPanel(DefaultColorEditBackAuto)
                                 else BackgroundColorPanel(FormSettingsProgramm.PanelBackgroundColorViewMode.Color);
  ViewTablCount;
end;

procedure TFormWinInfSignal.BackgroundColorPanel(ColorPanel: TColor);
begin
  ListView1.Color:= ColorPanel;
  Chart1.Color:= ColorPanel;
  DBGrid1.Color:= ColorPanel;
end;

function NameTable(view, lCode: integer): string;
begin
  case View of
    0: result:= 'C' + IntToStr(lCode);
    1: result:= 'CM' + IntToStr(lCode);
    2: result:= 'CH' + IntToStr(lCode);
  end;
end;

procedure TFormWinInfSignal.GraphFull;
  var i: integer;
      max_Param, ChartLeftYMin, ChartLeftYMax: double;
      EndCurrentDay, BeginBottomAxis, EndBottomAxis: TDateTime;
begin
  Chart1.LeftAxis.SetMinMax(0, 0);
  Chart1.BottomAxis.SetMinMax(0, 0);

  EndCurrentDay:= IncSecond(IncDay(CurrentDate, 1), -1); //конец текущих суток

  ParamGraf.LeftOffset:= IncHour(CurrentDate, -16);      // +/- 16 часов подгрузка данных
  ParamGraf.RightOffset:= IncHour(EndCurrentDay, 16);    // +/- 16 часов подгрузка данных

  if ListView1.Items.Count = 0 then
    begin
      if trunc(CurrentDate) = trunc(now) then
        Chart1.BottomAxis.SetMinMax(IncHour(now, -SizeHour), now)
        else Chart1.BottomAxis.SetMinMax(CurrentDate, IncHour(CurrentDate, SizeHour));
    end
    else begin
      EndBottomAxis:= StrToDateTime(ListView1.Items[ListView1.Items.Count - 1].Caption, myFormatDateTime);
          //сдвигаем границу на 2 минуты, чтобы график не упирался в край оси
      EndBottomAxis:= IncMinute(EndBottomAxis, 2);
      if GraphOpen then BeginBottomAxis:= StrToDateTime(ListView1.Items[0].Caption, myFormatDateTime)
                   else BeginBottomAxis:= IncHour(EndBottomAxis, -SizeHour);
      Chart1.BottomAxis.SetMinMax(BeginBottomAxis, EndBottomAxis);
    end;

  //автомасштабирование
  if FormSettingsProgramm.CheckBoxAutoscalingLeftAxisYMax.Checked then
    begin
      ChartLeftYMin:= 0;
      ChartLeftYMax:= 0;
      for i:= 0 to Chart1.SeriesCount - 1 do
        if Chart1.Series[i].Visible then
          begin
            if ChartLeftYMin > Chart1.Series[i].MinYValue then ChartLeftYMin:= Chart1.Series[i].MinYValue;
            if ChartLeftYMax < Chart1.Series[i].MaxYValue then ChartLeftYMax:= Chart1.Series[i].MaxYValue;
          end;
      if ChartLeftYMax = ChartLeftYMin then ChartLeftYMax:= 5/CoefLeftAxis; //если график пустой устаннавливаем макс оси Y = 5
      Chart1.LeftAxis.SetMinMax(ChartLeftYMin, Round(ChartLeftYMax*CoefLeftAxis));
    end
    else begin
      Chart1.LeftAxis.SetMinMax(0, FormSettingsProgramm.SpinEditLeftAxisYMax.Value);
    end;
end;

procedure TFormWinInfSignal.ImageOFFClick(Sender: TObject);
begin
  ImageOFF.Visible:= false;
  ImageON.Visible:= true;
  PanelNavi.Visible:= false;
end;

procedure TFormWinInfSignal.ImageONClick(Sender: TObject);
begin
  ImageOFF.Visible:= true;
  ImageON.Visible:= false;
  PanelNavi.Visible:= true;
end;

//было так
//procedure TFormWinInfSignal.ListFull;
//  var i, n:integer;
//    sName, sDtateTime: string;
//    BeginDate, EndDate, deltaBeginDate, deltaEndDate, PreviousValueDate, paramDateTime, deltaTime: TDateTime;
//    FirstTime: boolean;
//    param: double;
//    bCPW: DWORD;          //счетчик импульсных весов 1,2,3 и 4 байты Ch1, Ch2, Ch3, Ch4
//begin
//  Screen.Cursor:= crHourGlass;
//  ListView1.Items.Clear;
//  sName:= NameTable(View, L_Code);
//  FirstTime:= true;
//
//  case View of
//    0: deltaTime:= Interval/(24*60*60);        //переводим сек. в DateTime
//    1: deltaTime:= 60/(24*60*60);              //переводим 1мин. в DateTime
//    2: deltaTime:= (60*60)/(24*60*60);         //переводим 1час. в DateTime
//  end;
//
//  BeginDate:= CurrentDate;
//  EndDate:= IncDay(Trunc(BeginDate), 1);
//
//  deltaBeginDate:= IncDay(BeginDate, -1);   // запас +/- один день для плавной прокрутки графика
//  deltaEndDate:= IncDay(EndDate, 1);        // запас +/- один день для плавной прокрутки графика
//
//  DM.QueryWorkStation('Select * FROM ' + sName +
//     ' WHERE (format(C_Date, ''yyyy.mm.dd hh:nn:ss'') >= ''' + FormatDateTime('yyyy.mm.dd hh:nn:ss', deltaBeginDate) + ''') and ' +
//     ' (format(C_Date, ''yyyy.mm.dd hh:nn:ss'') < ''' + FormatDateTime('yyyy.mm.dd hh:nn:ss', deltaEndDate) + ''') AND C_Yes ORDER BY C_Date',
//                 Caption, 'ListFull', true);
//
//  while not DM.ADOQueryWorkStationMDB.EOF do
//    begin
//      //заполняем таблицу
//      sDtateTime:= FormatDateTime('dd.mm.yyyy hh:nn:ss',DM.ADOQueryWorkStationMDB.FieldByName('C_Date').AsDateTime);
//      if (strtodatetime(sDtateTime) >= strtodatetime(FormatDateTime('dd.mm.yyyy hh:nn:ss',BeginDate))) and
//         (strtodatetime(sDtateTime) < strtodatetime(FormatDateTime('dd.mm.yyyy hh:nn:ss',EndDate))) then
//        begin
//          LI:= ListView1.Items.Add; //добавили элемент списка
//          LI.Caption:= FormatDateTime('dd.mm.yyyy hh:nn:ss', DM.ADOQueryWorkStationMDB.FieldByName('C_Date').AsDateTime);
//          for i := 1 to CountSign do
//            begin
//              n:= Sign[i].num;
//              if CheckNumeric(DM.ADOQueryWorkStationMDB.Fields[n+5].AsString) then
//                LI.SubItems.Add(Format('%.2n', [DM.ADOQueryWorkStationMDB.Fields[n+5].AsFloat]))
//                else LI.SubItems.Add('');
//            end;
//          //формирование DWORD из байтов счетчика импульсных весов (если импульсные весы имеются)
//          bCPW:= 0;
//          if СounterPulseWeight then
//            begin
//              for i := 1 to 4 do
//                bCPW:= (bCPW shl 8) or DM.ADOQueryWorkStationMDB.Fields[5 + 8 + (i)].AsInteger;
//            end;
////          LI.SubItems.Add(Format('%.8x',[bCPW]));  //для HEX
//          LI.SubItems.Add(inttostr(bCPW));
//        end;
//
//        //строим график
//        if FirstTime then PreviousValueDate:= StrToDateTime(sDtateTime);   //предыдущее значение даты
//        try
//            paramDateTime:= StrToDateTime(sDtateTime);
//            //делаем разрыв в графике, если данные прерывались.
//            while (SelTime(paramDateTime) - SelTime(PreviousValueDate)) >= 1.2 * SelTime(deltaTime) do //тогда нужен разрыв
//              begin
//                for i:= 0 to CountSign - 1 do
//                    Chart1.Series[i].AddNullXY(PreviousValueDate + deltaTime, 0);
//                PreviousValueDate:= PreviousValueDate + deltaTime;
//              end;
//
//            for i:= 0 to CountSign - 1 do
//              begin
//                n:= Sign[i + 1].num;
//                if CheckNumeric(Trim(DM.ADOQueryWorkStationMDB.Fields[n+5].AsString)) then
//                  begin
//                    param:= StrToFloat(Trim(DM.ADOQueryWorkStationMDB.Fields[n+5].AsString));
//                    Chart1.Series[i].AddXY(paramDateTime, param);
//                  end;
//              end;
//            PreviousValueDate:= paramDateTime;
//            FirstTime:= false;
//        except
//
//        end;
//
//      DM.ADOQueryWorkStationMDB.Next;
//    end;
//
//  if ListView1.Items.Count > 0 then ListView1.PopupMenu:= PopupMenuLV
//                               else ListView1.PopupMenu:= nil;
//
//  Screen.Cursor:= crDefault;
//end;

procedure TFormWinInfSignal.ListFull;
  var i, n:integer;
    sName, sDtateTime: string;
    BeginDate, EndDate, PreviousValueDate, paramDateTime, deltaTime: TDateTime;
    FirstTime: boolean;
    param: double;
    bCPW: DWORD;          //счетчик импульсных весов 1,2,3 и 4 байты Ch1, Ch2, Ch3, Ch4
begin
  Screen.Cursor:= crHourGlass;
  ListView1.Items.Clear;
  sName:= NameTable(View, L_Code);
  FirstTime:= true;

  case View of
    0: deltaTime:= Interval/(24*60*60);        //переводим сек. в DateTime
    1: deltaTime:= 60/(24*60*60);              //переводим 1мин. в DateTime
    2: deltaTime:= (60*60)/(24*60*60);         //переводим 1час. в DateTime
  end;

  BeginDate:= CurrentDate;
  EndDate:= IncDay(Trunc(BeginDate), 1);

  DM.QueryWorkStation('Select * FROM ' + sName +
     ' WHERE (format(C_Date, ''yyyy.mm.dd hh:nn:ss'') >= ''' + FormatDateTime('yyyy.mm.dd hh:nn:ss', BeginDate) + ''') and ' +
     ' (format(C_Date, ''yyyy.mm.dd hh:nn:ss'') < ''' + FormatDateTime('yyyy.mm.dd hh:nn:ss', EndDate) + ''') AND C_Yes ORDER BY C_Date',
                 Caption, 'ListFull', true);

  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      //заполняем таблицу
      try
        sDtateTime:= FormatDateTime('dd.mm.yyyy hh:nn:ss',DM.ADOQueryWorkStationMDB.FieldByName('C_Date').AsDateTime);

        LI:= ListView1.Items.Add; //добавили элемент списка
        LI.Caption:= FormatDateTime('dd.mm.yyyy hh:nn:ss', DM.ADOQueryWorkStationMDB.FieldByName('C_Date').AsDateTime);
        for i := 1 to CountSign do
          begin
            n:= Sign[i].num;
            if CheckNumeric(DM.ADOQueryWorkStationMDB.Fields[n+5].AsString) then
              LI.SubItems.Add(Format('%.2n', [DM.ADOQueryWorkStationMDB.Fields[n+5].AsFloat]))
              else LI.SubItems.Add('');
          end;
            //формирование DWORD из байтов счетчика импульсных весов (если импульсные весы имеются)
        bCPW:= 0;
        if СounterPulseWeight then
          begin
            for i := 1 to 4 do
              bCPW:= (bCPW shl 8) or DM.ADOQueryWorkStationMDB.Fields[5 + 8 + (i)].AsInteger;
          end;
//            LI.SubItems.Add(Format('%.8x',[bCPW]));  //для HEX
        LI.SubItems.Add(inttostr(bCPW));

            //строим график
        if FirstTime then PreviousValueDate:= StrToDateTime(sDtateTime);   //предыдущее значение даты
        paramDateTime:= StrToDateTime(sDtateTime);
            //делаем разрыв в графике, если данные прерывались.
        while (SelTime(paramDateTime) - SelTime(PreviousValueDate)) >= 1.2 * SelTime(deltaTime) do //тогда нужен разрыв
          begin
            for i:= 0 to CountSign - 1 do
              Chart1.Series[i].AddNullXY(PreviousValueDate + deltaTime, 0);
            PreviousValueDate:= PreviousValueDate + deltaTime;
          end;

        for i:= 0 to CountSign - 1 do
          begin
            n:= Sign[i + 1].num;
            if CheckNumeric(Trim(DM.ADOQueryWorkStationMDB.Fields[n+5].AsString)) then
              begin
                param:= StrToFloat(Trim(DM.ADOQueryWorkStationMDB.Fields[n+5].AsString));
                Chart1.Series[i].AddXY(paramDateTime, param);
              end;
          end;
        PreviousValueDate:= paramDateTime;
        FirstTime:= false;
      except

      end;
      DM.ADOQueryWorkStationMDB.Next;
    end;

  if ListView1.Items.Count > 0 then ListView1.PopupMenu:= PopupMenuLV
                               else ListView1.PopupMenu:= nil;

  Screen.Cursor:= crDefault;
end;

procedure TFormWinInfSignal.ListView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

begin
  if (Button = mbRight) then
    if (ListView1.SelCount > 1) then
      begin
        ListView1.PopupMenu:= PopupMenuLV;
      end
      else begin
        Application.MessageBox('Не выбраны значения.' + #10#13 +
                             'Для расчета следует выбрать больше одного значения.',
                             'Внимание !!!',  MB_OK + MB_ICONWARNING);
        ListView1.PopupMenu:= nil;
      end;

  if ListView1.SelCount > 1 then         //выводим маркеры на график
    begin
      SelBeg:= ListView1.Selected.Index;
      SelEnd:= SelBeg + ListView1.SelCount - 1;
     //правый маркер
      Chart1.Series[Chart1.SeriesCount - 1].Clear;
      Chart1.Series[Chart1.SeriesCount - 1].AddXY(StrToDateTime(ListView1.Items[SelEnd].Caption, myFormatDateTime), -200);
      Chart1.Series[Chart1.SeriesCount - 1].AddXY(StrToDateTime(ListView1.Items[SelEnd].Caption, myFormatDateTime), 200);
      Chart1.Series[Chart1.SeriesCount - 1].Visible:= true;
     //левый маркер
      Chart1.Series[Chart1.SeriesCount - 2].Clear;
      Chart1.Series[Chart1.SeriesCount - 2].AddXY(StrToDateTime(ListView1.Items[SelBeg].Caption, myFormatDateTime), -200);
      Chart1.Series[Chart1.SeriesCount - 2].AddXY(StrToDateTime(ListView1.Items[SelBeg].Caption, myFormatDateTime), 200);
      Chart1.Series[Chart1.SeriesCount - 2].Visible:= true;
    end;

  ViewTablCount;
end;

procedure TFormWinInfSignal.ListView1Resize(Sender: TObject);
  var i: integer;
begin
  if ListView1.Columns.Count = 0 then exit;
  for i := 0 to ListView1.Columns.Count - 1 do
    ListView1.Columns[i].Width:= Trunc(ListView1.Width/ListView1.Columns.Count);
end;

procedure TFormWinInfSignal.ListViewListShowSignClick(Sender: TObject);
  var row: integer;
begin
  if ListViewListShowSign.Items.Count = 0 then exit;
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  ClearAllData;
  //удаляем все записи
  DM.QueryWorkStation('DELETE FROM ShowSignal WHERE L_Code = ' + IntToStr(L_Code),
                 FMas[Tag].Caption, 'ListViewListShowSignClick', false);
  for row := 0 to ListViewListShowSign.Items.Count - 1 do
    if ListViewListShowSign.Items[row].Checked then
      begin
        DM.QueryWorkStation('INSERT INTO ShowSignal (L_Code, Dt_Code) VALUES (' +
           IntToStr(L_Code) + ', ' +
           Trim(ListViewListShowSign.Items[row].SubItems[3]) + ')',
                 FMas[Tag].Caption, 'ListViewListShowSignClick', false);
      end;

  SpeedButtonAutoRefreshClick(Sender);
end;

procedure TFormWinInfSignal.ListViewListShowSignResize(Sender: TObject);
  var ratio: real;
begin
  if ListViewListShowSign.Columns.Count = 0 then exit; //колонки еще не созданы

  //множитель для ширины колонок в процентах
  ratio:= ListViewListShowSign.Width/100;
  with ListViewListShowSign do
    begin
      Columns[0].Width:= Trunc(ratio*43);
      Columns[1].Width:= Trunc(ratio*15);
      Columns[2].Width:= Trunc(ratio*15);
      Columns[3].Width:= ListViewListShowSign.Width - Columns[0].Width - Columns[1].Width - Columns[2].Width;
//      for i := 0 to Columns.Count - 2 do   // без последней колонки. в последней хранится значение поля Dt_Code
//        if i = Columns.Count - 2 then Columns[i].Width:= Trunc(ratio*70) - 2
//                                 else Columns[i].Width:= Trunc(ratio*15) - 2;
      Columns[Columns.Count - 1].Width:= 0; //скрываем последнюю колонку
    end;
end;

procedure TFormWinInfSignal.N1DelProbaClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются
  if Application.MessageBox(PChar('Удалить пробу № ' +
       DBGrid1.DataSource.DataSet.FieldByName('J_Num').AsString + ' ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      DM.QueryWorkStation('DELETE FROM Jornal WHERE J_Code = ' + IntToStr(jCode),
                 FMas[Tag].Caption, 'N1DelProbaClick', false);
      DM.QueryWorkStation('DELETE FROM SpJornal WHERE J_Code = ' + IntToStr(jCode),
                 FMas[Tag].Caption, 'N1DelProbaClick', false);
      JornalFull;
    end;
end;

procedure TFormWinInfSignal.N1ProbaClick(Sender: TObject);
  var   sumI: array [1..MAXPIP] of double;
      countI: array [1..MAXPIP] of integer;
       nullI: array [1..MAXPIP] of double;
      J_Date: TDateTime;
      i, indSign, num: integer;
      sqlText, sP: string;
begin
//  Chart1.PopupMenu:= nil;   //отключаем контекстное меню после его вызова, чтобы не было возможности его вызвать при не выделенных данных
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются
  FillChar(sumI, SizeOf(sumI), #0);
  FillChar(countI, SizeOf(countI), #0);
  SelBeg:= ListView1.Selected.Index;
  with Listview1 do
    begin
      for i := SelBeg to Items.Count - 1 do
        if Items[i].Selected then
          begin
            for indSign:= 1 to CountSign do
              if CheckNumeric(Trim(Items[i].SubItems[indSign - 1])) then
                begin
                  sumI[Sign[indSign].num]:= sumI[Sign[indSign].num] + StrToFloat(Trim(Items[i].SubItems[indSign - 1]));
                  inc(countI[Sign[indSign].num]);
                  SelEnd:= i;
                end;
          end;
      BeginDate:= StrToDateTime(Items[SelBeg].Caption, myFormatDateTime);
      EndDate  := StrToDateTime(Items[SelEnd].Caption, myFormatDateTime);
    end;
  for indSign:= 1 to CountSign do
    if countI[Sign[indSign].num] > 0 then sumI[Sign[indSign].num]:= sumI[Sign[indSign].num]/countI[Sign[indSign].num];

  if View = 0 then   //только для мгновенных значений вычитаем нулевые сигналы
    begin
      FillChar(nullI, SizeOf(nullI), #0);
      DM.QueryWorkStation('SELECT Null_I, Num FROM Points WHERE L_Code =  ' +
                          IntToStr(L_Code) + ' ORDER BY Num',
                 FMas[Tag].Caption, 'N1ProbaClick', true);

      while not DM.ADOQueryWorkStationMDB.EOF do
        begin
          if CheckNumeric(DM.ADOQueryWorkStationMDB.FieldByName('Null_I').AsString) and
             CheckNumeric(DM.ADOQueryWorkStationMDB.FieldByName('Num').AsString)
          then
            begin
              num:= DM.ADOQueryWorkStationMDB.FieldByName('Num').AsInteger;
              if num > 0 then
                nullI[num]:= DM.ADOQueryWorkStationMDB.FieldByName('Null_I').AsFloat;
            end;
          DM.ADOQueryWorkStationMDB.Next;
        end;
      for i := 1 to CountSign do
        sumI[Sign[i].num]:= sumI[Sign[i].num] - nullI[Sign[i].num];
    end;

  DM.QueryWorkStation('SELECT MAX(J_Num) as Jnum FROM Jornal WHERE L_Code =  ' + IntToStr(L_Code),
                 FMas[Tag].Caption, 'N1ProbaClick', true);
  if DM.ADOQueryWorkStationMDB.EOF or
      DM.ADOQueryWorkStationMDB.FieldByName('Jnum').AsVariant = null
        then num:= 1
        else num:= DM.ADOQueryWorkStationMDB.FieldByName('Jnum').AsInteger + 1;

  sqlText:= 'INSERT INTO Jornal (J_Num, L_Code, J_DateBeg, J_DateEnd';
    for i := 1 to CountSign do
      sqlText:= sqlText + ', ' + IntToStr(Sign[i].num);
  sqlText:= sqlText + ') VALUES (' + IntToStr(num) + ', ' + IntToStr(L_Code) +
            ', '''+ FormatDateTime('dd.mm.yyyy hh:nn:ss', BeginDate) + ''', ''' +
            FormatDateTime('dd.mm.yyyy hh:nn:ss', EndDate) + '''';
    for i := 1 to CountSign do
      sqlText:= sqlText + ', ''' + Format('%.2n', [sumI[Sign[i].num]]) + '''';
  sqlText:= sqlText + ')';

  if DM.QueryWorkStation(sqlText, FMas[Tag].Caption, 'N1ProbaClick', false) then
    begin
      PageControl1.TabIndex:= 2;
      JornalFull;
      //устанавливаем курсор в таблице на новую запись
      DM.QueryWorkStation('SELECT MAX(J_Code) as code FROM Jornal WHERE L_Code =  ' + IntToStr(L_Code),
                 FMas[Tag].Caption, 'N1ProbaClick', true);
      if not DM.ADOQueryWorkStationMDB.Eof then jCode:= DM.ADOQueryWorkStationMDB.FieldByName('code').AsInteger;
      if jCode > 0 then DBGrid1.DataSource.DataSet.Locate('J_Code', jCode, []);

      //записываем дату, когда была свормирована последняя проба по конвейеру.
      //Для автоматического отключения режима отбора проб
      DM.QueryWorkStation('UPDATE ParamLines SET DateBeginStart = ''' + FormatDateTime('dd.mm.yyyy hh:nn:ss', now) +
                      ''' WHERE L_Code = ' + IntToStr(L_Code), FMas[Tag].Caption, 'N1ProbaClick', false);

      //добавляем пробе примечание
      AddOrderProba(New_OrderProba);

      Application.MessageBox(PChar('Сформирована проба № ' + IntTostr(num)),
             PChar(FMas[Tag].Caption), MB_OK + MB_ICONINFORMATION);
    end
    else begin
      Application.MessageBox('Не удалось сформировать пробу !!!',
             PChar(FMas[Tag].Caption), MB_OK + MB_ICONERROR);
    end;

  //спецификация пробы с вычетом нулей только для мгновенных
  jCode:= 0;
  DM.QueryWorkStation('SELECT MAX(J_Code) as code FROM Jornal WHERE L_Code =  ' + IntToStr(L_Code),
              FMas[Tag].Caption, 'N1ProbaClick', true);
  if not DM.ADOQueryWorkStationMDB.Eof then jCode:= DM.ADOQueryWorkStationMDB.FieldByName('code').AsInteger;

  if jCode > 0 then
    begin
      with Listview1 do
        begin
          for i := SelBeg to Items.Count - 1 do
            if Items[i].Selected then
              begin
               sqlText:= 'INSERT INTO SpJornal (J_Code, J_Date ';

               for indSign:= 1 to CountSign do
                sqlText:= sqlText + ', ' + IntToStr(Sign[indSign].num);

               sqlText:= sqlText + ') VALUES (' + IntToStr(jCode) +
                   ', ''' + FormatDateTime('dd.mm.yyyy hh:nn:ss', J_Date) + '''';
               J_Date:= StrToDateTime(Items[i].Caption, myFormatDateTime);

               for indSign:= 1 to CountSign do
                begin
                  if CheckNumeric(Trim(Items[i].SubItems[indSign - 1])) then
                    sP:= Format('''%.3n''',[StrToFloat(Trim(Items[i].SubItems[indSign - 1])) - nullI[Sign[indSign].num]])
                    else sP:= 'null';
                  sqlText:= sqlText + ', ' + sP;
                end;

               sqlText:= sqlText + ')';
               DM.QueryWorkStation(sqlText, FMas[Tag].Caption, 'N1ProbaClick', false);
              end;
        end;
    end;
//  Listview1.ClearSelection;                    //убираем выделения
end;

procedure TFormWinInfSignal.N2ConvertInFileClick(Sender: TObject);
  var  s: string;
      st: TStringList;
      FileName: string;
      i: integer;
begin
  SaveDialog1.FileName:= Format('%s_%s', [ComboBoxWS.Text, ComboBoxLine.Text]);
  SaveDialog1.InitialDir:= PathFileCoeffProb;
  if SaveDialog1.Execute then FileName:= SaveDialog1.FileName
                         else exit;
  st:=TStringList.Create;
  with ADOQueryJornal do begin
    First;
    while not eof do begin
      s:='';
      for i:= 5 to Fields.Count - 2 do
        if Fields[i].Visible then
          if CheckNumeric(Fields[i].AsString) then s:= s + Format('%.2n', [Fields[i].AsFloat]) + #09
                                                 else s:= s + #09 + #09;
      st.Append(s);
      Next;
    end;
  end;
  st.SaveToFile(FileName);
  st.Free;
end;

//ищет в списке сигналы U1 и U2. Если обнаружены - result = true, нет - result = fslse
//ListNameString - содержит имена найденных сигналов
function FindSign(Sign: TMassSign; var ListNameString: TStrings): boolean;
  var i: integer;
begin
  result:= false;
  for i := Low(Sign) to High(Sign) do
    if Sign[i].Status in [1, 2] then      //U1 для MB5 и U2 для MB5
      begin
        ListNameString.Add(Sign[i].msName + ' - Вход ' + IntToStr(Sign[i].Point));
        result:= true;
      end;
end;

procedure TFormWinInfSignal.N2NullClick(Sender: TObject);
  var sumI: array [1..MAXPIP] of double;
      countI: array [1..MAXPIP] of integer;
      ListNameSign: TStrings;
      i, indSign: integer;
      sqlText: string;
      errSQL: boolean;
      SinglStrListNameSign: string;
begin
//  Chart1.PopupMenu:= nil;   //отключаем контекстное меню после его вызова, чтобы не было возможности его вызвать при не выделенных данных
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются
  ListNameSign:= TStringList.Create; //список имен сигналолов U1 и U2

  try
    if not FindSign(Sign, ListNameSign) then
      begin
        Application.MessageBox(PChar('Не выбраны сигналы для определения нулей.' + #10#13 +
                         'Необходимо выбрать хотя бы один сигнал с зондового устройства.'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка!!!'),
                            MB_OK + MB_ICONWARNING);
        exit;
      end;

    SinglStrListNameSign:= '';
    for i := 0 to ListNameSign.Count - 1 do
      if i = ListNameSign.Count - 1 then   //если последнее значение
        SinglStrListNameSign:= SinglStrListNameSign + ListNameSign[i]
        else SinglStrListNameSign:= SinglStrListNameSign + ListNameSign[i] + #10#13;

    if Application.MessageBox(PChar(Format('Подразделение: "%s"' + #10#13 + 'Конвейер: "%s"' +
      #10#13 + #10#13 + 'Определить нули по выделенному интервалу для сигнала(ов):' + #10#13 + '%s ?',
              [ComboBoxWS.Text, ComboBoxLine.Text, SinglStrListNameSign])),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDNO  then exit;

    FillChar(sumI, SizeOf(sumI), #0);
    FillChar(countI, SizeOf(countI), #0);
    SelBeg:= ListView1.Selected.Index;
    with Listview1 do
      begin
        for i := SelBeg to Items.Count - 1 do
          if Items[i].Selected then
            begin
              for indSign:= 1 to CountSign do
                if CheckNumeric(Trim(Items[i].SubItems[indSign - 1])) then
                  begin
                    sumI[Sign[indSign].num]:= sumI[Sign[indSign].num] + StrToFloat(Trim(Items[i].SubItems[indSign - 1]));
                    inc(countI[Sign[indSign].num]);
                    SelEnd:= i;
                  end;
            end;
      end;

    for indSign:= 1 to CountSign do
      if countI[Sign[indSign].num] > 0 then sumI[Sign[indSign].num]:= sumI[Sign[indSign].num]/countI[Sign[indSign].num];

    for indSign:= 1 to CountSign do
      if Sign[indSign].Status < 3 then      //U1 для MB5 и U2 для MB5
        begin
          sqlText:= 'UPDATE Points SET Null_I = ''' + Format('%.2n', [sumI[Sign[indSign].num]]) +
            ''', DateNull = ''' + FormatDateTime('dd.mm.yyyy hh:nn:ss', now) + ''' WHERE L_Code = ' + IntToStr(L_Code) +
            ' AND Num = ' + IntToStr(Sign[indSign].num);

          errSQL:= DM.QueryWorkStation(sqlText, FMas[Tag].Caption, 'N2NullClick', false);
        end;

    //записываем дату, когда была свормированы нули по конвейеру.
    //Для автоматического отключения режима отбора проб (записи в базу данных мгновенных сигналов)
    DM.QueryWorkStation('UPDATE ParamLines SET DateBeginStart = ''' + FormatDateTime('dd.mm.yyyy hh:nn:ss', now) +
                      ''' WHERE L_Code = ' + IntToStr(L_Code), FMas[Tag].Caption, 'N2NullClick', false);

    Listview1.ClearSelection;                    //убираем выделения
    ClearSel;

    if FormTableInformationSignals.Showing then FormTableInformationSignals.Close; //открываем форму с информационными сигналами
    FormTableInformationSignals.Show;
    if errSQL then
      Application.MessageBox('Установлены новые значения нулей',
               PChar(FMas[Tag].Caption), MB_OK + MB_ICONINFORMATION)
        else
          Application.MessageBox('Ошибка установки новых значений нулей.',
               PChar(FMas[Tag].Caption), MB_OK + MB_ICONERROR);
  finally
    ListNameSign.Free;
  end;
end;

procedure TFormWinInfSignal.N3ViewProbaClick(Sender: TObject);
begin
      //
end;

procedure TFormWinInfSignal.JornalFull;
  var i: integer;
begin
  ADOQueryJornal.SQL.Clear;
  ADOQueryJornal.SQL.Add('SELECT * FROM Jornal WHERE L_Code = ' + IntToStr(L_Code) +
                         ' ORDER BY J_Num');
  try
    ADOQueryJornal.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[JornalFull]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryJornal.SQL.Text +'"'),
                               PChar(FMas[Tag].Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;

  DataSourceJornal.DataSet.FieldByName('J_Code').Visible:= false;
  DataSourceJornal.DataSet.FieldByName('L_Code').Visible:= false;
  DataSourceJornal.DataSet.FieldByName('J_Num').DisplayLabel:= '№ пробы';
  DataSourceJornal.DataSet.FieldByName('J_Num').Alignment:= taCenter;
  DataSourceJornal.DataSet.FieldByName('J_DateBeg').DisplayLabel:= 'Дата\Время начала';
  DataSourceJornal.DataSet.FieldByName('J_DateEnd').DisplayLabel:= 'Дата\Время окончания';
  DataSourceJornal.DataSet.FieldByName('Prim').DisplayLabel:= 'Примечание';

  for i := 1 to MAXPIP do
    DataSourceJornal.DataSet.FieldByName(IntToStr(i)).Visible:= false;

  for i := 1 to CountSign do
    begin
      DataSourceJornal.DataSet.FieldByName(IntToStr(Sign[i].num)).Visible:= true;
      DataSourceJornal.DataSet.FieldByName(IntToStr(Sign[i].num)).DisplayLabel:= Sign[i].msName +
              ' (' + Sign[i].NameController + ' - Вход ' + IntToStr(Sign[i].Point) + ')';
    end;

  for i := 1 to MAXPARAM do
    if ControlP[i].num > 0 then
      begin
        DataSourceJornal.DataSet.FieldByName('P' + IntToStr(i)).Visible:= true;
        DataSourceJornal.DataSet.FieldByName('P' + IntToStr(i)).DisplayLabel:= ControlP[i].name;
      end
      else DataSourceJornal.DataSet.FieldByName('P' + IntToStr(i)).Visible:= false;

  for i := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns[i].Title.Alignment:= taCenter;
end;

procedure TFormWinInfSignal.NaviWorkDay(NumHour: integer);
  var Sender: TObject;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются
  if SpeedButtonAutoRefresh.Down then
    begin
      TimerRestoreScale.Interval:= 0;
      TimerRestoreScale.Interval:= FormSettingsProgramm.SpinRestoreScale.Value*1000;
    end;
  Chart1.BottomAxis.SetMinMax(IncHour(Chart1.BottomAxis.Minimum, NumHour),
                              IncHour(Chart1.BottomAxis.Maximum, NumHour));

  if Trunc(CurrentDate) <> Trunc((Chart1.BottomAxis.Minimum + Chart1.BottomAxis.Maximum) / 2) then   //если график перешел половину другой даты
    begin
      RadioButtonManual.Checked:= true;
      CurrentDate:= Trunc((Chart1.BottomAxis.Minimum + Chart1.BottomAxis.Maximum) / 2);
      DateTimePicker1.DateTime:= CurrentDate;
      //временно сохраняем
      ParamGraf.BottomAxisMin:= Chart1.BottomAxis.Minimum;
      ParamGraf.BottomAxisMax:= Chart1.BottomAxis.Maximum;

      ButtonChooseClick(Sender);

      //восстанавливаем
      Chart1.BottomAxis.SetMinMax(ParamGraf.BottomAxisMin, ParamGraf.BottomAxisMax);
    end;
end;

procedure TFormWinInfSignal.PageControl1Change(Sender: TObject);
begin
  StatusBar1.Panels.Items[1].Text:= '';
  case PageControl1.TabIndex of
    0: BitBtnPrint.Visible:= true;
    1: begin
        if GraphOpen then StatusBar1.Panels.Items[1].Text:= txtStatusBarGrafik + 'все значения'
               else StatusBar1.Panels.Items[1].Text:= txtStatusBarGrafik + 'окно ' + inttostr(SizeHour) + ' ч.';
       BitBtnPrint.Visible:= true;
    end;
    2, 3: BitBtnPrint.Visible:= false;
  end;
end;

procedure TFormWinInfSignal.BitBtnBackwardClick(Sender: TObject);
begin
  NaviWorkDay(-1);
end;

procedure TFormWinInfSignal.BitBtnCurrentClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются
  TimerRestoreScale.Interval:= 0;
  DateTimePicker1.DateTime:= Date;
  RadioButtonManual.Checked:= true;
  SpeedButtonAutoRefreshClick(Sender);
  if not SpeedButtonAutoRefresh.Down then ButtonChooseClick(Sender);//заполняем предыдущими значениями
end;

procedure TFormWinInfSignal.BitBtnForwardClick(Sender: TObject);
begin
  NaviWorkDay(1);    //один час
end;

procedure TFormWinInfSignal.BitBtnPrintClick(Sender: TObject);
begin
  sTitle1:= Label1.Caption + ' "' + ComboBoxWS.Text + '"';
  sTitle2:= Label2.Caption + ' "' + ComboBoxLine.Text + '" от ' + FormatDateTime('dd.mm.yyyy', CurrentDate);
  sTitle3:= '';
  PrinTitle:= ProgName_ShortStringVersion + ' ' + PageControl1.ActivePage.Caption;
  case PageControl1.TabIndex of
    0: if ListView1.Items.Count > 0 then
          DM.PrintListview(ListView1, sTitle1, sTitle2, sTitle3, PrinTitle);
    1: DM.PrintChart(Chart1, sTitle1, sTitle2, sTitle3, PrinTitle);
  end;
end;

procedure TFormWinInfSignal.BoundList;
  var i: integer;

begin
  DM.FullDD(FMas[Tag].Caption);
  with ListView1.Columns do //готовим колонки списка
    begin
      Clear;     //удаляем все старые колонки
      LC:=Add;   //добавляем новую колонку
        LC.Caption:= 'Дата/Время';
        LC.Width:= 130;
      for i := 1 to CountSign do
        begin
          LC:=Add; //добавляем новую колонку
          LC.Caption:= Sign[i].NameController + //'Канал ' + IntToStr(Sign[i].Plata) +
                                  ' - Вход ' + IntToStr(Sign[i].Point);
          LC.Width:= 100;
          LC.Tag:= Abs(Ord(true));
        end;

      СounterPulseWeight:= false;
      try
        if DM.ValueList(clDDCW {clDDW}, 'D' + IntToStr(integer(ComboBoxLine.Items.Objects[ComboBoxLine.ItemIndex]))) >= 0
           then СounterPulseWeight:= true;
      except

      end;

      if СounterPulseWeight then   //если есть импульсные весы
        begin
          LC:=Add; //добавляем новую колонку
          LC.Caption:= 'Счетчик импульсных весов';
          LC.Width:= 170;
          LC.Tag:= Abs(Ord(true));
        end;
    end;
end;

//функция возвращяет индекс из таблицы ближащий к времени MyValueDateTime
procedure TFormWinInfSignal.ADOQueryJornalAfterScroll(DataSet: TDataSet);
begin
  jCode:= DBGrid1.DataSource.DataSet.FieldByName('J_Code').AsInteger;
end;

//по дате получаем индекс записи в таблице
function TFormWinInfSignal.Approx(MyValueDateTime: TDateTime): integer;
  var i: integer;
      paramDateTime, delta1, delta2: extended;
begin
  result:= -1;
  paramDateTime:= MyValueDateTime;   //переводим из TDateTime в extended
  for i := 0 to ListView1.Items.Count - 1 do
    if StrToDateTime(ListView1.Items[i].Caption, myFormatDateTime) > paramDateTime
       then begin
        if (i > 0) then      //
          begin
          //корректируем до ближайщего значения  DateTime
            if i = (ListView1.Items.Count - 1) then result:= i
              else begin
                delta1:= abs(StrToDateTime(ListView1.Items[i].Caption, myFormatDateTime) - paramDateTime);
                delta2:= abs(StrToDateTime(ListView1.Items[i - 1].Caption, myFormatDateTime) - paramDateTime);
                if delta1 < delta2 then result:= i
                                   else result:= i - 1;
              end;
          end;
        break;
       end;
end;

procedure TFormWinInfSignal.Chart1AfterDraw(Sender: TObject);
begin
  if GraphOpen then StatusBar1.Panels.Items[1].Text:= txtStatusBarGrafik + 'все значения'
               else StatusBar1.Panels.Items[1].Text:= txtStatusBarGrafik + 'окно ' + inttostr(SizeHour) + ' ч.';
end;

procedure TFormWinInfSignal.Chart1AllowScroll(Sender: TChartAxis; var AMin,
  AMax: Double; var AllowScroll: Boolean);
begin
  if SpeedButtonAutoRefresh.Down then
    begin
      TimerRestoreScale.Interval:= 0;
      TimerRestoreScale.Interval:= FormSettingsProgramm.SpinRestoreScale.Value*1000;
    end;
  if Trunc(CurrentDate) < Trunc((Chart1.BottomAxis.Minimum + Chart1.BottomAxis.Maximum) / 2) then   //если график перешел половину другой даты
    begin
      BitBtnForwardClick(Sender);
    end;
  if Trunc(CurrentDate) > Trunc((Chart1.BottomAxis.Minimum + Chart1.BottomAxis.Maximum) / 2) then   //значит график сдвинут вправо больше чем 1 смену
    begin
      BitBtnBackwardClick(Sender);
    end;
end;

procedure TFormWinInfSignal.Chart1DblClick(Sender: TObject);
  var tempView:integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  //обновляем данные по графику, если были внесены изменения в настройках
  //выбранный тип отображения данных View не трогаем, поэтому вводим временную переменную tempView
  SettingsGrafik(tempView, ColorBack, SizeHour, L_Code);
  GraphOpen:= not GraphOpen;
  GraphFull;
end;

procedure TFormWinInfSignal.Chart1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var i, tempSel: integer;
begin
  chart1.AllowZoom:= true;
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  try
    //если мышь не за пределами чарта по оси Х
    if (Chart1.BottomAxis.CalcPosPoint(x) < Chart1.BottomAxis.Minimum) or
       (Chart1.BottomAxis.CalcPosPoint(x) > Chart1.BottomAxis.Maximum) then exit;

    if (ssShift in Shift) and (Button = mbLeft) and (ListView1.Items.Count > 1) then
      begin
        tempSel:= Approx(Chart1.BottomAxis.CalcPosPoint(X));
        if tempSel < 0 then  //значит вне графика
          begin
            chart1.AllowZoom:= false;      //отключаем возможность увиличения графика, т.к. после сообщения об ошибке, цепляется курсор за график
            Application.MessageBox('Ошибка при размещении маркера на графике.' + #10#13 +
                                   'Маркер должен устанавливаться в зоны графика(ов).',
                             'Внимание !!!',  MB_OK + MB_ICONWARNING);
            exit;
          end;

        if Chart1.Series[Chart1.SeriesCount - 2].Visible then //левый маркер установлен
          begin
            if SelBeg >= tempSel then  //правый маркер стоит слева от левого маркера
              begin
                SelEnd:= SelBeg;
                SelBeg:= tempSel;
                Chart1.Series[Chart1.SeriesCount - 2].Clear;
                Chart1.Series[Chart1.SeriesCount - 2].AddXY(StrToDateTime(ListView1.Items[SelBeg].Caption, myFormatDateTime), -200);
                Chart1.Series[Chart1.SeriesCount - 2].AddXY(StrToDateTime(ListView1.Items[SelBeg].Caption, myFormatDateTime), 200);
                Chart1.Series[Chart1.SeriesCount - 2].Visible:= true;
              end
              else SelEnd:= tempSel;
            Chart1.Series[Chart1.SeriesCount - 1].Clear;
            Chart1.Series[Chart1.SeriesCount - 1].AddXY(StrToDateTime(ListView1.Items[SelEnd].Caption, myFormatDateTime), -200);
            Chart1.Series[Chart1.SeriesCount - 1].AddXY(StrToDateTime(ListView1.Items[SelEnd].Caption, myFormatDateTime), 200);
            Chart1.Series[Chart1.SeriesCount - 1].Visible:= true;
          end
          else begin
            SelBeg:= tempSel;    //ставим левый маркер
            Chart1.Series[Chart1.SeriesCount - 2].Clear;
            Chart1.Series[Chart1.SeriesCount - 2].AddXY(StrToDateTime(ListView1.Items[SelBeg].Caption, myFormatDateTime), -200);
            Chart1.Series[Chart1.SeriesCount - 2].AddXY(StrToDateTime(ListView1.Items[SelBeg].Caption, myFormatDateTime), 200);
            Chart1.Series[Chart1.SeriesCount - 2].Visible:= true;
          end;

        ListView1.ClearSelection;
        for i := SelBeg to SelEnd do ListView1.Items[i].Selected:= true;  //помечаем
      end;
  except
    Application.MessageBox('Ошибка установки маркера на графике.',
                             'Ошибка !!!',  MB_OK + MB_ICONERROR);
    exit;
  end;

  Chart1.PopupMenu:= nil;
  if (ssShift in Shift) and (Button = mbRight) then
    if (ListView1.SelCount > 1) then
      begin
        Chart1.PopupMenu:= PopupMenuLV;
      end
      else begin
        Application.MessageBox('Не выбраны значения.' + #10#13 +
                             'Для расчета следует выбрать больше одного значения.',
                             'Внимание !!!',  MB_OK + MB_ICONWARNING);
      end;
  ViewTablCount;
end;

procedure TFormWinInfSignal.Chart1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
  var xt, yt : double;
  ChartPart: TChartClickedPart;
begin
  Chart1.CalcClickedPart(Point(X,Y),ChartPart);
  LabelHint.Visible:= false;
  LabelFon.Visible:= false;
  Chart1.ShowHint:= false;
  if (ChartPart.ASeries <> nil) and FormSettingsProgramm.CheckBoxShowPointChart.Checked then
    begin
      ChartPart.ASeries.GetCursorValues(xt, yt);
//    Chart1.ShowHint:= true;
//    Chart1.Hint:=  ChartPart.ASeries.YValueToText(Yt) + #13#10 + ChartPart.ASeries.XValueToText(Xt);
      LabelHint.Left:= x - LabelHint.Width - 5; //слева от курсора
      LabelHint.Top:= y - 40;                   //поднять выше
      LabelFon.Left:= LabelHint.Left + 3;
      LabelFon.Top:= LabelHint.Top + 3;
      LabelHint.Visible:= true;
      LabelFon.Visible:= true;
//      LabelHint.Caption:= ChartPart.ASeries.YValueToText(Yt) + '  ' + #13#10 +
//                          ChartPart.ASeries.XValueToText(Xt) + '  ';
      LabelHint.Caption:= Format('%.3n', [ChartPart.ASeries.YValue[ChartPart.PointIndex]]) + '  ' + #13#10 +
                          FormatDateTime('hh:nn:ss', ChartPart.ASeries.XValue[ChartPart.PointIndex]) + '  ';
//    sMsg:=sMsg+#13#9'X: '+FloatToStr(ChartPart.ASeries.XValue[ChartPart.PointIndex]);
//    sMsg:=sMsg+#13#9'Y: '+FloatToStr(ChartPart.ASeries.YValue[ChartPart.PointIndex]);
//    sMsg:=sMsg+#13#9'XScreenToValue: '+FloatToStr(ChartPart.ASeries.XScreenToValue(X));
//    sMsg:=sMsg+#13#9'YScreenToValue: '+FloatToStr(ChartPart.ASeries.YScreenToValue(Y));
    end;

end;

procedure TFormWinInfSignal.Chart1UndoZoom(Sender: TObject);
begin
  if SpeedButtonAutoRefresh.Down then TimerRestoreScale.Interval:= 0;
  GraphFull;
end;

procedure TFormWinInfSignal.Chart1Zoom(Sender: TObject);
begin
  if SpeedButtonAutoRefresh.Down then
    begin
      TimerRestoreScale.Interval:= 0;
      TimerRestoreScale.Interval:= FormSettingsProgramm.SpinRestoreScale.Value*1000;
    end;
end;

procedure  TFormWinInfSignal.ClearAllData;
  var i: integer;
begin
  ListView1.Items.Clear;
  ListView1.Columns.Clear;

  while Chart1.SeriesCount > 0 do
    Chart1.Series[0].Free;
  //возвращаем цвет фона в исходное состояние
  Chart1.Walls.Back.Color:= $C0C0C0; //серый цвет
  Chart1.Walls.Back.Transparent:= true;

  CountSign:= 0;
  CountParam:= 0;
  for i:= 1 to MAXPIP do Sign[i].msCode:= -1;    //стираем информацию по сигналам
  for i:= 1 to MAXPARAM do ControlP[i].num:= -1; //стираем информацию по контролируемым параметрам

  StatusBar1.Panels.Items[1].Text:= '';
  ViewTablCount;
end;

procedure TFormWinInfSignal.CreateSeries;
  var i:integer;
begin
  with Chart1 do
    begin
      //-- Clear the series
      while SeriesCount > 0 do
        Series[0].Free;

      //--Then trying to add 5 new series
      for i:= 0 to CountSign - 1 do
        begin
          AddSeries(TLineSeries.Create(Self));
          SeriesList.Groups.Items[0].Add(Series[i]);                // <- change like this
          Series[i].Name := 'Series'+IntToStr(i+1);                 // <- change like this
          Series[i].Color:= Sign[i + 1].Color;
          Series[i].Pen.Width:= Sign[i + 1].Width;
//          Series[i].Legend.Text:= Sign[i + 1].msName;
          Series[i].Legend.Text:= Sign[i + 1].msName + '(' + Sign[i + 1].NameController +
                                  ' - Вход ' + IntToStr(Sign[i + 1].Point) + ')';
          Series[i].XValues.DateTime:= true;
          Series[i].Visible:= true;
        end;
      // создаем серии маркеров
      i:= SeriesCount;
      AddSeries(TLineSeries.Create(Self));
      SeriesList.Groups.Items[1].Add(Series[i]);
      Series[i].Name:= 'markerLeft';
      Series[i].Legend.Text:= 'Левый маркер';
      Series[i].Color:= LeftMarker.Color;
      Series[i].Pen.Width:= LeftMarker.Width;
      Series[i].Pen.Style:= LeftMarker.Style;
      Series[i].XValues.DateTime:= true;
      Series[i].Visible:= false;

      AddSeries(TLineSeries.Create(Self));
      SeriesList.Groups.Items[1].Add(Series[i + 1]);
      Series[i+1].Name:= 'markerRight';
      Series[i+1].Legend.Text:= 'Правый маркер';
      Series[i+1].Color:= RightMarker.Color;
      Series[i+1].Pen.Width:= RightMarker.Width;
      Series[i+1].Pen.Style:= RightMarker.Style;
      Series[i].XValues.DateTime:= true;
      Series[i+1].Visible:= false;

      //устанавливаем цвет фона
      Walls.Back.Color:= ColorBack;
      Walls.Back.Transparent:= false;
      LeftAxis.Automatic:= false;
    end;
end;

//Формируем массив параметров
function TFormWinInfSignal.FullControlParam: integer;
  var i: integer;
begin
  result:= 0;
  for i := 1 to MAXPARAM do ControlP[i].num:= -1;

  DM.QueryServer('SELECT * FROM ControlParam WHERE L_Code = ' + IntToStr(L_Code) +
                 ' AND "Connect" ORDER BY num', FMas[Tag].Caption, 'FullControlParam', true);

  DM.ADOQueryServerMDB.First;
  while not DM.ADOQueryServerMDB.EOF do
    begin
      inc(result);
      ControlP[result].num := DM.ADOQueryServerMDB.FieldByName('num').AsInteger;
      StrPCopy(ControlP[result].name, DM.ADOQueryServerMDB.FieldByName('Cp_Name').AsString);
      DM.ADOQueryServerMDB.Next;
    end;
end;

//Формируем массив сигналов
function TFormWinInfSignal.FullSign: integer;
  var i: integer;
begin
  result:= 0;
  for i := 1 to MAXPIP do Sign[i].msCode:= -1;

  DM.QueryWorkStation('SELECT Points.*, Measurer.Ms_Name, LinkContr.NameController ' +
                      'FROM ((Points INNER JOIN Measurer ON Points.Ms_Code = Measurer.Ms_Code) ' +
                      'INNER JOIN LinkContr ON Points.Lc_Code = LinkContr.Lc_Code) ' +
                      'INNER JOIN ShowSignal ON Points.Dt_Code = ShowSignal.Dt_code ' +
                      'WHERE ((("Connect")=True) AND ((Points.L_Code) = ' + IntToStr(integer(ComboBoxLine.Items.Objects[ComboBoxLine.ItemIndex])) +
                      ')) ORDER BY Points.NUM', FMas[Tag].Caption, 'FullSign', true);

//  DM.QueryWorkStation('SELECT Points.*, Measurer.Ms_Name, LinkContr.NameController ' +
//                      'FROM (Points INNER JOIN Measurer ON Points.Ms_Code = Measurer.Ms_Code) INNER JOIN ShowSignal ON Points.Dt_Code = ShowSignal.Dt_code ' +
//                      'WHERE ((("Connect")=True) AND ((Points.L_Code) = ' + IntToStr(integer(ComboBoxLine.Items.Objects[ComboBoxLine.ItemIndex])) +
//                      ')) ORDER BY Points.NUM', FMas[Tag].Caption, 'FullSign', true);

  DM.ADOQueryWorkStationMDB.First;
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      inc(result);
      Sign[result].NameController:= DM.ADOQueryWorkStationMDB.FieldByName('NameController').AsString;
      Sign[result].msCode:= DM.ADOQueryWorkStationMDB.FieldByName('Ms_Code').AsInteger;
      Sign[result].msName:= DM.ADOQueryWorkStationMDB.FieldByName('Ms_Name').AsString;
      Sign[result].dtCode:= DM.ADOQueryWorkStationMDB.FieldByName('Dt_Code').AsInteger;
      Sign[result].Plata := DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger + 1;
      Sign[result].Point := DM.ADOQueryWorkStationMDB.FieldByName('Point').AsInteger + 1;
      Sign[result].Status:= DM.ADOQueryWorkStationMDB.FieldByName('Status').AsInteger;
      Sign[result].Color := DM.ADOQueryWorkStationMDB.FieldByName('Color').AsInteger;
      Sign[result].Width := DM.ADOQueryWorkStationMDB.FieldByName('Width').AsInteger;
      Sign[result].num   := DM.ADOQueryWorkStationMDB.FieldByName('num').AsInteger;
      DM.ADOQueryWorkStationMDB.Next;
    end;
end;

procedure TFormWinInfSignal.ListShowSign;
  var Sender: TObject;
begin
  with ListViewListShowSign.Columns do //готовим колонки списка сигналов
    begin
      Clear;     //удаляем все старые колонки
      LC:=Add;   //добавляем новую колонку
        LC.Caption:= 'Название контроллера';
      LC:=Add;   //добавляем новую колонку
        LC.Caption:= DisplayLabel;
      LC:=Add;   //добавляем новую колонку
        LC.Caption:= 'Вход';
      LC:=Add;   //добавляем новую колонку
        LC.Caption:= 'Датчик';
      LC:=Add;   //добавляем новую колонку
        LC.Caption:= 'Points.Dt_code';
    end;

  DM.QueryWorkStation('SELECT Points.Plata, Points.Point, Points.Dt_code, Measurer.Ms_Name, ShowSignal.Dt_code, ' +
     'LinkContr.NameController, LinkContr.PlataAddress ' +
     'FROM ((Measurer INNER JOIN Points ON (Measurer.Ms_Code = Points.Ms_Code) AND (Measurer.L_Code = Points.L_Code)) ' +
     'LEFT JOIN ShowSignal ON (Points.Dt_Code = ShowSignal.Dt_code) AND (Points.L_Code = ShowSignal.L_Code)) ' +
     'INNER JOIN LinkContr ON Points.Lc_Code = LinkContr.Lc_Code ' +
     'WHERE (((Measurer.L_Code) = ' + IntToStr(L_Code) + ') AND ((Measurer.Connect)=True)) ' +
     'ORDER BY Points.NUM',
     FMas[Tag].Caption, 'ListShowSign', true);

//  DM.QueryWorkStation('SELECT Points.Plata, Points.Point, Points.Dt_code, Measurer.Ms_Name, ShowSignal.Dt_code ' +
//     'FROM (Measurer INNER JOIN Points ON (Measurer.L_Code = Points.L_Code) AND ' +
//     '(Measurer.Ms_Code = Points.Ms_Code)) LEFT JOIN ShowSignal ON (Points.L_Code = ShowSignal.L_Code) ' +
//     'AND (Points.Dt_Code = ShowSignal.Dt_code) ' +
//     'WHERE (((Measurer.L_Code) = ' + IntToStr(L_Code) + ') AND ((Measurer.Connect)=True)) ' +
//     'ORDER BY Points.NUM',
//     FMas[Tag].Caption, 'ListShowSign', true);  // ORDER BY Points.NUM,  {Points.Plata, Points.Point, Points.Status}

  DM.ADOQueryWorkStationMDB.First;
  ListViewListShowSign.Items.Clear;
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      LI:= ListViewListShowSign.Items.Add; //добавили элемент списка
      LI.Caption:= DM.ADOQueryWorkStationMDB.FieldByName('NameController').AsString;
      LI.SubItems.Add(IntToStr(DM.ADOQueryWorkStationMDB.FieldByName('PlataAddress').AsInteger + 1));
      LI.SubItems.Add(IntToStr(DM.ADOQueryWorkStationMDB.FieldByName('Point').AsInteger + 1));
      LI.SubItems.Add(DM.ADOQueryWorkStationMDB.FieldByName('Ms_Name').AsString);
      LI.SubItems.Add(DM.ADOQueryWorkStationMDB.Fields[2].AsString);     //поле Points.Dt_code
      if CheckNumeric(DM.ADOQueryWorkStationMDB.Fields[4].AsString) then //поле ShowSignal.Dt_code
          LI.Checked:= true else LI.Checked:= false;
      DM.ADOQueryWorkStationMDB.Next;
    end;

  ListViewListShowSignResize(Sender);
end;

//считываем настройки графика и вид данных
function TFormWinInfSignal.SettingsGrafik(var View, ColorBack, SizeHour: integer; L_Code: Int64): boolean;
begin
  StatusBar1.Panels.Items[3].Text:= '';    //режим отбора проб
  result:= DM.QueryWorkStation('SELECT * FROM ParamLines WHERE L_Code = ' + IntToStr(L_Code),
                                FMas[Tag].Caption, 'SettingsGrafik', true);
  if not DM.ADOQueryWorkStationMDB.EOF then
    begin
      View:= StrToInt(DM.ValNumeric(Trim(DM.ADOQueryWorkStationMDB.FieldByName('View').AsString)));
      ColorBack:= StrToInt(DM.ValNumeric(Trim(DM.ADOQueryWorkStationMDB.FieldByName('ColorBack').AsString)));
      SizeHour:= DM.ADOQueryWorkStationMDB.FieldByName('SizeCadr').AsInteger;
      ShowConfigStart(DM.ADOQueryWorkStationMDB.FieldByName('Start').AsBoolean);
    end;
end;

procedure TFormWinInfSignal.ComboBoxLineChange(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then  //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
    begin
      ComboBoxLine.ItemIndex:= FPriorIndexLine;
      exit;
    end;
  FPriorIndexLine:= ComboBoxLine.ItemIndex;

  SpeedButtonAutoRefresh.Down:= false;
  SpeedButtonAutoRefreshClick(Sender);
  ClearAllData;
  if ComboBoxLine.Items.Count > 0 then
    begin
      L_Code:= -1;
      JornalFull;    //делаем так, чтобы появилась чистая (незаполненная) таблица проб

      L_Code:= integer(ComboBoxLine.Items.Objects[ComboBoxLine.ItemIndex]);

      Caption:= TextCaption;
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'Win' + inttostr(Tag), Caption);

      View:= 0;

      SettingsGrafik(View, ColorBack, SizeHour, L_Code);

      RadioGroupView.ItemIndex:= View;

      Interval:= 0;
      DM.QueryWorkStation('SELECT * FROM  ParamStation WHERE D_Code = ' + IntToStr(D_Code),
                                FMas[Tag].Caption, 'ComboBoxLineChange', true);
      if not DM.ADOQueryWorkStationMDB.EOF then
        Interval:= StrToInt(DM.ValNumeric(Trim(DM.ADOQueryWorkStationMDB.FieldByName('Interval').AsString))) AND $7F;

      if Interval = 0 then Interval:= 3;

      ListShowSign;
      DateList(L_Code, View);
    end;
end;

procedure TFormWinInfSignal.ComboBoxListDateChange(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  SpeedButtonAutoRefresh.Down:= false;
  SpeedButtonAutoRefreshClick(Sender);
  ClearAllData;
end;

function ChangeFormatDate(strDate: string): string;  //меняет формат даты с yyyy.mm.dd на dd.mm.yyyy
  var d, m, y: string;
begin
  result:= '';
  if length(strDate) <> 10 then exit; //значит пришли неправильные данные
  d:= ''; m:= ''; y:= '';
  try
    d:= copy(strDate, 9, 2);
    m:= copy(strDate, 6, 2);
    y:= copy(strDate, 1, 4);
    if CheckNumeric(d) and CheckNumeric(d) and CheckNumeric(d) then
      result:= d + '.' + m + '.' + y
      else exit;
  except

  end;
end;

//заполняем ComboBox со списком всех возможных дат
procedure TFormWinInfSignal.DateList(cLine, View: integer);
  var sName, s: string;
begin
  ComboBoxListDate.Items.Clear;
  sName:= NameTable(View, cLine);
  DM.QueryWorkStation('SELECT DISTINCT DateValue(C_Date) as DateList ' +
                      'FROM ' + sName + ' WHERE C_Yes = True', FMas[Tag].Caption, 'DateList', true);
  DM.ADOQueryWorkStationMDB.First;
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      s:= FormatDateTime('dd.mm.yyyy', DM.ADOQueryWorkStationMDB.FieldByName('DateList').AsDateTime);
      if s <> '' then ComboBoxListDate.Items.Add(s);
      DM.ADOQueryWorkStationMDB.Next;
    end;
  if ComboBoxListDate.Items.Count > 0 then ComboBoxListDate.ItemIndex:= ComboBoxListDate.Items.Count - 1;
end;

procedure TFormWinInfSignal.DateTimePicker1Change(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  SpeedButtonAutoRefresh.Down:= false;
  SpeedButtonAutoRefreshClick(Sender);
  ClearAllData;
end;

//проверить принадлежит поле DBGrid к полю парматера P1-P12 и Prim, которые разрешено редактировать
function TFormWinInfSignal.CheckFieldNameParamAndOrder(fieldName: string): boolean;
var i: integer;
begin
  result:= false;
  if AnsiUpperCase(fieldName) = AnsiUpperCase('Prim') then
    begin
      result:= true;
      exit;
    end;

  for i := 1 to MAXPARAM do
    if AnsiUpperCase(fieldName) = AnsiUpperCase('P' + inttostr(i)) then
      begin
        result:= true;
        break;
      end;
end;

//делаем возможность редактировать ячейки в DBGrid
procedure TFormWinInfSignal.DBGrid1ColExit(Sender: TObject);
begin
  EditForCellGrid.Visible:= false;
end;

procedure TFormWinInfSignal.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  var grid : TDBGrid;
      aRect : TRect;
      fieldValue: string;
begin
  aRect := Rect;
  grid := sender as TDBGrid;
  if (DBGrid1.DataSource.DataSet.RecordCount > 0) and CheckFieldNameParamAndOrder(column.FieldName) then
  begin
    if gdfocused in State then
      begin
        EditForCellGrid.Left := Rect.Left + grid.Left + 1;
        EditForCellGrid.Top  := rect.Top + grid.Top + 1;
        EditForCellGrid.Width := Rect.Right - Rect.Left + 2;
        EditForCellGrid.Height := Rect.Bottom - Rect.Top + 2;

        fieldValue:= Trim(DBGrid1.DataSource.DataSet.FieldByName(column.FieldName).AsString);

        if (fieldValue = '') or (AnsiUpperCase(column.FieldName) = AnsiUpperCase('Prim')) then
          EditForCellGrid.Text:= fieldValue
        else
          begin
            try
              EditForCellGrid.Text:= FloatToStr(SimpleRoundTo(DBGrid1.DataSource.DataSet.FieldByName(column.FieldName).AsFloat, - 2));
            except
              EditForCellGrid.Clear;
            end;
          end;

        EditForCellGrid.Visible := True;
        EditFildName:= column.FieldName;
      end
    else
      begin
//        grid.Canvas.FillRect(Rect);
//        DrawText(grid.Canvas.Handle, PChar('*******'), 7, aRect,
//          DT_SINGLELINE or DT_LEFT or DT_VCENTER);
      end
  end
  else
    grid.DefaultDrawColumnCell(Rect, DataCol, Column, state);
end;

procedure TFormWinInfSignal.EditForCellGridChange(Sender: TObject);
begin
  if DBGrid1.DataSource.State in [dsEdit, dsInsert] then
    begin
      DBGrid1.DataSource.DataSet.FieldByName(EditFildName).AsString:= EditForCellGrid.Text;
    end;
end;

procedure TFormWinInfSignal.EditForCellGridEnter(Sender: TObject);
begin
  //переводим источник данных в режим редактирования
  DBGrid1.DataSource.Edit;
end;

procedure TFormWinInfSignal.EditForCellGridKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in [#9, #13] then
    begin
      EditForCellGrid.Visible:= false;  //если Enter закрываем
      if DBGrid1.DataSource.State in [dsEdit, dsInsert] then DBGrid1.DataSource.DataSet.Post;
    end;

  if AnsiUpperCase(EditFildName) <> AnsiUpperCase('Prim') then
    DM.CheckSignFloatPressKey('', EditForCellGrid.Text, Key);
end;

procedure TFormWinInfSignal.DBGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbRight) then
    if (DBGrid1.DataSource.DataSet.RecordCount > 0) then
        begin
          N1DelProba.Enabled:= true;
          N2ConvertInFile.Enabled:= true;
          N3ViewProba.Enabled:= false; //true;   когда напишу поставлю true
          EditOrderProba.Enabled:= true;
        end
        else begin
          N1DelProba.Enabled:= false;
          N2ConvertInFile.Enabled:= false;
          N3ViewProba.Enabled:= false;
          EditOrderProba.Enabled:= false;
        end;
end;

procedure TFormWinInfSignal.AddOrderProba(ModeEnterOrderProba: ModeEnterOrderProba);
begin
  jCodeForm:= jCode;
  ModeEnterProba:= ModeEnterOrderProba;
  CaptionForm:= NameLineAndWS;
  //передаем позицию и размер окна
  PositionForm.X:= Left;
  PositionForm.Y:= Top;
  PositionForm.WidthWin:= Width;
  PositionForm.HeightWin:= Height;
  FormEditOrderProba.ShowModal;
  JornalFull;
end;

procedure TFormWinInfSignal.EditOrderProbaClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются
  AddOrderProba(Edit_OrderProba);
end;

procedure TFormWinInfSignal.ComboBoxWSChange(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then  //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
    begin
      ComboBoxWS.ItemIndex:= FPriorIndexWS;
      exit;
    end;
  FPriorIndexWS:= ComboBoxWS.ItemIndex;

  SpeedButtonAutoRefresh.Down:= false;
  SpeedButtonAutoRefreshClick(Sender);
  ComboBoxLine.Items.Clear;
  D_Code:= integer(ComboBoxWS.Items.Objects[ComboBoxWS.ItemIndex]);
  DM.QueryServer('SELECT L_Code, L_Name FROM Lines WHERE [Connect] and D_Code = ' +
                 IntToStr(D_Code), FMas[Tag].Caption, 'ComboBoxWSChange', true);
  DM.ADOQueryServerMDB.First;
  while not DM.ADOQueryServerMDB.EOF do
    begin
      ComboBoxLine.Items.AddObject(DM.ADOQueryServerMDB.FieldByName('L_Name').AsString,
                   TObject(integer(DM.ADOQueryServerMDB.FieldByName('L_Code').AsInteger)));
      DM.ADOQueryServerMDB.Next;
    end;
  if ComboBoxLine.Items.Count > 0 then
    begin
      ComboBoxLine.ItemIndex:= 0;
      ComboBoxLineChange(Sender);
    end;
end;

procedure TFormWinInfSignal.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  StatusBar1.Panels[1].Width:= StatusBar1.Width -
      StatusBar1.Panels[0].Width -
      StatusBar1.Panels[2].Width -
      StatusBar1.Panels[3].Width -
      StatusBar1.Panels[4].Width;
end;

procedure TFormWinInfSignal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFormWinInfSignal.ClearSel;
begin
  if SelBeg > 0 then
    begin
      Chart1.Series[Chart1.SeriesCount - 2].Clear;
      Chart1.Series[Chart1.SeriesCount - 2].Visible:= false;
    end;

  if SelEnd > 0 then
    begin
      Chart1.Series[Chart1.SeriesCount - 1].Clear;
      Chart1.Series[Chart1.SeriesCount - 1].Visible:= false;
    end;

  SelBeg:= -1;
  SelEnd:= -1;
  BeginDate:= StrToDateTime('01.01.1900 00:00:00', myFormatDateTime);
  EndDate  := StrToDateTime('01.01.1900 00:00:00', myFormatDateTime);
  ViewTablCount;
end;

procedure TFormWinInfSignal.FormCreate(Sender: TObject);
begin
  CountSign:= 0;
  CountParam:= 0;
  L_Code:= -1;
  jCode:= 0;
  PageControl1.TabIndex:= 3;
end;

procedure TFormWinInfSignal.FormDestroy(Sender: TObject);
begin
  TimerShowDateTime.Enabled:= false;
  Timer2.Enabled:= false;
  TimerRestoreScale.Interval:= 0;
  while Chart1.SeriesCount > 0 do Chart1.Series[0].Free;
  WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'Win' + inttostr(Tag),'');
  FormWinInfSignal:= nil;
  FMas[tag]:= nil;
end;

procedure TFormWinInfSignal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = Char(VK_ESCAPE)) and (PageControl1.TabIndex < 2) then     //отменяем выделенный диапазон
    begin
      Listview1.ClearSelection; //убираем выделения
      ClearSel;

    end;
end;

procedure TFormWinInfSignal.FormShow(Sender: TObject);
  var dCode: integer;
begin
  TextCaption:= Caption;

  TypeController:= DM.FunTypeController;
  case TypeController of
     -1: DisplayLabel:= 'Канал/Адрес'; //значит была ошибка
    1,2: DisplayLabel:= 'Канал';       //значит MK001, MK002
      3: DisplayLabel:= 'Адрес';       //значит MK003
  end;

  ComboBoxWS.Items.Clear;
  ComboBoxListDate.Items.Clear;
  ADOQueryJornal.SQL.Clear;
  DateTimePicker1.DateTime:= now;

  with Chart1 do
    begin
      while SeriesList.Groups.Count > 0 do
        SeriesList.Groups[0].Free;

        SeriesList.AddGroup('Signals');
        SeriesList.AddGroup('Marker');
    end;

  CreateSeries;  //очищаем график
  ClearSel;      //очищаем выделенный диапазон
  JornalFull;    //делаем так, чтобы появилась чистая (незаполненная) таблица проб

  Chart1.LeftAxis.Title.Caption:= 'Значение';
  Chart1.BottomAxis.DateTimeFormat:= 'dd.mm hh:nn';
  Chart1.BottomAxis.Title.Caption:= 'Дата (день.месяц часы:минуты)';

  RadioButtonManual.Checked:= true;
  RadioButtonManualClick(Sender);

  DM.QueryWorkStation('SELECT D_Code FROM ParamStation', FMas[Tag].Caption, 'FormShow', true);
  dCode:= DM.ADOQueryWorkStationMDB.FieldByName('D_Code').AsInteger;

  DM.QueryServer('SELECT * FROM WS WHERE D_Code = ' + IntToStr(dCode), FMas[Tag].Caption, 'FormShow', true);
  ComboBoxWS.Items.AddObject(DM.ADOQueryServerMDB.FieldByName('D_Name').AsString,
                                   TObject(integer(Dm.ADOQueryServerMDB.FieldByName('D_Code').AsInteger)));
  if ComboBoxWS.Items.Count > 0 then
    begin
      ComboBoxWS.ItemIndex:= 0;
      ComboBoxWSChange(Sender);
    end;

  ViewTablCount;
  TimerShowDateTimeTimer(Sender);
  TimerShowDateTime.Enabled:= true;
  StatusBar1.Panels.Items[0].Width:= 0;  //скрываем панель
  StatusBarIndexIco:= 36;
  LabelFon.Caption:= '';
  LabelHint.Caption:= '';
  LabelHint.Transparent:= false;  //чтобы был виден фон
  LabelFon.Transparent:= false;
  LabelHint.Visible:= false;
  LabelFon.Visible:= false;
  GraphOpen:= false;
  ImageOFFClick(Sender);

  FPriorIndexLine:= ComboBoxLine.ItemIndex;
  FPriorLineDate:= RadioButtonList.Checked;
  FPriorLineManual:= RadioButtonManual.Checked;
  FPriorIndexView:= RadioGroupView.ItemIndex;
  FPriorIndexWS:= ComboBoxWS.ItemIndex;

  WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'Win' + inttostr(Tag), Caption);
end;

procedure TFormWinInfSignal.ViewTablCount;
begin
  StatusBar1.Panels.Items[2].Text:= inttostr(ListView1.Items.Count)+ ':' +
                                    inttostr(ListView1.SelCount);
end;

procedure TFormWinInfSignal.RadioButtonManualClick(Sender: TObject);
begin
  FPriorLineDate:= RadioButtonList.Checked;         //запоминаем текущее состояние
  FPriorLineManual:= RadioButtonManual.Checked;     //запоминаем текущее состояние
  DateTimePicker1.Enabled:= RadioButtonManual.Checked;
  ComboBoxListDate.Enabled:= not RadioButtonManual.Checked;
  ClearAllData;
end;

procedure TFormWinInfSignal.RadioButtonManualMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then  //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
    begin
      RadioButtonList.Checked:= FPriorLineDate;     //восстанавливаем предыдущее состояние
      RadioButtonManual.Checked:= FPriorLineManual; //восстанавливаем предыдущее состояние
      exit;
    end;
end;

procedure TFormWinInfSignal.RadioGroupViewClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then  //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
    begin
      RadioGroupView.OnClick:= nil;
      RadioGroupView.ItemIndex:= FPriorIndexView;  //восстанавливаем предыдущее состояние
      RadioGroupView.OnClick:= RadioGroupViewClick;
      exit;
    end;
  FPriorIndexView:= RadioGroupView.ItemIndex;     //запоминаем текущее состояние

  SpeedButtonAutoRefresh.Down:= false;
  SpeedButtonAutoRefreshClick(Sender);
  if View = RadioGroupView.ItemIndex then exit;

  View:= RadioGroupView.ItemIndex;
  if ComboBoxLine.Items.Count > 0 then
    DM.QueryWorkStation('UPDATE ParamLines SET [View] = ' + IntToStr(View) +
                        ' WHERE L_Code = ' + IntToStr(L_Code),
                        Caption, 'RadioGroupViewClick', false);
  ComboBoxLineChange(Sender);
end;

procedure TFormWinInfSignal.SpeedButtonAutoRefreshClick(Sender: TObject);
  var i: integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if SpeedButtonAutoRefresh.Down then
    begin
      SpeedButtonAutoRefresh.Hint:= ' Остановить автоматическое обновление данных ';
      TimerRestoreScale.Interval:= 0;
      RadioButtonManual.Checked:= true;
      DateTimePicker1.DateTime:= Date;
      ButtonChooseClick(Sender);   //заполняем предыдущими значениями

      case View of
        0: delta_Time:= Interval/(24*60*60);        //переводим сек. в DateTime
        1: delta_Time:= 60/(24*60*60);              //переводим 1мин. в DateTime
        2: delta_Time:= (60*60)/(24*60*60);         //переводим 1час. в DateTime
      end;

      StatusBar1.Panels.Items[0].Width:= 20;
      BackgroundColorPanel(DefaultColorEditBackAuto);
      Timer2.Enabled:= true;
    end
    else begin
      Timer2.Enabled:= false;
      StatusBar1.Panels.Items[0].Width:= 0;
      for i := 0 to Application.ComponentCount - 1 do
        if (Application.Components[i] is TFormWinInfSignal) and not FMas[(Application.Components[i] as TFormWinInfSignal).Tag].SpeedButtonAutoRefresh.Down then
             (Application.Components[i] as TFormWinInfSignal).Icon:= Image1.Picture.Icon;

      SpeedButtonAutoRefresh.Hint:= ' Начать автоматическое обновление данных ';
      BackgroundColorPanel(FormSettingsProgramm.PanelBackgroundColorViewMode.Color);
    end;
end;

procedure TFormWinInfSignal.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  case Panel.Index of
    0: begin
          StatusBar1.Canvas.FillRect( Rect );
          FormRudaAdmin.ImageList1.Draw( StatusBar1.Canvas, Rect.Left + 2, Rect.Top, StatusBarIndexIco );
       end;
    3: begin
        if start then
          begin
            StatusBar.Canvas.Font.Color:= clRed;
            StatusBar.Canvas.Font.Style:= [fsBold];
          end
          else begin
            StatusBar.Canvas.Font.Color:= clWindowText;
            StatusBar.Canvas.Font.Style:= [];
          end;
        StatusBar.Canvas.TextOut(Rect.left+5, Rect.Top, StatusBar.Panels[3].Text);
       end;
  end;
end;

procedure TFormWinInfSignal.TimerShowDateTimeTimer(Sender: TObject);
begin
  StatusBar1.Panels.Items[4].Text:= Format('%s  %s', [DateToStr(Date), TimeToStr(Time)]);
end;

procedure TFormWinInfSignal.Timer2Timer(Sender: TObject);
  var i: integer;
begin
  if StatusBarIndexIco = 36 then begin
                                  StatusBarIndexIco:= 37;
                                  for i := 0 to Application.ComponentCount - 1 do
                                    if (Application.Components[i] is TFormWinInfSignal) and FMas[(Application.Components[i] as TFormWinInfSignal).Tag].SpeedButtonAutoRefresh.Down then
                                         (Application.Components[i] as TFormWinInfSignal).Icon:= Image3.Picture.Icon;
                                 end
                            else begin
                                  StatusBarIndexIco:= 36;
                                  for i := 0 to Application.ComponentCount - 1 do
                                    if (Application.Components[i] is TFormWinInfSignal) and FMas[(Application.Components[i] as TFormWinInfSignal).Tag].SpeedButtonAutoRefresh.Down then
                                         (Application.Components[i] as TFormWinInfSignal).Icon:= Image2.Picture.Icon;
                                 end;
  StatusBar1.Panels.Items[0].Text:= inttostr(StatusBarIndexIco); //это необходимо чтобы вызвать событие смены иконки
end;

procedure TFormWinInfSignal.TimerRestoreScaleTimer(Sender: TObject);
  var EndWorkDay, BeginWorkDay, LastPointGraf: TDateTime;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing(false) then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются
  TimerRestoreScale.Interval:= 0;
  if ListView1.Items.Count > 0 then
    begin
      LastPointGraf:= StrToDateTime(ListView1.Items[ListView1.Items.Count - 1].Caption, myFormatDateTime);
      //получаем данные времени текущих рабочих сутках
      BeginWorkDay:= Date;
      EndWorkDay:= IncSecond(IncDay(BeginWorkDay, 1), -1); //конец текущих суток Date;
      //надо обновить если график (таблица) не в текущих сутках или
      //график (таблица) в текущих сутках, но значение текущего времени вне поля видимости
      if (not VarInRange(now, BeginWorkDay, EndWorkDay)) or
         (VarInRange(now, BeginWorkDay, EndWorkDay) and
         (not VarInRange(now, Chart1.BottomAxis.Minimum, Chart1.BottomAxis.Maximum))) then
              BitBtnCurrentClick(Sender);
    end
    else BitBtnCurrentClick(Sender);
end;

end.
