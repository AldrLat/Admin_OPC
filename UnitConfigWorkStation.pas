unit UnitConfigWorkStation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.Samples.Spin, Vcl.ExtCtrls, Data.Win.ADODB,
  Vcl.Mask, Vcl.DBCtrls, Math, UnitDM, RudaGlobals, UnitMyForm{обязательно ПОСЛЕДНИМ};

type
  TFormConfigWorkStation = class(TForm)
    DBGridLineList: TDBGrid;
    Label1: TLabel;
    EditName: TEdit;
    Label2: TLabel;
    EditCod: TEdit;
    Label3: TLabel;
    ComboBoxRegimeName: TComboBox;
    CheckBoxStart: TCheckBox;
    Label4: TLabel;
    ComboBoxTypeOre: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CheckBoxEEPROM: TCheckBox;
    CheckBoxSelect: TCheckBox;
    SpeedButtonAdd: TSpeedButton;
    SpeedButtonDelete: TSpeedButton;
    GroupBox3: TGroupBox;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ButtonClose: TButton;
    CheckBoxNull: TCheckBox;
    CheckBoxRefNull: TCheckBox;
    CheckBoxWeightNull: TCheckBox;
    CheckBoxSignal1: TCheckBox;
    CheckBoxSignal2: TCheckBox;
    CheckBoxSignalWithWeights: TCheckBox;
    RadioButtonInstantaneous: TRadioButton;
    RadioButtonMinute: TRadioButton;
    RadioButtonHour: TRadioButton;
    SpinEditSizeHour: TSpinEdit;
    Label8: TLabel;
    Label9: TLabel;
    PanelColorBack: TPanel;
    ADOQueryLine: TADOQuery;
    DataSourceLine: TDataSource;
    ADOQueryLineL_Code: TAutoIncField;
    ADOQueryLineL_Name: TWideStringField;
    ADOQueryLineL_CodeLine: TWideStringField;
    ADOQueryLineD_Code: TIntegerField;
    ADOQueryLineConnect: TBooleanField;
    ADOQueryLineR_Code: TIntegerField;
    ADOQueryLineL_CodeSQL: TIntegerField;
    GroupBox4: TGroupBox;
    EditValDisp1: TEdit;
    EditValDisp2: TEdit;
    EditValDisp3: TEdit;
    EditValDisp4: TEdit;
    EditValDisp5: TEdit;
    EditValDisp6: TEdit;
    EditValDisp7: TEdit;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ColorDialog1: TColorDialog;
    DBGridEquipmentList: TDBGrid;
    DBGridControlParamList: TDBGrid;
    Label5: TLabel;
    BitBtnAddEquipment: TBitBtn;
    BitBtnEditEquipment: TBitBtn;
    BitBtnDelEquipment: TBitBtn;
    Label6: TLabel;
    BitBtnAddControlParam: TBitBtn;
    BitBtnEditControlParam: TBitBtn;
    BitBtnDelControlParam: TBitBtn;
    ADOQueryEquipmentList: TADOQuery;
    ADOQueryEquipmentListConnect: TBooleanField;
    ADOQueryEquipmentListMs_Name: TWideStringField;
    ADOQueryEquipmentListMs_Code: TAutoIncField;
    ADOQueryEquipmentListL_Code: TIntegerField;
    ADOQueryEquipmentListMs_Status: TWordField;
    ADOQueryEquipmentListNum: TWordField;
    ADOQueryEquipmentListCode1: TIntegerField;
    DataSourceEquipmentList: TDataSource;
    ADOQueryControlParamList: TADOQuery;
    ADOQueryControlParamListConnect: TBooleanField;
    ADOQueryControlParamListCp_Name: TWideStringField;
    ADOQueryControlParamListCp_Code: TAutoIncField;
    ADOQueryControlParamListL_Code: TIntegerField;
    ADOQueryControlParamListNum: TWordField;
    ADOQueryControlParamListPlan: TFloatField;
    ADOQueryControlParamListMax: TFloatField;
    ADOQueryControlParamListMeas: TWideStringField;
    ADOQueryControlParamListStatus: TWordField;
    ADOQueryControlParamListMin: TFloatField;
    ADOQueryControlParamListCp_CodeSQL: TIntegerField;
    DataSourceControlParamList: TDataSource;
    BitBtnInfo: TBitBtn;
    ADOQueryControlParamListCp_Description: TStringField;
    Label16: TLabel;
    EditUminNull: TEdit;
    Label17: TLabel;
    EditUmaxNull: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure LineList;
    procedure FormShow(Sender: TObject);
    procedure ADOQueryLineAfterScroll(DataSet: TDataSet);
    procedure ClearAllData;
    procedure DBGridLineListCellClick(Column: TColumn);
    procedure DBGridLineListDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridLineListColEnter(Sender: TObject);
    procedure DBGridLineListColExit(Sender: TObject);
    procedure DBGridLineListEnter(Sender: TObject);
    procedure EquipmentList;
    procedure DBGridEquipmentListCellClick(Column: TColumn);
    procedure DBGridEquipmentListColEnter(Sender: TObject);
    procedure DBGridEquipmentListColExit(Sender: TObject);
    procedure DBGridEquipmentListDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGridEquipmentListEnter(Sender: TObject);
    procedure ControlParamList;
    procedure DBGridControlParamListCellClick(Column: TColumn);
    procedure DBGridControlParamListColEnter(Sender: TObject);
    procedure DBGridControlParamListColExit(Sender: TObject);
    procedure DBGridControlParamListDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGridControlParamListEnter(Sender: TObject);
    procedure CheckBoxNullClick(Sender: TObject);
    procedure CheckBoxRefNullClick(Sender: TObject);
    procedure CheckBoxWeightNullClick(Sender: TObject);
    procedure PanelColorBackClick(Sender: TObject);
    procedure BitBtnAddEquipmentClick(Sender: TObject);
    procedure BitBtnEditEquipmentClick(Sender: TObject);
    procedure BitBtnDelEquipmentClick(Sender: TObject);
    procedure BitBtnAddControlParamClick(Sender: TObject);
    function CheckCoeff: boolean;     //проверка на наличия коэффициентов
    function CheckEquipment: boolean; //проверка на наличия оборудования
    function CheckTypeOre: boolean;   //проверка на наличия типов руды
    procedure BitBtnEditControlParamClick(Sender: TObject);
    procedure BitBtnDelControlParamClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    function SaveDataInBD: boolean;
    procedure EditCodKeyPress(Sender: TObject; var Key: Char);
    procedure EditValDisp1KeyPress(Sender: TObject; var Key: Char);
    procedure EditValDisp2KeyPress(Sender: TObject; var Key: Char);
    procedure EditValDisp3KeyPress(Sender: TObject; var Key: Char);
    procedure EditValDisp4KeyPress(Sender: TObject; var Key: Char);
    procedure EditValDisp5KeyPress(Sender: TObject; var Key: Char);
    procedure EditValDisp6KeyPress(Sender: TObject; var Key: Char);
    procedure EditValDisp7KeyPress(Sender: TObject; var Key: Char);
    procedure SpinEditSizeHourKeyPress(Sender: TObject; var Key: Char);
    procedure ADOQueryLineBeforeScroll(DataSet: TDataSet);
    procedure SpeedButtonAddClick(Sender: TObject);
    procedure UpdateLineList(SetCursorPosition: boolean);
    procedure ButtonCancelClick(Sender: TObject);
    procedure SpeedButtonDeleteClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure BitBtnInfoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ProcedureChangeData(rb: boolean; cd: boolean);   //признак, что данные были изменены
    procedure ChangeDataTrue(Sender: TObject);
    procedure EnabledDisabled(param: boolean);
    procedure SpinEditSizeHourChange(Sender: TObject);
    procedure RadioButtonMinuteClick(Sender: TObject);
    procedure RadioButtonInstantaneousClick(Sender: TObject);
    procedure RadioButtonHourClick(Sender: TObject);
    procedure EditUminNullKeyPress(Sender: TObject; var Key: Char);
    procedure EditUmaxNullKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxStartClick(Sender: TObject);  //запрещает доступ к полям для заполнения, если нет ниодного ковейера
  private
    { Private declarations }
    GridOriginalOptions : TDBGridOptions;
    
    var

    Row_Count: integer;
  public
    { Public declarations }
  end;

var
  FormConfigWorkStation: TFormConfigWorkStation;
  CodeLine: integer;
  massBusyChannelAndPoint: array [1..MAXCHANNEL, 1..4] of boolean;  //для автозаполнения полей какие свободные каналы и поинты
  DateBeginStart: TDateTime;
  ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                        //измененные данные записать в базу данных
  RebootMonitor: boolean = false;   //требуется ли перезагрузка программы Сбор и обработка данных
implementation

{$R *.dfm}
uses MainUnit, UnitDlgConnect, UnitDlgLink, UnitSettingsProgramm,
  UnitViewEquipment;

function SendDataSet(CDS: TCopyDataStruct): integer;  //передать собщение всем окнам
  var receiverHandle: THandle;
      i: integer;
      s: string;
      param: variant;
begin
  result:=0;

  //для информационных сигналов
  for i := 0 to MAXWIN - 1 do
    begin
      if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'Win' + inttostr(i), asString,
              param)
        then s:= string(param)
        else s:= '';
      receiverHandle:= FindWindow(PChar('TFormWinInfSignal'), PChar(s));
      if receiverHandle <> 0 then
          result:= SendMessage(receiverHandle, WM_COPYDATA, Application.Handle, Integer(@CDS));
    end;
