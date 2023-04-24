unit UnitÑoefficients;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.StdCtrls, UnitDM,
  Vcl.DBGrids, Data.Win.ADODB, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, UnitMyForm{îáÿçàòåëüíî ÏÎÑËÅÄÍÈÌ};

type
  TFormÑoefficients = class(TForm)
    Label1: TLabel;
    EditÑoefficientsName: TEdit;
    StringGridÑoefficients: TStringGrid;
    ADOQueryÑoefficientsName: TADOQuery;
    DataSourceÑoefficientsName: TDataSource;
    SpeedButtonDeleteÑoefficients: TSpeedButton;
    SpeedButtonAddÑoefficients: TSpeedButton;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ADOQueryÑoefficientsNameCf_Code: TAutoIncField;
    ADOQueryÑoefficientsNameCf_Name: TWideStringField;
    ADOQueryÑoefficientsNameK1: TFloatField;
    ADOQueryÑoefficientsNameK2: TFloatField;
    ADOQueryÑoefficientsNameK3: TFloatField;
    ADOQueryÑoefficientsNameK4: TFloatField;
    ADOQueryÑoefficientsNameK5: TFloatField;
    ADOQueryÑoefficientsNameK6: TFloatField;
    ADOQueryÑoefficientsNameK7: TFloatField;
    ADOQueryÑoefficientsNameK8: TFloatField;
    ADOQueryÑoefficientsNameK9: TFloatField;
    ADOQueryÑoefficientsNameK10: TFloatField;
    ADOQueryÑoefficientsNameK11: TFloatField;
    ADOQueryÑoefficientsNameK12: TFloatField;
    ADOQueryÑoefficientsNameK13: TFloatField;
    ADOQueryÑoefficientsNameK14: TFloatField;
    Panel1: TPanel;
    DBGridListÑoefficients: TDBGrid;
    Memo1: TMemo;
    Memo2: TMemo;
    SpeedButtonInfo: TSpeedButton;
    ButtonFromFile: TButton;
    ButtonClose: TButton;
    SpeedButtonLoadÑoefficients: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListÑoefficients;
    procedure ADOQueryÑoefficientsNameAfterScroll(DataSet: TDataSet);
    procedure ClearAllData;
    procedure StringGridÑoefficientsDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridÑoefficientsClick(Sender: TObject);
    procedure StringGridÑoefficientsKeyPress(Sender: TObject; var Key: Char);
    procedure EditÑoefficientsNameKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButtonInfoClick(Sender: TObject);

    procedure ButtonCancelClick(Sender: TObject);
    procedure SaveDataInBD;
    procedure ButtonSaveClick(Sender: TObject);
    procedure SpeedButtonAddÑoefficientsClick(Sender: TObject);
    procedure SpeedButtonDeleteÑoefficientsClick(Sender: TObject);
    procedure ADOQueryÑoefficientsNameBeforeScroll(DataSet: TDataSet);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ProcedureChangeData(param: boolean = true);   //ïğèçíàê, ÷òî äàííûå áûëè èçìåíåíû
    function SaveCopyDataCoefficients: boolean;
    procedure SpeedButtonLoadÑoefficientsClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateÑoefficientsList(SetCursorPosition: boolean);

    const
      ColWidths0 = 150;     //Øèğèíà êîëîíêè 0 â StringGridUserList
      ColWidths1 = 205;     //Øèğèíà êîëîíêè 1 â StringGridUserList

    var
      ChangeData: boolean;  //ïğîèçîøëè ëè èçìåíåíèÿ ñ äàííûìè äëÿ äèàëîãà, ÷òîáû
                            //èçìåíåííûå äàííûå çàïèñàòü â áàçó äàííûõ
      Row_Count: integer;
      RegimEdit: boolean;   //ïîëÿ íàõîäÿòñÿ â ğåæèìå ğåäàêòèğîâàíèÿ
  public
    { Public declarations }
  end;


var
  FormÑoefficients: TFormÑoefficients;
  CodeÑoefficients: integer;
implementation
uses MainUnit, UnitSettingsProgramm, UnitLoadÑoefficients, RudaGlobals;
{$R *.dfm}

procedure TFormÑoefficients.ADOQueryÑoefficientsNameBeforeScroll(
  DataSet: TDataSet);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormÑoefficients.ButtonCancelClick(Sender: TObject);
