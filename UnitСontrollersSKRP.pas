unit UnitÑontrollersSKRP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, UnitMyForm{îáÿçàòåëüíî ÏÎÑËÅÄÍÈÌ};

type
  TFormÑontrollersSKRP = class(TForm)
    DBGridListÑontrollers: TDBGrid;
    ADOQueryÑontrollersSKRP: TADOQuery;
    DataSourceÑontrollersSKRP: TDataSource;
    SpeedButtonAddController: TSpeedButton;
    SpeedButtonDeleteController: TSpeedButton;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ButtonClose: TButton;
    ADOQueryÑontrollersSKRPCn_Code: TAutoIncField;
    ADOQueryÑontrollersSKRPCn_Name: TWideStringField;
    ADOQueryÑontrollersSKRPCn_SizeAnswer: TWordField;
    ADOQueryÑontrollersSKRPCn_SizeCh: TWordField;
    ADOQueryÑontrollersSKRPCn_Echo1: TWordField;
    ADOQueryÑontrollersSKRPCn_Echo2: TWordField;
    ADOQueryÑontrollersSKRPCn_Address: TWordField;
    ADOQueryÑontrollersSKRPCn_TypeController: TIntegerField;
    ADOQueryÑontrollersSKRPNc_NameController: TWideStringField;
    ADOQueryÑontrollersSKRPNc_Code: TAutoIncField;
    PanelMK001_002: TPanel;
    Label2: TLabel;
    Edit_AY0: TEdit;
    Edit_AY1: TEdit;
    Label3: TLabel;
    RadioGroupSizeAnswer: TRadioGroup;
    Label4: TLabel;
    EditSize: TEdit;
    CheckBoxW: TCheckBox;
    PanelMK003: TPanel;
    Label5: TLabel;
    ComboBoxTypeControllers: TComboBox;
    CheckBoxW_MK003: TCheckBox;
    RadioGroupSizeAnswer_MK003: TRadioGroup;
    Edit_AY1_MK003: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Edit_AY0_MK003: TEdit;
    Label1: TLabel;
    EditÑontrollersName: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ÑontrollersList;
    procedure ProcedureChangeData(param: boolean);   //ïğèçíàê, ÷òî äàííûå áûëè èçìåíåíû
    procedure FormShow(Sender: TObject);
    procedure ADOQueryÑontrollersSKRPAfterScroll(DataSet: TDataSet);
    procedure ClearAllData;
    procedure ClearOnlyFieldData(ClearFieldTypeControllers: boolean);       //ñòèğàåì òîëüêî ïîëÿ äëÿ çàïîëíåíèÿ
    procedure EditÑontrollersNameKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_AY0KeyPress(Sender: TObject; var Key: Char);
    procedure Edit_AY1KeyPress(Sender: TObject; var Key: Char);
    procedure EditSizeKeyPress(Sender: TObject; var Key: Char);
    procedure RadioGroupSizeAnswerClick(Sender: TObject);
    procedure CheckBoxWKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxWClick(Sender: TObject);
    procedure SaveDataInBD;
    function SaveDataInDBforMK001_002: boolean;     //ñîõğàíÿåì äàííûå äëÿ êîíòğîëëêğîâ MK001 è MK002
    function SaveDataInDBforMK003: boolean;         //ñîõğàíÿåì äàííûå äëÿ êîíòğîëëêğà MK003
    procedure ButtonSaveClick(Sender: TObject);
    procedure UpdateÑontrollersList(SetCursorPosition: boolean);
    procedure ButtonCancelClick(Sender: TObject);
    procedure SpeedButtonAddControllerClick(Sender: TObject);
    procedure SpeedButtonDeleteControllerClick(Sender: TObject);
    procedure ADOQueryÑontrollersSKRPBeforeScroll(DataSet: TDataSet);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBoxTypeControllersChange(Sender: TObject);
    procedure EnabledDisabledFields(param: boolean = true);
    procedure Edit_AY0_MK003KeyPress(Sender: TObject; var Key: Char);
    procedure Edit_AY1_MK003KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    var
      ChangeData: boolean;  //ïğîèçîøëè ëè èçìåíåíèÿ ñ äàííûìè äëÿ äèàëîãà, ÷òîáû
                            //èçìåíåííûå äàííûå çàïèñàòü â áàçó äàííûõ
      Row_Count: integer;
  public
    { Public declarations }
  end;

