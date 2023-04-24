unit UnitLoad—oefficients;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.Win.ADODB, UnitMyForm{Ó·ˇÁ‡ÚÂÎ¸ÌÓ œŒ—À≈ƒÕ»Ã};

type
  TFormLoad—oefficients = class(TForm)
    DBGridLoad—oefficients: TDBGrid;
    ButtonLoad: TButton;
    ButtonDelete: TButton;
    ButtonClose: TButton;
    ADOQueryLoad—oefficients: TADOQuery;
    DataSourceLoad—oefficients: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure DBGridLoad—oefficientsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ADOQueryLoad—oefficientsAfterScroll(DataSet: TDataSet);
    procedure ButtonLoadClick(Sender: TObject);
  private
    { Private declarations }
    procedure ListLoad—oefficients;
    procedure ClearAllData;
    procedure UpdateLoad—oefficientsList(SetCursorPosition: boolean);
    var Row_Count: integer;
        Edit—oefficientsName: string;
        CodeLoad—oefficients: integer;
        DT: TDateTime;
  public
    { Public declarations }
    procedure SetButtonToCenterForm(Form: TForm; ButtonLeft, ButtonCenter, ButtonRight: TButton; IntervalBetweenButtons: integer);
  end;

var
  FormLoad—oefficients: TFormLoad—oefficients;

implementation

{$R *.dfm}

uses UnitDM, RudaGlobals, Unit—oefficients, MainUnit;

//‚˚‚Ó‰ËÏ ÔÓˇ‰ÍÓ‚˚È ÌÓÏÂ ÒÚÓÍË
procedure TFormLoad—oefficients.ADOQueryLoad—oefficientsAfterScroll(
  DataSet: TDataSet);
begin
  ClearAllData;
  if Row_Count > 0 then
    begin
      CodeLoad—oefficients:= DBGridLoad—oefficients.DataSource.DataSet.FieldByName('CfRes_Code').AsInteger;
      Edit—oefficientsName:= Trim(DBGridLoad—oefficients.DataSource.DataSet.FieldByName('Res_Name').AsString);
      DT:= DBGridLoad—oefficients.DataSource.DataSet.FieldByName('Res_Date').AsDateTime;
    end;
end;

procedure TFormLoad—oefficients.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormLoad—oefficients.ClearAllData;
  var R_Row: integer;
begin
  CodeLoad—oefficients:= 0;
  Edit—oefficientsName:= '';
end;

