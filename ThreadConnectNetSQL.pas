unit ThreadConnectNetSQL;

interface

uses
  System.Classes, System.SysUtils, Data.Win.ADODB, ActiveX, Registry, Winapi.Windows,
  RudaGlobals;

type
  ConnectNetSQL = class(TThread)
  procedure Log;
  private
    { Private declarations }
    ADOconNET: TADOConnection;
    Msg: string;
  protected
    procedure Execute; override;
  end;

implementation

uses UnitSettingsWorkStation, UnitDM;
{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure ConnectNetSQL.UpdateCaption;
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

{ ConnectNetSQL }

//из ODBC DSN извлекаем путь к базе
function FromDSNgetPathBase(NameDSN, KeyRead: string): string;
  const SubKey = 'Software\ODBC\ODBC.INI';
//        KeyRead = 'DBQ';
  var registry: TRegistry;
      KeyOpen: string;
begin
  result:= '';
  if Trim(NameDSN) = '' then exit;

  Registry := TRegistry.Create(KEY_READ or KEY_WRITE);

  try
    Registry.RootKey:= RootKey_HKCU;
    KeyOpen:= SubKey + '\' + NameDSN;

    Registry.OpenKeyReadOnly(KeyOpen);// OpenKey(Key_Open, False);
    if registry.ValueExists(KeyRead) then result:= Registry.ReadString(KeyRead)
  finally
    Registry.Free;
  end;
end;

procedure ConnectNetSQL.Log;
begin
  DM.log('[RudaAdmin][ThreadConnectNetSQL] ' + Msg, 4);
end;

procedure ConnectNetSQL.Execute;
  var err: boolean;
      Err_SQLState, DataBaseName, ServerName: string;
      State: TObjectStates;
begin
//  FreeOnTerminate:= True;
  TxtForEditDsnSQL:= '';
  TxtForMsg:= '';
  NameThreadForDebugging('TConnectNetSQL');
  { Place thread code here }

  CoInitialize(nil);      //потому что ADO в потоке

  ADOconNet:= TADOConnection.Create(nil);
  ADOconNet.ConnectionString:= DSNConnectSQL;
  ADOconNet.ConnectOptions:= coConnectUnspecified;   //coConnectUnspecified - синхронное соединение всегда ожидает результат последнего запроса
  ADOconNet.Mode:= cmReadWrite; //cmShareDenyNone;
  ADOconNet.IsolationLevel:= ilCursorStability;
  ADOconNet.CursorLocation:= clUseClient;//clUseServer;//clUseClient;
  ADOconNet.CommandTimeout:= 30;                  //время ожидания выполнения команды (в секундах). Значение по умолчанию — 30.
  ADOconNet.ConnectionTimeout:= 15;                //время ожидания открытия соединения (в секундах). Значение по умолчанию — 15
  ADOconNet.LoginPrompt:= false;
  sleep(50);  //было 100

  try
    ErrConnectNetSQL:= false;
    ADOConNET.Connected:= true;
  except
    on e: Exception do
      begin
        Err_SQLState:= e.Message;
        ErrConnectNetSQL:= true;
      end;
  end;

  if ADOconNet.Connected then
    begin
      DataBaseName:= FromDSNgetPathBase(DSNNameRudaSQL, 'Database');
      ServerName:= FromDSNgetPathBase(DSNNameRudaSQL, 'Server');
          //если не удалось получить имя базы данных или имя сервера, исключаем его из текста
      if DataBaseName <> '' then DataBaseName:= 'DATABASE = ' + DataBaseName + '; ';
      if ServerName <> '' then ServerName:= 'SERVER = ' + ServerName + '; ';

      TxtForEditDsnSQL:= 'Соединение установлено. ' + DataBaseName + ServerName;
      TxtForMsg:= 'Соединение установлено успешно.' + #10#13 + DataBaseName + #10#13 + ServerName;

      ADOconNET.Connected:= false;
    end
    else begin
      TxtForEditDsnSQL:= 'Не найдена база данных или неверные данные пользователя. Проверьте настройки DSN для "' + DSNNameRudaSQL +
              '" и данные пользователя (' + Err_SQLState + ')';
      TxtForMsg:= 'Ошибка. Не найдена база данных или неверные данные пользователя.' + #10#13 + 'Проверьте настройки DSN для "' + DSNNameRudaSQL +
              '" и данные пользователя (' + Err_SQLState + ')'
    end;


  if ADOconNET <> nil then
    begin
      ADOconNET.Free;
      sleep(100);
      ADOconNET:= nil;
    end;

  CoUninitialize();  //потому что ADO в потоке
end;

end.
