unit EnterpriseСompany;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids, Vcl.Samples.Spin, Vcl.Buttons;

type
  TFormEnterpriseСompany = class(TForm)
    EditRegimeName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBGridListRegime: TDBGrid;
    ADOQueryRegimeName: TADOQuery;
    DataSourceRegimeName: TDataSource;
    ADOQueryRegimeNameR_Code: TAutoIncField;
    ADOQueryRegimeNameR_Name: TWideStringField;
    ADOQueryRegimeNameSizeCh: TSmallintField;
    SpinEditNumSmena: TSpinEdit;
    StringGridSmena: TStringGrid;
    ADOQueryRegimeNameBegCh1: TWideStringField;
    ADOQueryRegimeNameEndCh1: TWideStringField;
    ADOQueryRegimeNameBegCh2: TWideStringField;
    ADOQueryRegimeNameEndCh2: TWideStringField;
    ADOQueryRegimeNameBegCh3: TWideStringField;
    ADOQueryRegimeNameEndCh3: TWideStringField;
    ADOQueryRegimeNameBegCh4: TWideStringField;
    ADOQueryRegimeNameEndCh4: TWideStringField;
    SpeedButtonAddRegime: TSpeedButton;
    SpeedButton1: TSpeedButton;
    ButtonCancel: TButton;
    ButtonSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RegimeList;
    procedure SpinEditNumSmenaKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridSmenaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGridSmenaClick(Sender: TObject);
    procedure StringGridSmenaGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure EditRegimeNameKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSaveClick(Sender: TObject);
    procedure SaveDataInBD;
    procedure SpinEditNumSmenaChange(Sender: TObject);
    procedure ADOQueryRegimeNameAfterScroll(DataSet: TDataSet);
    procedure ADOQueryRegimeNameBeforeScroll(DataSet: TDataSet);
    procedure SpeedButtonAddRegimeClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure UpdateRegimeList(SetCursorPosition: boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ClearAllData;
  private
    { Private declarations }
    const
      ColWidths0 = 107;
      ColWidths1 = 124;     //Ширина колонки 0 в StringGridUserList
      ColWidths2 = 124;     //Ширина колонки 1 в StringGridUserList

    var
      ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                            //измененные данные записать в базу данных

  public
    { Public declarations }
  end;

var
  FormEnterpriseСompany: TFormEnterpriseСompany;
  CodeRegime: integer;
  RowCount: integer;
  AddRegime: boolean; // режим добавления записи

implementation
uses MainUnit;
{$R *.dfm}

procedure TFormEnterpriseСompany.SaveDataInBD;
  var i, j: integer;
  s: string;
begin
  if Application.MessageBox(PChar('Сохранить изменения для режима работы: "' +
                                  EditRegimeName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if EditRegimeName.Text = '' then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                 Copy(Label1.Caption, 1 ,Length(Label1.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          exit;
        end;

      //пробегаем по всем ячейкам и проверяем корретность ввода времени
      with StringGridSmena do
        for i:= 1 to ColCount - 1 do  //Заголовки столбцов не трогаем - цикл от 1
          for  j:= 1 to RowCount - 1 do
            begin
              if not Form1.CheckTime(Cells[i, j]) then
                begin
                  Application.MessageBox(PChar('Ошибка при указании времени.' + #13#10+
                                  'Часы должны быть указаны в диапазоне от 0 до 23,' + #13#10 +
                                  'минуты от 0 до 59. Пустых значений не должно быть.'),
                                  PChar(ProgName_ShortStringVersion + ' Ошибка !!!'),
                                  MB_OK + MB_ICONERROR);
                  exit;
                end;
            end;
      if CodeRegime = 0 then        //заносим новую запись
        begin
          try
            Form1.ADOQueryServerMDB.SQL.Clear;
            Form1.ADOQueryServerMDB.SQL.Add('INSERT INTO REGIMS (R_Name, SizeCh) VALUES ("' +
                                            Trim(EditRegimeName.Text) + '", "' +
                                            IntToStr(SpinEditNumSmena.Value) + '")');
            Form1.ADOQueryServerMDB.ExecSQL
          except
            on e: Exception do
          end;

          //узнаем номер уникальной записи нового режима работы (последней записи)
          try
            Form1.ADOQueryServerMDB.SQL.Clear;
            Form1.ADOQueryServerMDB.SQL.Add('SELECT MAX(R_Code) as cod FROM REGIMS');
            Form1.ADOQueryServerMDB.Active:= true;
          except
            on e: Exception do
          end;

          if not Form1.ADOQueryServerMDB.Eof then CodeRegime:= Form1.ADOQueryServerMDB.FieldByName('cod').AsInteger;
          if CodeRegime = 0 then exit;
        end
        else
        begin                      //изменяем сущуствующую запись
          try
            Form1.ADOQueryServerMDB.SQL.Clear;
            Form1.ADOQueryServerMDB.SQL.Add('UPDATE REGIMS SET R_Name = "' + Trim(EditRegimeName.Text) +
                                      '", SizeCh = "' + IntToStr(SpinEditNumSmena.Value) +
                                      '" WHERE R_Code = ' + IntToStr(CodeRegime));
            Form1.ADOQueryServerMDB.ExecSQL;
          except
            on e: Exception do
          end;

        end;

        //заполняем таблицу времен
        for i := 1 to SpinEditNumSmena.Value do
          begin
            try
              Form1.ADOQueryServerMDB.SQL.Clear;
              Form1.ADOQueryServerMDB.SQL.Add('UPDATE REGIMS SET BegCh' + IntToStr(i) + ' = "' + Trim(StringGridSmena.Cells[1, i]) +
                                      '", EndCh' + IntToStr(i) + ' = "' + Trim(StringGridSmena.Cells[2, i]) +
                                      '" WHERE R_Code = ' + IntToStr(CodeRegime));
              Form1.ADOQueryServerMDB.ExecSQL;
            except
              on e: Exception do
            end;
          end;

        //дописываем не заполненную таблицу времени пустыми значениями
        i:= SpinEditNumSmena.Value + 1;
        while i < 5 do
          begin
            try
              Form1.ADOQueryServerMDB.SQL.Clear;
              Form1.ADOQueryServerMDB.SQL.Add('UPDATE REGIMS SET BegCh' + IntToStr(i) + ' = Null' +
                                      ', EndCh' + IntToStr(i) + ' = Null' +
                                      ' WHERE R_Code = ' + IntToStr(CodeRegime));
              s:= Form1.ADOQueryServerMDB.SQL.Text;
              Form1.ADOQueryServerMDB.ExecSQL;
            except
              on e: Exception do
            end;
            inc(i);
          end;
    end;
  ChangeData:= false;
  UpdateRegimeList(true);
end;

procedure TFormEnterpriseСompany.ADOQueryRegimeNameAfterScroll(
  DataSet: TDataSet);
var R_Row: integer;

begin
  ClearAllData;
  if RowCount > 0 then
    begin
      CodeRegime:= DBGridListRegime.DataSource.DataSet.FieldByName('R_Code').AsInteger;
      EditRegimeName.Text:= Trim(DBGridListRegime.DataSource.DataSet.FieldByName('R_Name').AsString);
      SpinEditNumSmena.Value:= DBGridListRegime.DataSource.DataSet.FieldByName('SizeCh').AsInteger;
      StringGridSmena.RowCount:= SpinEditNumSmena.Value + 1;
      //заносим данные в таблицу
      with StringGridSmena do
        for R_Row:= 1 to RowCount -1 do
          begin
            cells[1, R_Row]:= Trim(DBGridListRegime.DataSource.DataSet.FieldByName('BegCh' + IntToStr(R_Row)).AsString);
            cells[2, R_Row]:= Trim(DBGridListRegime.DataSource.DataSet.FieldByName('EndCh' + IntToStr(R_Row)).AsString);
          end;
    end;
  StringGridSmena.Row:= 1;  //устанавливаем на первую строку
  ChangeData:= false;  //чтобы не зафиксировать изменения при прокрутки скролом и данные не записывались в базу данных
end;

procedure TFormEnterpriseСompany.ADOQueryRegimeNameBeforeScroll(
  DataSet: TDataSet);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormEnterpriseСompany.UpdateRegimeList(SetCursorPosition: boolean);
  var DataSet: TDataSet;
      TempCodeRegime: integer;
begin
  EditRegimeName.Color:= clWhite;
  SpinEditNumSmena.Color:= clWhite;
  StringGridSmena.Color:= clWhite;

  DBGridListRegime.Enabled:= true;
  TempCodeRegime:= CodeRegime;    //запоминаем позицию курсора в DBGrid
  RegimeList;
//  ADOQueryRegimeNameAfterScroll(DataSet);
  if SetCursorPosition then
    begin
      CodeRegime:= TempCodeRegime;
      //восстанавливаем позицию курсора
      DBGridListRegime.DataSource.DataSet.Locate('R_Code', CodeRegime, []);
    end;
  DBGridListRegime.SetFocus;
end;

procedure TFormEnterpriseСompany.ButtonCancelClick(Sender: TObject);
begin
  UpdateRegimeList(true);
end;

procedure TFormEnterpriseСompany.ButtonSaveClick(Sender: TObject);
  var DataSet: TDataSet;
begin
  SaveDataInBD;
end;

procedure TFormEnterpriseСompany.EditRegimeNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  ChangeData:= true;
end;

procedure TFormEnterpriseСompany.FormCreate(Sender: TObject);
begin
  FormEnterpriseСompany.Caption:= ProgName_ShortStringVersion + FormEnterpriseСompany.Caption;
  StringGridSmena.RowCount:= 1;
   //подготавливаем высоту строки: //N - количество строк в ячейке
  StringGridSmena.RowHeights[0]:=(StringGridSmena.Canvas.TextHeight('A')+2)*2{N};
  StringGridSmena.ColWidths[0]:= ColWidths0;
  StringGridSmena.ColWidths[1]:= ColWidths1;
  StringGridSmena.ColWidths[2]:= ColWidths2;
end;

procedure TFormEnterpriseСompany.FormShow(Sender: TObject);
//  var DataSet: TDataSet;
begin
  EditRegimeName.Text:= '';
  SpinEditNumSmena.Value:= 1;
  RegimeList;

//  if RowCount > 0 then
//    begin
//      DBGridListRegime.SetFocus;
//      ADOQueryRegimeNameAfterScroll(DataSet);
//    end;
  DBGridListRegime.SetFocus;
  ChangeData:= false;
  AddRegime:= false;

end;

procedure TFormEnterpriseСompany.RegimeList;
  var DataSet: TDataSet;
      i: integer;
begin
  //получаем список всех режимов
  try
    ADOQueryRegimeName.SQL.Clear;
    ADOQueryRegimeName.SQL.Add('SELECT * FROM Regims');
    ADOQueryRegimeName.Active:= true;
  except
    on e: Exception do
  end;
  RowCount:= DataSourceRegimeName.DataSet.RecordCount;

  with DBGridListRegime do
    begin
      Columns[0].Visible:= false;  //скрываем колонку R_Code
      Columns[1].Title.Alignment:= taCenter;
      Columns[2].Title.Alignment:= taCenter;
      //скрываем колонки BegCh и EndCh в DBGridListRegime
      for i := 3 to 10 do
        Columns[i].Visible:= false;
    end;

  ADOQueryRegimeNameAfterScroll(DataSet);

end;

procedure TFormEnterpriseСompany.SpeedButton1Click(Sender: TObject);
begin
  if Application.MessageBox(PChar('Удалить запись режима работы предприятия: "' +
                                  EditRegimeName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      try
        Form1.ADOQueryServerMDB.SQL.Clear;
        Form1.ADOQueryServerMDB.SQL.Add('DELETE FROM Regims WHERE R_Code = ' + IntToStr(CodeRegime));
        Form1.ADOQueryServerMDB.ExecSQL;
      except
        on e: Exception do
      end;
      UpdateRegimeList(false);
    end;
end;

procedure TFormEnterpriseСompany.ClearAllData;
  var R_Col, R_Row: integer;
begin
  CodeRegime:= 0;

  // очищаем таблицу
  StringGridSmena.RowCount:= 5;   //учитываем заголовок

  StringGridSmena.Cells[0, 1]:= 'Смена I';
  StringGridSmena.Cells[0, 2]:= 'Смена II';
  StringGridSmena.Cells[0, 3]:= 'Смена III';
  StringGridSmena.Cells[0, 4]:= 'Смена IV';

  with StringGridSmena do
    for R_Col:= 1 to ColCount - 1 do  //Заголовки столбцов не трогаем - цикл от 1
      for R_Row := 1 to RowCount - 1 do
        cells[R_Col, R_Row]:= '00:00';

  SpinEditNumSmena.Value:= 1;
  StringGridSmena.RowCount:= SpinEditNumSmena.Value + 1;
end;

procedure TFormEnterpriseСompany.SpeedButtonAddRegimeClick(Sender: TObject);
  var i: integer;
begin
  AddRegime:= true;
  EditRegimeName.Text:= '';
  EditRegimeName.SetFocus;
  DBGridListRegime.Enabled:= false;

  EditRegimeName.Color  := ColorEdit;
  SpinEditNumSmena.Color:= ColorEdit;
  StringGridSmena.Color := ColorEdit;
  ClearAllData;
end;

procedure TFormEnterpriseСompany.SpinEditNumSmenaChange(Sender: TObject);
begin
  StringGridSmena.RowCount:= SpinEditNumSmena.Value + 1;
  ChangeData:= true;
end;

procedure TFormEnterpriseСompany.SpinEditNumSmenaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['1'..'4']) then
    begin
      Application.MessageBox(PChar('Диапазон значений должен быть от 1 до 4'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
    end;
end;

procedure TFormEnterpriseСompany.StringGridSmenaClick(Sender: TObject);
begin
  if StringGridSmena.RowCount = 1 then exit;
  //чтобы курсор не залезал на шапку таблицы
  if StringGridSmena.Row < 2 then StringGridSmena.Row:= 1;
end;

procedure TFormEnterpriseСompany.StringGridSmenaDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);

  var   s: string;
     Flag: Cardinal;
begin
  if (ACol=0) and (ARow=0) then
    begin
      s:= 'N смены';
      Flag:= DT_VCENTER or DT_CENTER or DT_SINGLELINE;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridSmena.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;

  if (ACol=1) and (ARow=0) then
    begin
      s:= 'Время начала смены';
      //Если нет переноса слов, то выровнять по центру вертикали и горизонтали можно так
      Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_SINGLELINE;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridSmena.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;

  if (ACol=2) and (ARow=0) then
    begin
      s:= 'Время окончания смены';
      //Если нет переноса слов, то выровнять по центру вертикали и горизонтали можно так
      Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_WORDBREAK;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridSmena.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;
//  StringGridSmena.Canvas.Brush.Color:=clBlue;
//       StringGridSmena.Canvas.FillRect(Rect);
//       StringGridSmena.Canvas.TextOut(Rect.Left,Rect.Top,StringGridSmena.Cells[Acol,Arow]);


end;

procedure TFormEnterpriseСompany.StringGridSmenaGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: string);
begin
   if (ACol > 0) and (ARow > 0) then Value:='!90:00;1;_';  //Маска ввода времени
   ChangeData:= true;
end;

end.