begin
  UpdateÑoefficientsList(true);
end;

procedure TFormÑoefficients.ButtonCloseClick(Sender: TObject);
begin
  FormÑoefficients.Close;
end;

procedure TFormÑoefficients.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

procedure TFormÑoefficients.ClearAllData;
  var R_Row: integer;
begin
  CodeÑoefficients:= 0;
  EditÑoefficientsName.Clear;
  // î÷èùàåì òàáëèöó
  with StringGridÑoefficients do
    //Çàãîëîâêè ñòîëáöîâ íå òğîãàåì - öèêë îò 1
    for R_Row := 1 to RowCount - 1 do
      begin
        cells[0, R_Row]:= 'K' + IntToStr(R_Row);
        cells[1, R_Row]:= '0';
      end;
end;

procedure TFormÑoefficients.EditÑoefficientsNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
end;

procedure TFormÑoefficients.ADOQueryÑoefficientsNameAfterScroll(
  DataSet: TDataSet);
  var R_Row: integer;
      K_Data: string;
begin
  ClearAllData;
  if Row_Count > 0 then
    begin
      CodeÑoefficients:= DBGridListÑoefficients.DataSource.DataSet.FieldByName('Cf_Code').AsInteger;
      EditÑoefficientsName.Text:= Trim(DBGridListÑoefficients.DataSource.DataSet.FieldByName('Cf_Name').AsString);
      //çàíîñèì äàííûå â òàáëèöó
      with StringGridÑoefficients do
        for R_Row:= 1 to RowCount -1 do
          begin
            K_Data:= Trim(DBGridListÑoefficients.DataSource.DataSet.FieldByName('K' + IntToStr(R_Row)).AsString);
            if K_Data = '' then cells[1, R_Row]:= '0'
                           else cells[1, R_Row]:= K_Data;
          end;
    end;
  StringGridÑoefficients.Row:= 1;  //óñòàíàâëèâàåì íà ïåğâóş ñòğîêó
  ProcedureChangeData(false);              //÷òîáû íå çàôèêñèğîâàòü èçìåíåíèÿ ïğè ïğîêğóòêè ñêğîëîì è äàííûå íå çàïèñûâàëèñü â áàçó äàííûõ
end;

procedure TFormÑoefficients.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormÑoefficients.FormCreate(Sender: TObject);
begin
  FormÑoefficients.Caption:= ProgName_ShortStringVersion + FormÑoefficients.Caption;
  StringGridÑoefficients.RowCount:= 15;

  StringGridÑoefficients.ColWidths[0]:= ColWidths0;
  StringGridÑoefficients.ColWidths[1]:= ColWidths1;
end;

