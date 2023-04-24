unit UnitClearBD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  StrUtils, Data.DB, Data.Win.ADODB;

type
  TFormClearBD = class(TForm)
    CheckBoxAllWS: TCheckBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ButtonClose: TButton;
    ButtonBegin: TButton;
    DateTimePickerMin: TDateTimePicker;
    DateTimePickerHour: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    LabelInfo: TLabel;
    Timer1: TTimer;
    CheckBoxAllMin: TCheckBox;
    CheckBoxDateMin: TCheckBox;
    CheckBoxAllHour: TCheckBox;
    CheckBoxDateHour: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonBeginClick(Sender: TObject);
    procedure CheckBoxAllMinClick(Sender: TObject);
    procedure CheckBoxDateMinClick(Sender: TObject);
    procedure CheckBoxAllHourClick(Sender: TObject);
    procedure CheckBoxDateHourClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClearBD: TFormClearBD;

implementation

{$R *.dfm}

uses UnitDM, UnitSettingsProgramm;

procedure TFormClearBD.ButtonCloseClick(Sender: TObject);
begin
  Timer1.Enabled:= false;
  FormClearBD.Close;
end;

procedure TFormClearBD.ButtonBeginClick(Sender: TObject);

  procedure CopyFileWithPercent(Source, Destination: string);

    procedure insertTxtPercent(percent: string); //вставляет в поледнюю строку Memo
        var strBegin, strLength: integer;        //значение процентов при копировании файла
      begin
        strBegin:= pos('-', Memo1.Lines.Strings[Memo1.Lines.Count - 1]) + 2; //начало процентов
        strLength:= length(Memo1.Lines.Strings[Memo1.Lines.Count - 1]) - strBegin + 1; //длина строки процентов
        Memo1.Lines.BeginUpdate;
        Memo1.Lines.Strings[Memo1.Lines.Count - 1]:=
          StuffString(Memo1.Lines.Strings[Memo1.Lines.Count - 1], strBegin, strLength, percent);
        Memo1.Lines.EndUpdate;
      end;

    var
      FromF, ToF: file of byte;
      Buffer: array[0..4095] of char;
      NumRead: integer;
      FileLength, SizeFile: longint;
      sNameFile, percent, oldPercent: string;
  begin
    try
      sNameFile:= ExtractFileName(Source);
      AssignFile(FromF, Source);
      reset(FromF);
      AssignFile(ToF, Destination);
      rewrite(ToF);
      FileLength := FileSize(FromF);
      SizeFile := FileLength;
      Memo1.Lines.Add(FormatDateTime('dd.mm.yyyy hh:nn:ss', now) +
       ' Резервное копирование базы ' + sNameFile + ' - 0,0%' );
      while FileLength > 0 do
        begin
          NumRead:= SizeOf(Buffer);
          BlockRead(FromF, Buffer[0], SizeOf(Buffer), NumRead);
          FileLength := FileLength - NumRead;
          BlockWrite(ToF, Buffer[0], NumRead);
          percent := Format('%.0n', [100 - ((FileLength/SizeFile)* 100)]) + '%';
          Application.ProcessMessages;
          if oldPercent <> percent then    //обновляем только если процент изменился
            begin
              insertTxtPercent(percent);
              oldPercent:= percent;
            end;
        end;
      insertTxtPercent('база данных успешно скопирована в ' + Destination);
    except
      insertTxtPercent('ошибка копирования БД ' + Destination);
    end;
    CloseFile(FromF);
    CloseFile(ToF);
  end;

  procedure ClearTabl(nameTabl: string);
      var strNow: string;
    begin
      strNow:= FormatDateTime('dd.mm.yyyy hh:nn:ss', now);
      if DM.QueryWorkStation('DELETE FROM ' + nameTabl,
            FormClearBD.Caption, 'ButtonSaveClick', false) then
        Memo1.Lines.Add(strNow + ' Таблица ' + nameTabl + ' (WorkStation.mdb) - очищена успешно.')
        else Memo1.Lines.Add(strNow + ' Таблица ' + nameTabl + ' (WorkStation.mdb) - ошибка очистки.');
    end;

  var sNameTable, strNow, s: string;
      List: TStringList;