end;

procedure SendCMD(CMD: word; pTransferParamConfig: PTransferParamConfig);
  var CDS: TCopyDataStruct;
     TransferParamConfig: TTransferParamConfig;
begin
  CDS.dwData:= CMD;
  TransferParamConfig:= pTransferParamConfig^;
  CDS.cbData:= sizeof(TransferParamConfig);
  CDS.lpData:= @TransferParamConfig;
  SendDataSet(CDS);
end;

procedure TFormConfigWorkStation.ADOQueryLineAfterScroll(DataSet: TDataSet);
  var i: integer;
        CalcDisp: byte;
begin
  ClearAllData;

  //получаем список всех режимов
  if not DM.QueryServer('SELECT * FROM Regims', FormConfigWorkStation.Caption, 'ADOQueryLineAfterScroll', true) then exit;

  DM.ADOQueryServerMDB.First;
  ComboBoxRegimeName.Items.Clear;
  while not DM.ADOQueryServerMDB.EOF do
    begin
      ComboBoxRegimeName.Items.AddObject(DM.ADOQueryServerMDB.FieldByName('R_Name').AsString,
                                   TObject(integer(DM.ADOQueryServerMDB.FieldByName('R_Code').AsInteger)));
      DM.ADOQueryServerMDB.Next; // го на следующего
    end;

  if ComboBoxRegimeName.Items.Count > 0 then
    begin
      for i := 0 to ComboBoxRegimeName.Items.Count - 1 do
        begin
          if DBGridLineList.DataSource.DataSet.FieldByName('R_Code').AsInteger =
                  integer(ComboBoxRegimeName.Items.Objects[i]) then
            begin
              ComboBoxRegimeName.ItemIndex:= i;
              break;
            end;
        end;
    end;

      //получаем список всех типов руд
  if not DM.QueryServer('SELECT * FROM TypeOre', FormConfigWorkStation.Caption, 'ADOQueryLineAfterScroll', true) then exit;

  DM.ADOQueryServerMDB.First;
  ComboBoxTypeOre.Items.Clear;
  while not DM.ADOQueryServerMDB.EOF do
    begin
      ComboBoxTypeOre.Items.AddObject(DM.ADOQueryServerMDB.FieldByName('T_Name').AsString,
                                   TObject(integer(DM.ADOQueryServerMDB.FieldByName('T_Code').AsInteger)));
      DM.ADOQueryServerMDB.Next; // го на следующего
    end;

  if Row_Count > 0 then
    begin
      CodeLine     := DBGridLineList.DataSource.DataSet.FieldByName('L_Code').AsInteger;
      EditName.Text:= DBGridLineList.DataSource.DataSet.FieldByName('L_Name').AsString;
      EditCod.Text := DBGridLineList.DataSource.DataSet.FieldByName('L_CodeLine').AsString;

//      //получаем список всех режимов
//      if not DM.QueryServer('SELECT * FROM Regims', FormConfigWorkStation.Caption, 'ADOQueryLineAfterScroll', true) then exit;
//
//      DM.ADOQueryServerMDB.First;
//      ComboBoxRegimeName.Items.Clear;
//      while not DM.ADOQueryServerMDB.EOF do
//        begin
//          ComboBoxRegimeName.Items.AddObject(DM.ADOQueryServerMDB.FieldByName('R_Name').AsString,
//                                   TObject(integer(DM.ADOQueryServerMDB.FieldByName('R_Code').AsInteger)));
//          DM.ADOQueryServerMDB.Next; // го на следующего
//        end;
//
//      if ComboBoxRegimeName.Items.Count > 0 then
//        begin
//          for i := 0 to ComboBoxRegimeName.Items.Count - 1 do
//            begin
//              if DBGridLineList.DataSource.DataSet.FieldByName('R_Code').AsInteger =
//                  integer(ComboBoxRegimeName.Items.Objects[i]) then
//                begin
//                  ComboBoxRegimeName.ItemIndex:= i;
//                  break;
//                end;
//            end;
//        end;
//
//      //получаем список всех типов руд
//      if not DM.QueryServer('SELECT * FROM TypeOre', FormConfigWorkStation.Caption, 'ADOQueryLineAfterScroll', true) then exit;
//
//      DM.ADOQueryServerMDB.First;
//      ComboBoxTypeOre.Items.Clear;
//      while not DM.ADOQueryServerMDB.EOF do
//        begin
//          ComboBoxTypeOre.Items.AddObject(DM.ADOQueryServerMDB.FieldByName('T_Name').AsString,
//                                   TObject(integer(DM.ADOQueryServerMDB.FieldByName('T_Code').AsInteger)));
//          DM.ADOQueryServerMDB.Next; // го на следующего
//        end;

      if not DM.QueryWorkStation('SELECT * FROM ParamLines WHERE L_Code=' + IntToStr(CodeLine),
                                  FormConfigWorkStation.Caption, 'ADOQueryLineAfterScroll', true) then exit;

      DM.ADOQueryWorkStationMDB.First;
      while not DM.ADOQueryWorkStationMDB.EOF do
        begin
          CheckBoxEEPROM.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('Flag').AsBoolean;
          CheckBoxStart.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('Start').AsBoolean;
          CheckBoxSelect.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('Sel').AsBoolean;

          if ComboBoxTypeOre.Items.Count > 0 then
            begin
              for i := 0 to ComboBoxTypeOre.Items.Count - 1 do
                begin
                  if DM.ADOQueryWorkStationMDB.FieldByName('T_Code').AsInteger =
                  integer(ComboBoxTypeOre.Items.Objects[i]) then
                    begin
                      ComboBoxTypeOre.ItemIndex:= i;
                      break;
                    end;
                end;
            end;

          CheckBoxNull.Checked:= DM.ADOQueryWorkStationMDB.FieldByName('SetNull').AsBoolean;

          try
            case DM.ADOQueryWorkStationMDB.FieldByName('View').AsInteger of
              0: RadioButtonInstantaneous.Checked:= true;
              1: RadioButtonMinute.Checked:= true;
              2: RadioButtonHour.Checked:= true;
            end;
          except
            RadioButtonInstantaneous.Checked:= false;
            RadioButtonMinute.Checked:= false;
            RadioButtonHour.Checked:= false;
          end;

          try
            EditUminNull.Text:= FloatToStr(SimpleRoundTo(DM.ADOQueryWorkStationMDB.FieldByName('UminNull').AsFloat, -2));
          except
            EditUminNull.Text:= Format('%.2n', [DefaultUminNull]);
          end;

          try
            EditUmaxNull.Text:= FloatToStr(SimpleRoundTo(DM.ADOQueryWorkStationMDB.FieldByName('UmaxNull').AsFloat, -2));
          except
            EditUmaxNull.Text:= Format('%.2n', [DefaultUmaxNull]);
          end;

          try
            EditValDisp1.Text:= FloatToStr(SimpleRoundTo(DM.ADOQueryWorkStationMDB.FieldByName('ValDisp1').AsFloat, -6));
          except
            EditValDisp1.Clear;
          end;

          try
            EditValDisp2.Text:= FloatToStr(SimpleRoundTo(DM.ADOQueryWorkStationMDB.FieldByName('ValDisp2').AsFloat, - 6));
          except
            EditValDisp2.Clear;
          end;

          try
            EditValDisp3.Text:= FloatToStr(SimpleRoundTo(DM.ADOQueryWorkStationMDB.FieldByName('ValDisp3').AsFloat, - 6));
          except
            EditValDisp3.Clear;
          end;

          try
            EditValDisp4.Text:= FloatToStr(SimpleRoundTo(DM.ADOQueryWorkStationMDB.FieldByName('ValDisp4').AsFloat, - 6));
          except
            EditValDisp4.Clear;
          end;

          try
            EditValDisp5.Text:= FloatToStr(SimpleRoundTo(DM.ADOQueryWorkStationMDB.FieldByName('ValDisp5').AsFloat, - 6));
          except
            EditValDisp5.Clear;
          end;

          try
            EditValDisp6.Text:= FloatToStr(SimpleRoundTo(DM.ADOQueryWorkStationMDB.FieldByName('ValDisp6').AsFloat, - 6));
          except
            EditValDisp6.Clear;
          end;

          try
            EditValDisp7.Text:= FloatToStr(SimpleRoundTo(DM.ADOQueryWorkStationMDB.FieldByName('ValDisp7').AsFloat, - 6));
          except
            EditValDisp7.Clear;
          end;

          try
            PanelColorBack.Color:= DM.ADOQueryWorkStationMDB.FieldByName('ColorBack').AsInteger;
          except
            PanelColorBack.Color:= clBtnFace;
          end;

          try
            SpinEditSizeHour.Value:= DM.ADOQueryWorkStationMDB.FieldByName('SizeCadr').AsInteger;
          except
            SpinEditSizeHour.Value:= 2;
          end;

          try
            CalcDisp:= DM.ADOQueryWorkStationMDB.FieldByName('CalcDisp').AsInteger;
          except
            CalcDisp:= 0;
          end;

          try
            DateBeginStart:= DM.ADOQueryWorkStationMDB.FieldByName('DateBeginStart').AsDateTime;
          except
            DateBeginStart:= now;
          end;

          CheckBoxSignal1.Checked          := IsBitSet(CalcDisp, 0);
          CheckBoxSignal2.Checked          := IsBitSet(CalcDisp, 1);
          CheckBoxSignalWithWeights.Checked:= IsBitSet(CalcDisp, 2);
          CheckBoxRefNull.Checked          := IsBitSet(CalcDisp, 3);
          CheckBoxWeightNull.Checked       := IsBitSet(CalcDisp, 4);

          //список оборудования
          EquipmentList;

          //список контролируемых параметров
          ControlParamList;

          DM.ADOQueryWorkStationMDB.Next;
        end;
    end;
  ProcedureChangeData(false, false);  //чтобы не зафиксировать изменения при прокрутки скролом и данные не записывались в базу данных
  RebootMonitor:= false; //делаем принудительно, т.к. если до этого был в true, то через процедуру ProcedureChangeData false установить нельзя
