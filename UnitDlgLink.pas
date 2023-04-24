unit UnitDlgLink;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids, Math,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Data.Win.ADODB, UnitMyForm{обязательно ПОСЛЕДНИМ};

type    //убираем прокрутку скрола в ComboBox
  TComboBox = class(Vcl.StdCtrls.TComboBox)
    protected
      procedure MsgMouseWheel(var Message: TMessage); message WM_MOUSEWHEEL;
    end;

type
  TFormDlgLink = class(TForm)
    Label1: TLabel;
    EditNameContrParam: TEdit;
    Label2: TLabel;
    ComboBoxEquipmentList: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditPlan: TEdit;
    EditMax: TEdit;
    EditMin: TEdit;
    EditMeas: TEdit;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ButtonClose: TButton;
    GroupBoxAr: TGroupBox;
    RadioGroupHour: TRadioGroup;
    RadioGroupСumulative: TRadioGroup;
    StringGridTypeOre: TStringGrid;
    ComboBoxEstimatedCoefficients: TComboBox;
    Label7: TLabel;
    EditDescriptionContrParam: TEdit;
    procedure FormShow(Sender: TObject);
    function EquipmentList: integer;
    function CoefficientList: integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ClearAllData;
    procedure SaveDataInBD;
    procedure StringGridTypeOreDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ComboBoxEstimatedCoefficientsChange(Sender: TObject);
    procedure ComboBoxEstimatedCoefficientsExit(Sender: TObject);
    procedure StringGridTypeOreSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ButtonSaveClick(Sender: TObject);
    procedure EditPlanKeyPress(Sender: TObject; var Key: Char);
    procedure EditMaxKeyPress(Sender: TObject; var Key: Char);
    procedure EditMinKeyPress(Sender: TObject; var Key: Char);
    function UpdateDlgLink: boolean;    //если true - все хорошо.
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ComboBoxEquipmentListChange(Sender: TObject);
    procedure ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
    procedure ChangeDataTrue(Sender: TObject);
    procedure EditMaxChange(Sender: TObject);  //событие Change:= true;
  private
    { Private declarations }
    var
      ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                            //измененные данные записать в базу данных

    Ms_Status : TStringList;
    const
      ColWidths0 = 150;     //Ширина колонки 0 в StringGridTypeOre
      ColWidths1 = 116;     //Ширина колонки 1 в StringGridTypeOre
      ColWidths2 = 0;       //Ширина колонки 2 в StringGridTypeOre     T_Code
      ColWidths3 = 0;       //Ширина колонки 3 в StringGridTypeOre     Cf_Code

  public
    { Public declarations }
  end;

var
  FormDlgLink: TFormDlgLink;

implementation
uses MainUnit, UnitConfigWorkStation, UnitDM, RudaGlobals;
{$R *.dfm}
//игнорируем скрол мышки в ComboBox
procedure TComboBox.MsgMouseWheel(var Message: TMessage);
begin
end;


procedure TFormDlgLink.EditMaxChange(Sender: TObject);
  var s: string;
begin
  
end;

procedure TFormDlgLink.EditMaxKeyPress(Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Copy(Label4.Caption, 1 ,Length(Label4.Caption)-1) + '"', EditMax, Key, 3);
end;

procedure TFormDlgLink.EditMinKeyPress(Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Copy(Label5.Caption, 1 ,Length(Label5.Caption)-1) + '"', EditMin, Key, 3);
end;

procedure TFormDlgLink.EditPlanKeyPress(Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Copy(Label3.Caption, 1 ,Length(Label3.Caption)-1) + '"', EditPlan, Key, 3);
end;

function TFormDlgLink.EquipmentList: integer;
begin
  result:= 0;
  ComboBoxEquipmentList.Items.Clear;
  Ms_Status.Clear;

  if not DM.QueryWorkStation('SELECT Ms_Code,Ms_Name,Ms_Status FROM measurer WHERE L_Code = ' +
                                              IntToStr(UnitConfigWorkStation.CodeLine) +
                                         ' AND Ms_Status <> 3 AND Ms_Status <> 5 ORDER BY Num',
                                      FormDlgLink.Caption, 'EquipmentList', true) then exit;

  DM.ADOQueryWorkStationMDB.First;
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      ComboBoxEquipmentList.Items.AddObject(DM.ADOQueryWorkStationMDB.FieldByName('Ms_Name').AsString,
                                            Tobject(strtoint((DM.ADOQueryWorkStationMDB.FieldByName('Ms_Code')).AsString)));
      Ms_Status.Add(DM.ADOQueryWorkStationMDB.FieldByName('Ms_Status').AsString);
      inc(result);
      DM.ADOQueryWorkStationMDB.Next;
    end;