begin
  if Application.MessageBox(PChar('Очистить таблицы в базах данных ' +
       'WorkStation.mdb и Data.mdb ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      CopyFileWithPercent(PathWorkStationMDB, PathBackUpBD + '\' +
           FormatDateTime('yymmdd_hhmmss_', now) + ExtractFileName(PathWorkStationMDB));
      CopyFileWithPercent(PathDataWSMDB, PathBackUpBD + '\' +
           FormatDateTime('yymmdd_hhmmss_', now) + ExtractFileName(PathDataWSMDB));

      ClearTabl('RudaNet');
      ClearTabl('RudaNetHour');
      ClearTabl('RudaNetTxt');
      ClearTabl('RudaNetTxtHour');
      ClearTabl('RudaNetMdbHour');
      ClearTabl('RudaNetSQLArchive');
      ClearTabl('RudaNetSQLHour');

      if CheckBoxAllWS.Checked then
        begin
          DM.QueryTempWorkStation('SELECT * FROM ParamLines',
            FormClearBD.Caption, 'ButtonSaveClick', true);
          DM.ADOQueryTempWS.First;
          while not DM.ADOQueryTempWS.EOF do
            begin
              ClearTabl('C' + DM.ADOQueryTempWS.FieldByName('L_Code').AsString);
              ClearTabl('CM' + DM.ADOQueryTempWS.FieldByName('L_Code').AsString);
              ClearTabl('CH' + DM.ADOQueryTempWS.FieldByName('L_Code').AsString);
              DM.ADOQueryTempWS.Next;
            end;
        end;

      if CheckBoxAllMin.Checked or CheckBoxDateMin.Checked then
        begin
          DM.QueryTempWorkStation('SELECT * FROM ParamLines',
               FormClearBD.Caption, 'ButtonSaveClick', true);
          DM.ADOQueryTempWS.First;
          while not DM.ADOQueryTempWS.EOF do
            begin
              sNameTable:= 'M' + DM.ADOQueryTempWS.FieldByName('L_Code').AsString;
              strNow:= FormatDateTime('dd.mm.yyyy hh:nn:ss', now);

              if CheckBoxAllMin.Checked then
                begin
                  if DM.QueryDataWS('DELETE FROM ' + sNameTable,
                    FormClearBD.Caption, 'ButtonBeginClick', false) then
                      Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable + ' (Data.mdb) - очищена успешно.')
                      else Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable + ' (Data.mdb) - ошибка очистки.');
                end;

              if CheckBoxDateMin.Checked then
                begin
                  s:= FormatDateTime('dd.mm.yyyy', DateTimePickerMin.DateTime);
                  if DM.QueryDataWS('DELETE FROM ' + sNameTable + ' WHERE M_Date < datevalue(''' + s + ''')',
                       FormClearBD.Caption, 'ButtonSaveClick', false) then
                      Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable +
                                   ' (Data.mdb) - очищена успешно.')
                      else Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable +
                                           ' (Data.mdb) - ошибка очистки.');
                end;

              DM.ADOQueryTempWS.Next;
            end;

          if CheckBoxAllMin.Checked then  //таблица CM
            ClearTabl('CM');
          if CheckBoxDateMin.Checked then
            begin
              s:= FormatDateTime('dd.mm.yyyy', DateTimePickerMin.DateTime);
              if DM.QueryWorkStation('DELETE FROM CM WHERE C_Date < datevalue(''' + s + ''')',
                       FormClearBD.Caption, 'ButtonSaveClick', false) then
                      Memo1.Lines.Add(strNow + ' Таблица CM (Data.mdb) - очищена успешно.')
                      else Memo1.Lines.Add(strNow + ' Таблица CM (Data.mdb) - ошибка очистки.');
            end;
        end;

        if CheckBoxAllHour.Checked or CheckBoxDateHour.Checked then
         begin
          DM.QueryTempWorkStation('SELECT * FROM ParamLines',
               FormClearBD.Caption, 'ButtonSaveClick', true);
          DM.ADOQueryTempWS.First;
          while not DM.ADOQueryTempWS.EOF do
            begin
              sNameTable:= 'H' + DM.ADOQueryTempWS.FieldByName('L_Code').AsString;
              strNow:= FormatDateTime('dd.mm.yyyy hh:nn:ss', now);
              if CheckBoxAllHour.Checked then
                begin
                  if DM.QueryDataWS('DELETE FROM ' + sNameTable,
                    FormClearBD.Caption, 'ButtonBeginClick', false) then
                      Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable + ' (Data.mdb) - очищена успешно.')
                      else Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable + ' (Data.mdb) - ошибка очистки.');
                end;

              if  CheckBoxDateHour.Checked then
                begin
                  s:= FormatDateTime('dd.mm.yyyy', DateTimePickerHour.DateTime);
                  if DM.QueryDataWS('DELETE FROM ' + sNameTable + ' WHERE H_Date < datevalue(''' + s + ''')',
                       FormClearBD.Caption, 'ButtonSaveClick', false) then
                      Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable +
                                   ' (Data.mdb) - очищена успешно.')
                      else Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable +
                                           ' (Data.mdb) - ошибка очистки.');
                end;

              sNameTable:= 'W' + DM.ADOQueryTempWS.FieldByName('L_Code').AsString;
              strNow:= FormatDateTime('dd.mm.yyyy hh:nn:ss', now);
              if CheckBoxAllHour.Checked then
                begin
                  if DM.QueryDataWS('DELETE FROM ' + sNameTable,
                    FormClearBD.Caption, 'ButtonBeginClick', false) then
                      Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable + ' (Data.mdb) - очищена успешно.')
                      else Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable + ' (Data.mdb) - ошибка очистки.');
                end;

              if  CheckBoxDateHour.Checked then
                begin
                  s:= FormatDateTime('dd.mm.yyyy', DateTimePickerHour.DateTime);
                  if DM.QueryDataWS('DELETE FROM ' + sNameTable + ' WHERE W_Date < datevalue(''' + s + ''')',
                       FormClearBD.Caption, 'ButtonSaveClick', false) then
                      Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable +
                                   ' (Data.mdb) - очищена успешно.')
                      else Memo1.Lines.Add(strNow + ' Таблица ' + sNameTable +
                                           ' (Data.mdb) - ошибка очистки.');
                end;
              DM.ADOQueryTempWS.Next;
            end;

          List:= TStringList.Create;
          DM.ADOConnectionWorkStationMDB.GetTableNames(List);
          if List.IndexOf('RudaNetOPCHour') >= 0 then //значит такая таблица есть
            begin
              if CheckBoxAllHour.Checked then
                begin
                  ClearTabl('RudaNetOPCHour');
                end;

              if  CheckBoxDateHour.Checked then
                begin
                  s:= FormatDateTime('dd.mm.yyyy', DateTimePickerHour.DateTime);
                  if DM.QueryWorkStation('DELETE FROM RudaNetOPCHour WHERE Dat < datevalue(''' + s + ''')',
                       FormClearBD.Caption, 'ButtonSaveClick', false) then
                      Memo1.Lines.Add(strNow + ' Таблица RudaNetOPCHour (WorkStation.mdb) - очищена успешно.')
                      else Memo1.Lines.Add(strNow + ' Таблица RudaNetOPCHour (WorkStation.mdb) - ошибка очистки.');
                end;
            end;
          List.Free;

         end;
    end;
end;

procedure TFormClearBD.CheckBoxAllHourClick(Sender: TObject);
begin
  if CheckBoxAllHour.Checked and CheckBoxDateHour.Checked then
        CheckBoxDateHour.Checked:= false;
end;

procedure TFormClearBD.CheckBoxAllMinClick(Sender: TObject);
begin
  if CheckBoxAllMin.Checked and CheckBoxDateMin.Checked then
        CheckBoxDateMin.Checked:= false;
end;

procedure TFormClearBD.CheckBoxDateHourClick(Sender: TObject);
begin
  if CheckBoxAllHour.Checked and CheckBoxDateHour.Checked then
        CheckBoxAllHour.Checked:= false;
end;

procedure TFormClearBD.CheckBoxDateMinClick(Sender: TObject);
begin
  if CheckBoxDateMin.Checked and CheckBoxAllMin.Checked then
        CheckBoxAllMin.Checked:= false;
end;

procedure TFormClearBD.FormCreate(Sender: TObject);
begin
  FormClearBD.Caption:= ProgName_ShortStringVersion + FormClearBD.Caption;
end;

procedure TFormClearBD.FormShow(Sender: TObject);
begin
  CheckBoxAllWS.Checked      := false;
  CheckBoxAllMin.Checked  := false;
  CheckBoxDateMin.Checked := false;
  CheckBoxAllHour.Checked := false;
  CheckBoxDateHour.Checked:= false;
  Memo1.Clear;
  LabelInfo.Caption:= 'Внимание !!! Перед началом очистки базы данных, закройте все работающие приложения ' + ProgName_ShortStringVersion;
  LabelInfo.Font.Color:= clRed;
  DateTimePickerMin.Date:= now;
  DateTimePickerHour.Date:= now;
  Timer1.Enabled:= true;
end;

procedure TFormClearBD.Timer1Timer(Sender: TObject);
begin
  if LabelInfo.Font.Color = clWindowText then LabelInfo.Font.Color:= clRed
    else LabelInfo.Font.Color:= clWindowText;
end;

end.
