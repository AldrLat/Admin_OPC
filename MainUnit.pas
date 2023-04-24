unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.CategoryButtons,
  Vcl.ActnCtrls, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnMenus,
  Vcl.PlatformDefaultStyleActnCtrls, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, IniFiles, Data.DB, Data.Win.ADODB, Vcl.BandActn, Registry,
  Vcl.DBCtrls, Vcl.DBGrids, Printers, Vcl.Mask, Vcl.AppEvnts, Vcl.CustomizeDlg,
  UnitWinInfSignal, UnitDM, UnitTestState, ComObj, ShellApi, WinSvc, RudaGlobals;

type
  Position = (_left, center, right);   // для позиционирование текста в StringGrid1
  TSetingWinAdmin = packed record
                    PosSG: integer;    //для запоминания позици курсора в StringGridUserList
                    PosWS: integer;    //для запоминания позици курсора в ComboBoxWS
                    PosLine: integer;  //для запоминания позици курсора в ComboBoxLine
     end;

    //  TRegistryValue = set of TRegistryValueEnum;
  TFormRudaAdmin = class(TForm)
    ActionManager1: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionToolBar1: TActionToolBar;
    ActionAccountManagement: TAction;
    ActionOpenWinInfSignal: TAction;
    ActionCloseAllWinInfSignal: TAction;
    ActionClearBD: TAction;
    ActionCompressBD: TAction;
    Exit_Prog: TAction;
    ActionHelp: TAction;
    ActionAbout: TAction;
    PrinterSetup: TAction;
    ActionDisp: TAction;
    ActionTestState: TAction;
    ActionSettingsWorkStation: TAction;
    ImageList1: TImageList;
    ActionConfigWorkStation: TAction;
    ActionTableInformationSignals: TAction;
    ActionConnectControllers: TAction;
    ActionEnterpriseСompany: TAction;
    ActionСoefficients: TAction;
    ActionСontrollersSKRP: TAction;
    ActionListOre: TAction;
    ActionConfigMenu: TAction;
    PrinterSetupDialog1: TPrinterSetupDialog;
    OpenDialog1: TOpenDialog;
    TimerRunDialogEnterPassword: TTimer;
    TimerNameLang: TTimer;
    PanelAccountManagement: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    SpeedButtonAddUser: TSpeedButton;
    SpeedButtonDelUser: TSpeedButton;
    Label4: TLabel;
    EditUser: TEdit;
    Label5: TLabel;
    ComboBoxWS: TComboBox;
    ListViewCheckParam: TListView;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    Panel1: TPanel;
    StringGridUserList: TStringGrid;
    CustomizeDlg1: TCustomizeDlg;
    ActionResetConfigMenu: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButtonCascade: TToolButton;
    ToolButtonTile: TToolButton;
    ToolButtonArrangeAll: TToolButton;
    BitBtnClose: TBitBtn;
    ActionSettingProgramm: TAction;
    PageControlAdmin: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PanelChangePasswordAdmin: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelKeyboardLayout: TLabel;
    CheckBoxChangePasswordAdmin: TCheckBox;
    EditNewPassword: TEdit;
    EditConfirmNewPassword: TEdit;
    EditOldPassword: TEdit;
    BitBtnEyePassword: TBitBtn;
    ButtonCreateService: TButton;
    ButtonStartService: TButton;
    ButtonPauseService: TButton;
    ButtonStopService: TButton;
    ButtonContinueService: TButton;
    ButtonDeleteService: TButton;
    Label6: TLabel;
    LabelStatusService: TLabel;
    TimerServiceStatus: TTimer;
    ActionLineSettingsConnection: TAction;
    ButtonClose: TButton;
    TimerRunWinShowInfoCompressDB: TTimer;
    procedure ActionAccountManagementExecute(Sender: TObject);
    procedure PrinterSetupExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionAboutExecute(Sender: TObject);
    function IsWindows64: Boolean;
    function WinInfo(Root_Key: HKEY; Key_Open, Key_Read: string): string;
    procedure Exit_ProgExecute(Sender: TObject);
    procedure SetAccess(admin: boolean);
    procedure ListingUser;
    procedure StringGridUserListDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState); //получаем список всех пользователй
    function SGText(Grid: TStringGrid; Text: String; NumCol: Integer; where: Position): String;
    procedure StringGridUserListClick(Sender: TObject);
    procedure CheckBoxChangePasswordAdminClick(Sender: TObject);
    procedure ComboBoxWSChange(Sender: TObject);
