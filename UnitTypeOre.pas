unit UnitTypeOre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, UnitMyForm{обязательно ПОСЛЕДНИМ};

type
  TFormTypeOre = class(TForm)
    DBGridListTypeOre: TDBGrid;
    ADOQueryTypeOre: TADOQuery;
    DataSourceTypeOre: TDataSource;
    SpeedButtonAddTypeOre: TSpeedButton;
    SpeedButtonDeleteTypeOre: TSpeedButton;
    Label1: TLabel;
    EditTypeOre: TEdit;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ButtonClose: TButton;
    ADOQueryTypeOreT_Code: TAutoIncField;
    ADOQueryTypeOreT_Name: TWideStringField;
    ADOQueryTypeOreT_CodeSQL: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TypeOreList;
    procedure ADOQueryTypeOreAfterScroll(DataSet: TDataSet);
    procedure ClearAllData;
    procedure ADOQueryTypeOreBeforeScroll(DataSet: TDataSet);
    procedure SaveDataInBD;
    procedure UpdateTypeOre(SetCursorPosition: boolean);
    procedure EditTypeOreKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure SpeedButtonAddTypeOreClick(Sender: TObject);
    procedure SpeedButtonDeleteTypeOreClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
  private
    { Private declarations }
    var
      ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                            //измененные данные записать в базу данных
      Row_Count: integer;
  public
    { Public declarations }
  end;

var
  FormTypeOre: TFormTypeOre;
  CodeTypeOre: integer;

implementation
uses MainUnit, UnitDM, UnitSettingsProgramm;

{$R *.dfm}

procedure TFormTypeOre.ADOQueryTypeOreAfterScroll(DataSet: TDataSet);
begin
  ClearAllData;
  if Row_Count > 0 then
    begin
      CodeTypeOre:= DBGridListTypeOre.DataSource.DataSet.FieldByName('T_Code').AsInteger;
      EditTypeOre.Text:= Trim(DBGridListTypeOre.DataSource.DataSet.FieldByName('T_Name').AsString);
    end;
  ProcedureChangeData(false);  //чтобы не зафиксировать изменения при прокрутки скролом и данные не записывались в базу данных
end;

procedure TFormTypeOre.ADOQueryTypeOreBeforeScroll(DataSet: TDataSet);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormTypeOre.ButtonCancelClick(Sender: TObject);
begin
  UpdateTypeOre(true);
end;

procedure TFormTypeOre.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormTypeOre.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

procedure TFormTypeOre.SaveDataInBD;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Сохранить изменения для руды: "' +
                                  EditTypeOre.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if EditTypeOre.Text = '' then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                 Copy(Label1.Caption, 1 ,Length(Label1.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          exit;
        end;

        if CodeTypeOre = 0 then        //заносим новую запись
        begin
          if not DM.QueryServer('INSERT INTO TYPEORE (T_Name) VALUES (''' +
                                Trim(EditTypeOre.Text)  + ''')',
                                FormTypeOre.Caption, 'SaveDataInBD', false) then exit;

          //узнаем номер уникальной записи нового типа руды (последней записи)
          if not DM.QueryServer('SELECT MAX(T_Code) as cod FROM TYPEORE',
                                  FormTypeOre.Caption, 'SaveDataInBD', true) then exit;

          if not DM.ADOQueryServerMDB.Eof then CodeTypeOre:= DM.ADOQueryServerMDB.FieldByName('cod').AsInteger;
          if CodeTypeOre = 0 then exit;
        end
        else
        begin
          if not DM.QueryServer('UPDATE TYPEORE SET T_Name = ''' + Trim(EditTypeOre.Text) +
                                ''' WHERE T_Code = ' + IntToStr(CodeTypeOre),
                                FormTypeOre.Caption, 'SaveDataInBD', false) then exit;
        end;
    end;
  ProcedureChangeData(false);
  UpdateTypeOre(true);
end;

procedure TFormTypeOre.SpeedButtonAddTypeOreClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if ChangeData then SaveDataInBD;
  EditTypeOre.Clear;

  SpeedButtonAddTypeOre.Enabled:= false;
  SpeedButtonDeleteTypeOre.Enabled:= false;
  DBGridListTypeOre.Enabled:= false;
  EditTypeOre.Enabled:= true;

  FormTypeOre.Color:= ColorEdit;
//  EditTypeOre.Color:= ColorEdit;

  EditTypeOre.SetFocus;
  ClearAllData;
  ProcedureChangeData;
end;

procedure TFormTypeOre.SpeedButtonDeleteTypeOreClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Удалить запись тип руды: "' +
                                  EditTypeOre.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
      if not DM.QueryServer('DELETE FROM TYPEORE WHERE T_Code = ' + IntToStr(CodeTypeOre),
                FormTypeOre.Caption, 'SpeedButtonDeleteTypeOreClick', false) then exit;
      UpdateTypeOre(false);
    end;
end;

procedure TFormTypeOre.UpdateTypeOre(SetCursorPosition: boolean);
  var DataSet: TDataSet;
      TempCodeRegime: integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  FormTypeOre.Color:= clBtnFace;
//  EditTypeOre.Color:= clWhite;

  SpeedButtonAddTypeOre.Enabled:= true;
  DBGridListTypeOre.Enabled:= true;

  TempCodeRegime:= CodeTypeOre; //запоминаем позицию курсора в DBGrid
  TypeOreList;
  if SetCursorPosition then
    begin
      CodeTypeOre:= TempCodeRegime;
      //восстанавливаем позицию курсора
      DBGridListTypeOre.DataSource.DataSet.Locate('T_Code', CodeTypeOre, []);
    end;
  DBGridListTypeOre.SetFocus;
end;

procedure TFormTypeOre.ClearAllData;
begin
  CodeTypeOre:= 0;
  EditTypeOre.Clear;
end;

procedure TFormTypeOre.EditTypeOreKeyPress(Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
end;

procedure TFormTypeOre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ChangeData then SaveDataInBD;
  UpdateTypeOre(false);
end;

procedure TFormTypeOre.FormCreate(Sender: TObject);
begin
  FormTypeOre.Caption:= ProgName_ShortStringVersion + FormTypeOre.Caption;
end;

procedure TFormTypeOre.FormShow(Sender: TObject);
begin
  EditTypeOre.Clear;
  TypeOreList;
  DBGridListTypeOre.SetFocus;
  ProcedureChangeData(false);
end;

procedure TFormTypeOre.TypeOreList;
  var DataSet: TDataSet;
begin
  //получаем список всех типов руд
  try
    ADOQueryTypeOre.SQL.Clear;
    ADOQueryTypeOre.SQL.Add('SELECT * FROM TypeOre');
    ADOQueryTypeOre.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[TypeOreList]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryTypeOre.SQL.Text +'"'),
                               PChar(FormTypeOre.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;
  Row_Count:= DataSourceTypeOre.DataSet.RecordCount;

  with DBGridListTypeOre do
    begin
      Columns[0].Visible:= false;  //скрываем колонку T_Code
      Columns[1].Title.Alignment:= taCenter;
      Columns[2].Visible:= false;  //скрываем колонку T_CodeSQL
    end;

  SpeedButtonDeleteTypeOre.Enabled:= (DataSourceTypeOre.DataSet.RecordCount > 0);
  EditTypeOre.Enabled:= (DataSourceTypeOre.DataSet.RecordCount > 0);

  ADOQueryTypeOreAfterScroll(DataSet);
end;

procedure TFormTypeOre.ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //если данные были изменены, разрешаем кнопку "Применить"
end;

end.