end;

procedure ReNum;
  var n: integer;
begin
  DM.QueryWorkStation('SELECT Pl_Code FROM ParamLines ORDER BY L_Code',
                                  FormConfigWorkStation.Caption, 'ReNum', true);
  n:= 1;
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      DM.CommandWS('UPDATE ParamLines SET Num = ' +  inttostr(n) +
          ' WHERE Pl_Code = ' + DM.ADOQueryWorkStationMDB.FieldByName('Pl_Code').AsString,
          FormConfigWorkStation.Caption, 'ReNum');
//      DM.QueryTempWorkStation('UPDATE ParamLines SET Num = ' +  inttostr(n) +
//          ' WHERE Pl_Code = ' + DM.ADOQueryWorkStationMDB.FieldByName('Pl_Code').AsString,
//                                  FormConfigWorkStation.Caption, 'ReNum', true);
      inc(n);
      DM.ADOQueryWorkStationMDB.Next;
    end;

  DM.QueryWorkStation('SELECT L_Code FROM ParamLines ORDER BY Num',
                                  FormConfigWorkStation.Caption, 'ReNum', true);
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      n:= 1;
      DM.QueryTempWorkStation('SELECT Ms_Code FROM Measurer WHERE L_Code=' + DM.ADOQueryWorkStationMDB.FieldByName('L_Code').AsString +
          ' ORDER BY Ms_Status, Ms_Code',
                                  FormConfigWorkStation.Caption, 'ReNum', true);
      while not DM.ADOQueryTempWS.EOF do
        begin
          DM.CommandWS('UPDATE Measurer SET Num=' + inttostr(n) +
             ' WHERE Ms_Code = ' + DM.ADOQueryTempWS.FieldByName('Ms_Code').AsString,
              FormConfigWorkStation.Caption, 'ReNum');
          inc(n);
          DM.ADOQueryTempWS.Next;
        end;

      n:= 1;
      DM.QueryTempWorkStation('SELECT Dt_Code FROM Points WHERE L_Code=' + DM.ADOQueryWorkStationMDB.FieldByName('L_Code').AsString +
          ' ORDER BY Plata, Point',
                                  FormConfigWorkStation.Caption, 'ReNum', true);
      while not DM.ADOQueryTempWS.EOF do
        begin
          DM.CommandWS('UPDATE Points SET Num=' + inttostr(n) +
             ' WHERE Dt_Code = ' + DM.ADOQueryTempWS.FieldByName('Dt_Code').AsString,
             FormConfigWorkStation.Caption, 'ReNum');
          inc(n);
          DM.ADOQueryTempWS.Next;
        end;

      DM.ADOQueryWorkStationMDB.Next;
    end;

  //переустановка полей для надежности
  DM.QueryWorkStation('SELECT L_Code FROM ParamLines ORDER BY Num',
                                  FormConfigWorkStation.Caption, 'ReNum', true);
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      n:= 1;
      DM.QueryServer('SELECT * FROM ControlParam WHERE L_Code=' + DM.ADOQueryWorkStationMDB.FieldByName('L_Code').AsString +
          ' ORDER BY Cp_Code', FormConfigWorkStation.Caption, 'ReNum', true);
      while not DM.ADOQueryServerMDB.EOF do
        begin
          DM.ADOCommandServer.CommandText:= 'UPDATE ControlParam SET Num=' + inttostr(n) +
             ' WHERE Cp_Code = ' + DM.ADOQueryServerMDB.FieldByName('Cp_Code').AsString;
          try
            DM.ADOCommandServer.Execute;
          except

          end;
          inc(n);
          DM.ADOQueryServerMDB.Next;
        end;
      inc(n);
      DM.ADOQueryWorkStationMDB.Next;
    end;
end;

procedure TFormConfigWorkStation.UpdateLineList(SetCursorPosition: boolean);
  var DataSet: TDataSet;
      TempCode: integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  FormConfigWorkStation.Color:= clBtnFace;

  SpeedButtonAdd.Enabled:= true;
  DBGridLineList.Enabled:= true;

  TempCode:= CodeLine;    //запоминаем позицию курсора в DBGrid
  LineList;
  if SetCursorPosition AND (CodeLine > 0) then
    begin
      CodeLine:= TempCode;
      //восстанавливаем позицию курсора
      DBGridLineList.DataSource.DataSet.Locate('L_Code', CodeLine, []);
    end;
  DBGridLineList.SetFocus;
end;

procedure TFormConfigWorkStation.ControlParamList;
  var i: integer;
begin
  try
    ADOQueryControlParamList.SQL.Clear;
    ADOQueryControlParamList.SQL.Add('SELECT * FROM ControlParam WHERE L_Code=' +
                    IntToStr(CodeLine) + ' ORDER BY Cp_Code');  //было ORDER BY NUM
    ADOQueryControlParamList.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[ControlParamList]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryControlParamList.SQL.Text +'"'),
                               PChar(FormConfigWorkStation.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;

  with DBGridControlParamList do
    begin
      for i := 0 to 2 do
        Columns[i].Title.Alignment:= taCenter;
      for i := 3 to 11 do
        Columns[i].Visible:= false; //скрываем колонки
    end;

  DBGridControlParamList.Enabled:= boolean(DBGridControlParamList.DataSource.DataSet.RecordCount);
end;

procedure TFormConfigWorkStation.EditCodKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label2.Caption, 1 ,Length(Label2.Caption)-1) + '"', Key);
end;

procedure TFormConfigWorkStation.EditUmaxNullKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckSignFloatPressKey('"Максимальное значение нуля"', EditUmaxNull.Text, Key);
end;

procedure TFormConfigWorkStation.EditUminNullKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckSignFloatPressKey('"Минимальное значение нуля"', EditUminNull.Text, Key);
end;

procedure TFormConfigWorkStation.EditValDisp1KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckSignFloatPressKey('"Критерий ' + Label7.Caption + '"', EditValDisp1.Text, Key);
end;

procedure TFormConfigWorkStation.EditValDisp2KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckSignFloatPressKey('"Критерий ' + Label10.Caption + '"', EditValDisp2.Text, Key);
end;

procedure TFormConfigWorkStation.EditValDisp3KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckSignFloatPressKey('"Критерий ' + Label11.Caption + '"', EditValDisp3.Text, Key);
end;

procedure TFormConfigWorkStation.EditValDisp4KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckSignFloatPressKey('"Критерий ' + Label12.Caption + '"', EditValDisp4.Text, Key);
end;

procedure TFormConfigWorkStation.EditValDisp5KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckSignFloatPressKey('"Критерий ' + Label13.Caption + '"', EditValDisp5.Text, Key);
end;

procedure TFormConfigWorkStation.EditValDisp6KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckSignFloatPressKey('"Критерий ' + Label14.Caption + '"', EditValDisp6.Text, Key);
end;

procedure TFormConfigWorkStation.EditValDisp7KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckSignFloatPressKey('"Критерий ' + Label15.Caption + '"', EditValDisp7.Text, Key);
end;

procedure TFormConfigWorkStation.EquipmentList;
  var i: integer;