end;

function TFormDlgLink.CoefficientList: integer;
begin
  result:= 0;
  ComboBoxEstimatedCoefficients.Items.Clear;
  if not DM.QueryWorkStation('SELECT Cf_Code, Cf_Name FROM cf', FormDlgLink.Caption, 'CoefficientList', true) then exit;

  DM.ADOQueryWorkStationMDB.First;
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      ComboBoxEstimatedCoefficients.Items.AddObject(DM.ADOQueryWorkStationMDB.FieldByName('Cf_Name').AsString,
                                            Tobject(strtoint((DM.ADOQueryWorkStationMDB.FieldByName('Cf_Code')).AsString)));
      inc(result);
      DM.ADOQueryWorkStationMDB.Next;
    end;
end;

procedure TFormDlgLink.SaveDataInBD;
  var sMs_Code, sStatus: string;
      Status, row: integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Сохранить значения для параметра: "' +
                                  EditNameContrParam.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if Trim(EditNameContrParam.Text) = '' then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                 Copy(Label1.Caption, 1 ,Length(Label1.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditNameContrParam.SetFocus;
          exit;
        end;

      if (Trim(EditPlan.Text) = '') or (not CheckNumeric(EditPlan.Text)) then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                 Copy(Label3.Caption, 1 ,Length(Label3.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditPlan.SetFocus;
          exit;
        end;

      if (Trim(EditMax.Text) = '') or (not CheckNumeric(EditMax.Text)) then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                 Copy(Label4.Caption, 1 ,Length(Label4.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditMax.SetFocus;
          exit;
        end;

      if (Trim(EditMin.Text) = '') or (not CheckNumeric(EditMin.Text)) then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                 Copy(Label5.Caption, 1 ,Length(Label5.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditMin.SetFocus;
          exit;
        end;

      if ComboBoxEquipmentList.ItemIndex = -1 then
        begin
          sMs_Code:= 'Null';
          sStatus:= 'Null';
          Application.MessageBox(PChar('Не выбрано оборудование.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          ComboBoxEquipmentList.SetFocus;
          exit;
        end
        else begin
          sMs_Code:= IntToStr(integer(ComboBoxEquipmentList.Items.Objects[ComboBoxEquipmentList.ItemIndex]));
          Status:= StrToInt(Trim(Ms_Status[ComboBoxEquipmentList.ItemIndex]));
          if Status = 1 then
            begin
              if (RadioGroupHour.ItemIndex = -1) or (RadioGroupСumulative.ItemIndex = -1) then
                begin
                  Application.MessageBox(PChar('Не выбраны варианты расчета значения параметра.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
                  RadioGroupHour.SetFocus;
                  exit;
                end;
              if RadioGroupHour.ItemIndex = 0 then Status:= Status or (1 shl 3); //4-й бит в единицу
              if RadioGroupСumulative.ItemIndex = 0 then Status:= Status or (1 shl 4); //5-й бит в единицу
            end;
          sStatus:= IntToStr(Status);
        end;

      if strtofloat(EditMin.Text) > strtofloat(EditMax.Text) then
        begin
          Application.MessageBox(PChar('Максимальное значение параметра должно быть больше минимального.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditMax.SetFocus;
          exit;
        end;

      if (strtofloat(EditPlan.Text) > strtofloat(EditMax.Text)) or
         (strtofloat(EditMin.Text) > strtofloat(EditPlan.Text)) then
        begin
          Application.MessageBox(PChar('Значение плана должно находится в диапазоне от Минимального значения = ' +
            EditMin.Text + ' до Максимального значения = ' + EditMax.Text),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditPlan.SetFocus;
          exit;
        end;

      if FormDlgLink.Tag = 0 then  //добавляем новый контролируемый параметр   Num, [Connect],  "0", true,
        begin
          if NoErrСreateNewField then    //удалось создать новые поля для новой версии СКРП
            begin
              if not DM.QueryServer('INSERT INTO CONTROLPARAM (Cp_Name, Cp_Description, L_code, Num, [Connect], Plan, [Max], [Min], Meas, Status) VALUES (''' +
                                            EditNameContrParam.Text + ''', ''' +
                                            EditDescriptionContrParam.Text + ''', ''' +
                                            IntToStr(UnitConfigWorkStation.CodeLine) + ''', 0, true, ''' +
                                            EditPlan.Text + ''', ''' +
                                            EditMax.Text + ''', ''' +
                                            EditMin.Text + ''', ''' +
                                            EditMeas.Text + ''', ''' +
                                            sStatus + ''')',
                                        FormDlgLink.Caption, 'SaveDataInBD', false) then exit;
            end
            else begin
              if not DM.QueryServer('INSERT INTO CONTROLPARAM (Cp_Name, L_code, Num, [Connect], Plan, [Max], [Min], Meas, Status) VALUES (''' +
                                            EditNameContrParam.Text + ''', ''' +
                                            IntToStr(UnitConfigWorkStation.CodeLine) + ''', 0, true, ''' +
                                            EditPlan.Text + ''', ''' +
                                            EditMax.Text + ''', ''' +
                                            EditMin.Text + ''', ''' +
                                            EditMeas.Text + ''', ''' +
                                            sStatus + ''')',
                                        FormDlgLink.Caption, 'SaveDataInBD', false) then exit;
            end;

          if not DM.QueryServer('SELECT Max(Cp_Code) as n FROM ControlParam WHERE L_Code = ' +
                                                  IntToStr(UnitConfigWorkStation.CodeLine),
                                        FormDlgLink.Caption, 'SaveDataInBD', true) then exit;

          try
            FormDlgLink.Tag:= DM.ADOQueryServerMDB.FieldByName('n').AsInteger;
          except
            on e: Exception do
              begin
                MessageBox(handle, PChar(e.Message + #13#10 + '"ADOQueryServerMDB.FieldByName ..."'),
                           PChar(FormDlgLink.Caption), MB_ICONERROR+MB_OK);
                Exit;
              end;
          end;

          if not DM.QueryWorkStation('INSERT INTO Link (L_Code, Ms_Code, Cp_Code) VALUES (''' +
                                            IntToStr(UnitConfigWorkStation.CodeLine) + ''', ''' +
                                            sMs_Code + ''', ''' +
                                            IntToStr(FormDlgLink.Tag) + ''')',
                                      FormDlgLink.Caption, 'SaveDataInBD', false) then exit;
        end
        else begin                //редактируем уже имеющийся контролируемый параметр
          if NoErrСreateNewField then    //удалось создать новые поля для новой версии СКРП
            begin
              if not DM.QueryServer('UPDATE ControlParam SET ' +
                                    'Cp_Name = ''' + EditNameContrParam.Text + ''', ' +
                                    'Cp_Description = ''' + EditDescriptionContrParam.Text + ''', ' +
                                    'Plan = ''' + EditPlan.Text + ''', ' +
                                    '[Max] = ''' + EditMax.Text + ''', ' +
                                    '[Min] = ''' + EditMin.Text + ''', ' +
                                    'Meas = ''' + EditMeas.Text + ''', ' +
                                    'Status = ''' + sStatus +
                                    ''' WHERE Cp_Code = ' + IntToStr(FormDlgLink.Tag),
                                        FormDlgLink.Caption, 'SaveDataInBD', false) then exit;
            end
            else begin
              if not DM.QueryServer('UPDATE ControlParam SET ' +
                                            'Cp_Name = ''' + EditNameContrParam.Text + ''', ' +
                                            'Plan = ''' + EditPlan.Text + ''', ' +
                                            '[Max] = ''' + EditMax.Text + ''', ' +
                                            '[Min] = ''' + EditMin.Text + ''', ' +
                                            'Meas = ''' + EditMeas.Text + ''', ' +
                                            'Status = ''' + sStatus +
                                            ''' WHERE Cp_Code = ' + IntToStr(FormDlgLink.Tag),
                                        FormDlgLink.Caption, 'SaveDataInBD', false) then exit;
            end;

          if not DM.QueryWorkStation('UPDATE Link SET ' +
                                      'Ms_Code = ''' + sMs_Code +
                                      '''  WHERE Cp_Code = ' + IntToStr(FormDlgLink.Tag),
                                      FormDlgLink.Caption, 'SaveDataInBD', false) then exit;
        end;

      if not DM.QueryWorkStation('DELETE FROM LinkTO WHERE Cp_Code = ' + IntToStr(FormDlgLink.Tag),
                                      FormDlgLink.Caption, 'SaveDataInBD', false) then exit;

      for row := 1 to StringGridTypeOre.RowCount - 1 do
        begin
          if Trim(StringGridTypeOre.Cells[3, row]) <> '' then   //Cf_Code
            begin
              if not DM.QueryWorkStation('INSERT INTO LinkTO (T_Code, Cp_Code, Cf_Code) VALUES (''' +
                                           Trim(StringGridTypeOre.Cells[2, row]) + ''', ''' +
                                           IntToStr(FormDlgLink.Tag) + ''', ''' +
                                           Trim(StringGridTypeOre.Cells[3, row]) + ''')',
                                      FormDlgLink.Caption, 'SaveDataInBD', false) then exit;
            end;
        end;
      UnitConfigWorkStation.ChangeData:= true;
    end;
  ProcedureChangeData(false);
  FormConfigWorkStation.ControlParamList;;    //обновляем список контролируемых параметров
  //восстанавливаем позицию курсора
  FormConfigWorkStation.DBGridControlParamList.DataSource.DataSet.Locate('Cp_Code', FormDlgLink.Tag, []);
end;

procedure TFormDlgLink.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ChangeData then SaveDataInBD;
  Ms_Status.Free;
end;

procedure TFormDlgLink.FormCreate(Sender: TObject);
begin
  {Высоту у combobox не получится установить, поэтому мы будем}
 {подгонять размер у грида под размер combobox!}
  StringGridTypeOre.DefaultRowHeight := ComboBoxEstimatedCoefficients.Height;
 {Скрываем combobox}
  ComboBoxEstimatedCoefficients.Visible := False;

  StringGridTypeOre.ColWidths[0]:= ColWidths0;
  StringGridTypeOre.ColWidths[1]:= ColWidths1;
  StringGridTypeOre.ColWidths[2]:= ColWidths2;     //T_Code скрываем
  StringGridTypeOre.ColWidths[3]:= ColWidths3;     //Cf_Code надо скрыть
end;

procedure TFormDlgLink.ButtonCancelClick(Sender: TObject);
begin
  UpdateDlgLink;
end;

procedure TFormDlgLink.ButtonCloseClick(Sender: TObject);
begin
  FormDlgLink.Close;
end;

procedure TFormDlgLink.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

procedure TFormDlgLink.ClearAllData;
  var i: integer;
      Sender: TObject;
begin
  EditNameContrParam.Clear;
  EditDescriptionContrParam.Clear;
  ComboBoxEquipmentList.Items.Clear;
  EditPlan.Clear;
  EditMax.Clear;
  EditMin.Clear;
  EditMeas.Clear;
  RadioGroupHour.ItemIndex:= -1;
  RadioGroupСumulative.ItemIndex:= -1;

  // очищаем таблицу
  StringGridTypeOre.RowCount:= 2;

  i:= StringGridTypeOre.ColCount - 1;
  While i >= 0 do
    begin
      StringGridTypeOre.Cells[i, 1]:= '';
      dec(i);
    end;
end;

procedure TFormDlgLink.ComboBoxEquipmentListChange(Sender: TObject);
begin
  ProcedureChangeData;
  if Trim(Ms_Status[ComboBoxEquipmentList.ItemIndex]) = '1' then
    begin
      FormDlgLink.Height:= 396;
      GroupBoxAr.Visible:= true;
      RadioGroupHour.ItemIndex:= 0;
      RadioGroupСumulative.ItemIndex:= 0;
    end
    else begin
      GroupBoxAr.Visible:= false;
      FormDlgLink.Height:= 303;
      RadioGroupHour.ItemIndex:= -1;
      RadioGroupСumulative.ItemIndex:= -1;
    end;
end;

procedure TFormDlgLink.ComboBoxEstimatedCoefficientsChange(Sender: TObject);
begin
  {Получаем выбранный элемент из ComboBox и помещаем его в грид}
  with StringGridTypeOre do
    begin
      Cells[Col, Row]:= ComboBoxEstimatedCoefficients.Items[ComboBoxEstimatedCoefficients.ItemIndex];
      //записываем Cf_Code
      if ComboBoxEstimatedCoefficients.ItemIndex < 0   //нет данных
        then Cells[3, Row]:= ''
        else Cells[3, Row]:= IntToStr(integer(ComboBoxEstimatedCoefficients.Items.Objects[ComboBoxEstimatedCoefficients.ItemIndex]));
      ComboBoxEstimatedCoefficients.Visible := False;
      SetFocus;
    end;
  ProcedureChangeData;
end;

procedure TFormDlgLink.ComboBoxEstimatedCoefficientsExit(Sender: TObject);
begin
  {Получаем выбранный элемент из ComboBox и помещаем его в грид}
  ComboBoxEstimatedCoefficientsChange(Sender);
  ComboBoxEstimatedCoefficients.ItemIndex:= -1;
end;

function TFormDlgLink.UpdateDlgLink: boolean;
  var row, i: integer;
    msCode: variant;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  result:= true;
  //строго сохранять последовательность  CoefficientList; ClearAllData; EquipmentList;
  CoefficientList;
  ClearAllData;
  EquipmentList;

  if not DM.QueryServer('SELECT * FROM TypeOre', FormDlgLink.Caption, 'UpdateDlgLink', true) then exit;

  DM.ADOQueryServerMDB.First;
  row:= 1;
  while not DM.ADOQueryServerMDB.EOF do
    begin
      StringGridTypeOre.Cells[0, row]:= DM.ADOQueryServerMDB.FieldByName('T_Name').AsString;
      StringGridTypeOre.Cells[2, row]:= DM.ADOQueryServerMDB.FieldByName('T_Code').AsString;

      if not DM.QueryWorkStation('SELECT Cf_Name,Cf_Code FROM Cf WHERE Cf_Code = (SELECT Cf_Code FROM LinkTO WHERE T_Code = ' +
                                              DM.ADOQueryServerMDB.FieldByName('T_Code').AsString +
                                              ' AND Cp_Code = ' + IntToStr(FormDlgLink.Tag) +')',
                                      FormDlgLink.Caption, 'UpdateDlgLink', true) then exit;

      StringGridTypeOre.Cells[3, row]:= DM.ADOQueryWorkStationMDB.FieldByName('Cf_Code').AsString;
      StringGridTypeOre.Cells[1, row]:= DM.ADOQueryWorkStationMDB.FieldByName('Cf_Name').AsString;

      inc(row);
      StringGridTypeOre.RowCount:= StringGridTypeOre.RowCount + 1;
      DM.ADOQueryServerMDB.Next;
    end;
  //удаляем последнюю пустую строку
  if StringGridTypeOre.RowCount > 2 then StringGridTypeOre.RowCount:= StringGridTypeOre.RowCount - 1;

  if FormDlgLink.Tag = 0 then exit;     //если новый

  if not DM.QueryServer('SELECT * FROM ControlParam WHERE Cp_Code = ' + IntToStr(FormDlgLink.Tag),
                               FormDlgLink.Caption, 'UpdateDlgLink', true) then exit;

  if not DM.ADOQueryServerMDB.EOF then
    begin
      if ((DM.ADOQueryServerMDB.FieldByName('Status').AsInteger) and 7) = 1 then
        begin   //если Fe с MB5
          FormDlgLink.Height:= 396;
          GroupBoxAr.Visible:= true;
          // проверяем 4-ый бит в Status
          if IsBitSet(DM.ADOQueryServerMDB.FieldByName('Status').AsInteger, 3) then RadioGroupHour.ItemIndex:= 0
                                                                               else RadioGroupHour.ItemIndex:= 1;
          // проверяем 5-ый бит в Status
          if IsBitSet(DM.ADOQueryServerMDB.FieldByName('Status').AsInteger, 4) then RadioGroupСumulative.ItemIndex:= 0
                                                                               else RadioGroupСumulative.ItemIndex:= 1;
        end
        else begin
          RadioGroupHour.ItemIndex:= -1;
          RadioGroupСumulative.ItemIndex:= -1;
          GroupBoxAr.Visible:= false;
          FormDlgLink.Height:= 303;
        end;
      EditNameContrParam.Text:= DM.ADOQueryServerMDB.FieldByName('Cp_Name').AsString;
      if NoErrСreateNewField then
        EditDescriptionContrParam.Text:= DM.ADOQueryServerMDB.FieldByName('Cp_Description').AsString
        else EditDescriptionContrParam.Clear;
      EditPlan.Text          := FloatToStr(SimpleRoundTo(DM.ADOQueryServerMDB.FieldByName('Plan').AsFloat, - 3));
      EditMax.Text           := FloatToStr(SimpleRoundTo(DM.ADOQueryServerMDB.FieldByName('Max').AsFloat, - 3));
      EditMin.Text           := FloatToStr(SimpleRoundTo(DM.ADOQueryServerMDB.FieldByName('Min').AsFloat, - 3));
      EditMeas.Text          := DM.ADOQueryServerMDB.FieldByName('Meas').AsString;
    end;

  if ComboBoxEquipmentList.Items.Count > 0 then
    begin
      if not DM.QueryWorkStation('SELECT * FROM Link WHERE Cp_Code = ' + IntToStr(FormDlgLink.Tag),
                                      FormDlgLink.Caption, 'UpdateDlgLink', true) then exit;

      msCode:= DM.ADOQueryWorkStationMDB.FieldByName('Ms_Code').AsVariant;
      if msCode <> null then
        begin
          for i := 0 to ComboBoxEquipmentList.Items.Count - 1 do
            begin
              if integer(ComboBoxEquipmentList.Items.Objects[i]) = msCode then
                begin
                  ComboBoxEquipmentList.ItemIndex:= i;
                  break;
                end;
            end;
        end;
    end;
  ProcedureChangeData(false);
  EditNameContrParam.SetFocus;
end;

procedure TFormDlgLink.FormShow(Sender: TObject);
begin
  // Создание объекта TList для хранения Ms_Status из таблицы Measurer для ComboBoxEquipmentList
  Ms_Status:= TStringList.Create;
  UpdateDlgLink;
end;

procedure TFormDlgLink.StringGridTypeOreDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
  var   s: string;
     Flag: Cardinal;
begin
  if (ACol=0) and (ARow=0) then
    begin
      s:= 'Тип руды';
      Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_SINGLELINE;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridTypeOre.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;

  if (ACol=1) and (ARow=0) then
    begin
      s:= 'Коэффициенты';
      //Если нет переноса слов, то выровнять по центру вертикали и горизонтали можно так
      Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_SINGLELINE;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridTypeOre.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;
end;

procedure TFormDlgLink.StringGridTypeOreSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
  i: integer;
  Cf_Code: string;
begin
  if (ACol = 1) AND (ARow > 0) then
    begin
      {Размер и расположение combobox подгоняем под ячейку}
      R := StringGridTypeOre.CellRect(ACol, ARow);
      R.Left := R.Left + StringGridTypeOre.Left;
      R.Right := R.Right + StringGridTypeOre.Left;
      R.Top := R.Top + StringGridTypeOre.Top;
      R.Bottom := R.Bottom + StringGridTypeOre.Top;
      ComboBoxEstimatedCoefficients.Left := R.Left + 1;
      ComboBoxEstimatedCoefficients.Top := R.Top + 1;
      ComboBoxEstimatedCoefficients.Width := (R.Right + 1) - R.Left;
      ComboBoxEstimatedCoefficients.Height := (R.Bottom + 1) - R.Top;
      {Показываем combobox}
      ComboBoxEstimatedCoefficients.Visible := True;
      Cf_Code:= Trim(StringGridTypeOre.Cells[3, ARow]);
      if (ComboBoxEstimatedCoefficients.Items.Count > 0) and (Cf_Code <> '') then
        begin
          for i := 0 to ComboBoxEstimatedCoefficients.Items.Count - 1 do
            begin
              if integer(ComboBoxEstimatedCoefficients.Items.Objects[i]) = StrToInT(Cf_Code) then
                begin
                  ComboBoxEstimatedCoefficients.ItemIndex:= i;
                  break;
                end;
            end;
        end
        else ComboBoxEstimatedCoefficients.ItemIndex:= -1;

      ComboBoxEstimatedCoefficients.SetFocus;
    end;
  CanSelect := True;
end;

procedure TFormDlgLink.ChangeDataTrue(Sender: TObject);  //событие Change:= true;
begin
  ProcedureChangeData;
end;

procedure TFormDlgLink.ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //если данные были изменены, разрешаем кнопку "Применить"
end;

end.