//    function GetActiveKbdLayout : LongWord;
    procedure TimerRunDialogEnterPasswordTimer(Sender: TObject);
    procedure TimerNameLangTimer(Sender: TObject);
    procedure SpeedButtonAddUserClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ListWS(Sender: TObject);
    procedure GridClean(Sender: TObject; CanClean: boolean);
    procedure ButtonCancelClick(Sender: TObject);
    procedure LoadSetingWinAdmin;
    procedure SaveSetingWinAdmin;
    procedure SpeedButtonDelUserClick(Sender: TObject);
    procedure BitBtnEyePasswordMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtnEyePasswordMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ActionEnterpriseСompanyExecute(Sender: TObject);
    procedure CloseWindowsAdmin;       //закрывает все панели администратора
    procedure ActionСoefficientsExecute(Sender: TObject);
    procedure ActionСontrollersSKRPExecute(Sender: TObject);
    procedure ActionListOreExecute(Sender: TObject);
    procedure ActionConnectControllersExecute(Sender: TObject);
    procedure ActionTableInformationSignalsExecute(Sender: TObject);
    procedure ActionConfigWorkStationExecute(Sender: TObject);
    procedure ActionSettingsWorkStationExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClearAllData;
    procedure ActionDispExecute(Sender: TObject);
    procedure ActionTestStateExecute(Sender: TObject);
    procedure EditUserKeyPress(Sender: TObject; var Key: Char);
    procedure ListViewCheckParamClick(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure ActionConfigMenuExecute(Sender: TObject);
    procedure ActionResetConfigMenuExecute(Sender: TObject);
    procedure ActionOpenWinInfSignalExecute(Sender: TObject);
    procedure ActionCloseAllWinInfSignalExecute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButtonCascadeClick(Sender: TObject);
    procedure ToolButtonTileClick(Sender: TObject);
    procedure ToolButtonArrangeAllClick(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure ActionSettingProgrammExecute(Sender: TObject);
    procedure ActionClearBDExecute(Sender: TObject);
    procedure ActionCompressBDExecute(Sender: TObject);
    procedure ActionHelpExecute(Sender: TObject);
    procedure ButtonCreateServiceClick(Sender: TObject);
    procedure ButtonStopServiceClick(Sender: TObject);
    procedure ButtonStartServiceClick(Sender: TObject);
    procedure ButtonPauseServiceClick(Sender: TObject);
    procedure ButtonContinueServiceClick(Sender: TObject);
    procedure ButtonDeleteServiceClick(Sender: TObject);
    procedure SrvStat;
    procedure TimerServiceStatusTimer(Sender: TObject);
    function ConnectDB: boolean;      //путь к базам данных из DSN
    procedure DisconnectDB();
    function FindConnectUser(): boolean;
    function СreateNewField: boolean; //создаем новые поля для версии СКРП 5.xx
    procedure LimitSizeForm(param: boolean);
    procedure ActionLineSettingsConnectionExecute(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject); //true - big, false - low
    function GetStateComressDBinDataBase(var stateCompressDB: TStateCompressDB): boolean;
    function StateProcessCompressDBinProcessing(showMsg: boolean = true): boolean;
    procedure TimerRunWinShowInfoCompressDBTimer(Sender: TObject);
  private
    { Private declarations }

    const
      ColWidths0 = 30;     //Ширина колонки 0 в StringGridUserList
      ColWidths1 = 120;    //Ширина колонки 1 в StringGridUserList
      ColWidths2 = 120;    //Ширина колонки 1 в StringGridUserList
      OffsetRight = 36;    //Отступ от прового края последний колонки для скрола
      BigFormMinHeight = 666;
      BigFormMinWidth = 640;
      LowFormMinHeight = 110;
      LowFormMinWidth = 640;
    var
      ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                            //измененные данные записать в базу данных
      After_Change: integer;

    procedure WMCopyData(var MessageData: TWMCopyData); message WM_COPYDATA;
  
  public
    { Public declarations }
//    procedure LangChange(var Mess: TMessage); message  WM_INPUTLANGCHANGE;   //ловим смену раскладки

  end;

var
  FormRudaAdmin: TFormRudaAdmin;
  PrinterName: string; //имя принтера
  EnterPassOK: boolean = false;   //если true - пароль введен коректно
                                  //если false - что-то не то
  ReservedWords: array [0..1] of string = ('администратор', 'administrator');
  CodeUser: integer;
  SetingWinAdmin: TSetingWinAdmin;
  OffsetTopButton, OffsetBottomButton: integer; //смещение верхних и нижних кнопок
                                                //относительно центра панели
  ConfigFile: TFileName; //в этом файле сохраняются настройки меню
  FMas:array[0..MAXWIN - 1] of TFormWinInfSignal;
  FormTestState: TFormTestState;
  TransferParamConfig: PTransferParamConfig;
  DB_Connect: boolean;
//  FormWinInfSignalNew: TFormWinInfSignal;

implementation

uses UnitEnterPassword, About,
     UnitEnterpriseСompany, UnitСoefficients, UnitСontrollersSKRP, UnitTypeOre,
     UnitConnectControllers, UnitTableInformationSignals, UnitConfigWorkStation,
     UnitSettingsWorkStation, UnitDisp, UnitSettingsProgramm, UnitLineSettingsConnection,
     UnitClearBD, HTMLHelpViewer, UnitProgressCompressDB, UnitShowProgressCompressDB;

{$R *.dfm}

////ловим смену раскладки клавиатуры
//procedure TForm1.LangChange(var Mess: TMessage);
//begin
//  if FormEnterUser.Showing then
//          FormEnterUser.LabelKeyboardLayout.Caption:= NameKeyboardLayout(GetActiveKbdLayout);
//  if PanelChangePasswordAdmin.Visible then
//          LabelKeyboardLayout.Caption:= NameKeyboardLayout(GetActiveKbdLayout);
//end;

//{активная раскладка в своей программе}
//function TForm1.GetActiveKbdLayout : LongWord;
//begin
//  result:= GetKeyboardLayout(0) shr $10;
//end;

procedure TFormRudaAdmin.WMCopyData(var MessageData: TWMCopyData);
begin
  if MessageData.CopyDataStruct.dwData = CMD_COMPRESSDB then
    begin
      TransferParamConfig:= MessageData.CopyDataStruct.lpData;
      StateProcessCompressDB:= TransferParamConfig^.StateCompressDB;
      if TransferParamConfig^.StateCompressDB = Processing then     //значит идет процесс сжатия. Отключаем базы данных
        begin
          DisconnectDB();
          TimerRunWinShowInfoCompressDB.Enabled:= true;
        end
        else begin
          DB_Connect:= ConnectDB;
          if FormShowProgressCompressDB.Showing then FormShowProgressCompressDB.Close;
        end;
    end;
end;

procedure TFormRudaAdmin.SrvStat;
  var statSrv: DWORD;
begin
  statSrv:= DM.ServiceGetStatus(nil, ServiceName);
  case statSrv of
    0: begin
          LabelStatusService.Font.Color:= clRed;
          LabelStatusService.Caption:= 'не установлен';
          ButtonCreateService.Enabled:= true;
          ButtonDeleteService.Enabled:= false;
          ButtonStartService.Enabled:= false;
          ButtonStopService.Enabled:= false;
          ButtonContinueService.Enabled:= false;
          ButtonPauseService.Enabled:= false;
       end;
    1: begin
          LabelStatusService.Font.Color:= clBlue;
          LabelStatusService.Caption:= 'остановлен';
          ButtonCreateService.Enabled:= false;
          ButtonDeleteService.Enabled:= true;
          ButtonStartService.Enabled:= true;
          ButtonStopService.Enabled:= false;
          ButtonContinueService.Enabled:= false;
          ButtonPauseService.Enabled:= false;
       end;
    4: begin
          LabelStatusService.Font.Color:= clGreen;
          LabelStatusService.Caption:= 'выполняется';
          ButtonCreateService.Enabled:= false;
          ButtonDeleteService.Enabled:= false;
          ButtonStartService.Enabled:= false;
          ButtonStopService.Enabled:= true;
          ButtonContinueService.Enabled:= false;
          ButtonPauseService.Enabled:= true;
       end;
    7: begin
          LabelStatusService.Font.Color:= $FF8C00;
          LabelStatusService.Caption:= 'приостановлен';
          ButtonCreateService.Enabled:= false;
          ButtonDeleteService.Enabled:= false;
          ButtonStartService.Enabled:= false;
          ButtonStopService.Enabled:= true;
          ButtonContinueService.Enabled:= true;
          ButtonPauseService.Enabled:= false;
       end;
  end;
end;

//информация о операционной системе
function TFormRudaAdmin.IsWindows64: Boolean;
var
  ASystemInfo: TSystemInfo;
begin
  ASystemInfo.dwOemId := 0;
  GetNativeSystemInfo(ASystemInfo);
  Result := ASystemInfo.wProcessorArchitecture in [PROCESSOR_ARCHITECTURE_IA64,PROCESSOR_ARCHITECTURE_AMD64];
end;

function TFormRudaAdmin.WinInfo(Root_Key: HKEY; Key_Open, Key_Read: string): string;
 var
  registry: TRegistry;
begin
  //если Windows NT, открываем другой ключ
  if ((GetVersion and $80000000)=0) and (Key_Open=WinVers) then
  Key_Open:='SOFTWARE\Microsoft\Windows NT\CurrentVersion';
  Registry := TRegistry.Create;
  try
    Registry.RootKey:= Root_Key;
    Registry.OpenKeyReadOnly(Key_Open);// OpenKey(Key_Open, False);
    if registry.ValueExists(Key_Read) then
      Result:= Registry.ReadString(Key_Read)
      else Result:= #0;  //
  finally
    Registry.Free;
  end;
 //если ничего не найдено, выводим "невозможно определить"
// if Result = EmptyStr then Result:= Key_read + ': невозможно определить';

end;

procedure TFormRudaAdmin.Panel1Resize(Sender: TObject);
  var param: real;
begin
  if After_Change = 0 then After_Change:= StringGridUserList.Width - OffsetRight;
  param:= (StringGridUserList.Width - OffsetRight)/After_Change;
  StringGridUserList.ColWidths[0]:= round(StringGridUserList.ColWidths[0] * param);
  StringGridUserList.ColWidths[1]:= round(StringGridUserList.ColWidths[1] * param);
  StringGridUserList.ColWidths[2]:= round(StringGridUserList.ColWidths[2] * param);
  After_Change:= StringGridUserList.Width - OffsetRight;
end;

procedure TFormRudaAdmin.Panel2Resize(Sender: TObject);
begin
  SpeedButtonAddUser.Left:= (Panel2.Width div 2) - OffsetTopButton - SpeedButtonAddUser.Width;
  SpeedButtonDelUser.Left:= (Panel2.Width div 2) + OffsetTopButton;
//  ButtonSave.Left:= (Panel2.Width div 2) - OffsetBottomButton - ButtonSave.Width;
//  ButtonCancel.Left:= (Panel2.Width div 2) + OffsetBottomButton;
end;

procedure TFormRudaAdmin.PrinterSetupExecute(Sender: TObject);
begin
  Printer.PrinterIndex:=Printer.Printers.IndexOf(PrinterName); //Вытащил
  if PrinterSetupDialog1.Execute then
    begin
      //запомнил в глобальной переменной и в реестре
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'PrinterName',
                 Trim(Printer.Printers.Strings[Printer.PrinterIndex]));
      PrinterName:=Trim(Printer.Printers.Strings[Printer.PrinterIndex]);
    end;
end;

procedure TFormRudaAdmin.SetAccess(admin: boolean);
begin
  ActionAccountManagement.Enabled:= admin;
  ActionСoefficients.Enabled:= admin;
  FormSettingsProgramm.SpinEditTimeChannelFind.Enabled:= admin;
end;

//добавляет пробелы
function TFormRudaAdmin.SGText(Grid: TStringGrid; Text: String; NumCol: Integer; where: Position): String;
 var WCells: Integer;
begin
  WCells:= Grid.ColWidths[NumCol] - 7;
  //7 - корректировка для более точного вывода текста
  Result:=Text;
  with Grid, Grid.Canvas do
    case where of
     center: while TextWidth(Result) < WCells do
               Result:= ' ' + Result + ' ';
      right: while TextWidth(Result) < WCells do
               Result:= ' ' + Result;
      _left:  ;
    end;
end;

procedure TFormRudaAdmin.GridClean(Sender: TObject; CanClean: boolean);   //убирает выделение ячеек после покидания фокуса
var
  hGridRect: TGridRect;
begin
  if CanClean then
    begin
      hGridRect.Top := -1;
      hGridRect.Left := -1;
      hGridRect.Right := -1;
      hGridRect.Bottom := -1;
    end
    else
    begin
      hGridRect.Top := 1;
      hGridRect.Left := 1;
      hGridRect.Right := 1;
      hGridRect.Bottom := 1;
    end;
  (Sender as TStringgrid).Selection := hGridRect;
end;

procedure TFormRudaAdmin.SpeedButtonAddUserClick(Sender: TObject);
begin
//   PanelChangePasswordAdmin.Visible:= false;
//   PageControlAdmin.Enabled:= false;
   EditUser.Enabled:= true;

   EditUser.Clear;
   EditUser.SetFocus;
   GridClean(StringGridUserList, true);

   SpeedButtonDelUser.Enabled:= false;
   StringGridUserList.Enabled:= false;

   PanelAccountManagement.Color:= ColorEdit;
   PanelChangePasswordAdmin.Color:= ColorEdit;

//   EditUser.Color:= ColorEdit;
//   ComboBoxWS.Color:= ColorEdit;;
//   ListViewCheckParam.Color:= ColorEdit;;
//   PanelChangePasswordAdmin.Visible:= false;
   CodeUser:= 0;

   ListWS(sender);
//   ComboBoxWSChange(sender);
//   ComboBoxLineChange(sender);
end;

procedure TFormRudaAdmin.SpeedButtonDelUserClick(Sender: TObject);
begin
  if CountUser = 0 then exit; //нет пользователей
  if Application.MessageBox(PChar('Удалить пользователя: "' +
                                  StringGridUserList.Cells[1, StringGridUserList.Row] + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      if not DM.QueryServer('DELETE FROM Users WHERE U_Code = ' + IntToStr(CodeUser),
                                Caption, 'SpeedButtonDelUserClick', false) then exit;

      if not DM.QueryServer('DELETE FROM UserGraph WHERE U_Code = ' + IntToStr(CodeUser),
                                Caption, 'SpeedButtonDelUserClick', false) then exit;

      if not DM.QueryServer('DELETE FROM UserOpen WHERE U_Code = ' + IntToStr(CodeUser),
                                Caption, 'SpeedButtonDelUserClick', false) then exit;

      if not DM.QueryServer('DELETE FROM UserParam WHERE U_Code = ' + IntToStr(CodeUser),
                                Caption, 'SpeedButtonDelUserClick', false) then exit;

      if not DM.QueryServer('DELETE FROM UserView WHERE U_Code = ' + IntToStr(CodeUser),
                                Caption, 'SpeedButtonDelUserClick', false) then exit;

      if not DM.QueryServer('DELETE FROM UserWindow WHERE U_Code = ' + IntToStr(CodeUser),
                                Caption, 'SpeedButtonDelUserClick', false) then exit;

      if not DM.QueryAccess('DELETE FROM Access WHERE U_Code = ' + IntToStr(CodeUser),
                                Caption, 'SpeedButtonDelUserClick', false) then exit;

//     эта запись присутсвует у Ульяны. Таблицы с названием AccessMI нет!!!!
//      try
//        ADOQueryAccessMDB.SQL.Clear;
//        ADOQueryAccessMDB.SQL.Add('DELETE FROM AccessMI WHERE U_Code = ' + IntToStr(CodeUser));
//        ADOQueryAccessMDB.ExecSQL;
//      except
//        on e: Exception do
//      end;

      ListingUser;
      StringGridUserListClick(Sender);
    end;

end;

procedure TFormRudaAdmin.StringGridUserListClick(Sender: TObject);
  var s: string;
begin
  if CountUser = 0 then exit;
  if ChangeData then ButtonSaveClick(Sender);

  if StringGridUserList.Row < 2 then StringGridUserList.Row:= 1;  //чтобы курсор не залезал на шапку таблицы
  with StringGridUserList do
    begin
      EditUser.Text:= Cells[1, Row];
      CodeUser:= StrToInt(Trim(Cells[3, Row]));
    end;

  //включаем панель смены пароля администратора
  s:= AnsiStrLower(PChar(EditUser.Text));
  if (pos(ReservedWords[0], s) > 0) or (pos(ReservedWords[1], s) > 0) then
    begin
//      PanelChangePasswordAdmin.Visible:= true;
//      PageControlAdmin.Enabled:= true;
      TimerNameLang.Enabled:= true;
      EditOldPassword.Clear;
      EditNewPassword.Clear;
      EditConfirmNewPassword.Clear;
      EditUser.Enabled:= false;
      CheckBoxChangePasswordAdmin.Checked:= false;
      CheckBoxChangePasswordAdminClick(Sender);
    end
    else
    begin
      TimerNameLang.Enabled:= false;
//      PanelChangePasswordAdmin.Visible:= false;
//      PageControlAdmin.Enabled:= false;
      EditUser.Enabled:= true;
    end;
  ListWS(sender);
  SaveSetingWinAdmin;
  ChangeData:= false;
end;

procedure TFormRudaAdmin.ListWS(Sender: TObject);   //получаем список рабочих станций
begin
  if not DM.QueryServer('SELECT * FROM WS', Caption, 'ListWS', true) then exit;

  DM.ADOQueryServerMDB.First;
  ComboBoxWS.Items.Clear;
  while not Dm.ADOQueryServerMDB.EOF do
    begin
      ComboBoxWS.Items.AddObject(DM.ADOQueryServerMDB.FieldByName('D_Name').AsString,
                                   TObject(integer(Dm.ADOQueryServerMDB.FieldByName('D_Code').AsInteger)));
      DM.ADOQueryServerMDB.Next; // го на следующего
    end;
  DM.ADOQueryServerMDB.First;

  if ComboBoxWS.Items.Count > 0 then
    begin
      ComboBoxWS.ItemIndex:= SetingWinAdmin.PosWS;
      ComboBoxWSChange(sender);
    end;
end;

procedure TFormRudaAdmin.StringGridUserListDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var s: string;
     Flag: Cardinal;
begin
  if (ACol=0) and (ARow=0) then
    begin
      s:= 'N п/п';
      Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_SINGLELINE; //or DT_WORDBREAK;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridUserList.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;

  if (ACol=1) and (ARow=0) then
    begin
      s:= 'Имя пользователя';
      //Если нет переноса слов, то выровнять по центру вертикали и горизонтали можно так
      Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_SINGLELINE;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridUserList.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;

  if (ACol=2) and (ARow=0) then
    begin
      s:= 'Права доступа';
      //Если нет переноса слов, то выровнять по центру вертикали и горизонтали можно так
      Flag:= DT_NOCLIP or DT_VCENTER or DT_CENTER or DT_SINGLELINE;
      Inc(Rect.Left,3);
      Dec(Rect.Right,3);
      DrawText(StringGridUserList.Canvas.Handle,PChar(s),length(s),Rect,Flag);
    end;
end;

procedure TFormRudaAdmin.TimerNameLangTimer(Sender: TObject);
begin
  LabelKeyboardLayout.Caption:= NameKeyboardLayout(GetActiveKbdLayoutWnd);
end;

procedure TFormRudaAdmin.TimerRunDialogEnterPasswordTimer(Sender: TObject);
begin
  if Active then
    begin
      TimerRunDialogEnterPassword.Enabled:= false;

      DB_Connect:= ConnectDB;
      if not DB_Connect then Close;

      ListingUser; //получаем список всех пользователй
      FormEnterUser.ComboBoxSelectUser.ItemIndex:= 0;
      FormEnterUser.ShowModal;
    end;
end;

procedure TFormRudaAdmin.TimerRunWinShowInfoCompressDBTimer(Sender: TObject);
begin
  TimerRunWinShowInfoCompressDB.Enabled:= false;
  if (not FormShowProgressCompressDB.Showing) and (not DB_Connect) then FormShowProgressCompressDB.ShowModal;
end;

procedure TFormRudaAdmin.TimerServiceStatusTimer(Sender: TObject);
begin
  SrvStat;
end;

procedure TFormRudaAdmin.ToolButtonArrangeAllClick(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TFormRudaAdmin.ToolButton1Click(Sender: TObject);
begin
  //
end;

procedure TFormRudaAdmin.ToolButtonTileClick(Sender: TObject);
begin
  Tile;
end;

procedure TFormRudaAdmin.ToolButtonCascadeClick(Sender: TObject);
begin
  Cascade;
end;

procedure TFormRudaAdmin.ActionAccountManagementExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  LimitSizeForm(true);
  ListWS(sender);
  ChangeData:= false;
  if ComboBoxWS.Items.Count = 0 then  //нет подключенных рабочих станций
    begin
      Application.MessageBox(PChar('Не найдено ни одной рабочей станции.' + #10#13 +
           'Сначала настройте рабочую станцию: "Рабочая станция" -> "Настройка рабочих станций".' +
           'Затем настройте ее конфигурацию: "Рабочая станция" -> "Конфигурация рабочей станции". '),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
      exit;
    end;

  PanelAccountManagement.Visible:= true;
  EditOldPassword.Clear;
  EditNewPassword.Clear;
  EditConfirmNewPassword.Clear;
  CheckBoxChangePasswordAdmin.Checked:= false;
  CheckBoxChangePasswordAdminClick(Sender);
  if CountUser > 0 then  //если в таблицы есть пользователи
    begin
      StringGridUserList.SetFocus;
      //устанавливаем курсор на первую строку
      StringGridUserList.Col:= 0;
      StringGridUserList.Row:= 1;
      //обнуляем позиции
      SetingWinAdmin.PosSG:= 0;
      SetingWinAdmin.PosWS:= 0;
      SetingWinAdmin.PosLine:= 0;
      StringGridUserListClick(Sender);
    end;
  SrvStat;
  TimerServiceStatus.Enabled:= true;
end;

procedure TFormRudaAdmin.ActionClearBDExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormClearBD.Show;
end;

procedure TFormRudaAdmin.ActionCloseAllWinInfSignalExecute(Sender: TObject);
  var i: integer;
begin
  if Application.MessageBox(PChar('Закрыть все окна "Просмотр значений информационных сигналов конвейеров" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
//      DM.CloseAllWin(tagWinInfSign);
      for i:= 0 to MAXWIN - 1 do
        if FMas[i] <> nil then
          begin
            DM.CloseAllWinClassName('TFormWinInfSignal', PChar(FMas[i].Caption));
            FMas[i]:= nil;
          end;
    end;
end;

//проверяем по наличию файлов с расширением *.ldb
function TFormRudaAdmin.FindConnectUser(): boolean;
  var FindFile: TSearchRec;
begin
  if (FindFirst(ExtractFilePath(PathAccessMDB) + '*.ldb', faAnyFile, FindFile) = 0) or
     (FindFirst(ExtractFilePath(PathWorkStationMDB) + '*.ldb', faAnyFile, FindFile) = 0) or
     (FindFirst(ExtractFilePath(PathDataMDB) + '*.ldb', faAnyFile, FindFile) = 0) or
     (FindFirst(ExtractFilePath(PathDataWSMDB) + '*.ldb', faAnyFile, FindFile) = 0) or
     (FindFirst(ExtractFilePath(PathServerMDB) + '*.ldb', faAnyFile, FindFile) = 0) then //Параметры функции задают поиск

    result:= true
    else result:= false;
end;

procedure TFormRudaAdmin.ActionCompressBDExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Перед началом сжатия баз данных:'
                            + #10#13 + #10#13 +
                            NameAccessMdb + ', ' + #10#13 +
                            NameDataMdb + ', ' + #10#13 +
                            NameServerMdb + ', ' + #10#13 +
                            NameWorkStationMdb + ', ' + #10#13 + #10#13 +
         'необходимо:' + #10#13 +
         '1. закрыть все работающие программы СКРП;' + #10#13 +
         '2. закрыть все окна программы СКРП "Администрирование и настройка рабочей станции";' + #10#13 +
         '3. рекомендуется сделать резервную копию файлов баз данных:' + #10#13 +
         PathAccessMDB + '; ' + #10#13 +
         PathDataMdb + '; ' + #10#13 +
         PathServerMdb + '; ' + #10#13 +
         PathWorkStationMdb + '; ' + #10#13 + #10#13 +
         'Сжать указанные базы данных?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONWARNING) = IDYES  then
    begin
      DisconnectDB();  //отключаем все подключения к базе данных программы администрирования
      sleep(500);
      if FindConnectUser() then
        begin
          MessageDlg('К базам данных подключены клиенты.' + #10#13 +
                    'Сжатие баз данных невозможно.',mtWarning, [mbOK], 0);
          DB_Connect:= ConnectDB;
          exit;
        end;

      FormProgressCompressDB.ShowModal;
    end;
end;

procedure TFormRudaAdmin.ActionConfigMenuExecute(Sender: TObject);
begin
  CustomizeDlg1.Show;
end;

procedure TFormRudaAdmin.ActionConfigWorkStationExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormConfigWorkStation.Show;
end;

procedure TFormRudaAdmin.ActionLineSettingsConnectionExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormLineSettingsConnection.Show;
end;

procedure TFormRudaAdmin.Action2Execute(Sender: TObject);
begin
//    подменю Настройка технических параметров
end;

procedure TFormRudaAdmin.ActionAboutExecute(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

procedure TFormRudaAdmin.BitBtn1Click(Sender: TObject);
begin
  Cascade;
end;

procedure TFormRudaAdmin.BitBtn2Click(Sender: TObject);
begin
  Tile;
end;

procedure TFormRudaAdmin.BitBtn3Click(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TFormRudaAdmin.BitBtnCloseClick(Sender: TObject);
begin
  if ChangeData then ButtonSaveClick(Sender);
  CloseWindowsAdmin;
end;

procedure TFormRudaAdmin.BitBtnEyePasswordMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      EditOldPassword.PasswordChar:= #0;
      EditNewPassword.PasswordChar:= #0;
      EditConfirmNewPassword.PasswordChar:= #0;
    end;
end;

procedure TFormRudaAdmin.BitBtnEyePasswordMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      EditOldPassword.PasswordChar:= Char('*');
      EditNewPassword.PasswordChar:= Char('*');
      EditConfirmNewPassword.PasswordChar:= Char('*');
    end;
end;

procedure TFormRudaAdmin.ButtonCreateServiceClick(Sender: TObject);
  var hProcess: THandle;
begin
  DM.RunAsAdmin(Handle, PathServiceRudaWS + FileNameService, '/install', hProcess);

//  err:= ShellExecute(handle, 'runas','net','stop RudaWS', nil, SW_HIDE);
//  err:= WinExec(PAnsiChar('net stop RudaWS'), SW_HIDE);
end;

procedure TFormRudaAdmin.ButtonDeleteServiceClick(Sender: TObject);
  var hProcess: THandle;
begin
  DM.RunAsAdmin(Handle, PathServiceRudaWS + FileNameService, ' /uninstall', hProcess);
end;

procedure TFormRudaAdmin.ButtonPauseServiceClick(Sender: TObject);
  var hProcess: THandle;
begin
  DM.RunAsAdmin(Handle, 'net', 'pause ' + ServiceName, hProcess);
end;

procedure TFormRudaAdmin.ButtonContinueServiceClick(Sender: TObject);
  var hProcess: THandle;
begin
  DM.RunAsAdmin(Handle, 'net', 'continue ' + ServiceName, hProcess);
end;

procedure TFormRudaAdmin.ButtonStartServiceClick(Sender: TObject);
  var hProcess: THandle;
begin
  DM.RunAsAdmin(Handle, 'net', 'start ' + ServiceName, hProcess);
end;

procedure TFormRudaAdmin.ButtonStopServiceClick(Sender: TObject);
  var hProcess: THandle;
begin
  DM.RunAsAdmin(Handle, 'net', 'stop ' + ServiceName, hProcess);
end;

procedure TFormRudaAdmin.ButtonCancelClick(Sender: TObject);
begin
  ClearAllData;
  GridClean(StringGridUserList, false);
  StringGridUserListClick(Sender);
  if CountUser = 0 then EditUser.SetFocus
                   else StringGridUserList.SetFocus;
end;

procedure TFormRudaAdmin.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRudaAdmin.ButtonSaveClick(Sender: TObject);
  var  row, i: integer;
begin
  if Application.MessageBox(PChar('Сохранить изменения для пользователя: "' + EditUser.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if Trim(EditUser.Text) = '' then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                 Copy(Label4.Caption, 1 ,Length(Label4.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
          EditUser.SetFocus;
          exit;
        end;

      if (ComboBoxWS.Items.Count = 0) or (ComboBoxWS.ItemIndex = -1) then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                  Copy(Label5.Caption, 1 ,Length(Label5.Caption)-1) + '"'),
                                  PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                  MB_OK + MB_ICONWARNING);
          exit;
        end;

      if ListViewCheckParam.Items.Count = 0 then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "Контролируемые параметры"'),
                                  PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                  MB_OK + MB_ICONWARNING);
          exit;
        end;

      if CodeUser = 0 then    //записываем нового пользователя
        begin
          if not DM.QueryServer('INSERT INTO Users (U_Name) VALUES (''' + EditUser.Text + ''')',
                                  Caption, 'ButtonSaveClick', false) then exit;

          //узнаем номер уникальной записи нового пользователя (последней записи)
          if not DM.QueryServer('SELECT Max(U_Code) as cod FROM Users',
                                  Caption, 'ButtonSaveClick', true) then exit;

          if not DM.ADOQueryServerMDB.Eof then CodeUser:= DM.ADOQueryServerMDB.FieldByName('cod').AsInteger;
          if CodeUser = 0 then exit;
        end
        else
        begin
          //если пользователь старый - просто перезаписываем имя
          if not DM.QueryServer('UPDATE Users SET U_Name = ''' + EditUser.Text +
                                      ''' WHERE U_Code = ' + IntToStr(CodeUser),
                                  Caption, 'ButtonSaveClick', false) then exit;
        end;

      //удаляем предыдущие записи с установками Контролируемых параметров
      for i:= 0 to ListViewCheckParam.Groups.Count - 1 do
        begin
          if not DM.QueryAccess('DELETE FROM Access WHERE U_Code = ' + IntToStr(CodeUser) +
                                ' AND D_Code = ' + Trim(IntToStr(integer(ComboBoxWS.Items.Objects[ComboBoxWS.ItemIndex]))) +
                                ' AND L_Code = ' + Trim(IntToStr(ListViewCheckParam.Groups.Items[i].GroupID)),
                                 Caption, 'ButtonSaveClick', false) then exit;
        end;

      //заносим новые данные с установками Контролируемых параметров
      for row:= 0 to ListViewCheckParam.Items.Count - 1 do
        begin
          if ListViewCheckParam.Items[row].Checked and (ListViewCheckParam.Items[row].GroupID >= 0) then
            if not DM.QueryAccess('INSERT INTO Access(U_Code,D_Code,L_Code,Cp_Code) VALUES (''' +
                                  IntToStr(CodeUser) + ''', ''' +
                                  Trim(IntToStr(integer(ComboBoxWS.Items.Objects[ComboBoxWS.ItemIndex]))) + ''',''' +
                                  Trim(IntToStr(ListViewCheckParam.Items[row].GroupID)) + ''',''' +
                                  Trim(ListViewCheckParam.Items[row].SubItems[0]) + ''')',
                                  Caption, 'ButtonSaveClick', false) then exit;
        end;
    end;

  if PageControlAdmin.Enabled {PanelChangePasswordAdmin.Visible} then
    begin
      if CheckBoxChangePasswordAdmin.Checked then
        begin
          //получаем пароль администратора
          if not DM.QueryWorkStation('SELECT PassWordCf FROM ParamStation',
                                      Caption, 'ButtonSaveClick', true) then exit;

          if EditOldPassword.Text = Trim(DM.ADOQueryWorkStationMDB.FieldByName('PassWordCf').AsString) then
            begin
              if Trim(EditNewPassword.Text) = Trim(EditConfirmNewPassword.Text) then
               begin
              //сохраняем новый пароль
                if not DM.QueryWorkStation('UPDATE ParamStation Set PassWordCf = ''' +
                                            Trim(EditNewPassword.Text) + '''',
                                      Caption, 'ButtonSaveClick', false) then exit;

                Application.MessageBox(PChar('Пароль был успешно изменен.' ),
                            PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                            MB_OK + MB_ICONINFORMATION);

              end
              else
              begin
                Application.MessageBox(PChar('Не совпадает новый пароль с его подтверждением. Пароль не будет сохранен.' ),
                            PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'),
                            MB_OK + MB_ICONERROR);
              end;
            end
            else
            begin
              Application.MessageBox(PChar('Ошибка ввода пароля: ' + EditUser.Text + '. Пароль не будет сохранен.' ),
                            PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'),
                            MB_OK + MB_ICONERROR);
            end;
        end;
    end;

  PanelAccountManagement.Color:= clBtnFace;
  PanelChangePasswordAdmin.Color:= clBtnFace;
//  EditUser.Color:= clWhite;
//  ComboBoxWS.Color:= EditUser.Color;
//  ListViewCheckParam.Color:= EditUser.Color;
  SpeedButtonDelUser.Enabled:= true;
  StringGridUserList.Enabled:= true;
  GridClean(StringGridUserList, false);
  ListingUser;
  StringGridUserList.SetFocus;
  ChangeData:= false; //должна стоять именно перед LoadSetingWinAdmin;
  LoadSetingWinAdmin;
  StringGridUserListClick(Sender);
end;

procedure TFormRudaAdmin.CheckBoxChangePasswordAdminClick(Sender: TObject);
begin
   Label1.Enabled:= CheckBoxChangePasswordAdmin.Checked;
   Label2.Enabled:= CheckBoxChangePasswordAdmin.Checked;
   Label3.Enabled:= CheckBoxChangePasswordAdmin.Checked;

   EditOldPassword.Enabled:= CheckBoxChangePasswordAdmin.Checked;
   EditNewPassword.Enabled:= CheckBoxChangePasswordAdmin.Checked;
   EditConfirmNewPassword.Enabled:= CheckBoxChangePasswordAdmin.Checked;

   BitBtnEyePassword.Enabled:= CheckBoxChangePasswordAdmin.Checked;
   if CheckBoxChangePasswordAdmin.Checked then ChangeData:= true;
end;

procedure TFormRudaAdmin.ComboBoxWSChange(Sender: TObject);
 var i: integer;
     LI: TListItem; //элемент списка
     row: integer;
begin
  with ListViewCheckParam.Columns do //готовим колонки списка
    begin
      Clear; //удаляем все старые колонки
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Разрешенные для просмотра параметры';
        LC.Width:= ListViewCheckParam.Width - 5;
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Код параметра';
        LC.Width:= 0;
    end;

  if not DM.QueryServer('SELECT L_Code, L_Name FROM Lines WHERE D_Code = ' +
                        Trim(IntToStr(integer(ComboBoxWS.Items.Objects[ComboBoxWS.ItemIndex]))),
                                Caption, 'ComboBoxWSChange', true) then exit;

  ListViewCheckParam.Groups.Clear;
  DM.ADOQueryServerMDB.First;
  while not DM.ADOQueryServerMDB.EOF do
    begin
      with ListViewCheckParam.Groups do //готовим группы списка
        begin
          LG:=Add; //новая группа
          LG.Header:= 'Конвейер: ' + DM.ADOQueryServerMDB.FieldByName('L_Name').AsString; //текст верхнего колонтитула
          LG.GroupID:= DM.ADOQueryServerMDB.FieldByName('L_Code').AsInteger; //идентификатор группы
        end;
      DM.ADOQueryServerMDB.Next; // го на следующего
    end;

  for i := 0 to ListViewCheckParam.Groups.Count - 1 do
    begin
      if not DM.QueryServer('SELECT Cp_Code, Cp_Name FROM ControlParam WHERE L_Code = ' +
                            Trim(IntToStr(ListViewCheckParam.Groups.Items[i].GroupID)) +
                            ' AND Num > 0 AND Connect ORDER BY Num',
                            Caption, 'ComboBoxWSChange', true) then exit;

      DM.ADOQueryServerMDB.First;
      while not DM.ADOQueryServerMDB.EOF do
        begin
          LI:= ListViewCheckParam.Items.Add; //добавили элемент списка
          LI.GroupID:= ListViewCheckParam.Groups.Items[i].GroupID;//идентификатор группы
          LI.Caption:= DM.ADOQueryServerMDB.FieldByName('Cp_Name').AsString;  //название параметра
          LI.SubItems.AddObject(DM.ADOQueryServerMDB.FieldByName('Cp_Code').AsString,
                              TObject(integer(DM.ADOQueryServerMDB.FieldByName('Cp_Code').AsInteger)));  //код параметра
          DM.ADOQueryServerMDB.Next; // го на следующего
        end;

      //расставляем галочки
      if (ListViewCheckParam.Items.Count > 0) and (CodeUser > 0) then
        begin
           if not DM.QueryAccess('SELECT Cp_Code FROM Access WHERE U_Code = ' +
               IntToStr(CodeUser) +
               ' AND D_Code = ' + Trim(IntToStr(integer(ComboBoxWS.Items.Objects[ComboBoxWS.ItemIndex])))+
               ' AND L_Code = ' + Trim(IntToStr(ListViewCheckParam.Groups.Items[i].GroupID)),
                                 Caption, 'ComboBoxWSChange', true) then exit;

           DM.ADOQueryAccessMDB.First;
           while not DM.ADOQueryAccessMDB.EOF do
            begin
              for row:= 0 to ListViewCheckParam.Items.Count - 1 do
                  if DM.ADOQueryAccessMDB.FieldByName('Cp_Code').AsInteger =
                      StrToInt(Trim(ListViewCheckParam.Items[row].SubItems[0])) then
                          ListViewCheckParam.Items[row].Checked:= true;

              DM.ADOQueryAccessMDB.Next;
              inc(row);
            end;
        end;
    end;
  ChangeData:= true;
  SaveSetingWinAdmin;
end;

//проверка происходит процесс сжатия баз данных или нет. И выводить сообщение об этом или не выводить.
function TFormRudaAdmin.StateProcessCompressDBinProcessing(showMsg: boolean = true): boolean;
begin
  result:= StateProcessCompressDB = Processing;
  if (StateProcessCompressDB = Processing) and showMsg then
    Application.MessageBox(PChar('Запущен процесс сжатия баз данных.' + #10#13 +
              'Подождите некоторое время и повторите попытку позже.'),
                  PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'), MB_OK + MB_ICONWARNING);
end;

procedure TFormRudaAdmin.ActionConnectControllersExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormConnectControllers.Show;
end;

procedure TFormRudaAdmin.ActionDispExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormDisp.Show;
end;

procedure TFormRudaAdmin.ActionEnterpriseСompanyExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormEnterpriseСompany.Show;
end;

procedure TFormRudaAdmin.ActionHelpExecute(Sender: TObject);
begin
  ShellExecute(0,PChar('Open'),PChar(PathApp + '\help.chm'),nil,nil,SW_SHOW);
end;

procedure TFormRudaAdmin.ActionListOreExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormTypeOre.Show;
end;

procedure TFormRudaAdmin.ActionOpenWinInfSignalExecute(Sender: TObject);
  var i: integer;
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
//  FormWinInfSignalNew:= TFormWinInfSignal.Create(Application);
//  FormWinInfSignalNew.Caption:= ProgName_ShortStringVersion;
//  FormWinInfSignalNew.Tag:= tagWinInfSign;             //признак, для удаления определенных видов формы
//  FormWinInfSignalNew.Show;

  for i := 0 to MAXWIN - 1 do
    if FMas[i] = nil then
      begin
        FMas[i]:= TFormWinInfSignal.Create(Application);
        FMas[i].Caption:= ProgName_ShortStringVersion +
                          ' окно ' + IntToStr(i + 1) + ' из ' + inttostr(MAXWIN);
        FMas[i].Tag:= i;
//        FMas[i].Name:= 'FormWinInfSignal' + inttostr(i+1);
        FMas[i].Show;
        break;
      end;
end;

procedure TFormRudaAdmin.ActionResetConfigMenuExecute(Sender: TObject);
  var i: integer;
begin
  if Application.MessageBox(PChar('Сбросить настройки меню для пользователя "' +
                                  UserName + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      for i:= 0 to ActionManager1.ActionBars.Count - 1 do
        ActionManager1.ResetActionBar(i);
      ActionManager1.ResetUsageData;   //сброс настроек
    end;
end;

procedure TFormRudaAdmin.ActionSettingProgrammExecute(Sender: TObject);
begin
  CloseWindowsAdmin;
  FormSettingsProgramm.ShowModal;
end;

procedure TFormRudaAdmin.ActionSettingsWorkStationExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormSettingsWorkStation.ShowModal;
end;

procedure TFormRudaAdmin.ActionTableInformationSignalsExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormTableInformationSignals.Show;
end;

procedure TFormRudaAdmin.ActionTestStateExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  if (not Assigned(FormTestState)) then
    begin
      Application.CreateForm(TFormTestState, FormTestState);
      FormTestState.Show;
    end;
end;

procedure TFormRudaAdmin.ActionСoefficientsExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormСoefficients.Show;
end;

procedure TFormRudaAdmin.ActionСontrollersSKRPExecute(Sender: TObject);
begin
  if StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  CloseWindowsAdmin;
  FormСontrollersSKRP.Show;
end;

procedure TFormRudaAdmin.EditUserKeyPress(Sender: TObject; var Key: Char);
begin
  ChangeData:= true;
end;

procedure TFormRudaAdmin.Exit_ProgExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormRudaAdmin.ListingUser; //получаем список всех пользователй
 var i: integer;
     s: string;
begin
  // очищаем таблицу
  with StringGridUserList do
    for i:= FixedRows to RowCount - 1 do
      Rows[i].Clear;

  StringGridUserList.RowCount:= 2;

   //получаем список всех пользователй
  if not DM.QueryServer('SELECT * FROM USERS', Caption, 'ListingUser', true) then exit;
  CountUser:= DM.DataSourceServerMDB.DataSet.RecordCount;

   //заполняем список пользователей
  DM.ADOQueryServerMDB.First;
  FormEnterUser.ComboBoxSelectUser.Items.Clear; // чистим список
  i:= 1; //начинаем с первой строки
  while not DM.ADOQueryServerMDB.EOF do
    begin
      StringGridUserList.RowCount:= StringGridUserList.RowCount + 1;
      StringGridUserList.Cells[0, i]:= SGText(StringGridUserList, IntToStr(i), 0, center);// IntToStr(i);
      StringGridUserList.Cells[1, i]:= DM.ADOQueryServerMDB.FieldByName('U_Name').AsString;
      s:= AnsiStrLower(PChar(DM.ADOQueryServerMDB.FieldByName('U_Name').AsString));
      if (pos(ReservedWords[0], s) > 0) or (pos(ReservedWords[1], s) > 0)
         then StringGridUserList.Cells[2, i]:= SGText(StringGridUserList, 'Администратор ', 2, right)
         else StringGridUserList.Cells[2, i]:= SGText(StringGridUserList, 'Пользователь ', 2, right);
      StringGridUserList.Cells[3, i]:= DM.ADOQueryServerMDB.FieldByName('U_Code').AsString;
      inc(i);

      FormEnterUser.ComboBoxSelectUser.Items.Add(DM.ADOQueryServerMDB.FieldByName('U_Name').AsString);
      DM.ADOQueryServerMDB.Next; // го на следующего
    end;
   //удаляем последнюю пустую строку
  if StringGridUserList.RowCount > 2 then StringGridUserList.RowCount:= StringGridUserList.RowCount - 1;
  DM.ADOQueryServerMDB.First;
end;

//получить состояние сжатия базы данных из базы Access
function TFormRudaAdmin.GetStateComressDBinDataBase(var stateCompressDB: TStateCompressDB): boolean;
  var TextSQL: string;
      intStateCompressionDB: integer;
begin
  try
    result:= true;
    TextSQL:= 'SELECT TOP 1 * FROM CompressionDatabase order by CSS_Code';      //выбираем верхнюю строку
    result:= DM.QueryAccess(TextSQL, Caption, 'GetStatusComressDBinDataBase', true);
    if result then
      begin
        if DM.ADOQueryAccessMDB.Eof then
          begin
            result:= false;
            exit;
          end
          else begin
            intStateCompressionDB:= DM.ADOQueryAccessMDB.FieldByName('StateCompressionDB').AsInteger;
            //проверяем диапазон.
            if (intStateCompressionDB >= Ord(Low(TStateCompressDB))) and (intStateCompressionDB <= Ord(High(TStateCompressDB))) then
              stateCompressDB := TStateCompressDB(intStateCompressionDB)
            else result:= false;
          end;
      end;
  except
    result:= false;
  end;
end;

procedure TFormRudaAdmin.ListViewCheckParamClick(Sender: TObject);
begin
  ChangeData:= true;
end;

function TFormRudaAdmin.СreateNewField: boolean;

  procedure SetDefaultDataFieldInAutoOffStart;
    begin
      if DM.QueryTempWorkStation('SELECT * FROM ParamStation', Caption, 'СreateNewField', true) then
        begin
          DM.ADOQueryTempWS.First;
          while not DM.ADOQueryTempWS.EOF do
            begin
                DM.CommandWS('UPDATE ParamStation SET AutoOffStart = ' + booltostr(defAutoOffStart, true) +
                  ' WHERE D_Code = ' + DM.ADOQueryTempWS.FieldByName('Pst_Code').AsString, Caption, 'SetDefaultDataFieldInAutoOffStart');
                DM.ADOQueryTempWS.Next;
            end;
        end;
    end;

var List: TStringList;
    TextSQL: string;
    i: integer;
begin
  result:= true;
  try
    List:= TStringList.Create;
    //проверяем наличие полей в БД для работы с OPC-сервером, если их нет - создаем.
    if not DM.QueryWorkStation('SELECT * FROM ParamStation', Caption, 'СreateNewField', true) then
      raise Exception.Create('Ошибка с базой данных');

    List.Clear;
    DM.ADOQueryWorkStationMDB.GetFieldNames(List);    //получаем имена полей таблицы ParamStation

    if List.IndexOf('ReservOPC') = -1 then  //значит такого поля нет
      result:= DM.QueryWorkStation('ALTER TABLE ParamStation ADD COLUMN ReservOPC BIT', Caption, 'СreateNewField', false);

    if List.IndexOf('ReservOPCHour') = -1 then
      if result then  //если нет ошибки создания предыдущего поля создаем следующие
        result:= DM.QueryWorkStation('ALTER TABLE ParamStation ADD COLUMN ReservOPCHour BIT', Caption, 'СreateNewField', false);

    if List.IndexOf('ReservOPCWeight') = -1 then
      if result then  //если нет ошибки создания предыдущего поля создаем следующие
        result:= DM.QueryWorkStation('ALTER TABLE ParamStation ADD COLUMN ReservOPCWeight BIT', Caption, 'СreateNewField', false);

  //создаем поля для автоматического отключения "Режима отбора проб"
    if List.IndexOf('AutoOffStart') = -1 then
      if result then  //если нет ошибки создания предыдущего поля создаем следующие
        begin
          result:= DM.QueryWorkStation('ALTER TABLE ParamStation ADD COLUMN AutoOffStart BIT' , Caption, 'СreateNewField', false);
          if result then  //устанавливаем значение поля AutoOffStart по умолчанию для всех рабочих станций
            SetDefaultDataFieldInAutoOffStart;
        end;

    if List.IndexOf('TimeOffStart') = -1 then
      if result then  //если нет ошибки создания предыдущего поля создаем следующие
        result:= DM.QueryWorkStation('ALTER TABLE ParamStation ADD COLUMN TimeOffStart BYTE NULL', Caption, 'СreateNewField', false);

    if result then //если нет ошибки создания предыдущего поля, создаем таблицу
      begin
        List.Clear;
        DM.ADOConnectionWorkStationMDB.GetTableNames(List);   //получаем имена всех таблиц в базе WorkStation
        if List.IndexOf('RudaNetOPCHour') = -1 then //значит такой таблицы нет. создаем ее
          begin
            TextSQL:= 'CREATE TABLE RudaNetOPCHour (N_Code COUNTER primary key,' +
                        'L_Code long NOT NULL,' +
                        'L_CodeLine TEXT(3) NOT NULL,' +
                        'H_Date DATETIME,' +
                        'Dat TEXT(8) NOT NULL,' +
                        'Tim TEXT(8) NOT NULL';
            for i:= 1 to MAXPARAM do
              begin
                TextSQL:= TextSQL + ', P' + inttostr(i) + '_H DOUBLE NULL' +
                                    ', P' + inttostr(i) + '_C DOUBLE NULL' +
                                    ', P' + inttostr(i) + '_D DOUBLE NULL' +
                                    ', P' + inttostr(i) + '_M DOUBLE NULL';
              end;

            TextSQL:= TextSQL + ')';

            result:= DM.QueryWorkStation(TextSQL, Caption, 'СreateNewField', false);
          end;
      end;

       //создаем поля для минимуму-максимума нулей
    DM.QueryWorkStation('SELECT * FROM ParamLines', Caption, 'СreateNewField', true);

    List.Clear;
    DM.ADOQueryWorkStationMDB.GetFieldNames(List);    //получаем имена полей таблицы ParamLines

    if List.IndexOf('UminNull') = -1 then
      if result then  //если нет ошибки создания предыдущего поля создаем следующие
        result:= DM.QueryWorkStation('ALTER TABLE ParamLines ADD COLUMN UminNull REAL NULL', Caption, 'СreateNewField', false);

    if List.IndexOf('UmaxNull') = -1 then
      if result then  //если нет ошибки создания предыдущего поля создаем следующие
        result:= DM.QueryWorkStation('ALTER TABLE ParamLines ADD COLUMN UmaxNull REAL NULL', Caption, 'СreateNewField', false);

    if List.IndexOf('DateBeginStart') = -1 then
      if result then  //если нет ошибки создания предыдущего поля создаем следующие
        result:= DM.QueryWorkStation('ALTER TABLE ParamLines ADD COLUMN DateBeginStart DateTime', Caption, 'СreateNewField', false);

    DM.QueryServer('SELECT * FROM CONTROLPARAM', Caption, 'СreateNewField', true);

    List.Clear;
    DM.ADOQueryServerMDB.GetFieldNames(List);    //получаем имена полей таблицы CONTROLPARAM базы Server

    if List.IndexOf('Cp_Description') = -1 then              //описание контролируемого параметра
      if result then  //если нет ошибки создания предыдущего поля создаем следующие
        result:= DM.QueryServer('ALTER TABLE CONTROLPARAM ADD COLUMN Cp_Description TEXT(128)', Caption, 'СreateNewField', false);

    //создаем таблицу для обмена с прграммами RudaClient о статусе сжатия базы данных
    //устанавливаем начальное значение - компрессия завершена.
    if result then //если нет ошибки создания предыдущего поля, создаем таблицу
      begin
        List.Clear;
        DM.ADOConnectionAccessMDB.GetTableNames(List);
        if List.IndexOf('CompressionDatabase') = -1 then //значит такой таблицы нет. создаем ее
          begin
            TextSQL:= 'CREATE TABLE CompressionDatabase (CSS_Code COUNTER primary key, ' +
                        'CSS_Date DATETIME, ' +
                        'StateCompressionDB BYTE NOT NULL)';

            result:= DM.QueryAccess(TextSQL, Caption, 'СreateNewField', false);
            if result then  //устанавливаем начальное значение
              begin
                TextSQL:= 'INSERT INTO CompressionDatabase (CSS_Date, StateCompressionDB) VALUES (''' +
                FormatDateTime('dd.mm.yyyy hh:nn:ss', now) + ''', ' +
                IntToStr(Ord(Completed)) + ')';
                DM.QueryAccess(TextSQL, Caption, 'СreateNewField', false);
              end;
          end;
      end;
  finally
    FreeAndNil(List);
  end;
end;

function TFormRudaAdmin.ConnectDB: boolean;      //путь к базам данных из DSN
  var Err_SQLState: string;
      err: integer;
      sErr: string;
begin
  result:= true;
  sErr:= '';
  err:= DM.ConnectBDAccess(Err_SQLState);
  if err = 0 then PathAccessMDB:= DM.FromDSNgetPathBase(DSNNameRudaAdmin, 'DBQ')
    else begin
      PathAccessMDB:= '';
      sErr:= sErr + 'Не найдена база данных Access.mdb. Проверьте настройки DSN "' + DSNNameRudaAdmin +
           '"' + #10#13 + 'Код ошибки: NativeError[' + IntToStr(err) + '], SQLState:[' +
           Err_SQLState + ']' + #10#13 + #10#13;
    end;

  err:= DM.ConnectBDData(Err_SQLState);
  if err = 0 then PathDataMDB:= DM.FromDSNgetPathBase(DSNNameRudaDataDubl, 'DBQ')
    else begin
      PathDataMDB:= '';
      sErr:= sErr + 'Не найдена база данных Data.mdb. Проверьте настройки DSN "' + DSNNameRudaDataDubl +
           '"' + #10#13 + 'Код ошибки: NativeError[' + IntToStr(err) + '], SQLState:[' +
           Err_SQLState + ']' + #10#13 + #10#13;
    end;

  err:= DM.ConnectBDDataWS(Err_SQLState);
  if err = 0 then PathDataWSMDB:= DM.FromDSNgetPathBase(DSNNameRudaData, 'DBQ')
    else begin
      PathDataWSMDB:= '';
      sErr:= sErr + 'Не найдена база данных Data.mdb. Проверьте настройки DSN "' + DSNNameRudaData +
           '"' + #10#13 + 'Код ошибки: NativeError[' + IntToStr(err) + '], SQLState:[' +
           Err_SQLState + ']' + #10#13 + #10#13;
    end;

  err:= DM.ConnectBDServer(Err_SQLState);
  if err = 0 then PathServerMDB:= DM.FromDSNgetPathBase(DSNNameRudaServer, 'DBQ')
    else begin
      PathServerMDB:= '';
      sErr:= sErr + 'Не найдена база данных Server.mdb. Проверьте настройки DSN "' + DSNNameRudaServer +
           '"' + #10#13 + 'Код ошибки: NativeError[' + IntToStr(err) + '], SQLState:[' +
           Err_SQLState + ']' + #10#13 + #10#13;
    end;

  err:= DM.ConnectBDWorkStation(Err_SQLState);
  if err = 0 then PathWorkStationMDB:= DM.FromDSNgetPathBase(DSNNameRudaWS, 'DBQ')
    else begin
      PathWorkStationMDB:= '';
      sErr:= sErr + 'Не найдена база данных WorkStation.mdb. Проверьте настройки DSN "' + DSNNameRudaWS +
           '"' + #10#13 + 'Код ошибки: NativeError[' + IntToStr(err) + '], SQLState:[' +
           Err_SQLState + ']' + #10#13 + #10#13;
    end;

  if DM.ADOConnectionWorkStationMDB.Connected and
     DM.ADOconnectionServerMDB.Connected and
     DM.ADOConnectionAccessMDB.Connected then //если к базам есть подключение
    NoErrСreateNewField:= СreateNewField
    else NoErrСreateNewField:= false;

  StateProcessCompressDB:= Completed;     //задаем начальное значение

  if sErr <> '' then  //если есть хотябы одна ошибка подключения, отключаем все базы
    begin
      result:= false;

      if DM.ADOConnectionAccessMDB.Connected then //проверяем находятся ли базы данных в состоянии сжатия.
        begin
          if GetStateComressDBinDataBase(StateProcessCompressDB) then   //пробуем получить текущее значение состояния сжатия
            begin
              if StateProcessCompressDBinProcessing then    //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
                  exit;
            end
            else begin  //в базе данных отсутсвует таблица с информацией о текущем состоянии сжатия баз данных
              Application.MessageBox(PChar('Ошибка при получении информации о состоянии сжатия баз данных.' + #13#10 +
                  'Отсутсвует соответсвующая таблица или поле в таблице.'),
                  PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'), MB_OK + MB_ICONERROR);
            end;
        end;

      if DM.ADOConnectionAccessMDB.Connected      then DM.ADOConnectionAccessMDB.Connected:= false;
      if DM.ADOconnectionDataMDB.Connected        then DM.ADOconnectionDataMDB.Connected:=false;
      if DM.ADOConnectionDataWSMDB.Connected      then DM.ADOConnectionDataWSMDB.Connected:=false;
      if DM.ADOconnectionServerMDB.Connected      then DM.ADOconnectionServerMDB.Connected:=false;
      if DM.ADOConnectionWorkStationMDB.Connected then DM.ADOConnectionWorkStationMDB.Connected:=false;

      Application.MessageBox(PChar('Ошибка подключения к базе (базам) данных: ' + #13#10 + #10#13 + sErr),
              PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'), MB_OK + MB_ICONSTOP);
    end;
end;

procedure TFormRudaAdmin.FormCreate(Sender: TObject);
begin
  Caption:= ProgName_ShortStringVersion + Caption;
  Application.HintPause := HintPause;
  Application.HintHidePause := HintHidePause;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Path', 'PathServiceRudaWS', asString,
              ParamVariant)
    then PathServiceRudaWS:= ParamVariant
    else PathServiceRudaWS:= PathApp;
  PathServiceRudaWS:= IncludeTrailingPathDelimiter(PathServiceRudaWS);

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'PrinterName', asString,
               ParamVariant)
    then PrinterName:= ParamVariant
    else PrinterName:= '';

  admin:= true;
  DB_Connect:= false;
  TimerRunWinShowInfoCompressDB.Enabled:= false;
  //подготавливаем высоту строки: //N - количество строк в ячейке
  StringGridUserList.RowHeights[0]:=(StringGridUserList.Canvas.TextHeight('A')+2)*2{N};
  StringGridUserList.ColWidths[0]:= ColWidths0;
  StringGridUserList.ColWidths[1]:= ColWidths1;
  StringGridUserList.ColWidths[2]:= ColWidths2;
  //после отладки надо будет скрыть, поставив значение -1
  StringGridUserList.ColWidths[3]:= -1;  //скрываем колонку в которой находится код записи пользователя
                                         // U_Code таблицы USERS
  OffsetTopButton:= SpeedButtonDelUser.Left - (Panel2.Width div 2);
  OffsetBottomButton:= ButtonCancel.Left - (Panel2.Width div 2);
  After_Change:= StringGridUserList.Width - OffsetRight;
  Application.HelpFile:=PathApp + NameHelp;
end;

procedure TFormRudaAdmin.ClearAllData;
begin
  PanelAccountManagement.Color:= clBtnFace;
  PanelChangePasswordAdmin.Color:= clBtnFace;
//  EditUser.Color:= clWhite;
//  ComboBoxWS.Color:= clWhite;
//  ListViewCheckParam.Color:= clWhite;

  SpeedButtonDelUser.Enabled:= true;
  StringGridUserList.Enabled:= true;

  EditUser.Clear;
  ComboBoxWS.Items.Clear;
  ComboBoxWS.ItemIndex:= -1;
end;

procedure TFormRudaAdmin.FormShow(Sender: TObject);
begin
  ClearAllData;
end;

procedure TFormRudaAdmin.LoadSetingWinAdmin;
begin
  if SetingWinAdmin.PosSG < 0   //значит StringGridUserList терял фокус, когда добавляли новую запись
    then SetingWinAdmin.PosSG:= StringGridUserList.RowCount - 1;  //ставим курсор на добавленную запись
  StringGridUserList.Row := SetingWinAdmin.PosSG;
  ComboBoxWS.ItemIndex   := SetingWinAdmin.PosWS;
end;

procedure TFormRudaAdmin.SaveSetingWinAdmin;
begin
  SetingWinAdmin.PosSG:= StringGridUserList.Row;
  SetingWinAdmin.PosWS:= ComboBoxWS.ItemIndex;
end;

procedure TFormRudaAdmin.CloseWindowsAdmin;
begin
  TimerServiceStatus.Enabled:= false;
  PanelAccountManagement.Visible:= false;
  LimitSizeForm(false);
end;

procedure TFormRudaAdmin.DisconnectDB();
begin
  if DM.ADOConnectionAccessMDB.Connected      then DM.ADOConnectionAccessMDB.Connected:= false;
  if DM.ADOconnectionDataMDB.Connected        then DM.ADOconnectionDataMDB.Connected:=false;
  if DM.ADOConnectionDataWSMDB.Connected      then DM.ADOConnectionDataWSMDB.Connected:=false;
  if DM.ADOconnectionServerMDB.Connected      then DM.ADOconnectionServerMDB.Connected:=false;
  if DM.ADOConnectionWorkStationMDB.Connected then DM.ADOConnectionWorkStationMDB.Connected:=false;
  DB_Connect:= false;
end;

procedure TFormRudaAdmin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if EnterPassOK then
    begin
      if (Application.MessageBox(PChar('Хотите выйти из программы: ' + ProgName_ShortStringVersion + ' ?'),
          PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'), MB_YESNO + MB_ICONQUESTION)) = IDYES
      then begin
        CanClose:= true;
        DisconnectDB();
        ActionManager1.FileName:= ConfigFile;
        ActionManager1.SaveToFile(ActionManager1.FileName); //сохраняем настройки меню
      end
      else begin
        CanClose:= false;
      end;
    end
    else CanClose:= true;
end;

procedure TFormRudaAdmin.LimitSizeForm(param: boolean);
begin
  if param then
    begin
      Constraints.MaxHeight:= 0;
      Constraints.MaxWidth:= 0;
      Constraints.MinHeight:= BigFormMinHeight;
      Constraints.MinWidth:= BigFormMinWidth;
    end
    else begin
      Constraints.MaxHeight:= LowFormMinHeight;
      Constraints.MaxWidth:= 0;
      Constraints.MinHeight:= LowFormMinHeight;
      Constraints.MinWidth:= LowFormMinWidth;
//      if Constraints.MinHeight <> LowFormMinHeight then WindowState:= wsMaximized;
    end;
end;

end.