var
  FormÑontrollersSKRP: TFormÑontrollersSKRP;
  CodeÑontrollers: integer;

implementation
uses MainUnit, UnitDM, UnitSettingsProgramm, RudaGlobals;
{$R *.dfm}

procedure TFormÑontrollersSKRP.ADOQueryÑontrollersSKRPAfterScroll(
  DataSet: TDataSet);
  var i: integer;
     Sender: TObject;
begin
  ClearAllData;
  if Row_Count > 0 then   // êîíòğîëëåğû ïğèñóòñâóşò
    begin
      if ComboBoxTypeControllers.Items.Count > 0 then
        begin
          for i := 0 to ComboBoxTypeControllers.Items.Count - 1 do
            begin
              if DBGridListÑontrollers.DataSource.DataSet.FieldByName('Nc_Code').AsInteger =
                  integer(ComboBoxTypeControllers.Items.Objects[i]) then
                  begin
                    ComboBoxTypeControllers.ItemIndex:= i;
                    break;
                  end;
            end;
        end;

      CodeÑontrollers:= DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_Code').AsInteger;
      EditÑontrollersName.Text:= Trim(DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_Name').AsString);

      if ComboBoxTypeControllers.ItemIndex = 2 then   //çíà÷èò âûáğàí òèï êîíòğîëëåğà MK003
        begin
          panelMK001_002.Visible:= false;
          PanelMK003.Visible:= true;

          Edit_AY0_MK003.Text:= Format('%.2d', [DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_Echo1').AsInteger]);
          Edit_AY1_MK003.Text:= Format('%.2d', [DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_Echo2').AsInteger]);
          if Trim(DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_SizeAnswer').AsString) = '4' then
            RadioGroupSizeAnswer_MK003.ItemIndex:= 0 else RadioGroupSizeAnswer.ItemIndex:= 1;
          if Trim(DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_SizeCh').AsString) = '4' then
            CheckBoxW_MK003.Checked:= true else CheckBoxW_MK003.Checked:= false;
        end
        else begin
          PanelMK003.Visible:= false;
          panelMK001_002.Visible:= true;

          Edit_AY0.Text:= Format('%.2x', [DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_Echo1').AsInteger]);
          Edit_AY1.Text:= Format('%.2x', [DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_Echo2').AsInteger]);
          if Trim(DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_SizeAnswer').AsString) = '4' then
            RadioGroupSizeAnswer.ItemIndex:= 0 else RadioGroupSizeAnswer.ItemIndex:= 1;
          EditSize.Text:= Trim(DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_Address').AsString);
          if Trim(DBGridListÑontrollers.DataSource.DataSet.FieldByName('Cn_SizeCh').AsString) = '4' then
            CheckBoxW.Checked:= true else CheckBoxW.Checked:= false;
        end;

    end;

  SpeedButtonDeleteController.Enabled:= CodeÑontrollers > 4;  //4 ñòğîêè ıòî çàğåçåğâèğîâàííûå êîíòğîëëåğû
  EnabledDisabledFields(CodeÑontrollers > 4);  //4 ñòğîêè ıòî çàğåçåğâèğîâàííûå êîíòğîëëåğû

  ProcedureChangeData(false);  //÷òîáû íå çàôèêñèğîâàòü èçìåíåíèÿ ïğè ïğîêğóòêè ñêğîëîì è äàííûå íå çàïèñûâàëèñü â áàçó äàííûõ
end;

procedure TFormÑontrollersSKRP.ADOQueryÑontrollersSKRPBeforeScroll(
  DataSet: TDataSet);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormÑontrollersSKRP.ButtonCancelClick(Sender: TObject);
begin
  UpdateÑontrollersList(true);
end;

procedure TFormÑontrollersSKRP.ButtonCloseClick(Sender: TObject);
begin
  FormÑontrollersSKRP.Close;
end;

procedure TFormÑontrollersSKRP.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

procedure TFormÑontrollersSKRP.CheckBoxWClick(Sender: TObject);
begin
  ProcedureChangeData(true);
end;

procedure TFormÑontrollersSKRP.CheckBoxWKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true);
end;

procedure TFormÑontrollersSKRP.ClearOnlyFieldData(ClearFieldTypeControllers: boolean);       //ñòèğàåì òîëüêî ïîëÿ äëÿ çàïîëíåíèÿ
begin
  if ClearFieldTypeControllers then
    begin
      ComboBoxTypeControllers.ItemIndex:= -1;
      EditÑontrollersName.Clear;
    end;

  Edit_AY0.Clear;
  Edit_AY1.Clear;
  RadioGroupSizeAnswer.ItemIndex:= 0;
  EditSize.Clear;
  CheckBoxW.Checked:= false;

  Edit_AY0_MK003.Clear;
  Edit_AY1_MK003.Clear;
  RadioGroupSizeAnswer_MK003.ItemIndex:= 0;
  CheckBoxW_MK003.Checked:= false;
end;

procedure TFormÑontrollersSKRP.ClearAllData;
begin
  CodeÑontrollers:= 0;

  ClearOnlyFieldData(true);       //ñòèğàåì òîëüêî ïîëÿ äëÿ çàïîëíåíèÿ âìåñòå ñ ïîëåì òèï êîíòğîëëåğà

  PanelMK001_002.Visible:= false;
  PanelMK003.Visible:= false;

  ComboBoxTypeControllers.Enabled:= false;
end;

procedure TFormÑontrollersSKRP.ComboBoxTypeControllersChange(Sender: TObject);
begin
  ProcedureChangeData(true);

  if ComboBoxTypeControllers.ItemIndex = 2 then   //çíà÷èò âûáğàí òèï êîíòğîëëåğà MK003
    begin
      panelMK001_002.Visible:= false;
      PanelMK003.Visible:= true;
    end
    else begin
      PanelMK003.Visible:= false;
      panelMK001_002.Visible:= true;
    end;

  ClearOnlyFieldData(false);       //ñòèğàåì òîëüêî ïîëÿ äëÿ çàïîëíåíèÿ êğîìå ïîëÿ òèïà êîíòğîëëåğà è èìÿ êîíòğîëëåğà
end;

procedure TFormÑontrollersSKRP.EditSizeKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true);
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label4.Caption, 1 ,Length(Label4.Caption)-1) + '"', Key);
end;

procedure TFormÑontrollersSKRP.Edit_AY0KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true);
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckHexPressKey('"' + Copy(Label2.Caption, 1 ,Length(Label2.Caption)-1) + '"', Key);
end;

procedure TFormÑontrollersSKRP.Edit_AY0_MK003KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true);
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label7.Caption, 1 ,Length(Label7.Caption)-1) + '"', Key);
end;

procedure TFormÑontrollersSKRP.Edit_AY1KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true);
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckHexPressKey('"' + Copy(Label3.Caption, 1 ,Length(Label3.Caption)-1) + '"', Key);
end;

procedure TFormÑontrollersSKRP.Edit_AY1_MK003KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true);
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckIntPressKey('"' + Copy(Label6.Caption, 1 ,Length(Label6.Caption)-1) + '"', Key);
end;

procedure TFormÑontrollersSKRP.EditÑontrollersNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData(true);
  if key = #13 then ButtonSaveClick(Sender);
end;

procedure TFormÑontrollersSKRP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormÑontrollersSKRP.FormCreate(Sender: TObject);
begin
  FormÑontrollersSKRP.Caption:= ProgName_ShortStringVersion + FormÑontrollersSKRP.Caption;
end;

procedure TFormÑontrollersSKRP.FormShow(Sender: TObject);
begin
  ClearAllData;
  ÑontrollersList;

  DBGridListÑontrollers.SetFocus;
  ProcedureChangeData(false);
end;

function TFormÑontrollersSKRP.SaveDataInDBforMK001_002: boolean;     //ñîõğàíÿåì äàííûå äëÿ êîíòğîëëêğîâ MK001 è MK002
var SizeAnswer, SizeCh: string;
       ay0, ay1: integer;
begin
  result:= true;
  if Trim(Edit_AY0.Text) = '' then
    begin
      Application.MessageBox(PChar('Íåäîñòàòî÷íî äàííûõ â ïîëå: "' +
                                 Copy(Label2.Caption, 1 ,Length(Label2.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ÂÍÈÌÀÍÈÅ !!!'),
                                 MB_OK + MB_ICONWARNING);
      Edit_AY0.SetFocus;
      result:= false;
      exit;
    end;

  if Trim(Edit_AY1.Text) = '' then
    begin
      Application.MessageBox(PChar('Íåäîñòàòî÷íî äàííûõ â ïîëå: "' +
                                 Copy(Label3.Caption, 1 ,Length(Label3.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ÂÍÈÌÀÍÈÅ !!!'),
                                 MB_OK + MB_ICONWARNING);
      Edit_AY1.SetFocus;
      result:= false;
      exit;
    end;

  if RadioGroupSizeAnswer.ItemIndex = 0 then SizeAnswer:= '4'
                                        else SizeAnswer:= '8';
  if CheckBoxW.Checked then SizeCh:= '4' else SizeCh:= '0';

  ay0:= DM.HexToInt(Edit_AY0.Text);
  ay1:= DM.HexToInt(Edit_AY1.Text);

  if not CheckNumeric(EditSize.Text) then EditSize.Text:= '0';

  if CodeÑontrollers = 0 then        //çàíîñèì íîâóş çàïèñü
    begin
      if not DM.QueryServer('INSERT INTO Controllers (Cn_Name,Cn_SizeAnswer,Cn_SizeCh,Cn_Echo1,Cn_Echo2,Cn_Address, Cn_TypeController) VALUES (''' +
                                            Trim(EditÑontrollersName.Text) + ''', ''' +
                                            SizeAnswer + ''', ''' +
                                            SizeCh + ''', ''' +
                                            IntToStr(ay0) + ''', ''' +
                                            IntToStr(ay1) + ''', ''' +
                                            Trim(EditSize.Text) + ''', ''' +
                                            IntToStr(integer(ComboBoxTypeControllers.Items.Objects[ComboBoxTypeControllers.ItemIndex])) + ''')',
                                 FormÑontrollersSKRP.Caption, 'SaveDataInBD', false) then begin result:= false; exit; end;

          //óçíàåì íîìåğ óíèêàëüíîé çàïèñè íîâîãî êîíòğîëëåğà (ïîñëåäíåé çàïèñè)
      if not DM.QueryServer('SELECT MAX(Cn_Code) as cod FROM CONTROLLERS',
                                 FormÑontrollersSKRP.Caption, 'SaveDataInBD', true) then begin result:= false; exit; end;

      if not DM.ADOQueryServerMDB.Eof then CodeÑontrollers:= DM.ADOQueryServerMDB.FieldByName('cod').AsInteger;
      if CodeÑontrollers = 0 then begin result:= false; exit; end;
    end
    else
    begin
      if not DM.QueryServer('UPDATE Controllers SET Cn_Name = ''' + Trim(EditÑontrollersName.Text) +
                                ''', Cn_SizeAnswer = ''' + SizeAnswer +
                                ''', Cn_SizeCh = ''' + SizeCh +
                                ''', Cn_Echo1 = ''' + IntToStr(ay0) +
                                ''', Cn_Echo2 = ''' + IntToStr(ay1) +
                                ''', Cn_Address = ''' + Trim(EditSize.Text) +
                                ''' WHERE Cn_Code = ' + IntToStr(CodeÑontrollers),
                                FormÑontrollersSKRP.Caption, 'SaveDataInBD', false) then begin result:= false; exit; end;
    end;
end;

function TFormÑontrollersSKRP.SaveDataInDBforMK003: boolean;         //ñîõğàíÿåì äàííûå äëÿ êîíòğîëëêğà MK003
var SizeAnswer, SizeCh: string;
begin
  result:= true;

  if Trim(Edit_AY0_MK003.Text) = '' then
    begin
      Application.MessageBox(PChar('Íåäîñòàòî÷íî äàííûõ â ïîëå: "' +
                                 Copy(Label7.Caption, 1 ,Length(Label7.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ÂÍÈÌÀÍÈÅ !!!'),
                                 MB_OK + MB_ICONWARNING);
      Edit_AY0_MK003.SetFocus;
      result:= false;
      exit;
    end;

  if Trim(Edit_AY1_MK003.Text) = '' then
    begin
      Application.MessageBox(PChar('Íåäîñòàòî÷íî äàííûõ â ïîëå: "' +
                                 Copy(Label6.Caption, 1 ,Length(Label6.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ÂÍÈÌÀÍÈÅ !!!'),
                                 MB_OK + MB_ICONWARNING);
      Edit_AY1_MK003.SetFocus;
      result:= false;
      exit;
    end;

  if RadioGroupSizeAnswer_MK003.ItemIndex = 0 then SizeAnswer:= '4'
                                              else SizeAnswer:= '8';

  if CheckBoxW_MK003.Checked then SizeCh:= '4' else SizeCh:= '0';

  if CodeÑontrollers = 0 then        //çàíîñèì íîâóş çàïèñü
    begin
      if not DM.QueryServer('INSERT INTO Controllers (Cn_Name,Cn_SizeAnswer,Cn_SizeCh,Cn_Echo1,Cn_Echo2, Cn_TypeController) VALUES (''' +
                                            Trim(EditÑontrollersName.Text) + ''', ''' +
                                            SizeAnswer + ''', ''' +
                                            SizeCh + ''', ''' +
                                            Trim(Edit_AY0_MK003.Text) + ''', ''' +
                                            Trim(Edit_AY1_MK003.Text) + ''', ''' +
                                            IntToStr(integer(ComboBoxTypeControllers.Items.Objects[ComboBoxTypeControllers.ItemIndex])) + ''')',
                                 FormÑontrollersSKRP.Caption, 'SaveDataInBD', false) then begin result:= false; exit; end;

          //óçíàåì íîìåğ óíèêàëüíîé çàïèñè íîâîãî êîíòğîëëåğà (ïîñëåäíåé çàïèñè)
      if not DM.QueryServer('SELECT MAX(Cn_Code) as cod FROM CONTROLLERS',
                                 FormÑontrollersSKRP.Caption, 'SaveDataInBD', true) then begin result:= false; exit; end;

      if not DM.ADOQueryServerMDB.Eof then CodeÑontrollers:= DM.ADOQueryServerMDB.FieldByName('cod').AsInteger;
      if CodeÑontrollers = 0 then begin result:= false; exit; end;
    end
    else
    begin
      if not DM.QueryServer('UPDATE Controllers SET Cn_Name = ''' + Trim(EditÑontrollersName.Text) +
                                ''', Cn_SizeAnswer = ''' + SizeAnswer +
                                ''', Cn_SizeCh = ''' + SizeCh +
                                ''', Cn_Echo1 = ''' + Trim(Edit_AY0_MK003.Text) +
                                ''', Cn_Echo2 = ''' + Trim(Edit_AY1_MK003.Text) +
                                ''' WHERE Cn_Code = ' + IntToStr(CodeÑontrollers),
                                FormÑontrollersSKRP.Caption, 'SaveDataInBD', false) then begin result:= false; exit; end;
    end;

end;

procedure TFormÑontrollersSKRP.SaveDataInBD;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //ïğîâåğÿì íà ñîñòîÿíèå ñæàòèÿ áàç äàííûõ. åñëè ñåé÷àñ ñæèìàşòñÿ - âûõîäèì.
  if Application.MessageBox(PChar('Ñîõğàíèòü èçìåíåíèÿ äëÿ êîíòğîëëåğà: "' +
                                  EditÑontrollersName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ÂÍÈÌÀÍÈÅ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if Trim(EditÑontrollersName.Text) = '' then
        begin
          Application.MessageBox(PChar('Íåäîñòàòî÷íî äàííûõ â ïîëå: "' +
                                 Copy(Label1.Caption, 1 ,Length(Label1.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ÂÍÈÌÀÍÈÅ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditÑontrollersName.SetFocus;
          exit;
        end;

      if ComboBoxTypeControllers.ItemIndex = 2 then   //çíà÷èò âûáğàí òèï êîíòğîëëåğà MK003
        begin
          if not SaveDataInDBforMK003 then exit;
        end
        else
        begin     //çíà÷èò âûáğàí òèï êîíòğîëëåğà MK001 èëè MK002
          if not SaveDataInDBforMK001_002 then exit;

        end;

    end;

  ProcedureChangeData(false);
  UpdateÑontrollersList(true);
end;

procedure TFormÑontrollersSKRP.SpeedButtonAddControllerClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //ïğîâåğÿì íà ñîñòîÿíèå ñæàòèÿ áàç äàííûõ. åñëè ñåé÷àñ ñæèìàşòñÿ - âûõîäèì.
  if ChangeData then SaveDataInBD;

  ClearAllData;

  SpeedButtonDeleteController.Enabled:= false;
  SpeedButtonAddController.Enabled:= false;
  DBGridListÑontrollers.Enabled:= false;

  FormÑontrollersSKRP.Color:= ColorEdit;
//  EditÑontrollersName.Color:= ColorEdit;
//  Edit_AY0.Color:= ColorEdit;
//  Edit_AY1.Color:= ColorEdit;
//  EditSize.Color:= ColorEdit;
//  RadioGroupSizeAnswer.Color:= ColorEdit;
//  CheckBoxW.Font.Color:= ColorEdit;

  EnabledDisabledFields;
  ComboBoxTypeControllers.Enabled:= true;
  EditÑontrollersName.SetFocus;
end;

procedure TFormÑontrollersSKRP.EnabledDisabledFields(param: boolean = true);
begin
  EditÑontrollersName.Enabled:= param;

  Edit_AY0_MK003.Enabled:= param;
  Edit_AY1_MK003.Enabled:= param;
  RadioGroupSizeAnswer_MK003.Enabled:= param;
  CheckBoxW_MK003.Enabled:= param;

  CheckBoxW.Enabled:= param;
  Edit_AY0.Enabled:= param;
  Edit_AY1.Enabled:= param;
  RadioGroupSizeAnswer.Enabled:= param;
  EditSize.Enabled:= param;
end;

procedure TFormÑontrollersSKRP.SpeedButtonDeleteControllerClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Óäàëèòü çàïèñü ñ êîíòğîëëåğîì: "' +
                                  EditÑontrollersName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ÂÍÈÌÀÍÈÅ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //ïğîâåğÿì íà ñîñòîÿíèå ñæàòèÿ áàç äàííûõ. åñëè ñåé÷àñ ñæèìàşòñÿ - âûõîäèì.
      if not DM.QueryServer('DELETE FROM CONTROLLERS WHERE Cn_Code = ' + IntToStr(CodeÑontrollers),
                FormÑontrollersSKRP.Caption, 'SpeedButtonDeleteRegimeClick', false) then exit;
      UpdateÑontrollersList(false);
    end;
end;

procedure TFormÑontrollersSKRP.UpdateÑontrollersList(SetCursorPosition: boolean);
  var DataSet: TDataSet;
      TempCodeRegime: integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //ïğîâåğÿì íà ñîñòîÿíèå ñæàòèÿ áàç äàííûõ. åñëè ñåé÷àñ ñæèìàşòñÿ - âûõîäèì.
  FormÑontrollersSKRP.Color:= clBtnFace;
//  EditÑontrollersName.Color:= clWhite;
//  Edit_AY0.Color:= clWhite;
//  Edit_AY1.Color:= clWhite;
//  EditSize.Color:= clWhite;

  SpeedButtonAddController.Enabled:= true;
  DBGridListÑontrollers.Enabled:= true;

  TempCodeRegime:= CodeÑontrollers; //çàïîìèíàåì ïîçèöèş êóğñîğà â DBGrid
  ÑontrollersList;
  if SetCursorPosition then
    begin
      CodeÑontrollers:= TempCodeRegime;
      //âîññòàíàâëèâàåì ïîçèöèş êóğñîğà
      DBGridListÑontrollers.DataSource.DataSet.Locate('Cn_Code', CodeÑontrollers, []);
    end;
  DBGridListÑontrollers.SetFocus;
end;

procedure TFormÑontrollersSKRP.RadioGroupSizeAnswerClick(Sender: TObject);
begin
  ProcedureChangeData(true);
end;

procedure TFormÑontrollersSKRP.ÑontrollersList;
  var DataSet: TDataSet;
      i: integer;
begin
  //ïîëó÷àåì ñïèñîê òèïîâ êîíòğîëëåğîâ
  if not DM.QueryServer('SELECT * FROM TypeControllers', FormÑontrollersSKRP.Caption, 'ÑontrollersList', true) then exit;

  DM.ADOQueryServerMDB.First;
  ComboBoxTypeControllers.Items.Clear;
  while not DM.ADOQueryServerMDB.EOF do
    begin
      ComboBoxTypeControllers.Items.AddObject(DM.ADOQueryServerMDB.FieldByName('Nc_NameController').AsString,
                                   TObject(integer(DM.ADOQueryServerMDB.FieldByName('Nc_Code').AsInteger)));
      DM.ADOQueryServerMDB.Next; // ãî íà ñëåäóşùåãî
    end;

  //ïîëó÷àåì ñïèñîê âñåõ êîíòğîëëåğîâ
  try
    ADOQueryÑontrollersSKRP.SQL.Clear;
    ADOQueryÑontrollersSKRP.SQL.Add('SELECT Controllers.*, TypeControllers.* ' +
            'FROM Controllers LEFT JOIN TypeControllers ON Controllers.Cn_TypeController = TypeControllers.Nc_Code');
    ADOQueryÑontrollersSKRP.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[ÑontrollersList]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryÑontrollersSKRP.SQL.Text +'"'),
                               PChar(FormÑontrollersSKRP.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;
  Row_Count:= DataSourceÑontrollersSKRP.DataSet.RecordCount;

  with DBGridListÑontrollers do
    begin
      Columns[0].Visible:= false;  //ñêğûâàåì êîëîíêó Cn_Code
      Columns[1].Title.Alignment:= taCenter;
      Columns[2].Title.Alignment:= taCenter;
      //ñêğûâàåì êîëîíêè
      for i := 3 to 9 do
        Columns[i].Visible:= false;
    end;

  ADOQueryÑontrollersSKRPAfterScroll(DataSet);
end;

procedure TFormÑontrollersSKRP.ProcedureChangeData(param: boolean);   //ïğèçíàê, ÷òî äàííûå áûëè èçìåíåíû
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //åñëè äàííûå áûëè èçìåíåíû, ğàçğåøàåì êíîïêó "Ïğèìåíèòü"
end;

end.