begin
  try
    ADOQueryEquipmentList.SQL.Clear;
    ADOQueryEquipmentList.SQL.Add('SELECT * FROM Measurer WHERE L_Code = ' + IntToStr(CodeLine) + ' ORDER BY MS_Status');
    ADOQueryEquipmentList.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[EquipmentList]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryEquipmentList.SQL.Text +'"'),
                               PChar(FormConfigWorkStation.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;

  with DBGridEquipmentList do
    begin
      for i := 0 to 1 do
        Columns[i].Title.Alignment:= taCenter;
      for i := 2 to 6 do
        Columns[i].Visible:= false; //скрываем колонки
    end;

  DBGridEquipmentList.Enabled:= boolean(DBGridEquipmentList.DataSource.DataSet.RecordCount);
end;

procedure TFormConfigWorkStation.ADOQueryLineBeforeScroll(DataSet: TDataSet);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormConfigWorkStation.BitBtnInfoClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  FormViewEquipment.ShowModal;
end;

function TFormConfigWorkStation.CheckCoeff: boolean;
begin
  result:= false;
  if DM.QueryWorkStation('SELECT Cf_Code, Cf_Name FROM cf',
       FormConfigWorkStation.Caption, 'CheckCoeff', true) then
    if not DM.ADOQueryWorkStationMDB.EOF then result:= true;
end;

function TFormConfigWorkStation.CheckEquipment: boolean;
begin
  result:= false;
  if DM.QueryWorkStation('SELECT Ms_Code,Ms_Name,Ms_Status FROM measurer WHERE L_Code = ' +
    IntToStr(CodeLine) + ' AND Ms_Status <> 3 AND Ms_Status <> 5 ORDER BY Num',
    FormConfigWorkStation.Caption, 'CheckEquipment', true) then
        if not DM.ADOQueryWorkStationMDB.EOF then result:= true;
end;

function TFormConfigWorkStation.CheckTypeOre: boolean;
begin
  result:= false;
  if DM.QueryServer('SELECT * FROM TypeOre', FormConfigWorkStation.Caption, 'CheckTypeOre', true) then
        if not DM.ADOQueryServerMDB.EOF then result:= true;
end;

procedure TFormConfigWorkStation.BitBtnAddControlParamClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if CodeLine = 0 then
    begin
//      'Сначала заполните все поля кроме таблиц "Оборудование" и "Контролируемые параметры". ' +
//                 'Затем нажмите кнопку "Применить", чтобы параметры сохранились в базу под новой записью.' +
//                 ' И после этого, уже к новой записи, можете добавлять контролируемые параметры.'

      MessageBox(handle, PChar('Невозможно добавить контролируемый параметр.' + #10#13 +
        'Параметры конвейера не сохранены в базе данных. Необходимо заполнить все поля, ' +
        'кроме таблиц "Оборудование" и "Контролируемые параметры", нажать кнопку "Применить" ' +
        '(параметры конвейера сохранятся в базе данных), затем добавьте контролируемый параметр.'),
        PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'), MB_ICONWARNING + MB_OK);
      exit;
    end;
  if not CheckCoeff then
    begin
      Application.MessageBox(PChar('Не назначены коэффициенты.' + #10#13 +
        'Добавьте и(или) настройте правильно коэффициенты: "Рабочая станция" -> "Справочник" -> "Коэффициенты"' + #10#13 +
        'Настроить коэффициенты может только пользователь с правами администратора.'),
        PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'), MB_OK + MB_ICONWARNING);
      exit;
    end;

  if not CheckEquipment then
    begin
      Application.MessageBox(PChar('Не найдено ни одного оборудования.' + #10#13 +
        'Добавьте и(или) настройте правильно оборудование: "Рабочая станция" -> "Конфигурация рабочей станции" -> "Оборудование"'),
        PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'), MB_OK + MB_ICONWARNING);
      exit;
    end;

  if not CheckTypeOre then
    begin
      Application.MessageBox(PChar('Не найдено ни одного наименования руды.' + #10#13 +
        'Заполните список руд: "Рабочая станция" -> "Справочник" -> "Список типов руд"'),
        PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'), MB_OK + MB_ICONWARNING);
      exit;
    end;

  FormDlgLink.Caption:= ProgName_ShortStringVersion + ' Привязка контролируемого параметра';
  FormDlgLink.Tag:= 0;
  FormDlgLink.ShowModal;
  if DBGridControlParamList.Enabled then DBGridControlParamList.SetFocus;
end;

procedure TFormConfigWorkStation.BitBtnAddEquipmentClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if CodeLine = 0 then
    begin
//      'Сначала заполните все поля кроме таблиц "Оборудование" и "Контролируемые параметры". ' +
//                 'Затем нажмите кнопку "Применить", чтобы параметры сохранились в базу под новой записью.' +
//                 ' И после этого, уже к новой записи, можете добавлять оборудование.'
      MessageBox(handle, PChar('Невозможно добавить оборудование.' + #10#13 +
        'Параметры конвейера не сохранены в базе данных. Необходимо заполнить все поля, ' +
        'кроме таблиц "Оборудование" и "Контролируемые параметры", нажать кнопку "Применить" ' +
        '(параметры конвейера сохранятся в базе данных), затем добавьте оборудование.'),
          PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'), MB_ICONWARNING + MB_OK);
      exit;
    end;

  FormDlgConnect.Caption:= ProgName_ShortStringVersion + ' Подключение оборудования';
  FormDlgConnect.Tag:= 0;
  FormDlgConnect.ShowModal;
  if DBGridEquipmentList.Enabled then DBGridEquipmentList.SetFocus;
end;

procedure TFormConfigWorkStation.BitBtnDelControlParamClick(Sender: TObject);
begin
  if DBGridControlParamList.DataSource.DataSet.RecordCount = 0 then exit;
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Удалить контролируемый параметр "' +
                                  DBGridControlParamList.DataSource.DataSet.FieldByName('Cp_Name').AsString +
                                  '" из списка?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if not DM.QueryServer('DELETE FROM ControlParam WHERE Cp_Code = ' +
                            DBGridControlParamList.DataSource.DataSet.FieldByName('Cp_Code').AsString,
                            FormConfigWorkStation.Caption, 'BitBtnDelControlParamClick', false) then exit;

      if not DM.QueryWorkStation('DELETE FROM Link WHERE Cp_Code = ' +
                                 DBGridControlParamList.DataSource.DataSet.FieldByName('Cp_Code').AsString,
                                  FormConfigWorkStation.Caption, 'BitBtnDelControlParamClick', false) then exit;

      if not DM.QueryAccess('DELETE FROM Access WHERE Cp_Code = ' +
                            DBGridControlParamList.DataSource.DataSet.FieldByName('Cp_Code').AsString,
                            FormConfigWorkStation.Caption, 'BitBtnDelControlParamClick', false) then exit;

      ControlParamList;
      ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
    end;
  if DBGridControlParamList.Enabled then DBGridControlParamList.SetFocus;
end;

procedure TFormConfigWorkStation.BitBtnDelEquipmentClick(Sender: TObject);
begin
  if DBGridEquipmentList.DataSource.DataSet.RecordCount = 0 then exit;
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Удалить оборудование "' +
                                  DBGridEquipmentList.DataSource.DataSet.FieldByName('Ms_Name').AsString +
                                  '" из списка?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      //удаляем привязку весов к расчету
      if not DM.QueryWorkStation('DELETE FROM LinkW WHERE Ms_Code_MB = ' +
                                  DBGridEquipmentList.DataSource.DataSet.FieldByName('Ms_Code').AsString +
                                  ' OR Ms_Code_W = ' +
                                  DBGridEquipmentList.DataSource.DataSet.FieldByName('Ms_Code').AsString,
                                  FormConfigWorkStation.Caption, 'BitBtnDelEquipmentClick', false) then exit;

      //удаляем привязку входов АЦП
      if not DM.QueryWorkStation('DELETE FROM Points WHERE Ms_Code = ' +
                                  DBGridEquipmentList.DataSource.DataSet.FieldByName('Ms_Code').AsString,
                                  FormConfigWorkStation.Caption, 'BitBtnDelEquipmentClick', false) then exit;

      //удаляем привязку контролируемых параметров с измерительным оборудованием
      if not DM.QueryWorkStation('DELETE FROM Link WHERE Ms_Code = ' +
                                  DBGridEquipmentList.DataSource.DataSet.FieldByName('Ms_Code').AsString,
                                  FormConfigWorkStation.Caption, 'BitBtnDelEquipmentClick', false) then exit;

      //удаляем привязку установленного на конвейере оборудования
      if not DM.QueryWorkStation('DELETE FROM Measurer WHERE Ms_Code = ' +
                                  DBGridEquipmentList.DataSource.DataSet.FieldByName('Ms_Code').AsString,
                                  FormConfigWorkStation.Caption, 'BitBtnDelEquipmentClick', false) then exit;

      EquipmentList;
      ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
    end;
  if DBGridEquipmentList.Enabled then DBGridEquipmentList.SetFocus;
end;

procedure TFormConfigWorkStation.BitBtnEditControlParamClick(Sender: TObject);
begin
  if DBGridControlParamList.DataSource.DataSet.RecordCount = 0 then exit;
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  FormDlgLink.Caption:= ProgName_ShortStringVersion + ' Изменение настроек контролируемого параметра';
  FormDlgLink.Tag:= DBGridControlParamList.DataSource.DataSet.FieldByName('Cp_Code').AsInteger;
  FormDlgLink.ShowModal;
  DBGridControlParamList.SetFocus;
end;

procedure TFormConfigWorkStation.BitBtnEditEquipmentClick(Sender: TObject);
begin
  if DBGridEquipmentList.DataSource.DataSet.RecordCount = 0 then exit;
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  FormDlgConnect.Caption:= ProgName_ShortStringVersion + ' Изменение настроек подключенного оборудования';
  FormDlgConnect.Tag:= DBGridEquipmentList.DataSource.DataSet.FieldByName('Ms_Code').AsInteger;
  FormDlgConnect.ShowModal;
  DBGridEquipmentList.SetFocus;
end;

procedure TFormConfigWorkStation.ButtonCancelClick(Sender: TObject);
begin
  UpdateLineList(true);
end;

procedure TFormConfigWorkStation.ButtonCloseClick(Sender: TObject);
begin
  FormConfigWorkStation.Close;
end;

procedure TFormConfigWorkStation.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

function TFormConfigWorkStation.SaveDataInBD: boolean;
  var sOptRun, sD_Code, TextSQL, NameMB5: string;
      CalcDisp, i: integer;
      TransferParamConfig: TTransferParamConfig; //для передачи во внешнию программу значение сигналов
      UminNull, UmaxNull: double;

begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  result:= true;
  if Application.MessageBox(PChar('Сохранить значения для конвейера: "' +
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
          result:= false;
          exit;
        end;

      if ComboBoxRegimeName.ItemIndex < 0 then
        begin
          Application.MessageBox(PChar('Не выбран режим работы.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          ComboBoxRegimeName.SetFocus;
          result:= false;
          exit;
        end;

      if ComboBoxTypeOre.ItemIndex < 0 then
        begin
          Application.MessageBox(PChar('Не выбран текущий тип руды.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          ComboBoxTypeOre.SetFocus;
          result:= false;
          exit;
        end;

      try
        StrToFloat(EditValDisp1.Text);
      except
        Application.MessageBox(PChar('Некорректные данные критерия D1.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
        EditValDisp1.SetFocus;
        result:= false;
        exit;
      end;

      try
        StrToFloat(EditValDisp2.Text);
      except
        Application.MessageBox(PChar('Некорректные данные критерия D2.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
        EditValDisp2.SetFocus;
        result:= false;
        exit;
      end;

      try
        StrToFloat(EditValDisp3.Text);
      except
        Application.MessageBox(PChar('Некорректные данные критерия D3.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
        EditValDisp3.SetFocus;
        result:= false;
        exit;
      end;

      try
        StrToFloat(EditValDisp4.Text);
      except
        Application.MessageBox(PChar('Некорректные данные критерия D4.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
        EditValDisp4.SetFocus;
        result:= false;
        exit;
      end;

      try
        StrToFloat(EditValDisp5.Text);
      except
        Application.MessageBox(PChar('Некорректные данные критерия D5.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
        EditValDisp5.SetFocus;
        result:= false;
        exit;
      end;

      try
        StrToFloat(EditValDisp6.Text);
      except
        Application.MessageBox(PChar('Некорректные данные критерия D6.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
        EditValDisp6.SetFocus;
        result:= false;
        exit;
      end;

      try
        StrToFloat(EditValDisp7.Text);
      except
        Application.MessageBox(PChar('Некорректные данные критерия D7.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
        EditValDisp7.SetFocus;
        result:= false;
        exit;
      end;

      try
        StrToFloat(EditUminNull.Text);
      except
        Application.MessageBox(PChar('Некорректные данные минимального значения нуля.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
        EditUminNull.SetFocus;
        result:= false;
        exit;
      end;

      try
        StrToFloat(EditUmaxNull.Text);
      except
        Application.MessageBox(PChar('Некорректные данные максимального значения нуля.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
        EditUmaxNull.SetFocus;
        result:= false;
        exit;
      end;

      UminNull:= StrToFloat(EditUminNull.Text);
      UmaxNull:= StrToFloat(EditUmaxNull.Text);

      if (UminNull < 0) or (UminNull > 10) then
        begin
          Application.MessageBox(PChar('Некорректные данные минимального значения нуля.' + #10#13 +
            'Значение должно быть в диапазоне от 0 до 10.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditUminNull.SetFocus;
          result:= false;
          exit;
        end;

      if (UmaxNull < 0) or (UmaxNull > 10) then
        begin
          Application.MessageBox(PChar('Некорректные данные максимального значения нуля.' + #10#13 +
            'Значение должно быть в диапазоне от 0 до 10.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditUmaxNull.SetFocus;
          result:= false;
          exit;
        end;

      if UminNull >= UmaxNull then
        begin
          Application.MessageBox(PChar('Некорректные данные минимального и/или максимального значений нуля.' + #10#13 +
            'Минимальное значение нуля должно быть меньше максимального значения нуля.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditUminNull.SetFocus;
          result:= false;
          exit;
        end;


      sOptRun:= '0';     //RadioButtonInstantaneous.Checked
      if RadioButtonMinute.Checked then sOptRun:= '1';
      if RadioButtonHour.Checked then sOptRun:= '2';

      CalcDisp:= 0;
      if CheckBoxSignal1.Checked           then CalcDisp:= DM.BitOn(CalcDisp, 0);
      if CheckBoxSignal2.Checked           then CalcDisp:= DM.BitOn(CalcDisp, 1);
      if CheckBoxSignalWithWeights.Checked then CalcDisp:= DM.BitOn(CalcDisp, 2);
      if CheckBoxRefNull.Checked           then CalcDisp:= DM.BitOn(CalcDisp, 3);
      if CheckBoxWeightNull.Checked        then CalcDisp:= DM.BitOn(CalcDisp, 4);

      if CodeLine = 0 then   //новая запись
        begin
          if not DM.QueryWorkStation('SELECT D_Code FROM ParamStation',
                                  FormConfigWorkStation.Caption, 'SaveDataInBD', true) then exit;

          try
            sD_Code:= DM.ADOQueryWorkStationMDB.FieldByName('D_Code').AsString;
          except
            on e: Exception do
              begin
                MessageBox(handle, PChar(e.Message + #13#10 + '"ADOQueryWorkStationMDB.FieldByName..."'),
                           PChar(FormConfigWorkStation.Caption), MB_ICONERROR+MB_OK);
                Exit;
              end;
          end;

          if not DM.QueryServer('INSERT INTO Lines (L_Name, L_CodeLine, D_Code, [Connect], R_Code) VALUES (''' +
                                Trim(EditName.Text) + ''', ''' +
                                EditCod.Text + ''', ''' +
                                sD_Code + ''', true, ''' +
                                IntToStr(integer(ComboBoxRegimeName.Items.Objects[ComboBoxRegimeName.ItemIndex])) + ''')',
                                FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;

          if not DM.QueryServer('SELECT MAX(L_Code) as lCode FROM Lines',
                                FormConfigWorkStation.Caption, 'SaveDataInBD', true) then exit;

          try
            CodeLine:= DM.ADOQueryServerMDB.FieldByName('lCode').AsInteger;
          except
            on e: Exception do
              begin
                MessageBox(handle, PChar(e.Message + #13#10 + '"ADOQueryServerMDB.FieldByName..."'),
                           PChar(FormConfigWorkStation.Caption), MB_ICONERROR+MB_OK);
                Exit;
              end;
          end;

          if not DM.QueryWorkStation('INSERT INTO ParamLines ([L_Code], [View], [SetNull], ' +
                                     '[ValDisp1], [ValDisp2], [ValDisp3], [ValDisp4], [ValDisp5], ' +
                                     '[ValDisp6], [ValDisp7], [UminNull], [UmaxNull], [ColorBack], ' +
                                     '[SizeCadr], [CalcDisp], [Flag], [Start], [Sel], [T_Code], [DateBeginStart]) VALUES (''' +
                                IntToStr(CodeLine) + ''', ''' +
                                sOptRun + ''', ' +
                                booltostr(CheckBoxNull.Checked, true) + ', ''' +
                                EditValDisp1.Text + ''', ''' +
                                EditValDisp2.Text + ''', ''' +
                                EditValDisp3.Text + ''', ''' +
                                EditValDisp4.Text + ''', ''' +
                                EditValDisp5.Text + ''', ''' +
                                EditValDisp6.Text + ''', ''' +
                                EditValDisp7.Text + ''', ''' +
                                EditUminNull.Text + ''', ''' +
                                EditUmaxNull.Text + ''', ''' +
                                IntToStr(PanelColorBack.Color) + ''', ''' +
                                IntToStr(SpinEditSizeHour.Value) + ''', ''' +
                                IntToStr(CalcDisp) + ''', ' +
                                booltostr(CheckBoxEEPROM.Checked, true) + ', ' +
                                booltostr(CheckBoxStart.Checked, true) + ', ' +
                                booltostr(CheckBoxSelect.Checked, true) + ', ''' +
                                IntToStr(integer(ComboBoxTypeOre.Items.Objects[ComboBoxTypeOre.ItemIndex])) + ''', ''' +
                                FormatDateTime('dd.mm.yyyy hh:nn:ss', DateBeginStart) + ''')',
                                FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;

          TextSQL:= IntToStr(CodeLine) + ' (C_Code COUNTER PRIMARY KEY,' +
                                      'L_Code long,' +
                                      'C_Yes BIT,' +
                                      'C_Date DATETIME,' +
                                      'Run BIT,Move BIT,' +
                                      '1 DOUBLE NULL,' +
                                      '2 DOUBLE NULL,' +
                                      '3 DOUBLE NULL,' +
                                      '4 DOUBLE NULL,' +
                                      '5 DOUBLE NULL,' +
                                      '6 DOUBLE NULL,' +
                                      '7 DOUBLE NULL,' +
                                      '8 DOUBLE NULL,' +
                                      'ch1 BYTE,ch2 BYTE,ch3 BYTE,ch4 BYTE)';

          if not DM.QueryWorkStation('CREATE TABLE C' + TextSQL,
                                FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;

          if not DM.QueryWorkStation('CREATE TABLE CM' + TextSQL,
                                FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;

          if not DM.QueryWorkStation('CREATE TABLE CH' + TextSQL,
                                FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;

          TextSQL:= 'CREATE TABLE M' + IntToStr(CodeLine) + ' (M_Code COUNTER PRIMARY KEY,' +
                        'L_Code long,' +
                        'M_Yes BIT,' +
                        'M_Date DATETIME,' +
                        'ValDisp DOUBLE NULL,' +
                        'Run BIT,' +
                        'M_Size SMALLINT,' +
                        'G SMALLINT,' +
                        'P SMALLINT,' +
                        'DD SMALLINT,' +
                        'T_Code long,' +
                        '1 DOUBLE NULL,' +
                        '2 DOUBLE NULL,' +
                        '3 DOUBLE NULL,' +
                        '4 DOUBLE NULL,' +
                        '5 DOUBLE NULL,' +
                        '6 DOUBLE NULL,' +
                        '7 DOUBLE NULL,' +
                        '8 DOUBLE NULL,' +
                        '9 DOUBLE NULL,' +
                        '10 DOUBLE NULL,' +
                        '11 DOUBLE NULL,' +
                        '12 DOUBLE NULL)';
          if DM.ADOConnectionDataMDB.Connected then    //заносим в DATA на сервере
            if not DM.QueryData(TextSQL, FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;
          //заносим в DATA на раб. станции
          if not DM.QueryDataWS(TextSQL, FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;

          TextSQL:= 'CREATE TABLE H' + IntToStr(CodeLine) + ' (H_Code COUNTER PRIMARY KEY,' +
                        'L_Code long,' +
                        'H_Yes BIT,' +
                        'H_Date DATETIME,' +
                        'H_Size SMALLINT,' +
                        'T_Code long,' +
                        '1 DOUBLE NULL,' +
                        '2 DOUBLE NULL,' +
                        '3 DOUBLE NULL,' +
                        '4 DOUBLE NULL,' +
                        '5 DOUBLE NULL,' +
                        '6 DOUBLE NULL,' +
                        '7 DOUBLE NULL,' +
                        '8 DOUBLE NULL,' +
                        '9 DOUBLE NULL,' +
                        '10 DOUBLE NULL,' +
                        '11 DOUBLE NULL,' +
                        '12 DOUBLE NULL)';
          if DM.ADOConnectionDataMDB.Connected then    //заносим в DATA на сервере
            if not DM.QueryData(TextSQL, FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;
          //заносим в DATA на раб. станции
          if not DM.QueryDataWS(TextSQL, FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;

          TextSQL:= 'CREATE TABLE W' + IntToStr(CodeLine) + ' (W_Code COUNTER PRIMARY KEY, ' +
                        'L_Code long, ' +
                        'W_Date DATETIME, ' +
                        'W_ValueCh long)';
          if DM.ADOConnectionDataMDB.Connected then    //заносим в DATA на сервере
            if not DM.QueryData(TextSQL, FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;
          //заносим в DATA на раб. станции
          if not DM.QueryDataWS(TextSQL, FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;
        end
        else begin          //запись уже существует
          if not DM.QueryServer('UPDATE Lines SET L_Name = ''' + Trim(EditName.Text) +
                ''', L_CodeLine = ''' + EditCod.Text +
                ''', R_Code = ''' + IntToStr(integer(ComboBoxRegimeName.Items.Objects[ComboBoxRegimeName.ItemIndex])) +
                ''' WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;

          if not DM.QueryWorkStation('UPDATE ParamLines SET [View] = ''' + sOptRun +
                     ''', SetNull = ' + booltostr(CheckBoxNull.Checked, true) +
                     ', ValDisp1 = ''' + EditValDisp1.Text +
                     ''', ValDisp2 = ''' + EditValDisp2.Text +
                     ''', ValDisp3 = ''' + EditValDisp3.Text +
                     ''', ValDisp4 = ''' + EditValDisp4.Text +
                     ''', ValDisp5 = ''' + EditValDisp5.Text +
                     ''', ValDisp6 = ''' + EditValDisp6.Text +
                     ''', ValDisp7 = ''' + EditValDisp7.Text +
                     ''', UminNull = ''' + EditUminNull.Text +
                     ''', UmaxNull = ''' + EditUmaxNull.Text +
                     ''', ColorBack = ''' + IntToStr(PanelColorBack.Color) +
                     ''', SizeCadr = ''' + IntToStr(SpinEditSizeHour.Value) +
                     ''', CalcDisp = ''' + IntToStr(CalcDisp) +
                     ''', Flag = ' + booltostr(CheckBoxEEPROM.Checked, true) +
                     ', Start = ' + booltostr(CheckBoxStart.Checked, true) + //sStart +
                     ', Sel = ' + booltostr(CheckBoxSelect.Checked, true) +
                     ', T_Code = ''' + IntToStr(integer(ComboBoxTypeOre.Items.Objects[ComboBoxTypeOre.ItemIndex])) +
                     ''', DateBeginStart = ''' + FormatDateTime('dd.mm.yyyy hh:nn:ss', DateBeginStart) +
                     ''' WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SaveDataInBD', false) then exit;

          //контроль подключения весов к МВ5
          if FormDlgConnect.CheckLinkWeigher(CodeLine, NameMB5) = 3 then
            begin
              Application.MessageBox(PChar('Нет подключенных весов к ' + NameMB5 + #10#13 +
                'Подключите весы. Установите курсор в таблице "Оборудование" на устройство ' + NameMB5 +
                ', нажмите редактировать и выберите нужные весы в списке "Использовать весы".'),
                PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'), MB_OK + MB_ICONERROR);
              result:= false;
              exit;
            end;

          //передаем окнам иформационных сигналов новые значения настроек
          TransferParamConfig.L_Code:= CodeLine;
          TransferParamConfig._Date:= now;
          TransferParamConfig.Start:= CheckBoxStart.Checked;
          SendCMD(CMD_CONFIG, @TransferParamConfig);
        end;
      try
//        DataSourceLine.DataSet.First;
//        while not DataSourceLine.DataSet.Eof do
//          begin
//            DM.QueryWorkStation('UPDATE ParamLines SET [Connect] = ' +
//                booltostr(DataSourceLine.DataSet.FieldByName('Connect').AsBoolean, true) +
//                ' WHERE L_Code = ' + DataSourceLine.DataSet.FieldByName('L_Code').AsString,
//                FormConfigWorkStation.Caption, 'SaveDataInBD', false);
//            DataSourceLine.DataSet.Next;
//          end;

        if DM.QueryServer('SELECT [Connect] as con FROM Lines WHERE L_Code = ' + IntToStr(CodeLine),
            FormConfigWorkStation.Caption, 'SaveDataInBD', true) then
              DM.QueryWorkStation('UPDATE ParamLines SET [Connect] = ' +
                booltostr(DM.ADOQueryServerMDB.FieldByName('con').AsBoolean, true) + ' WHERE L_Code = ' + IntToStr(CodeLine),
                FormConfigWorkStation.Caption, 'SaveDataInBD', false);
      finally

      end;
      if RebootMonitor then DM.RebootMonitor();
    end;
  ProcedureChangeData(false, false);
  RebootMonitor:= false; //делаем принудительно, т.к. если до этого был в true, то через процедуру ProcedureChangeData false установить нельзя
  UpdateLineList(true);
end;

procedure TFormConfigWorkStation.SpeedButtonAddClick(Sender: TObject);
  var s: string;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  s:= '';
  if not DM.QueryWorkStation('SELECT D_Code FROM ParamStation',
                                  FormConfigWorkStation.Caption, 'SaveDataInBD', true) then exit;
  try
    if (not CheckNumeric(DM.ADOQueryWorkStationMDB.FieldByName('D_Code').AsString)) or
       (DM.ADOQueryWorkStationMDB.FieldByName('D_Code').AsInteger = 0)
     then s:= s + 'Отсутсвуют данные по рабочей станции. Заполните данные по рабочей станции: ' +
                  '"Рабочая станция" -> "Настройка рабочих станций"' + #10#13;
  except
    on e: Exception do
      begin
        MessageBox(handle, PChar(e.Message + #13#10 + 'SpeedButtonAddClick'),
                           PChar(FormConfigWorkStation.Caption), MB_ICONERROR+MB_OK);
        Exit;
      end;
  end;

  if ComboBoxRegimeName.Items.Count = 0 then
    s:= s + 'Отсутсвуют данных о режимах работы предприятия. Заполните данные о режимах работы предприятия: ' +
        '"Рабочая станция" -> "Справочник" -> "Режимы работы предприятия".' + #10#13;

  if ComboBoxTypeOre.Items.Count = 0 then
    s:= s + 'Отсутсвуют данных о типах руд. Заполните данные по типам руд: ' +
            '"Рабочая станция" -> "Справочник" -> "Список типов руд".';

  if s <> '' then
    begin
      MessageBox(handle, PChar(s + #10#13 + 'Затем добавьте новый конвейер.'),
        PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'), MB_ICONWARNING + MB_OK);
      exit;
    end;

  if ChangeData then SaveDataInBD;

  EnabledDisabled(true);     //именно здесь, чтобы не дать доступ к кнопке удалить запись
  SpeedButtonDelete.Enabled:= false;
  SpeedButtonAdd.Enabled:= false;
  DBGridLineList.Enabled:= false;
  FormConfigWorkStation.Color:= ColorEdit;
  ClearAllData;
  EditName.SetFocus;
end;

//удалить конвейер
procedure TFormConfigWorkStation.SpeedButtonDeleteClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Удалить запись: "' +
                                  EditName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if not DM.QueryServer('DELETE FROM Lines WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;
      if not DM.QueryWorkStation('DELETE FROM ParamLines WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;

      if not DM.QueryTempWorkStation('SELECT * FROM Measurer WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', true) then exit;

      while not DM.ADOQueryTempWS.Eof do
        begin
          if not DM.QueryWorkStation('DELETE FROM Points WHERE Ms_Code = ' + DM.ADOQueryTempWS.FieldByName('Ms_Code').AsString,
                                      FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;
          if not DM.QueryWorkStation('DELETE FROM LinkW WHERE Ms_Code_MB = ' +
                                      DM.ADOQueryTempWS.FieldByName('Ms_Code').AsString +
                                      ' OR Ms_Code_W = ' +
                                      DM.ADOQueryTempWS.FieldByName('Ms_Code').AsString,
                                      FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;
          DM.ADOQueryTempWS.Next;
        end;

      if not DM.QueryWorkStation('DELETE FROM Measurer WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;
      if not DM.QueryWorkStation('DELETE FROM Link WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;
      if not DM.QueryTempWorkStation('SELECT * FROM Jornal WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', true) then exit;

      while not DM.ADOQueryTempWS.Eof do
        begin
          if not DM.QueryWorkStation('DELETE FROM SpJornal WHERE J_Code = ' +
                                      DM.ADOQueryTempWS.FieldByName('J_Code').AsString,
                                      FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;
          DM.ADOQueryTempWS.Next;
        end;

      if not DM.QueryWorkStation('DELETE FROM Jornal WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;
      if not DM.QueryWorkStation('DELETE FROM ShowSignal WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;

      //удаляем таблицы
      DM.QueryWorkStation('DROP TABLE C' + IntToStr(CodeLine), FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false);
      DM.QueryWorkStation('DROP TABLE CM' + IntToStr(CodeLine), FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false);
      DM.QueryWorkStation('DROP TABLE CH' + IntToStr(CodeLine), FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false);

      if DM.ADOConnectionDataMDB.Connected then
        begin
          DM.QueryData('DROP TABLE M' + IntToStr(CodeLine), FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false);
          DM.QueryData('DROP TABLE H' + IntToStr(CodeLine), FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false);
          DM.QueryData('DROP TABLE W' + IntToStr(CodeLine),FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false);
        end;
      DM.QueryDataWS('DROP TABLE M' + IntToStr(CodeLine), FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false);
      DM.QueryDataWS('DROP TABLE H' + IntToStr(CodeLine), FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false);
      DM.QueryDataWS('DROP TABLE W' + IntToStr(CodeLine), FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false);

      if not DM.QueryServer('SELECT Cp_Code FROM ControlParam WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', true) then exit;
      DM.ADOQueryServerMDB.First;
      while not DM.ADOQueryServerMDB.EOF do
        begin
          if not DM.QueryWorkStation('DELETE FROM LinkTO WHERE Cp_Code = ' +
                                      DM.ADOQueryServerMDB.FieldByName('Cp_Code').AsString,
                                      FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;
          DM.ADOQueryServerMDB.Next;
        end;

      if not DM.QueryServer('DELETE FROM ControlParam WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;
      if not DM.QueryAccess('DELETE FROM Access WHERE L_Code = ' + IntToStr(CodeLine),
                                FormConfigWorkStation.Caption, 'SpeedButtonDeleteClick', false) then exit;
      UpdateLineList(false);
      ProcedureChangeData(true, false);
    end;
end;

procedure TFormConfigWorkStation.SpinEditSizeHourChange(Sender: TObject);
begin
  ProcedureChangeData(false, true);  //не перезагружать монитор, т.к. данные не косаются его работы
end;

procedure TFormConfigWorkStation.SpinEditSizeHourKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(false, true);  //не перезагружать монитор, т.к. данные не косаются его работы
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label8.Caption, 1 ,Length(Label8.Caption)-1) + '"', Key);
end;

procedure TFormConfigWorkStation.CheckBoxNullClick(Sender: TObject);
begin
  if not CheckBoxNull.Checked then
    begin
      CheckBoxRefNull.Checked:= false;
      CheckBoxWeightNull.Checked:= false;
    end;
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
end;

procedure TFormConfigWorkStation.CheckBoxRefNullClick(Sender: TObject);
begin
  if CheckBoxRefNull.Checked then CheckBoxNull.Checked:= true;
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
end;

procedure TFormConfigWorkStation.CheckBoxStartClick(Sender: TObject);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
  if CheckBoxStart.Checked then
    DateBeginStart:= now;
end;

procedure TFormConfigWorkStation.CheckBoxWeightNullClick(Sender: TObject);
begin
  if CheckBoxWeightNull.Checked then CheckBoxNull.Checked:= true;
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
end;

procedure TFormConfigWorkStation.ClearAllData;
begin
  EditName.Clear;
  ComboBoxRegimeName.ItemIndex:= -1;
  EditCod.Clear;
  ComboBoxTypeOre.ItemIndex:= -1;
  CheckBoxStart.Checked:= false;
  DateBeginStart:= now;
  CheckBoxEEPROM.Checked:= false;
  CheckBoxSelect.Checked:= false;
  CheckBoxNull.Checked:= false;
  CheckBoxRefNull.Checked:= false;
  CheckBoxWeightNull.Checked:= false;
  RadioButtonInstantaneous.Checked:= true;
  CheckBoxSignal1.Checked:= false;
  CheckBoxSignal2.Checked:= false;
  CheckBoxSignalWithWeights.Checked:= false;
  SpinEditSizeHour.Value:= 0;
  PanelColorBack.Color:= clWhite;
  EditValDisp1.Clear;
  EditValDisp2.Clear;
  EditValDisp3.Clear;
  EditValDisp4.Clear;
  EditValDisp5.Clear;
  EditValDisp6.Clear;
  EditValDisp7.Clear;
  EditUminNull.Text:= Format('%.2n', [DefaultUminNull]);
  EditUmaxNull.Text:= Format('%.2n', [DefaultUmaxNull]);
  CodeLine:= -1;       //для очистки таблиц Оборудование и Контролируемые параметры
  EquipmentList;       //очищаем таблицу Оборудование
  ControlParamList;    //очищаем таблицу Контролируемые параметры
  CodeLine:= 0;
end;

procedure TFormConfigWorkStation.DBGridControlParamListCellClick(
  Column: TColumn);
var ScrPt, GrdPt: TPoint;
      Cell: TGridCoord;
begin
  ScrPt := Mouse.CursorPos;
  GrdPt := DBGridControlParamList.ScreenToClient(ScrPt);
  Cell  := DBGridControlParamList.MouseCoord(GrdPt.X, GrdPt.Y);
  if Cell.X = 1 then
    begin
      if (Column.Field.DataType = ftBoolean) then
        begin
          Column.Grid.DataSource.DataSet.Edit;
          Column.Field.Value:= not Column.Field.AsBoolean;
          Column.Grid.DataSource.DataSet.Post;
        end;
    end;
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
end;

procedure TFormConfigWorkStation.DBGridControlParamListColEnter(
  Sender: TObject);
begin
  if Self.DBGridControlParamList.SelectedField.DataType = ftBoolean then
  begin
    Self.GridOriginalOptions := Self.DBGridControlParamList.Options;
    Self.DBGridControlParamList.Options := Self.DBGridControlParamList.Options - [dgEditing];
  end;
end;

procedure TFormConfigWorkStation.DBGridControlParamListColExit(Sender: TObject);
begin
  if Self.DBGridControlParamList.SelectedField.DataType = ftBoolean then
    Self.DBGridControlParamList.Options := Self.GridOriginalOptions;
end;

procedure TFormConfigWorkStation.DBGridControlParamListDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
   CtrlState: array[Boolean] of integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED) ;
begin
  if (Column.Field.DataType=ftBoolean) then
  begin
    DBGridControlParamList.Canvas.FillRect(Rect) ;
    if (VarIsNull(Column.Field.Value)) then
      DrawFrameControl(DBGridControlParamList.Canvas.Handle,Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_INACTIVE)
    else
      DrawFrameControl(DBGridControlParamList.Canvas.Handle,Rect, DFC_BUTTON, CtrlState[Column.Field.AsBoolean]);
  end;
end;

procedure TFormConfigWorkStation.DBGridControlParamListEnter(Sender: TObject);
begin
  DBGridControlParamListColEnter(Sender);
end;

procedure TFormConfigWorkStation.DBGridEquipmentListCellClick(Column: TColumn);
var ScrPt, GrdPt: TPoint;
      Cell: TGridCoord;
begin
  ScrPt := Mouse.CursorPos;
  GrdPt := DBGridEquipmentList.ScreenToClient(ScrPt);
  Cell  := DBGridEquipmentList.MouseCoord(GrdPt.X, GrdPt.Y);
  if Cell.X = 1 then
    begin
      if (Column.Field.DataType=ftBoolean) then
        begin
          Column.Grid.DataSource.DataSet.Edit;
          Column.Field.Value:= not Column.Field.AsBoolean;
          Column.Grid.DataSource.DataSet.Post;
        end;
    end;
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
end;

procedure TFormConfigWorkStation.DBGridEquipmentListColEnter(Sender: TObject);
begin
  if Self.DBGridEquipmentList.SelectedField.DataType = ftBoolean then
  begin
    Self.GridOriginalOptions := Self.DBGridEquipmentList.Options;
    Self.DBGridEquipmentList.Options := Self.DBGridEquipmentList.Options - [dgEditing];
  end;
end;

procedure TFormConfigWorkStation.DBGridEquipmentListColExit(Sender: TObject);
begin
  if Self.DBGridEquipmentList.SelectedField.DataType = ftBoolean then
    Self.DBGridEquipmentList.Options := Self.GridOriginalOptions;
end;

procedure TFormConfigWorkStation.DBGridEquipmentListDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
   CtrlState: array[Boolean] of integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED) ;
begin
  if (Column.Field.DataType=ftBoolean) then
  begin
    DBGridEquipmentList.Canvas.FillRect(Rect) ;
    if (VarIsNull(Column.Field.Value)) then
      DrawFrameControl(DBGridEquipmentList.Canvas.Handle,Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_INACTIVE)
    else
      DrawFrameControl(DBGridEquipmentList.Canvas.Handle,Rect, DFC_BUTTON, CtrlState[Column.Field.AsBoolean]);
  end;
end;

procedure TFormConfigWorkStation.DBGridEquipmentListEnter(Sender: TObject);
begin
  DBGridEquipmentListColEnter(Sender);
end;

procedure TFormConfigWorkStation.DBGridLineListCellClick(Column: TColumn);
  var ScrPt, GrdPt: TPoint;
      Cell: TGridCoord;
begin
  ScrPt := Mouse.CursorPos;
  GrdPt := DBGridLineList.ScreenToClient(ScrPt);
  Cell  := DBGridLineList.MouseCoord(GrdPt.X, GrdPt.Y);
  if Cell.X = 1 then
    begin
      if (Column.Field.DataType=ftBoolean) then
        begin
          Column.Grid.DataSource.DataSet.Edit;
          Column.Field.Value:= not Column.Field.AsBoolean;
          Column.Grid.DataSource.DataSet.Post;
          ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
        end;
    end;
end;

procedure TFormConfigWorkStation.DBGridLineListColEnter(Sender: TObject);
begin
  if Self.DBGridLineList.SelectedField.DataType = ftBoolean then
    begin
      Self.GridOriginalOptions := Self.DBGridLineList.Options;
      Self.DBGridLineList.Options := Self.DBGridLineList.Options - [dgEditing];
    end;
end;

procedure TFormConfigWorkStation.DBGridLineListColExit(Sender: TObject);
begin
  if Self.DBGridLineList.SelectedField.DataType = ftBoolean then
    Self.DBGridLineList.Options := Self.GridOriginalOptions;
end;

procedure TFormConfigWorkStation.DBGridLineListDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
const
   CtrlState: array[Boolean] of integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED) ;
begin
  if (Column.Field.DataType = ftBoolean) then
  begin
    DBGridLineList.Canvas.FillRect(Rect) ;
    if (VarIsNull(Column.Field.Value)) then
      DrawFrameControl(DBGridLineList.Canvas.Handle,Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_INACTIVE)
    else
      DrawFrameControl(DBGridLineList.Canvas.Handle,Rect, DFC_BUTTON, CtrlState[Column.Field.AsBoolean]);
  end;
end;

procedure TFormConfigWorkStation.DBGridLineListEnter(Sender: TObject);
begin
  DBGridLineListColEnter(Sender);
end;

procedure TFormConfigWorkStation.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ChangeData then CanClose:= SaveDataInBD;
  UpdateLineList(false);
  ReNum;
end;

procedure TFormConfigWorkStation.FormCreate(Sender: TObject);
begin
  FormConfigWorkStation.Caption:= ProgName_ShortStringVersion + FormConfigWorkStation.Caption;
  EditValDisp1.Hint:= 'D1 - величина резкого скачка значения' + #10#13 +
                      'информационного сигнала (опрос забраковывается)';
  EditValDisp2.Hint:= 'D2 - порог дисперсии выше, которого' + #10#13 +
                      'конвейер движется, ниже - стоит';
  EditValDisp3.Hint:= 'D3 - средний за минуту инф. сигнал с весов' + #10#13 +
                      '(с вычетом нуля, если задан), выше которого' + #10#13 +
                      'считать, что вес есть';
  EditValDisp4.Hint:= 'D4 - минимальный инф. сигнал без вычета нуля,' + #10#13 +
                      'меньше которого считать неисправность';
  EditValDisp5.Hint:= 'D5 - разность между текущим значением и нулевым,' + #10#13 +
                      'ниже которого, считать сигнал близким к нулю';
  EditValDisp6.Hint:= 'D6 - ср. за минуту инф. сигнал с весов (с выч. нуля,' + #10#13 +
                      'если задан), ниже которого - зона недостаточной для' + #13#10 +
                      'расчета контролируемых параметров нагрузки';
  EditValDisp7.Hint:= 'D7 - дисперсия за минуту,' + #10#13 +
                      'выше которой железо не считать';
  DBGridLineList.Columns[1].Width:= DBGridLineList.Width -
                                    DBGridLineList.Columns[0].Width -
                                    DBGridLineList.Columns[2].Width -
                                    40 {ширина полосы вертикальной прокрутки};
end;

procedure TFormConfigWorkStation.FormShow(Sender: TObject);
begin
  CheckBoxStart.OnClick:= nil;    //чтобы не срабатывало событие
  ClearAllData;
  ChangeData:= false; //т.к. после ClearAllData  ChangeData = true
  LineList;
  CheckBoxStart.OnClick:= CheckBoxStartClick; //подключаем событие

  CheckBoxSelect.Hint:= 'Включить для автоматического обновления данных в' + #10#13 +
                        'программе RudaClient для ручной корректировке нулей';
  CheckBoxSelect.ShowHint:= true;
  DBGridLineList.SetFocus;
end;

procedure TFormConfigWorkStation.LineList;
  var D_Code: string;
      i: integer;
     DataSet: TDataSet;
begin
  with DBGridLineList do
    begin
      for i := 0 to 2 do
        Columns[i].Title.Alignment:= taCenter;
      for i := 3 to 6 do
        Columns[i].Visible:= false; //скрываем колонки
    end;

  ADOQueryLineAfterScroll(DataSet);   //сюда ставим т.к. здесь необходимо, если еще ничего нет чтобы получить режим работы и тип руды

  if not DM.QueryWorkStation('SELECT D_Code FROM ParamStation',
                                  FormConfigWorkStation.Caption, 'LineList', true) then exit;

  if DM.DataSourceWorkStationMDB.DataSet.RecordCount = 0 then exit;
  D_Code:= DM.ADOQueryWorkStationMDB.FieldByName('D_Code').AsString;

  //получаем список всех имеющихся ковейеров на данной рабочей станции
  try
    ADOQueryLine.SQL.Clear;
    ADOQueryLine.SQL.Add('SELECT * FROM LINES WHERE D_Code = ' + D_Code );
    ADOQueryLine.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[LineList]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryLine.SQL.Text +'"'),
                               PChar(FormConfigWorkStation.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;
  Row_Count:= DataSourceLine.DataSet.RecordCount;
  EnabledDisabled(Row_Count > 0);
//  with DBGridLineList do
//    begin
//      for i := 0 to 2 do
//        Columns[i].Title.Alignment:= taCenter;
//      for i := 3 to 6 do
//        Columns[i].Visible:= false; //скрываем колонки
//    end;
  ADOQueryLineAfterScroll(DataSet);
end;

procedure TFormConfigWorkStation.PanelColorBackClick(Sender: TObject);
begin
  ColorDialog1.Color:= PanelColorBack.Color;
  if ColorDialog1.Execute then
    PanelColorBack.Color:= ColorDialog1.Color;

  ProcedureChangeData(false, true);  //не перезагружать монитор, т.к. данные не косаются его работы
end;

procedure TFormConfigWorkStation.RadioButtonHourClick(Sender: TObject);
begin
  ProcedureChangeData(false, true);  //не перезагружать монитор, т.к. данные не косаются его работы
end;

procedure TFormConfigWorkStation.RadioButtonInstantaneousClick(Sender: TObject);
begin
  ProcedureChangeData(false, true);  //не перезагружать монитор, т.к. данные не косаются его работы
end;

procedure TFormConfigWorkStation.RadioButtonMinuteClick(Sender: TObject);
begin
  ProcedureChangeData(false, true);  //не перезагружать монитор, т.к. данные не косаются его работы
end;

procedure TFormConfigWorkStation.EnabledDisabled(param: boolean);
begin
  SpeedButtonDelete.Enabled:= param;
  EditName.Enabled:= param;
  ComboBoxRegimeName.Enabled:= param;
  ComboBoxTypeOre.Enabled:= param;
  EditCod.Enabled:= param;
  CheckBoxStart.Enabled:= param;
  EditValDisp1.Enabled:= param;
  EditValDisp2.Enabled:= param;
  EditValDisp3.Enabled:= param;
  EditValDisp4.Enabled:= param;
  EditValDisp5.Enabled:= param;
  EditValDisp6.Enabled:= param;
  EditValDisp7.Enabled:= param;
  EditUminNull.Enabled:= param;
  EditUmaxNull.Enabled:= param;
  CheckBoxSignal1.Enabled:= param;
  CheckBoxSignal2.Enabled:= param;
  CheckBoxSignalWithWeights.Enabled:= param;
  CheckBoxEEPROM.Enabled:= param;
  CheckBoxSelect.Enabled:= param;
  CheckBoxNull.Enabled:= param;
  CheckBoxRefNull.Enabled:= param;
  CheckBoxWeightNull.Enabled:= param;
  SpinEditSizeHour.Enabled:= param;
  PanelColorBack.Enabled:= param;
  RadioButtonInstantaneous.Enabled:= param;
  RadioButtonMinute.Enabled:= param;
  RadioButtonHour.Enabled:= param;
end;

procedure TFormConfigWorkStation.ChangeDataTrue(Sender: TObject);
begin
  ProcedureChangeData(true, true);   //даем команду на перезагруз монитора и команду на измения данных
end;

procedure TFormConfigWorkStation.ProcedureChangeData(rb: boolean; cd: boolean);   //признак, что данные были изменены
begin
  //требуется ли перезагрузка программы Сбор и обработка данных
  //если RebootMonitor уже был утсановлен true (перезагрузка), то значение не меняем
  if not RebootMonitor then RebootMonitor:= rb;

  ChangeData:= cd;
  ButtonSave.Enabled:= cd;   //если данные были изменены, разрешаем кнопку "Применить"
end;

end.
