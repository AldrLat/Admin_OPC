
unit UnitEnterPassword;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls;

type
  TFormEnterUser = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EditEnterPassword: TEdit;
    SpeedButtonOK: TSpeedButton;
    SpeedButtonCancel: TSpeedButton;
    Panel1: TPanel;
    Image1: TImage;
    BitBtnEyePassword: TBitBtn;
    ComboBoxSelectUser: TComboBox;
    LabelKeyboardLayout: TLabel;
    TimerNameLang: TTimer;
    procedure SpeedButtonCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnEyePasswordMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtnEyePasswordMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButtonOKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TimerNameLangTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    
  public
    { Public declarations }
//    procedure LangChange(var Mess: TMessage); message  WM_INPUTLANGCHANGE;   //ловим смену раскладки
  end;

var
  FormEnterUser: TFormEnterUser;

implementation
uses MainUnit, UnitDM, UnitSettingsProgramm, UnitMyForm, RudaGlobals;
{$R *.dfm}

////ловим смену раскладки клавиатуры
//procedure TFormEnterUser.LangChange(var Mess: TMessage);
//begin
//  if FormEnterUser.Showing then
//          FormEnterUser.LabelKeyboardLayout.Caption:= Form1.NameKeyboardLayout(Form1.GetActiveKbdLayout);
////    Showmessage('modalForm');
//end;

procedure TFormEnterUser.BitBtnEyePasswordMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then EditEnterPassword.PasswordChar:= #0;
end;

procedure TFormEnterUser.BitBtnEyePasswordMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then EditEnterPassword.PasswordChar:= Char('*');
end;

procedure TFormEnterUser.FormClose(Sender: TObject; var Action: TCloseAction);
  var subPath: string;
begin
  FormRudaAdmin.SetAccess(admin);
  TimerNameLang.Enabled:= false;
  if not EnterPassOK then FormRudaAdmin.Close
                     else UserName:= ComboBoxSelectUser.Items[ComboBoxSelectUser.ItemIndex];

  //считываем настройки меню для выбранного пользователя
  if copy(PathUserDataConfig, length(PathUserDataConfig), 1) = '\'
      then subPath:= PathUserDataConfig
      else subPath:= PathUserDataConfig + '\';
  ConfigFile:= subPath + UserName + '.dat';
  if FileExists(ConfigFile) then
    begin
      //пока запрещаем загружать нстройки ActionManager. Глючит.
//      FormRudaAdmin.ActionManager1.FileName:= ConfigFile;
//      FormRudaAdmin.ActionManager1.LoadFromFile(FormRudaAdmin.ActionManager1.FileName);
    end;

//  if FileAge(ConfigFile) <> -1 then FormRudaAdmin.ActionManager1.LoadFromFile(ConfigFile);

//  with Form1 do  //чтобы форма была поверх всех окон
//    SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height,
//        SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TFormEnterUser.FormCreate(Sender: TObject);
begin
//  //считываем с БД всех пользователей WorkStation.mdb таблица ParamStation поля
//  if DM.ADOconnectionServerMDB.Connected and DM.ADOconnectionWorkStationMDB.Connected then
//    begin
//      Form1.ListingUser; //получаем список всех пользователй
//
//      //если список присутсвует открываем диалог прав доступа
//      if FormEnterUser.ComboBoxSelectUser.Items.Count > 0 then
//          //запускаем таймер и ждем чтобы появилась главная форма
//          Form1.TimerRunDialogEnterPassword.Enabled:= true;
//    end;
end;

procedure TFormEnterUser.FormKeyPress(Sender: TObject; var Key: Char);
begin
   case key of
     #13: SpeedButtonOKClick(Sender);       //Enter
     #27: SpeedButtonCancelClick(Sender);   //Esc
   end;
end;

procedure TFormEnterUser.FormShow(Sender: TObject);
begin
  FormEnterUser.Caption:= ProgName_ShortStringVersion + FormEnterUser.Caption;
  EnterPassOK:= false;
  EditEnterPassword.Clear;
  ComboBoxSelectUser.SetFocus;
  LabelKeyboardLayout.Caption:= NameKeyboardLayout(GetActiveKbdLayoutWnd);
  UserName:= '';
  TimerNameLang.Enabled:= true;
end;

procedure TFormEnterUser.SpeedButtonCancelClick(Sender: TObject);
begin
  FormEnterUser.Close;
end;

procedure TFormEnterUser.SpeedButtonOKClick(Sender: TObject);
var s: string;
    EnterOK: boolean;
begin
  admin:= false;
  s:= AnsiStrLower(PChar(ComboBoxSelectUser.Text));
  if (pos(ReservedWords[0], s) > 0) or (pos(ReservedWords[1], s) > 0) //'администратор', 'administrator'
    then
      begin
         //получаем пароль администратора
        if not DM.QueryWorkStation('SELECT PassWordCf FROM ParamStation',
                                    FormEnterUser.Caption,'SpeedButtonOKClick', true) then exit;

        if EditEnterPassword.Text =
          Trim(DM.ADOQueryWorkStationMDB.FieldByName('PassWordCf').AsString)
          then
          begin
            EnterPassOK:= true;
            admin:= true;
            FormRudaAdmin.LimitSizeForm(false);
          end
          else
          begin
            EnterPassOK:= false;
            if Application.MessageBox(PChar('Введен неверный пароль для пользователя: ' + ComboBoxSelectUser.Text),
                           PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                           MB_OKCANCEL + MB_ICONINFORMATION) = IDOK

            then EnterOK:= true
            else EnterOK:= false;
          end;
        EditEnterPassword.Clear;
        EditEnterPassword.SetFocus;
        if not EnterOK  or EnterPassOK then FormEnterUser.Close;
      end
      else
      begin
        //здесь обработка пароля для простых смертных
        if not DM.QueryWorkStation('SELECT PassWord FROM ParamStation',
                                    FormEnterUser.Caption, 'SpeedButtonOKClick', true) then exit;

        if EditEnterPassword.Text =
          Trim(DM.ADOQueryWorkStationMDB.FieldByName('PassWord').AsString)
          then
          begin
            EnterPassOK:= true;
            admin:= false;
            FormRudaAdmin.LimitSizeForm(false);
          end
          else
          begin
            EnterPassOK:= false;
            if Application.MessageBox(PChar('Введен неверный пароль для пользователя: ' + ComboBoxSelectUser.Text),
                           PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                           MB_OKCANCEL + MB_ICONINFORMATION) = IDOK

            then EnterOK:= true
            else EnterOK:= false;
          end;
        EditEnterPassword.Clear;
        EditEnterPassword.SetFocus;
        if not EnterOK  or EnterPassOK then FormEnterUser.Close;
      end;

end;

//индикация раскладки клавиатуры
procedure TFormEnterUser.TimerNameLangTimer(Sender: TObject);
begin
  LabelKeyboardLayout.Caption:= NameKeyboardLayout(GetActiveKbdLayoutWnd);

end;

end.
