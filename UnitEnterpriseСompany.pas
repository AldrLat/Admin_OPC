unit UnitEnterpriseСompany;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Grids, Data.DB, Data.Win.ADODB, Vcl.DBGrids, Vcl.Samples.Spin, Vcl.Buttons,
  UnitMyForm{обязательно ПОСЛЕДНИМ};

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
    SpeedButtonDeleteRegime: TSpeedButton;
    ButtonCancel: TButton;
    ButtonSave: TButton;
    ButtonClose: TButton;
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
    procedure SpeedButtonDeleteRegimeClick(Sender: TObject);
    procedure ClearAllData;
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DefaultTime(CountSmen: integer);
    procedure ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
    procedure EnabledDisabled(param: boolean);
  private
    { Private declarations }
    const
      ColWidths0 = 107;     //Ширина колонки 0 в StringGridSmena
      ColWidths1 = 124;     //Ширина колонки 1 в StringGridSmena
      ColWidths2 = 124;     //Ширина колонки 2 в StringGridSmena

    var
      ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                            //измененные данные записать в базу данных
      Row_Count: integer;
      RegimEdit: boolean;   //поля находятся в режиме редактирования
  public
    { Public declarations }
  end;

var
  FormEnterpriseСompany: TFormEnterpriseСompany;
  CodeRegime: integer;

  AddRegime: boolean; // режим добавления записи

implementation
uses UnitDM, MainUnit, UnitSettingsProgramm;
{$R *.dfm}

procedure TFormEnterpriseСompany.SaveDataInBD;
  var i, j: integer;

begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Сохранить изменения для режима работы: "' +
                                  EditRegimeName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if Trim(EditRegimeName.Text) = '' then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                 Copy(Label1.Caption, 1 ,Length(Label1.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditRegimeName.SetFocus;
          exit;
        end;

      //пробегаем по всем ячейкам и проверяем корретность ввода времени
      with StringGridSmena do
        for i:= 1 to ColCount - 1 do  //Заголовки столбцов не трогаем - цикл от 1
          for  j:= 1 to RowCount - 1 do
            begin
              if not DM.CheckTime(Cells[i, j]) then
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
          if not DM.QueryServer('INSERT INTO REGIMS (R_Name, SizeCh) VALUES (''' +
                                            Trim(EditRegimeName.Text) + ''', ''' +
                                            IntToStr(SpinEditNumSmena.Value) + ''')',
                                        FormEnterpriseСompany.Caption, 'SaveDataInBD', false)
            then exit;

          //узнаем номер уникальной записи нового режима работы (последней записи)
          if not DM.QueryServer('SELECT MAX(R_Code) as cod FROM REGIMS',
                                       FormEnterpriseСompany.Caption, 'SaveDataInBD', true)
            then exit;

          if not DM.ADOQueryServerMDB.Eof then CodeRegime:= DM.ADOQueryServerMDB.FieldByName('cod').AsInteger;
          if CodeRegime = 0 then exit;
        end
        else
        begin                      //изменяем сущуствующую запись
          if not DM.QueryServer('UPDATE REGIMS SET R_Name = ''' + Trim(EditRegimeName.Text) +
                                      ''', SizeCh = ''' + IntToStr(SpinEditNumSmena.Value) +
                                      ''' WHERE R_Code = ' + IntToStr(CodeRegime),
                                        FormEnterpriseСompany.Caption, 'SaveDataInBD', false)
            then exit;
        end;

        //заполняем таблицу времен
        for i := 1 to SpinEditNumSmena.Value do
          begin
            if not DM.QueryServer('UPDATE REGIMS SET BegCh' + IntToStr(i) + ' = ''' + Trim(StringGridSmena.Cells[1, i]) +
                                      ''', EndCh' + IntToStr(i) + ' = ''' + Trim(StringGridSmena.Cells[2, i]) +
                                      ''' WHERE R_Code = ' + IntToStr(CodeRegime),
                                        FormEnterpriseСompany.Caption, 'SaveDataInBD', false)
              then exit;
          end;

        //дописываем не заполненную таблицу времени пустыми значениями
        i:= SpinEditNumSmena.Value + 1;
        while i < 5 do
          begin
            if not DM.QueryServer('UPDATE REGIMS SET BegCh' + IntToStr(i) + ' = Null' +
                                         ', EndCh' + IntToStr(i) + ' = Null' +
                                         ' WHERE R_Code = ' + IntToStr(CodeRegime),
                                         FormEnterpriseСompany.Caption, 'SaveDataInBD', false)
              then exit;
            inc(i);
          end;
    end;
  ProcedureChangeData(false);
  UpdateRegimeList(true);
end;

procedure TFormEnterpriseСompany.ADOQueryRegimeNameAfterScroll(
  DataSet: TDataSet);
var R_Row: integer;

begin
  ClearAllData;
  if Row_Count > 0 then
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
  ProcedureChangeData(false);  //чтобы не зафиксировать изменения при прокрутки скролом и данные не записывались в базу данных
end;

procedure TFormEnterpriseСompany.ADOQueryRegimeNameBeforeScroll(
  DataSet: TDataSet);
begin
  if ChangeData then SaveDataInBD;
end;

procedure TFormEnterpriseСompany.UpdateRegimeList(SetCursorPosition: boolean);
  var TempCodeRegime: integer;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  FormEnterpriseСompany.Color:= clBtnFace;
//  EditRegimeName.Color:= clWhite;
//  SpinEditNumSmena.Color:= clWhite;
//  StringGridSmena.Color:= clWhite;
  AddRegime:= false;
  RegimEdit:= false;

  SpeedButtonAddRegime.Enabled:= true;
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
  AddRegime:= false;
  UpdateRegimeList(true);
end;

procedure TFormEnterpriseСompany.ButtonCloseClick(Sender: TObject);
begin
  FormEnterpriseСompany.Close;
end;

procedure TFormEnterpriseСompany.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

procedure TFormEnterpriseСompany.EditRegimeNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
end;

procedure TFormEnterpriseСompany.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ChangeData then SaveDataInBD;
  UpdateRegimeList(false);
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
begin
  RegimeList;
  DBGridListRegime.SetFocus;
  ProcedureChangeData(false);
  AddRegime:= false;
  RegimEdit:= false;
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
      begin
        Application.MessageBox(PChar('[RegimeList]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryRegimeName.SQL.Text +'"'),
                               PChar(FormEnterpriseСompany.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;

  Row_Count:= DataSourceRegimeName.DataSet.RecordCount;

  with DBGridListRegime do
    begin
      Columns[0].Visible:= false;  //скрываем колонку R_Code
      Columns[1].Title.Alignment:= taCenter;
      Columns[2].Title.Alignment:= taCenter;
      //скрываем колонки BegCh и EndCh в DBGridListRegime
      for i := 3 to 10 do
        Columns[i].Visible:= false;
    end;

  EnabledDisabled(DataSourceRegimeName.DataSet.RecordCount > 0);

  ADOQueryRegimeNameAfterScroll(DataSet);
end;

procedure TFormEnterpriseСompany.EnabledDisabled(param: boolean);
begin
  SpeedButtonDeleteRegime.Enabled:= param;
  EditRegimeName.Enabled:= param;
  SpinEditNumSmena.Enabled:= param;
  StringGridSmena.Enabled:= param;
end;

procedure TFormEnterpriseСompany.SpeedButtonDeleteRegimeClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Удалить запись режима работы предприятия: "' +
                                  EditRegimeName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
      if not DM.QueryServer('DELETE FROM Regims WHERE R_Code = ' + IntToStr(CodeRegime),
                     FormEnterpriseСompany.Caption, 'SpeedButtonDeleteRegimeClick', false)
        then exit;
      UpdateRegimeList(false);
    end;
end;

procedure TFormEnterpriseСompany.ClearAllData;
  var R_Col, R_Row: integer;
begin
  CodeRegime:= 0;

  EditRegimeName.Clear;
  SpinEditNumSmena.Value:= 1;

  // очищаем таблицу
  StringGridSmena.RowCount:= 5;   //учитываем заголовок

  StringGridSmena.Cells[0, 1]:= 'Смена I';
  StringGridSmena.Cells[0, 2]:= 'Смена II';
  StringGridSmena.Cells[0, 3]:= 'Смена III';
  StringGridSmena.Cells[0, 4]:= 'Смена IV';

  with StringGridSmena do
    for R_Col:= 1 to ColCount - 1 do  //Заголовки столбцов не трогаем - цикл от 1
      for R_Row:= 1 to RowCount - 1 do
        cells[R_Col, R_Row]:= '00:00';

  SpinEditNumSmena.Value:= 1;
  StringGridSmena.RowCount:= SpinEditNumSmena.Value + 1;
end;

procedure TFormEnterpriseСompany.SpeedButtonAddRegimeClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if ChangeData then SaveDataInBD;

  EnabledDisabled(true);     //именно здесь, чтобы не дать доступ к кнопке удалить запись
  SpeedButtonAddRegime.Enabled:= false;
  SpeedButtonDeleteRegime.Enabled:= false;
  DBGridListRegime.Enabled:= false;

  AddRegime:= true;
  EditRegimeName.Clear;
  EditRegimeName.SetFocus;

  FormEnterpriseСompany.Color:= ColorEdit;
//  EditRegimeName.Color  := ColorEdit;
//  SpinEditNumSmena.Color:= ColorEdit;
//  StringGridSmena.Color := ColorEdit;
//  RegimEdit:= true;

  ClearAllData;

  SpinEditNumSmenaChange(Sender);   //чтобы выставилось время в сетке согласно номеру смены
end;

procedure TFormEnterpriseСompany.SpinEditNumSmenaChange(Sender: TObject);
begin
  StringGridSmena.RowCount:= SpinEditNumSmena.Value + 1;
  DefaultTime(SpinEditNumSmena.Value);
  ProcedureChangeData;
end;

procedure TFormEnterpriseСompany.DefaultTime(CountSmen: integer);
  var R_Col, R_Row: integer;
begin
  if AddRegime then
    begin
      with StringGridSmena do
        for R_Col:= 1 to ColCount - 1 do  //Заголовки столбцов не трогаем - цикл от 1
          for R_Row:= 1 to RowCount - 1 do
            cells[R_Col, R_Row]:= '00:00';
      case CountSmen of
        1: begin
              StringGridSmena.cells[1, 1]:= '08:00';
              StringGridSmena.cells[2, 1]:= '20:00';
          end;
        2: begin
              StringGridSmena.cells[1, 1]:= '07:00';
              StringGridSmena.cells[2, 1]:= '19:00';
              StringGridSmena.cells[1, 2]:= '19:00';
              StringGridSmena.cells[2, 2]:= '07:00';
          end;
        3: begin
              StringGridSmena.cells[1, 1]:= '07:00';
              StringGridSmena.cells[2, 1]:= '15:00';
              StringGridSmena.cells[1, 2]:= '15:00';
              StringGridSmena.cells[2, 2]:= '23:00';
              StringGridSmena.cells[1, 3]:= '23:00';
              StringGridSmena.cells[2, 3]:= '07:00';
          end;
      end;
    end;
end;

procedure TFormEnterpriseСompany.SpinEditNumSmenaKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  if not (Key in ['1'..'4', #13]) then
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
  with StringGridSmena, StringGridSmena.Canvas do
    begin
      if (gdSelected in State) and not RegimEdit then begin
              Brush.Color:=clSkyBlue;
        end
        else
            //Фиксированные строки будут цветом по умолчанию
          if (ACol=0) or (ARow=0) then begin      //(gdFixed in State)
              Brush.Color:=FixedColor;
          end
            //Все остальные строки будут цветом по умолчанию
          else begin
            if RegimEdit then Canvas.Brush.Color:= ColorEdit else Canvas.Brush.Color:= clWhite;
          end;
      //красим ячейки
      Rect.Left:= Rect.Left - 3;   //смещаем левый край закраски
      FillRect(Rect);
      SetBkMode(Handle, TRANSPARENT);

      if (ACol=0) and (ARow=0) then
        begin
          s:= 'N смены';
          Flag:= DT_VCENTER or DT_CENTER or DT_SINGLELINE;
          Inc(Rect.Left,3);
          Dec(Rect.Right,3);
          DrawText(Handle,PChar(s),length(s),Rect,Flag);
        end;

      if (ACol=1) and (ARow=0) then
        begin
          s:= 'Время начала смены';
          //Если нет переноса слов, то выровнять по центру вертикали и горизонтали можно так
          Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_SINGLELINE;
          Inc(Rect.Left,3);
          Dec(Rect.Right,3);
          DrawText(Handle,PChar(s),length(s),Rect,Flag);
        end;

      if (ACol=2) and (ARow=0) then
        begin
          s:= 'Время окончания смены';
          //Если нет переноса слов, то выровнять по центру вертикали и горизонтали можно так
          Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_WORDBREAK;
          Inc(Rect.Left,3);
          Dec(Rect.Right,3);
          DrawText(Handle,PChar(s),length(s),Rect,Flag);
        end;

      if ARow>0 then       //основной текст
        begin
          Flag:= DT_SINGLELINE OR DT_VCENTER OR DT_LEFT;
          Inc(Rect.Left,3);
          Dec(Rect.Right,3);//смещаем текст от левого края
          DrawText(Handle, pchar(Cells[ACol, ARow]), -1, Rect, Flag);
        end;
    end;
end;

procedure TFormEnterpriseСompany.StringGridSmenaGetEditMask(Sender: TObject;
  ACol, ARow: Integer; var Value: string);
begin
   if (ACol > 0) and (ARow > 0) then Value:='!90:00;1;_';  //Маска ввода времени
   ProcedureChangeData;
end;

procedure TFormEnterpriseСompany.ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //если данные были изменены, разрешаем кнопку "Применить"
end;

end.