procedure TFormÑoefficients.SaveDataInBD;
  var R_Row: integer;
            K_Data: string;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //ïğîâåğÿì íà ñîñòîÿíèå ñæàòèÿ áàç äàííûõ. åñëè ñåé÷àñ ñæèìàşòñÿ - âûõîäèì.
  if Application.MessageBox(PChar('Ñîõğàíèòü êîıôôèöèåíòû äëÿ: "' +
                                  EditÑoefficientsName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ÂÍÈÌÀÍÈÅ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if Trim(EditÑoefficientsName.Text) = '' then
        begin
          Application.MessageBox(PChar('Íåäîñòàòî÷íî äàííûõ â ïîëå: "' +
                                 Copy(Label1.Caption, 1 ,Length(Label1.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ÂÍÈÌÀÍÈÅ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditÑoefficientsName.SetFocus;
          exit;
        end;

      //ïğîáåãàåì ïî âñåì ÿ÷åéêàì è ïğîâåğÿåì êîğğåòíîñòü ââîäà ÷èñåë
      with StringGridÑoefficients do
        for R_Row:= 1 to RowCount -1 do
          begin
            K_Data:= Trim(StringGridÑoefficients.Cells[1, R_Row]);
            if not CheckNumeric(K_Data) then
              begin
                Application.MessageBox(PChar('Îøèáêà ïğè ââîäå çíà÷åíèÿ êîıôôèöèåíòà.' + #13#10 +
                                    'Ğàçğåøåíî ââîäèòü ñëåäóşùèå ñèìâîëû: öèôû, çàïÿòàÿ èëè çíàê "ìèíóñ".'),
                                  PChar(ProgName_ShortStringVersion + ' Îøèáêà !!!'),
                                  MB_OK + MB_ICONERROR);
                //óñòàíàâëèâàåì êóğñîğ íà íåïğàâèëüíóş ïîçèöèş
                StringGridÑoefficients.Row:= R_Row;
                StringGridÑoefficients.SetFocus;
                exit;
              end;

          end;
      if CodeÑoefficients = 0 then        //çàíîñèì íîâóş çàïèñü
        begin
          if not DM.QueryWorkStation('INSERT INTO Cf (Cf_Name,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14) VALUES (''' +
                    EditÑoefficientsName.Text + ''', ''' +
                    StringGridÑoefficients.Cells[1, 1] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 2] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 3] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 4] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 5] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 6] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 7] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 8] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 9] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 10] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 11] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 12] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 13] + ''', ''' +
                    StringGridÑoefficients.Cells[1, 14] + ''')',
                      FormÑoefficients.Caption, 'SaveDataInBD', false) then exit;

          //óçíàåì íîìåğ óíèêàëüíîé çàïèñè êîıôôèöèåíòîâ (ïîñëåäíåé çàïèñè)
          if not DM.QueryWorkStation('SELECT MAX(Cf_Code) as cod FROM Cf',
                        FormÑoefficients.Caption, 'SaveDataInBD', true) then exit;

          if not DM.ADOQueryWorkStationMDB.Eof then CodeÑoefficients:= DM.ADOQueryWorkStationMDB.FieldByName('cod').AsInteger;
          if CodeÑoefficients = 0 then exit;
        end
        else    //èçìåíÿåì äàííûå, åñëè çàïèñü óæå áûëà
        begin
          if not DM.QueryWorkStation('UPDATE Cf SET Cf_Name = ''' +
                EditÑoefficientsName.Text + ''', ' +
                'K1 = ''' + StringGridÑoefficients.Cells[1, 1] + ''', ' +
                'K2 = ''' + StringGridÑoefficients.Cells[1, 2] + ''', ' +
                'K3 = ''' + StringGridÑoefficients.Cells[1, 3] + ''', ' +
                'K4 = ''' + StringGridÑoefficients.Cells[1, 4] + ''', ' +
                'K5 = ''' + StringGridÑoefficients.Cells[1, 5] + ''', ' +
                'K6 = ''' + StringGridÑoefficients.Cells[1, 6] + ''', ' +
                'K7 = ''' + StringGridÑoefficients.Cells[1, 7] + ''', ' +
                'K8 = ''' + StringGridÑoefficients.Cells[1, 8] + ''', ' +
                'K9 = ''' + StringGridÑoefficients.Cells[1, 9] + ''', ' +
                'K10 = ''' + StringGridÑoefficients.Cells[1, 10] + ''', ' +
                'K11 = ''' + StringGridÑoefficients.Cells[1, 11] + ''', ' +
                'K12 = ''' + StringGridÑoefficients.Cells[1, 12] + ''', ' +
                'K13 = ''' + StringGridÑoefficients.Cells[1, 13] + ''', ' +
                'K14 = ''' + StringGridÑoefficients.Cells[1, 14] + ''' WHERE CF_Code = ' + IntToStr(CodeÑoefficients),
                FormÑoefficients.Caption, 'SaveDataInBD', false) then exit;
          
        end;

        SaveCopyDataCoefficients;
    end;
  ProcedureChangeData(false);
  UpdateÑoefficientsList(true);
end;

function TFormÑoefficients.SaveCopyDataCoefficients: boolean;       //ñîõğàíÿåì ğåçåğâíóş êîïèş êîıôôèöèåíòû

var List: TStringList;
    TextSQL: string;
    i: integer;
    res: boolean;
    order: string;
begin
  try
    List:= TStringList.Create;
    res:= false;
    DM.ADOConnectionWorkStationMDB.GetTableNames(List);   //ïîëó÷àåì èìåíà âñåõ òàáëèö â áàçå WorkStation
    if List.IndexOf(TableNameReserveCopyCoefficients) = -1 then //çíà÷èò òàêîé òàáëèöû íåò. ñîçäàåì åå
       begin
         TextSQL:= 'CREATE TABLE ' + TableNameReserveCopyCoefficients +' (CfRes_Code COUNTER primary key,' +
                        'Res_Date DATETIME,' +
                        'Res_Name TEXT(50) NOT NULL, ';
          for i:= 1 to CountCoeff do
             begin
                TextSQL:= TextSQL + 'Res_K' + inttostr(i) + ' DOUBLE NULL, ';
              end;

          TextSQL:= TextSQL + 'Res_Order TEXT(100) NULL)';

          res:= DM.QueryWorkStation(TextSQL, FormÑoefficients.Caption, 'SaveCopyDataCoefficients', false);
       end
       else res:= true;

    if res then    //åñëè âñå õîğîøî è òàáëèöà ñîçäàíà, åñëè åå íå áûëî, ïğèñòóïàåì ê ñîõğàíåíèş äàííûõ
      begin
        TextSQL:= 'INSERT INTO ' + TableNameReserveCopyCoefficients + ' (Res_Date, Res_Name, ';
        for i:= 1 to CountCoeff do
          begin
            TextSQL:= TextSQL + 'Res_K' + inttostr(i) + ', ';
          end;
        TextSQL:= TextSQL + 'Res_Order) VALUES (''' + FormatDateTime('dd.mm.yy hh:nn:ss', now) + ''', ''' +
                  EditÑoefficientsName.Text + ''',''';
        for i:= 1 to CountCoeff do
          begin
            TextSQL:= TextSQL + StringGridÑoefficients.Cells[1, i] + ''', ''';

          end;

        TextSQL:= TextSQL + order + ''')';

        res:= DM.QueryWorkStation(TextSQL, FormÑoefficients.Caption, 'SaveCopyDataCoefficients', false);
      end;

  finally
    FreeAndNil(List);
    result:= res;
  end;

end;

procedure TFormÑoefficients.UpdateÑoefficientsList(SetCursorPosition: boolean);
  var TempCode: integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //ïğîâåğÿì íà ñîñòîÿíèå ñæàòèÿ áàç äàííûõ. åñëè ñåé÷àñ ñæèìàşòñÿ - âûõîäèì.
  FormÑoefficients.Color:= clBtnFace;
//  EditÑoefficientsName.Color:= clWhite;
//  StringGridÑoefficients.Color:= clWhite;
  RegimEdit:= false;

  SpeedButtonAddÑoefficients.Enabled:= true;
  DBGridListÑoefficients.Enabled:= true;

  TempCode:= CodeÑoefficients;    //çàïîìèíàåì ïîçèöèş êóğñîğà â DBGrid
  ListÑoefficients;
  if SetCursorPosition then
    begin
      CodeÑoefficients:= TempCode;
      //âîññòàíàâëèâàåì ïîçèöèş êóğñîğà
      DBGridListÑoefficients.DataSource.DataSet.Locate('Cf_Code', CodeÑoefficients, []);
    end;
  DBGridListÑoefficients.SetFocus;
end;

procedure TFormÑoefficients.ListÑoefficients;
  var DataSet: TDataSet;
      i: integer;
begin
  //ïîëó÷àåì ñïèñîê âñåõ êîıôôèöèåíòîâ
  try
    ADOQueryÑoefficientsName.SQL.Clear;
    ADOQueryÑoefficientsName.SQL.Add('SELECT * FROM Cf');
    ADOQueryÑoefficientsName.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[ListÑoefficients]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryÑoefficientsName.SQL.Text +'"'),
                               PChar(FormÑoefficients.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;
  Row_Count:= DataSourceÑoefficientsName.DataSet.RecordCount;

  with DBGridListÑoefficients do
    begin
      Columns[0].Visible:= false;  //ñêğûâàåì êîëîíêó Cf_Code
      Columns[1].Title.Alignment:= taCenter;
      //ñêğûâàåì êîëîíêè K1..K14 â DBGridListÑoefficients
      for i := 2 to 15 do
        Columns[i].Visible:= false;
    end;

  SpeedButtonDeleteÑoefficients.Enabled:= (DataSourceÑoefficientsName.DataSet.RecordCount > 0);
  EditÑoefficientsName.Enabled:= (DataSourceÑoefficientsName.DataSet.RecordCount > 0);
  StringGridÑoefficients.Enabled:= (DataSourceÑoefficientsName.DataSet.RecordCount > 0);

  ADOQueryÑoefficientsNameAfterScroll(DataSet);
end;

procedure TFormÑoefficients.SpeedButtonAddÑoefficientsClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //ïğîâåğÿì íà ñîñòîÿíèå ñæàòèÿ áàç äàííûõ. åñëè ñåé÷àñ ñæèìàşòñÿ - âûõîäèì.
  if ChangeData then SaveDataInBD;

  SpeedButtonAddÑoefficients.Enabled:= false;
  SpeedButtonDeleteÑoefficients.Enabled:= false;
  DBGridListÑoefficients.Enabled:= false;

  EditÑoefficientsName.Enabled:= true;
  StringGridÑoefficients.Enabled:= true;

  FormÑoefficients.Color:= ColorEdit;
//  EditÑoefficientsName.Color:= ColorEdit;
//  StringGridÑoefficients.Color:= ColorEdit;
//  RegimEdit:= true;

  ClearAllData;
  EditÑoefficientsName.SetFocus;
end;

procedure TFormÑoefficients.SpeedButtonDeleteÑoefficientsClick(
  Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //ïğîâåğÿì íà ñîñòîÿíèå ñæàòèÿ áàç äàííûõ. åñëè ñåé÷àñ ñæèìàşòñÿ - âûõîäèì.
  if Application.MessageBox(PChar('Óäàëèòü çàïèñü: "' +
                                  EditÑoefficientsName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ÂÍÈÌÀÍÈÅ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if not DM.QueryWorkStation('DELETE FROM Cf WHERE Cf_Code = ' + IntToStr(CodeÑoefficients),
                FormÑoefficients.Caption, 'SpeedButtonDeleteÑoefficientsClick', false) then exit;
      UpdateÑoefficientsList(false);
    end;
end;

procedure TFormÑoefficients.SpeedButtonInfoClick(Sender: TObject);
begin
  if SpeedButtonInfo.Down then
    begin
      SpeedButtonInfo.Hint:= 'Ñêğûòü ôîğìóëó ğàñ÷åòà æåëåçà';
      Memo1.Align:= alNone;
      Memo2.Visible:= SpeedButtonInfo.Down;
      Memo1.Align:= alBottom;
    end
    else
    begin
      SpeedButtonInfo.Hint:= 'Îòîáğàçèòü ôîğìóëó ğàñ÷åòà æåëåçà';
      Memo2.Visible:= SpeedButtonInfo.Down;
    end;
end;

procedure TFormÑoefficients.SpeedButtonLoadÑoefficientsClick(Sender: TObject);
var List: TStringList;
    TextSQL: string;
    noData: boolean;
begin
  try
    List:= TStringList.Create;
    DM.ADOConnectionWorkStationMDB.GetTableNames(List);   //ïîëó÷àåì èìåíà âñåõ òàáëèö â áàçå WorkStation
    noData:= List.IndexOf(TableNameReserveCopyCoefficients) = -1;    //çíà÷èò òàêîé òàáëèöû íåò
    if not noData then  //òàáëèöà åñòü ïğîâåğÿåì, ÷òî â íåé ïğèñóòâóşò äàííûå
      begin
        //ïîëó÷àåì ñïèñîê âñåõ ğàíåå ñîõğàíåííûõ êîıôôèöèåíòîâ
        if not DM.QueryWorkStation('SELECT * FROM ' + TableNameReserveCopyCoefficients,
                                  FormÑoefficients.Caption, 'SpeedButtonLoadÑoefficientsClick', true) then exit;

        noData:= DM.DataSourceWorkStationMDB.DataSet.RecordCount = 0;
      end;

    if noData then //íåò äàííûõ èëè ñàìîé òàáëèöû
      begin
        Application.MessageBox('Ñîõğàíåííûå êîıôôèöåíòû îòñóòñâóşò.',
                               PChar(FormÑoefficients.Caption),
                               MB_OK + MB_ICONINFORMATION);
      end
      else
      begin
        FormLoadÑoefficients.ShowModal; //çàãğóæàåì ôîğìó âûáîğà êîıôôèöèåíòîâ
      end;

  finally
    FreeAndNil(List);
  end;
end;

procedure TFormÑoefficients.StringGridÑoefficientsClick(Sender: TObject);
begin
  if StringGridÑoefficients.RowCount = 1 then exit;
  //÷òîáû êóğñîğ íå çàëåçàë íà øàïêó òàáëèöû
  if StringGridÑoefficients.Row < 2 then StringGridÑoefficients.Row:= 1;
end;

procedure TFormÑoefficients.StringGridÑoefficientsDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
   var   s: string;
      Flag: Cardinal;
begin
  with StringGridÑoefficients, StringGridÑoefficients.Canvas do
    begin
      if (gdSelected in State) and not RegimEdit then begin
              Brush.Color:=clSkyBlue;
        end
        else
            //Ôèêñèğîâàííûå ñòğîêè áóäóò öâåòîì ïî óìîë÷àíèş
          if (ACol=0) or (ARow=0) then begin      //(gdFixed in State)
              Brush.Color:=FixedColor;
          end
            //Âñå îñòàëüíûå ñòğîêè áóäóò öâåòîì ïî óìîë÷àíèş
          else begin
          if RegimEdit then Canvas.Brush.Color:= ColorEdit else Canvas.Brush.Color:= clWhite;
          end;
      //êğàñèì ÿ÷åéêè
      Rect.Left:= Rect.Left - 3;   //ñìåùàåì ëåâûé êğàé çàêğàñêè
      FillRect(Rect);
      SetBkMode(Handle, TRANSPARENT);

      if (ACol=0) and (ARow=0) then
        begin
          s:= 'Íàçâàíèå êîıôôèöèåíòà';
          Flag:= DT_VCENTER or DT_CENTER or DT_SINGLELINE;
          Inc(Rect.Left,3);
          Dec(Rect.Right,3);
          DrawText(StringGridÑoefficients.Canvas.Handle,PChar(s),length(s),Rect,Flag);
        end;

      if (ACol=1) and (ARow=0) then
        begin
          s:= 'Çíà÷åíèå êîıôôèöèåíòà';
          //Åñëè íåò ïåğåíîñà ñëîâ, òî âûğîâíÿòü ïî öåíòğó âåğòèêàëè è ãîğèçîíòàëè ìîæíî òàê
          Flag:= DT_VCENTER or DT_CENTER or DT_SINGLELINE;;
          Inc(Rect.Left,3);
          Dec(Rect.Right,3);
          DrawText(StringGridÑoefficients.Canvas.Handle,PChar(s),length(s),Rect,Flag);
        end;

      if ARow>0 then       //îñíîâíîé òåêñò
        begin
          Flag:= DT_SINGLELINE OR DT_VCENTER OR DT_LEFT;
          Inc(Rect.Left,3);
          Dec(Rect.Right,3);//ñìåùàåì òåêñò îò ëåâîãî êğàÿ
          DrawText(Handle, pchar(Cells[ACol, ARow]), -1, Rect, Flag);
        end;
    end;
end;

procedure TFormÑoefficients.StringGridÑoefficientsKeyPress(Sender: TObject;
  var Key: Char);
begin
//  //ïğîâåğêà íåò ëè ïîâòîğíûõ çàïÿòûõ èëè çíàêîâ ìèíóñ
//  if ((Key = ',') and (pos(',', StringGridÑoefficients.Cells[StringGridÑoefficients.Col, StringGridÑoefficients.Row]) > 0)) or
//     ((Key = '-') and (pos('-', StringGridÑoefficients.Cells[StringGridÑoefficients.Col, StringGridÑoefficients.Row]) > 0)) then
//        key:= #0;
//
//  if not (Key in ['0'..'9', ',', '-', #08, #13]) then
//    begin
//      Application.MessageBox(PChar('Ğàçğåøåíî ââîäèòü ñëåäóşùèå ñèìâîëû: öèôğû, çàïÿòàÿ èëè çíàê "ìèíóñ".'),
//                            PChar(ProgName_ShortStringVersion + ' Îøèáêà ââîäà !!!'),
//                            MB_OK + MB_ICONSTOP);
//      key:= #0;
//    end;
  DM.CheckSignFloatPressKey('"Êîıôôèöèåíò"',
         StringGridÑoefficients.Cells[StringGridÑoefficients.Col, StringGridÑoefficients.Row],
                                Key);
  ProcedureChangeData;
end;

procedure TFormÑoefficients.FormShow(Sender: TObject);
begin
  EditÑoefficientsName.Clear;
  ListÑoefficients;
  DBGridListÑoefficients.SetFocus;
  ProcedureChangeData(false);
  RegimEdit:= false;
end;

procedure TFormÑoefficients.ProcedureChangeData(param: boolean = true);   //ïğèçíàê, ÷òî äàííûå áûëè èçìåíåíû
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //åñëè äàííûå áûëè èçìåíåíû, ğàçğåøàåì êíîïêó "Ïğèìåíèòü"
end;

end.