procedure TFormLoad—oefficients.ButtonDeleteClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //ÔÓ‚ÂˇÏ Ì‡ ÒÓÒÚÓˇÌËÂ ÒÊ‡ÚËˇ ·‡Á ‰‡ÌÌ˚ı. ÂÒÎË ÒÂÈ˜‡Ò ÒÊËÏ‡˛ÚÒˇ - ‚˚ıÓ‰ËÏ.
  if Application.MessageBox(PChar('”‰‡ÎËÚ¸ Á‡ÔËÒ¸: "' + Edit—oefficientsName + '" ÓÚ ' +
                                  FormatDateTime('dd.mm.yyyy hh:nn:ss', DT) + '?'),
                                  PChar(ProgName_ShortStringVersion + ' ¬Õ»Ã¿Õ»≈ !!!'),
                                  MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if not DM.QueryWorkStation('DELETE FROM ' + TableNameReserveCopyCoefficients +
                                 ' WHERE CfRes_Code = ' + IntToStr(CodeLoad—oefficients),
                FormLoad—oefficients.Caption, 'ButtonDeleteClick', false) then exit;

      UpdateLoad—oefficientsList(false);
    end;
end;

procedure TFormLoad—oefficients.ButtonLoadClick(Sender: TObject);
var R_Row: integer;
    K_Data: string;
begin
  if Application.MessageBox(PChar('”ÒÚ‡ÌÓ‚ËÚ¸ ÁÌ‡˜ÂÌËˇ ÍÓ˝ÙÙËˆËÂÌÚÓ‚ ‰Îˇ "' + Form—oefficients.Edit—oefficientsName.Text +
                                 '" ËÁ ‡ÌÂÂ ÒÓı‡ÌÂÌÌ˚ı "' + Edit—oefficientsName + '" ÓÚ ' +
                                  FormatDateTime('dd.mm.yyyy hh:nn:ss', DT) + '?'),
                                  PChar(ProgName_ShortStringVersion + ' ¬Õ»Ã¿Õ»≈ !!!'),
                                  MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      //Á‡ÌÓÒËÏ ‰‡ÌÌ˚Â ‚ Ú‡·ÎËˆÛ
      with Form—oefficients.StringGrid—oefficients do
        for R_Row:= 1 to RowCount - 1 do
          begin
            K_Data:= Trim(DBGridLoad—oefficients.DataSource.DataSet.FieldByName('Res_K' + IntToStr(R_Row)).AsString);
            if K_Data = '' then cells[1, R_Row]:= '0'
                           else cells[1, R_Row]:= K_Data;
          end;
      Form—oefficients.StringGrid—oefficients.Row:= 1;  //ÛÒÚ‡Ì‡‚ÎË‚‡ÂÏ Ì‡ ÔÂ‚Û˛ ÒÚÓÍÛ
      Form—oefficients.ProcedureChangeData(true);
    end;
end;

procedure TFormLoad—oefficients.UpdateLoad—oefficientsList(SetCursorPosition: boolean);
  var TempCode: integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //ÔÓ‚ÂˇÏ Ì‡ ÒÓÒÚÓˇÌËÂ ÒÊ‡ÚËˇ ·‡Á ‰‡ÌÌ˚ı. ÂÒÎË ÒÂÈ˜‡Ò ÒÊËÏ‡˛ÚÒˇ - ‚˚ıÓ‰ËÏ.
  TempCode:= CodeLoad—oefficients;    //Á‡ÔÓÏËÌ‡ÂÏ ÔÓÁËˆË˛ ÍÛÒÓ‡ ‚ DBGrid
  ListLoad—oefficients;
  if SetCursorPosition then
    begin
      CodeLoad—oefficients:= TempCode;
      //‚ÓÒÒÚ‡Ì‡‚ÎË‚‡ÂÏ ÔÓÁËˆË˛ ÍÛÒÓ‡
      DBGridLoad—oefficients.DataSource.DataSet.Locate('CfRes_Code', CodeLoad—oefficients, []);
    end;
  DBGridLoad—oefficients.SetFocus;
end;

procedure TFormLoad—oefficients.DBGridLoad—oefficientsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  S : string;
  R : TRect;
begin
  if Column.Index = 0 then begin
    if DBGridLoad—oefficients.DataSource.DataSet.RecNo >= 1 then begin
      S := IntToStr(DBGridLoad—oefficients.DataSource.DataSet.RecNo);
      R := Rect;
      InflateRect(R, -2, -2);
      DrawText(DBGridLoad—oefficients.Canvas.Handle, PChar(S), -1, R, DT_RIGHT);
    end;
  end;
end;

procedure TFormLoad—oefficients.FormResize(Sender: TObject);
var centrForm: integer;
begin
  SetButtonToCenterForm(FormLoad—oefficients, ButtonLoad, ButtonDelete, ButtonClose, 70);
end;

//ÛÒÚ‡Ì‡‚ÎË‚‡ÂÏ ÔÓ ˆÂÌÚÛ ÙÓÏ˚ ÚË ÍÌÓÔÍË
procedure TFormLoad—oefficients.SetButtonToCenterForm(Form: TForm; ButtonLeft, ButtonCenter, ButtonRight: TButton; IntervalBetweenButtons: integer);
const verticalOffset = 57;//‡ÒÚÓˇÌËÂ ‰Ó ÍÌÓÔÓÍ ÓÚ ÌËÊÌÂÈ „‡ÌËˆ˚ ÙÓÏ˚
begin
  ButtonCenter.Left:=  Form.Width div 2 - ButtonCenter.Width div 2;
  ButtonLeft.Left:= ButtonCenter.Left - ButtonLeft.Width - IntervalBetweenButtons;
  ButtonRight.Left:= ButtonCenter.Left + ButtonCenter.Width + IntervalBetweenButtons;
  ButtonCenter.Top:= Form.Height - ButtonCenter.Height - verticalOffset;
  ButtonLeft.Top:= Form.Height - ButtonLeft.Height - verticalOffset;
  ButtonRight.Top:= Form.Height - ButtonRight.Height - verticalOffset;
end;

procedure TFormLoad—oefficients.FormShow(Sender: TObject);
begin
  Caption:= '”ÒÚ‡ÌÓ‚ËÚ¸ ÁÌ‡˜ÂÌËˇ ÍÓ˝ÙÙËˆËÂÌÚÓ‚ ‰Îˇ "' + Form—oefficients.Edit—oefficientsName.Text + '"';
  ListLoad—oefficients;
end;

procedure TFormLoad—oefficients.ListLoad—oefficients;
  var DataSet: TDataSet;

begin
  //ÔÓÎÛ˜‡ÂÏ ÒÔËÒÓÍ ‚ÒÂı ÍÓ˝ÙÙËˆËÂÌÚÓ‚
  try
    ADOQueryLoad—oefficients.SQL.Clear;
    ADOQueryLoad—oefficients.SQL.Add('SELECT * FROM ' + TableNameReserveCopyCoefficients);
    ADOQueryLoad—oefficients.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[ListLoad—oefficients]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryLoad—oefficients.SQL.Text +'"'),
                               PChar(FormLoad—oefficients.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;
  Row_Count:= DataSourceLoad—oefficients.DataSet.RecordCount;
  ButtonLoad.Enabled:= (DataSourceLoad—oefficients.DataSet.RecordCount > 0);
  ButtonDelete.Enabled:= (DataSourceLoad—oefficients.DataSet.RecordCount > 0);
  ADOQueryLoad—oefficientsAfterScroll(DataSet);
end;

end.
