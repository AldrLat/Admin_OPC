unit ThreadCompressDB;

interface

uses
  System.Classes, Windows, SysUtils, UnitDM, ComObj, Vcl.ComCtrls;

type TAddText = (None, OK, Bad);

type

  TCompressDB = class(TThread)
  function CompactDatabase_JRO(var errStr: string; DatabaseName: string; DestDatabaseName: string =
    ''; Password: string = ''): boolean;
  procedure InsertStringRichEditCompress;
  procedure ReplaceStringRichEditCompress;
  procedure ComplitStringRichEditCompress;
  procedure TerminatedCompress;
  procedure ShowCompressDB(PathDB: string; AddTypeTextInString: TAddText; txtErr: string = '');
  procedure ConnectDBafterCompress;
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

  var
    CurrentCompressNameDB, TextInRichEdit: string;
    beginTimeCompress: TDateTime;

implementation
  uses UnitProgressCompressDB, MainUnit;


{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure ThreadCompressDB.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or 
    
    Synchronize(
      procedure 
      begin
        Form1.Caption := 'Updated in thread via an anonymous method' 
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ ThreadCompressDB }

{ **** **************************************************** ****
>> Программное сжатие базы данных Access используя JRO (Jet Replication Objects)

Процедура позволяет сжать базу данных в формате Access,
используя JRO (Jet Replication Objects). Действие аналогичное
пункту меню в Access "Сервис -> Служебные программы ->
Сжать и восстановить базу данных".
Параметры:
* DatabaseName - путь к исходной (не сжатой) базе данных
* DestDatabaseName - путь к сжатой базе данных
(по умолчанию пустой - в этом случае исходная база заменяется сжатой)
* Password - пароль базы данных (по умолчанию пустой)
***************************************************** }

function TCompressDB.CompactDatabase_JRO(var errStr: string; DatabaseName: string; DestDatabaseName: string =
  ''; Password: string = ''): boolean;
const
  Provider = 'Provider=Microsoft.Jet.OLEDB.4.0;';
var
  TempName: array[0..MAX_PATH] of Char; // имя временного файла
  TempPath: string; // путь до него
  Name: string;
  NameDB: string;
  Prefix: string;
  Src, Dest: WideString;
  V: Variant;
begin
  try
    result:= true;
    errStr:= '';
    Src:= Provider + 'Data Source=' + DatabaseName;
    if DestDatabaseName <> '' then
      Name:= DestDatabaseName
    else
    begin
      // выходная база не указана - используем временный файл
      // получаем путь для временного файла
      TempPath:= ExtractFilePath(DatabaseName);
      if TempPath = '' then
        TempPath:= GetCurrentDir;

      NameDB:= ExtractFileName(DatabaseName);
      Prefix:= NameDB[1] + NameDB[2] + '_';
      //создаем и получаем имя временного файла
      GetTempFileName(PChar(TempPath), PChar(Prefix), 0, TempName);
      Name := StrPas(TempName);
    end;
    DeleteFile(PChar(Name)); // этого файла не должно существовать :))
    Dest:= Provider + 'Data Source=' + Name;
    if Password <> '' then
    begin
      Src := Src + ';Jet OLEDB:Database Password=' + Password;
      Dest:= Dest + ';Jet OLEDB:Database Password=' + Password;
    end;

    V:= CreateOleObject('jro.JetEngine');
    try
      V.CompactDatabase(Src, Dest); // сжимаем
    finally
      V:= 0;
    end;
    if DestDatabaseName = '' then
    begin // т.к. выходная база не указана
      DeleteFile(PChar(DatabaseName)); //то удаляем не упакованную базу
      RenameFile(Name, DatabaseName); // и переименовываем упакованную базу
    end;
  except
    // выдаем сообщение об исключительной ситуации
    on E: Exception do
      begin
//        ShowMessage(DatabaseName + #10#13 + e.message);
        errStr:= e.message;
        result:= false;
      end;
  end;
end;

//function TForm1.CompactDatabase_JRO(DatabaseName: string; DestDatabaseName: string =
//  ''; Password: string = ''): boolean;
//const
//  Provider = 'Provider=Microsoft.Jet.OLEDB.4.0;';
//  s1_DSN = 'Provider = MSDASQL.1; Extended Properties = "DBQ = ';
//  s2_DSN = '; Driver = {Microsoft Access Driver (* .mdb)}; DriverId = 281;"';
//
//var
//  TempName: array[0..MAX_PATH] of Char; // имя временного файла
//  TempPath: string; // путь до него
//  Name: string;
//  Src, Dest: WideString;
//  V: Variant;
//begin
//  try
//    result:= true;
//    Src:= s1_DSN + DatabaseName + s2_DSN;
//    if DestDatabaseName <> '' then
//      Name:= DestDatabaseName
//    else
//    begin
//      // выходная база не указана - используем временный файл
//      // получаем путь для временного файла
//      TempPath:= ExtractFilePath(DatabaseName);
//      if TempPath = '' then
//        TempPath:= GetCurrentDir;
//      //получаем имя временного файла
//      GetTempFileName(PChar(TempPath), 'mdb', 0, TempName);
//      Name := StrPas(TempName);
//    end;
//    DeleteFile(PChar(Name)); // этого файла не должно существовать :))
//    Dest:= s1_DSN + Name + s2_DSN;
//    if Password <> '' then
//    begin
//      Src := Src + ';Jet OLEDB:Database Password=' + Password;
//      Dest:= Dest + ';Jet OLEDB:Database Password=' + Password;
//    end;
//
//    V:= CreateOleObject('jro.JetEngine');
//    try
//      V.CompactDatabase(Src, Dest); // сжимаем
//    finally
//      V:= 0;
//    end;
//    if DestDatabaseName = '' then
//    begin // т.к. выходная база не указана
//      DeleteFile(PChar(DatabaseName)); //то удаляем не упакованную базу
//      RenameFile(Name, DatabaseName); // и переименовываем упакованную базу
//    end;
//  except
//    // выдаем сообщение об исключительной ситуации
//    on E: Exception do
//      begin
//        ShowMessage(e.message);
//        result:= false;
//      end;
//  end;
//end;

procedure TCompressDB.ConnectDBafterCompress;
begin
  FormRudaAdmin.ConnectDB;
end;

//RichEdit замена текста
function SearchAndReplace(RichEdit: TRichEdit;
  SearchText, ReplaceText: string): Boolean;
var
  startpos, Position, endpos: integer;
begin
  startpos := 0;
  with RichEdit do
  begin
    endpos := Length(RichEdit.Text);
    Lines.BeginUpdate;
    while FindText(SearchText, startpos, endpos, []) <> -1 do
    begin
      endpos   := Length(RichEdit.Text) - startpos;
      Position := FindText(SearchText, startpos, endpos, []);
      Inc(startpos, Length(SearchText));
      SetFocus;
      SelStart  := Position;
      SelLength := Length(SearchText);
      richedit.clearselection;
      SelText := ReplaceText;
    end;
    Lines.EndUpdate;
  end;
end;

procedure TCompressDB.InsertStringRichEditCompress;
begin
  FormProgressCompressDB.RichEditCompressDB.Lines.Add(TextInRichEdit);
  FormProgressCompressDB.Timer1.Enabled:= true;
end;

procedure TCompressDB.ReplaceStringRichEditCompress;
begin
  SearchAndReplace(FormProgressCompressDB.RichEditCompressDB, Format('  - %s - %s', [CurrentCompressNameDB, ShowJobText[0]]), TextInRichEdit);
  FormProgressCompressDB.Timer1.Enabled:= false;
end;

procedure TCompressDB.ComplitStringRichEditCompress;
begin
  FormProgressCompressDB.Timer1.Enabled:= false;
  FormProgressCompressDB.RichEditCompressDB.Lines.Add(#13 + 'Завершено.' + #13 +
    'Затраченное время: ' + FormatDateTime('hh:nn:ss.zzz', now - beginTimeCompress));
  FormProgressCompressDB.ButtonCancelCompressDB.Enabled:= false;
  FormProgressCompressDB.ButtonCloseCompressDB.Enabled:= true;
end;

procedure TCompressDB.TerminatedCompress;
begin
  FormProgressCompressDB.Timer1.Enabled:= false;
  FormProgressCompressDB.RichEditCompressDB.Lines.Add(#13 + 'Прервано пользователем.' + #13 +
    'Затраченное время: ' + FormatDateTime('hh:nn:ss.zzz', now - beginTimeCompress));
  FormProgressCompressDB.ButtonCancelCompressDB.Enabled:= false;
  FormProgressCompressDB.ButtonCloseCompressDB.Enabled:= true;
end;

procedure TCompressDB.ShowCompressDB(PathDB: string; AddTypeTextInString: TAddText; txtErr: string = '');
begin
  EditDataInRichEdit.WaitFor(INFINITE);
  EditDataInRichEdit.ResetEvent;   // Переводим в ожидание

  CurrentCompressNameDB:= ExtractFileName(PathDB);

  case AddTypeTextInString of
    None: TextInRichEdit:= Format('  - %s - %s', [CurrentCompressNameDB, ShowJobText[0]]);
    Ok  : TextInRichEdit:= Format('  - %s - ok;', [CurrentCompressNameDB]);
    Bad : TextInRichEdit:= Format('  - %s - ошибка (%s);', [CurrentCompressNameDB, txtErr]);
  end;

  if AddTypeTextInString = none then
    Synchronize(InsertStringRichEditCompress)
  else if (AddTypeTextInString = Ok) or (AddTypeTextInString = Bad) then
    Synchronize(ReplaceStringRichEditCompress);

  EditDataInRichEdit.SetEvent; //освобождаем событие
end;

procedure TCompressDB.Execute;
var Err_SQLState, errStrCompactDatabase: string;

begin
  beginTimeCompress:= now;
  FreeOnTerminate := True;

  if not Terminated then
    begin
      ShowCompressDB(PathAccessMDB, None);
      DM.ADOConnectionAccessMDB.Close;
      sleep(300);
      if CompactDatabase_JRO(errStrCompactDatabase, PathAccessMDB, '', '') then
            ShowCompressDB(PathAccessMDB, OK) else ShowCompressDB(PathAccessMDB, Bad, errStrCompactDatabase);
    end;

  if not Terminated then
    begin
      ShowCompressDB(PathDataWSMDB, None);
      DM.ADOConnectionDataWSMDB.Close;
      sleep(300);
      if CompactDatabase_JRO(errStrCompactDatabase, PathDataWSMDB, '', '') then
          ShowCompressDB(PathDataWSMDB, OK) else ShowCompressDB(PathDataWSMDB, BAD, errStrCompactDatabase);
    end;

  if not Terminated then
    begin
      ShowCompressDB(PathServerMDB, None);
      DM.ADOConnectionServerMDB.Close;
      sleep(300);
      if CompactDatabase_JRO(errStrCompactDatabase, PathServerMDB, '', '') then
          ShowCompressDB(PathServerMDB, OK) else ShowCompressDB(PathServerMDB, BAD, errStrCompactDatabase);
    end;

  if not Terminated then
    begin
      ShowCompressDB(PathWorkStationMDB, None);
      DM.ADOConnectionWorkStationMDB.Close;
      sleep(300);
      if CompactDatabase_JRO(errStrCompactDatabase, PathWorkStationMDB, '', '') then
          ShowCompressDB(PathWorkStationMDB, OK) else ShowCompressDB(PathWorkStationMDB, BAD, errStrCompactDatabase);
    end;

  if Terminated then
    begin
      Synchronize(TerminatedCompress);
    end;

  if not Terminated then
    begin
      Synchronize(ComplitStringRichEditCompress);
    end;

  Synchronize(ConnectDBafterCompress);
end;

end.
