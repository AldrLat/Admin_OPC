unit UnitDlgConnect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Data.Win.ADODB, Vcl.CheckLst,
  Vcl.Samples.Spin, UnitDM, UnitMyForm{обязательно ПОСЛЕДНИМ};

type
  TFormDlgConnect = class(TForm)
    Label1: TLabel;
    EditMeasurerName: TEdit;
    GroupBoxZnach: TGroupBox;
    Label2: TLabel;
    GroupBoxFunctions: TGroupBox;
    RadioButtonMB5: TRadioButton;
    RadioButtonAnalogWeigher: TRadioButton;
    RadioButtonImpulsWeigher: TRadioButton;
    RadioButtonMotionSensor1: TRadioButton;
    RadioButtonMotionSensor2: TRadioButton;
    RadioButtonOther: TRadioButton;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    PanelSmall: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    EditNull1: TEdit;
    EditMax1: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    EditMin1: TEdit;
    PanelColorBack1: TPanel;
    PanelWidthLine1: TPanel;
    Label8: TLabel;
    Label7: TLabel;
    PanelColor1: TPanel;
    PanelBig: TPanel;
    EditNull2: TEdit;
    EditMin2: TEdit;
    PanelColorBack2: TPanel;
    PanelWidthLine2: TPanel;
    PanelColor2: TPanel;
    Label9: TLabel;
    ColorDialog1: TColorDialog;
    ADOQueryWeigherList: TADOQuery;
    DataSourceWeigherList: TDataSource;
    CheckListBoxWeigherList: TCheckListBox;
    EditMax2: TEdit;
    SpinEditPoint1: TSpinEdit;
    SpinEditPoint2: TSpinEdit;
    ButtonClose: TButton;
    PanelButtonWidth: TPanel;
    BitBtn_1Pt: TBitBtn;
    BitBtn_2Pt: TBitBtn;
    BitBtn_3Pt: TBitBtn;
    BitBtn_4Pt: TBitBtn;
    BitBtn_5pt: TBitBtn;
    ComboBoxControllerChannel1: TComboBox;
    ComboBoxControllerChannel2: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure RadioButtonMB5Click(Sender: TObject);
    procedure RadioButtonAnalogWeigherClick(Sender: TObject);
    procedure RadioButtonOtherClick(Sender: TObject);
    procedure RadioButtonImpulsWeigherClick(Sender: TObject);
    procedure RadioButtonMotionSensor1Click(Sender: TObject);
    procedure RadioButtonMotionSensor2Click(Sender: TObject);
    procedure SelectShow(IndexShow: integer);
    procedure DefaultMB5;
    procedure DefaultAnalogWeigher;
    procedure DefaultOther;
    procedure PanelColorBack1Click(Sender: TObject);
    procedure PanelWidthLine1Click(Sender: TObject);
    procedure PanelColorBack2Click(Sender: TObject);
    procedure PanelWidthLine2Click(Sender: TObject);
    procedure BitBtn_1PtClick(Sender: TObject);
    procedure ShowWidthLine(WidthLine: integer);
    procedure BitBtn_2PtClick(Sender: TObject);
    procedure BitBtn_3PtClick(Sender: TObject);
    procedure BitBtn_4PtClick(Sender: TObject);
    procedure BitBtn_5ptClick(Sender: TObject);
    procedure PanelColor1Click(Sender: TObject);
    procedure PanelColor2Click(Sender: TObject);
    procedure ListWeigher;
    function CheckLinkWeigher(L_Code: integer; var NameMB5: string): integer;
    procedure LinkWeigher(msCode: dword; NameNewW: string);
    procedure EditNull1KeyPress(Sender: TObject; var Key: Char);
    procedure EditNull2KeyPress(Sender: TObject; var Key: Char);
    procedure EditMax1KeyPress(Sender: TObject; var Key: Char);
    procedure EditMax2KeyPress(Sender: TObject; var Key: Char);
    procedure EditMin1KeyPress(Sender: TObject; var Key: Char);
    procedure EditMin2KeyPress(Sender: TObject; var Key: Char);
    procedure EditMeasurerNameKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSaveClick(Sender: TObject);
    function SaveDataInBD: boolean;
    procedure ClearAllData;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure SpinEditPoint1KeyPress(Sender: TObject; var Key: Char);
    procedure SpinEditPoint2KeyPress(Sender: TObject; var Key: Char);
    procedure CheckListBoxWeigherListClickCheck(Sender: TObject);
    procedure FillArrayChAndPoint;
    procedure FormCreate(Sender: TObject);
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ComboBoxControllerChannel1Change(Sender: TObject);
    procedure ComboBoxControllerChannel2Change(Sender: TObject);
    procedure ListControllers;
    procedure FormDestroy(Sender: TObject);
    procedure SetIndexControllersFromList(var cb: TComboBox; Lc_Code: Int64);
    procedure ShowHintController(var cb: TComboBox);
    procedure ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
    procedure ChangeDataTrue(Sender: TObject);
  private
    { Private declarations }
    ChangeData: boolean;
  public
    { Public declarations }
  end;

type
  TConnectControllers = class
  private
    fLc_Code: Int64;
    fCn_Code: Int64;
    fPlata: integer;     //номер платы начинаем с 0
    fSp_Code: integer;   //настройки COM-порта
    fPortNum: integer;   //номер COM-порта
    fController: string; //Наименование версии контроллера
    fNameClassController: string; //название класс контроллеров MK001, MK002, MK003
    fTypeController: integer;     //тип контроллера MK001 - 1, MK002 - 2, MK003 - 3
  public
    property Lc_Code : Int64 read fLc_Code;
    property Cn_Code : Int64 read fCn_Code;
    property Plata : integer read fPlata;
    property Sp_Code : integer read fSp_Code;
    property PortNum : integer read fPortNum;
    property Controller: string read fController;          //Наименование версии контроллера
    property NameClassController: string read fNameClassController;//название класс контроллеров MK001, MK002, MK003
    property TypeController: integer read fTypeController;

    constructor Create(const Lc_Code: Int64; const Cn_Code: Int64;
      const Plata: integer; const Sp_Code: integer; const PortNum: integer;
      const Controller: string; const NameClassController: string;
      const TypeController: integer);
  end;
var
  FormDlgConnect: TFormDlgConnect;
  IndexShow, FreePoint: integer;
  LinesChannels: TLinesChannels;
  UsedChannels: TUsedChannels;
  Lines: TLines;  //список кодов подключенных конвейеров (по порядку), последний байт - общее число конвейеров
  CmpName: string;

implementation
uses MainUnit, UnitConfigWorkStation, RudaGlobals;
{$R *.dfm}

constructor TConnectControllers.Create(const Lc_Code: Int64; const Cn_Code: Int64;
      const Plata: integer; const Sp_Code: integer; const PortNum: integer;
      const Controller: string; const NameClassController: string;
      const TypeController: integer);
begin
  inherited Create;
  fLc_Code:= Lc_Code;
  fCn_Code:= Cn_Code;
  fPlata:= Plata;
  fSp_Code:= Sp_Code;
  fPortNum:= PortNum;
  fController:= Controller;
  fNameClassController:= NameClassController;
  fTypeController:= TypeController;
end;

//вычисляет верхний левый угол панели толщины линии для центровки линии в панели отображения
function LeftTopPanelWidht(PanelHeightOut, PanelHeightIn: integer): integer;
begin
  result:= (PanelHeightOut - PanelHeightIn) div 2;
end;
//показываем реальную толщину линии и центрируем ее в панеле отображения
procedure TFormDlgConnect.ShowWidthLine(WidthLine: integer);
begin
  if PanelButtonWidth.Top < 210 then //работаем с верхней строчкой
    begin
      PanelWidthLine1.Height:= WidthLine;
      PanelWidthLine1.Top:= LeftTopPanelWidht(PanelColorBack1.Height, PanelWidthLine1.Height);
    end
    else begin                      //работаем с нижней строчкой
      PanelWidthLine2.Height:= WidthLine;
      PanelWidthLine2.Top:= LeftTopPanelWidht(PanelColorBack2.Height, PanelWidthLine2.Height);
    end;
  PanelButtonWidth.Visible:= false;
end;

procedure TFormDlgConnect.SpinEditPoint1KeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  if not (Key in ['1'..'4', #8, #13]) then
    begin
      Application.MessageBox(PChar('Диапазон значений номера Входа должен быть от 1 до 4'),
                            PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                            MB_OK + MB_ICONSTOP);
      key:= #0;
    end;
end;

procedure TFormDlgConnect.SpinEditPoint2KeyPress(Sender: TObject;
  var Key: Char);
begin
  SpinEditPoint1KeyPress(Sender, Key);
end;

procedure TFormDlgConnect.BitBtn_1PtClick(Sender: TObject);
begin
  ShowWidthLine(1);
end;

procedure TFormDlgConnect.BitBtn_2PtClick(Sender: TObject);
begin
  ShowWidthLine(2);
end;

procedure TFormDlgConnect.BitBtn_3PtClick(Sender: TObject);
begin
  ShowWidthLine(3);
end;

procedure TFormDlgConnect.BitBtn_4PtClick(Sender: TObject);
begin
  ShowWidthLine(4);
end;

procedure TFormDlgConnect.BitBtn_5ptClick(Sender: TObject);
begin
  ShowWidthLine(5);
end;

procedure TFormDlgConnect.ButtonCancelClick(Sender: TObject);
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  FormShow(Sender);
end;

procedure TFormDlgConnect.ButtonCloseClick(Sender: TObject);
begin
  FormDlgConnect.Close;
end;

procedure TFormDlgConnect.ButtonSaveClick(Sender: TObject);
begin
  SaveDataInBD;
end;

procedure TFormDlgConnect.CheckListBoxWeigherListClickCheck(Sender: TObject);
  var i: integer;

begin
  ProcedureChangeData;
  for i := 0 to CheckListBoxWeigherList.Items.Count - 1 do
    if CheckListBoxWeigherList.ItemIndex <> i then
      CheckListBoxWeigherList.Checked[i]:= false;
end;

procedure TFormDlgConnect.EditMax1KeyPress(Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Label5.Caption + ' (1)"', EditMax1, Key);
end;

procedure TFormDlgConnect.EditMax2KeyPress(Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Label5.Caption + ' (2)"', EditMax2, Key);
end;

procedure TFormDlgConnect.EditMeasurerNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
end;

procedure TFormDlgConnect.EditMin1KeyPress(Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Label6.Caption + ' (1)"', EditMin1, Key);
end;

procedure TFormDlgConnect.EditMin2KeyPress(Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Label6.Caption + ' (2)"', EditMin2, Key);
end;

procedure TFormDlgConnect.EditNull1KeyPress(Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Label4.Caption + ' (1)"', EditNull1, Key);
end;

procedure TFormDlgConnect.EditNull2KeyPress(Sender: TObject; var Key: Char);
begin
  ProcedureChangeData;
  if key = #13 then ButtonSaveClick(Sender);
  DM.CheckFloatPressKey('"' + Label4.Caption + ' (2)"', EditNull2, Key);
end;

//0 - весы есть и они присоединены к МВ5
//1 - нет подключенных МВ5
//2 - нет подключенных весов
//3 - есть МВ5 и весы, но нет присоединения
//4 - ошибка БД
function TFormDlgConnect.CheckLinkWeigher(L_Code: integer; var NameMB5: string): integer;
begin
  result:= 4;
  //проверяем наличие МВ5
  if DM.QueryWorkStation('SELECT * FROM Measurer WHERE (L_Code = ' + IntToStr(L_Code) +
       ') AND (Ms_Status = 1) AND [Connect]', Caption, 'CheckLinkWeigher', true) then
    begin
      if DM.ADOQueryWorkStationMDB.EOF then
        begin
          result:= 1;
          exit;
        end
        else NameMB5:= DM.ADOQueryWorkStationMDB.FieldByName('Ms_Name').AsString;
    end
    else exit;

  //проверяем наличие весов
  if DM.QueryWorkStation('SELECT * FROM Measurer WHERE (L_Code = ' + IntToStr(L_Code) +
       ') AND ((Ms_Status = 2) OR (Ms_Status = 6)) AND [Connect]', Caption, 'CheckLinkWeigher', true) then
    begin
      if DM.ADOQueryWorkStationMDB.EOF then
        begin
          result:= 2;
          exit;
        end;
    end
    else exit;

  //получаем данные по подключенным весам
  if DM.QueryWorkStation('SELECT Measurer.L_Code, Measurer.Ms_Status, Measurer.Connect, Measurer.Code1 ' +
                          'FROM Measurer INNER JOIN LinkW ON Measurer.Ms_Code = LinkW.Ms_Code_W ' +
                          'WHERE (((Measurer.L_Code)=' + IntToStr(L_Code) + ') AND ((Measurer.Connect)=True))',
                          Caption, 'CheckLinkWeigher', true) then
    begin
      if DM.ADOQueryWorkStationMDB.EOF then
        begin
          if DM.ADOQueryWorkStationMDB.EOF then
            begin
              result:= 3;
              exit;
            end;
        end
        else begin
          result:= 0;
          exit;
        end;
    end
    else exit;
end;

procedure TFormDlgConnect.LinkWeigher(msCode: dword; NameNewW: string);
  var NameMB5, NameW: string;
      MB5: dword;
      errCod: integer;
begin
  errCod:= CheckLinkWeigher(UnitConfigWorkStation.CodeLine, NameMB5);
  if (errCod <> 1) or (errCod <> 4) then   //есть МВ5 и нет ошибок БД
    if Application.MessageBox(PChar('Подключить весы к "' + NameMB5 + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        DM.QueryTempWorkStation('SELECT MS_Code FROM Measurer WHERE (L_Code = ' +
              inttostr(UnitConfigWorkStation.CodeLine) +') AND [connect]',
                           Caption, 'LinkWeigher', true);
        if not DM.ADOQueryTempWS.Eof then
            MB5:= DM.ADOQueryTempWS.FieldByName('MS_Code').AsInteger;

                    //проверяем подключены ли к МВ5 другие весы
        DM.QueryWorkStation('SELECT * FROM LinkW WHERE MS_Code_MB = ' + inttostr(MB5)
                       , Caption, 'LinkWeigher', true);
        if not DM.ADOQueryWorkStationMDB.Eof then  //значит весы уже подключены
          begin
                        //считываем имя подключенных весов
            DM.QueryTempWorkStation('SELECT * FROM Measurer WHERE MS_Code = ' +
                          DM.ADOQueryWorkStationMDB.FieldByName('Ms_Code_W').AsString,
                           Caption, 'LinkWeigher', true);
            NameW:= DM.ADOQueryTempWS.FieldByName('Ms_Name').AsString;

            if Application.MessageBox(PChar('К "' + NameMB5 + '" уже есть подключенные весы "' +
                NameW + '".' + #10#13 + 'Подключить новые?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES then
              begin
                if DM.CommandWS('UPDATE LinkW SET Ms_Code_W = ' + inttostr(msCode) +
                  ' WHERE MS_Code_MB = ' + DM.ADOQueryWorkStationMDB.FieldByName('Ms_Code_MB').AsString,
                  Caption, 'LinkWeigher')
                  then Application.MessageBox(PChar('Весы "' + NameNewW + '" успешно подключены к "' + NameMB5 + '"'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_OK + MB_ICONINFORMATION)
                  else Application.MessageBox(PChar('Не удалось подключить весы "' + NameNewW + '" к "' + NameMB5 + '"'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка !!!'),
                             MB_OK + MB_ICONERROR);
              end;
          end
          else begin   //весы не подключины, подключаем
            if DM.CommandWS('INSERT INTO LinkW (Ms_Code_MB, Ms_Code_W) VALUES (' +
              IntToStr(MB5) + ', ' +
              inttostr(msCode) + ')',
              Caption, 'LinkWeigher')
              then Application.MessageBox(PChar('Весы "' + NameNewW + '" успешно подключены к "' + NameMB5 + '"'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_OK + MB_ICONINFORMATION)
                  else Application.MessageBox(PChar('Не удалось подключить весы "' + NameNewW + '" к "' + NameMB5 + '"'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка !!!'),
                             MB_OK + MB_ICONERROR);
          end;
      end;
end;

function TFormDlgConnect.SaveDataInBD: boolean;

  function CheckNumChannelOrPoint(str: string; value: integer): boolean;
    begin
      result:= true;
      if value < 1 then
        begin
          Application.MessageBox(PChar('Значение номера ' + str + ' должно быть больше нуля.'),
                                 PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'),
                                 MB_OK + MB_ICONERROR);
          result:= false;
        end;
    end;

  var Code1, Lc_Code, POINTS_Status, NameMB5: string;
      status, i: integer;
      conContrl_1, conContrl_2: TConnectControllers;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  result:= true;
  if Application.MessageBox(PChar('Сохранить значения для оборудования: "' +
                                  EditMeasurerName.Text + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if Trim(EditMeasurerName.Text) = '' then
        begin
          Application.MessageBox(PChar('Недостаточно данных в поле: "' +
                                 Copy(Label1.Caption, 1 ,Length(Label1.Caption)-1) + '"'),
                                 PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'),
                                 MB_OK + MB_ICONERROR);
          EditMeasurerName.SetFocus;
          result:= false;
          exit;
        end;

      if ComboBoxControllerChannel1.ItemIndex < 0 then
        begin
          Application.MessageBox(PChar('Не выбран контроллер.'),
                                 PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'),
                                 MB_OK + MB_ICONERROR);
          ComboBoxControllerChannel1.SetFocus;
          result:= false;
          exit;
        end;

      if RadioButtonMB5.Checked then
        begin
          if ComboBoxControllerChannel2.ItemIndex < 0 then
            begin
              Application.MessageBox(PChar('Не выбран контроллер.'),
                                 PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'),
                                 MB_OK + MB_ICONERROR);
              ComboBoxControllerChannel2.SetFocus;
              result:= false;
              exit;
            end;

          if not CheckNumChannelOrPoint('Входа', SpinEditPoint1.Value) then
            begin
              SpinEditPoint1.SetFocus;
              result:= false;
              exit;
            end;

          if not CheckNumChannelOrPoint('Входа', SpinEditPoint2.Value) then
            begin
              SpinEditPoint2.SetFocus;
              result:= false;
              exit;
            end;

          if strtofloat(EditMin2.Text) > strtofloat(EditMax2.Text) then
            begin
              Application.MessageBox(PChar('Максимальное значение сигнала должно быть больше минимального.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
              EditMin2.SetFocus;
              exit;
            end;


          conContrl_2:= ComboBoxControllerChannel2.Items.Objects[ComboBoxControllerChannel2.ItemIndex] as TConnectControllers;
        end;

      if RadioButtonMB5.Checked or RadioButtonAnalogWeigher.Checked then
        if strtofloat(EditMin1.Text) > strtofloat(EditMax1.Text) then
          begin
            Application.MessageBox(PChar('Максимальное значение сигнала должно быть больше минимального.'),
                                 PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                                 MB_OK + MB_ICONWARNING);
            EditMin1.SetFocus;
            exit;
          end;

      if RadioButtonAnalogWeigher.Checked or RadioButtonOther.Checked then
        begin
          if not CheckNumChannelOrPoint('Входа', SpinEditPoint1.Value) then
            begin
              SpinEditPoint1.SetFocus;
              result:= false;
              exit;
            end;
        end;

      if RadioButtonMB5.Checked then status:= 1;
      if RadioButtonAnalogWeigher.Checked then status:= 2;
      if RadioButtonMotionSensor1.Checked then status:= 3;
      if RadioButtonOther.Checked then status:= 4;
      if RadioButtonMotionSensor2.Checked then status:= 5;
      if RadioButtonImpulsWeigher.Checked then status:= 6;

      conContrl_1:= ComboBoxControllerChannel1.Items.Objects[ComboBoxControllerChannel1.ItemIndex] as TConnectControllers;

      //если датчик движения 1,2 или импульсные весы сохраняем номер контроллера
      if status in [3, 5, 6] then
        begin
          Code1:= IntToStr(conContrl_1.Plata);
          Lc_Code:= inttostr(conContrl_1.Lc_Code);
        end
        else begin
          Code1:= 'Null';
          Lc_Code:= 'Null';
        end;

      if FormDlgConnect.Tag = 0 then //новое оборудование
        begin
          if not DM.QueryWorkStation('INSERT INTO Measurer (L_Code, Ms_Name, Num, Ms_Status, [Connect], Code1, Lc_Code) VALUES (' +
                                            IntToStr(UnitConfigWorkStation.CodeLine) + ', ''' +
                                            EditMeasurerName.Text + ''', 0, ' +
                                            IntToStr(status) + ', true, ' +
                                            Code1 + ', ' +
                                            Lc_Code + ')',
                                      FormDlgConnect.Caption, 'SaveDataInBD', false) then exit;

          if not DM.QueryWorkStation('SELECT Max(Ms_Code) as n FROM Measurer WHERE L_Code = ' +
                                              IntToStr(UnitConfigWorkStation.CodeLine),
                                      FormDlgConnect.Caption, 'SaveDataInBD', true) then exit;

          FormDlgConnect.Tag:= DM.ADOQueryWorkStationMDB.FieldByName('n').AsInteger;   // новый Ms_Code

          //если датчики движения и ипульсные весы, то выходим.
          if RadioButtonMotionSensor1.Checked or RadioButtonMotionSensor2.Checked or
             RadioButtonImpulsWeigher.Checked then
            begin
              ProcedureChangeData(false);
              FormConfigWorkStation.EquipmentList;    //обновляем список оборудования
              if RadioButtonImpulsWeigher.Checked then LinkWeigher(FormDlgConnect.Tag, EditMeasurerName.Text);
              //восстанавливаем позицию курсора
              FormConfigWorkStation.DBGridEquipmentList.DataSource.DataSet.Locate('Ms_Code', FormDlgConnect.Tag, []);
              FormConfigWorkStation.DBGridEquipmentList.SetFocus;
              exit;
            end;

          if RadioButtonMB5.Checked then
            begin
              //записываем данные с первой строки
              if not DM.QueryWorkStation('INSERT INTO Points(Ms_Code,Plata,Point,L_Code,Num,Status,Null_I,Max_I,Min_I,DateNull,Color,Width, Lc_Code) VALUES (''' +
                                            IntToStr(FormDlgConnect.Tag) + ''', ''' +
                                            IntToStr(conContrl_1.Plata) + ''', ''' +
                                            IntToStr(SpinEditPoint1.Value - 1) + ''', ''' +
                                            IntToStr(UnitConfigWorkStation.CodeLine) + ''', 0, 1, ''' +
                                            EditNull1.Text + ''', ''' +
                                            EditMax1.Text + ''', ''' +
                                            EditMin1.Text + ''', ''' +
                                            FormatDateTime('dd.mm.yy hh:nn:ss', now) + ''', ''' +
                                            IntToStr(PanelColor1.Color) + ''', ''' +
                                            IntToStr(PanelWidthLine1.Height) + ''', ''' +
                                            IntToStr(conContrl_1.Lc_Code) + ''')',
                                      FormDlgConnect.Caption, 'SaveDataInBD', false) then exit;

              //записываем данные со второй строки
              if not DM.QueryWorkStation('INSERT INTO Points(Ms_Code,Plata,Point,L_Code,Num,Status,Null_I,Max_I,Min_I,DateNull,Color,Width, Lc_Code) VALUES (''' +
                                            IntToStr(FormDlgConnect.Tag) + ''', ''' +
                                            IntToStr(conContrl_2.Plata) + ''', ''' +
                                            IntToStr(SpinEditPoint2.Value - 1) + ''', ''' +
                                            IntToStr(UnitConfigWorkStation.CodeLine) + ''', 0, 2, ''' +
                                            EditNull2.Text + ''', ''' +
                                            EditMax2.Text + ''', ''' +
                                            EditMin2.Text + ''', ''' +
                                            FormatDateTime('dd.mm.yy hh:nn:ss', now) + ''', ''' +
                                            IntToStr(PanelColor2.Color) + ''', ''' +
                                            IntToStr(PanelWidthLine2.Height) + ''', ''' +
                                            IntToStr(conContrl_2.Lc_Code) + ''')',
                                      FormDlgConnect.Caption, 'SaveDataInBD', false) then exit;

              if (CheckListBoxWeigherList.Items.Count > 0) and RadioButtonMB5.Checked then
                begin
                  for i := 0 to CheckListBoxWeigherList.Items.Count - 1 do
                    begin
                      if CheckListBoxWeigherList.Checked[i] then
                        begin
                          try
                            DM.ADOQueryWorkStationMDB.SQL.Clear;
                            DM.ADOQueryWorkStationMDB.SQL.Add('INSERT INTO LinkW (Ms_Code_MB, Ms_Code_W) VALUES (' +
                                            IntToStr(FormDlgConnect.Tag) + ', ' +
                                            IntToStr(integer(CheckListBoxWeigherList.Items.Objects[i])) + ')');
                            DM.ADOQueryWorkStationMDB.ExecSQL;
                          except
                            on e: Exception do
                              begin
                                Application.MessageBox(PChar('[SaveDataInBD]' + #13#10 +
                                e.Message + #13#10 +
                                '"' + DM.ADOQueryWorkStationMDB.SQL.Text +'"'),
                                PChar(FormDlgConnect.Caption),
                                MB_OK + MB_ICONSTOP);

                                exit;
                              end;
                          end;
                        end;
                    end;
                end;
              if CheckLinkWeigher(UnitConfigWorkStation.CodeLine, NameMB5) = 3 then
                begin
                  Application.MessageBox(PChar('Нет подключенных весов к ' + NameMB5 + #10#13 +
                    'Подключите весы из списка "Использовать весы".'),
                    PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'), MB_OK + MB_ICONERROR);
                  exit;
                end;

            end
            else begin               //аналоговые весы и другое
              if RadioButtonAnalogWeigher.Checked then POINTS_Status:= '3'
                                                  else POINTS_Status:= '4';

              if not DM.QueryWorkStation('INSERT INTO Points (Ms_Code,Plata,Point,L_Code,Num,Status,Null_I,Max_I,Min_I,DateNull,Color,Width, Lc_Code) VALUES (''' +
                                            IntToStr(FormDlgConnect.Tag) + ''', ''' +
                                            IntToStr(conContrl_1.Plata) + ''', ''' +
                                            IntToStr(SpinEditPoint1.Value - 1) + ''', ''' +
                                            IntToStr(UnitConfigWorkStation.CodeLine) + ''', 0, ''' +
                                            POINTS_Status + ''', ''' +
                                            EditNull1.Text + ''', ''' +
                                            EditMax1.Text + ''', ''' +
                                            EditMin1.Text + ''', ''' +
                                            FormatDateTime('dd.mm.yy hh:nn:ss', now) + ''', ''' +
                                            IntToStr(PanelColor1.Color) + ''', ''' +
                                            IntToStr(PanelWidthLine1.Height) + ''', ''' +
                                            IntToStr(conContrl_1.Lc_Code) + ''')',
                                      FormDlgConnect.Caption, 'SaveDataInBD', false) then exit;

              if RadioButtonAnalogWeigher.Checked then LinkWeigher(FormDlgConnect.Tag, EditMeasurerName.Text);
            end;
        end
        else begin                   //изменение уже подключенного оборудования
          if not DM.QueryWorkStation('UPDATE Measurer SET Ms_Name = ''' + EditMeasurerName.Text +
                                      ''', Ms_Status = ' + IntToStr(status) +
                                      ', Code1 = ' + Code1 +
                                      ', Lc_Code = ' + Lc_Code +
                                      ' WHERE Ms_Code = ' + IntToStr(FormDlgConnect.Tag),
                                      FormDlgConnect.Caption, 'SaveDataInBD', false) then exit;

          //если датчики движения и ипульсные весы, то выходим.
          if RadioButtonMotionSensor1.Checked or RadioButtonMotionSensor2.Checked or
             RadioButtonImpulsWeigher.Checked then
            begin
              ProcedureChangeData(false);
              FormConfigWorkStation.EquipmentList;    //обновляем список оборудования
              //восстанавливаем позицию курсора
              FormConfigWorkStation.DBGridEquipmentList.DataSource.DataSet.Locate('Ms_Code', FormDlgConnect.Tag, []);
              FormConfigWorkStation.DBGridEquipmentList.SetFocus;
              exit;
            end;

          if RadioButtonMB5.Checked then
            begin
              //записываем данные из первой строки
              if not DM.QueryWorkStation('UPDATE Points SET ' +
                                          'Plata = ''' + IntToStr(conContrl_1.Plata) + ''', ' +
                                          'Point = ''' + IntToStr(SpinEditPoint1.Value - 1) + ''', ' +
                                          'L_Code = ''' + IntToStr(UnitConfigWorkStation.CodeLine) + ''', ' +
                                          'Null_I = ''' + EditNull1.Text + ''', ' +
                                          'Max_I = ''' + EditMax1.Text + ''', ' +
                                          'Min_I = ''' + EditMin1.Text + ''', ' +
                                          'DateNull = ''' + FormatDateTime('dd.mm.yy hh:nn:ss', now) + ''', ' +
                                          'Color = ''' + IntToStr(PanelColor1.Color) + ''', ' +
                                          'Width = ''' + IntToStr(PanelWidthLine1.Height) + ''', ' +
                                          'Lc_Code = ''' + IntToStr(conContrl_1.Lc_Code) +
                                          ''' WHERE Dt_Code = ' + IntToStr(ComboBoxControllerChannel1.Tag),
                                      FormDlgConnect.Caption, 'SaveDataInBD', false) then exit;

              //записываем данные со второй строки
              if not DM.QueryWorkStation('UPDATE Points SET ' +
                                            'Plata = ''' + IntToStr(conContrl_2.Plata) + ''', ' +
                                            'Point = ''' + IntToStr(SpinEditPoint2.Value - 1) + ''', ' +
                                            'L_Code = ''' + IntToStr(UnitConfigWorkStation.CodeLine) + ''', ' +
                                            'Null_I = ''' + EditNull2.Text + ''', ' +
                                            'Max_I = ''' + EditMax2.Text + ''', ' +
                                            'Min_I = ''' + EditMin2.Text + ''', ' +
                                            'DateNull = ''' + FormatDateTime('dd.mm.yy hh:nn:ss', now) + ''', ' +
                                            'Color = ''' + IntToStr(PanelColor2.Color) + ''', ' +
                                            'Width = ''' + IntToStr(PanelWidthLine2.Height) + ''', ' +
                                            'Lc_Code = ''' + IntToStr(conContrl_2.Lc_Code) +
                                            ''' WHERE Dt_Code = ' + IntToStr(ComboBoxControllerChannel2.Tag),
                                            Caption, 'SaveDataInBD', false) then exit;

              if (CheckListBoxWeigherList.Items.Count > 0) and RadioButtonMB5.Checked then
                begin
                  if not DM.QueryWorkStation('DELETE FROM LinkW WHERE Ms_Code_MB = ' +
                                                         IntToStr(FormDlgConnect.Tag),
                                      FormDlgConnect.Caption, 'SaveDataInBD', false) then exit;

                  for i := 0 to CheckListBoxWeigherList.Items.Count - 1 do
                    begin
                      if CheckListBoxWeigherList.Checked[i] then
                        begin
                          if not DM.QueryWorkStation('INSERT INTO LinkW (Ms_Code_MB, Ms_Code_W) VALUES (' +
                                            IntToStr(FormDlgConnect.Tag) + ', ' +
                                            IntToStr(integer(CheckListBoxWeigherList.Items.Objects[i])) + ')',
                                      FormDlgConnect.Caption, 'SaveDataInBD', false) then exit;
                        end;
                    end;
                end;
              if CheckLinkWeigher(UnitConfigWorkStation.CodeLine, NameMB5) = 3 then
                begin
                  Application.MessageBox(PChar('Нет подключенных весов к ' + NameMB5 + #10#13 +
                    'Подключите весы из списка "Использовать весы".'),
                    PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'), MB_OK + MB_ICONERROR);
                  exit;
                end;
            end
            else begin                 //аналоговые весы и другое
              if not DM.QueryWorkStation('UPDATE Points SET ' +
                                          'Plata = ''' + IntToStr(conContrl_1.Plata) + ''', ' +
                                          'Point = ''' + IntToStr(SpinEditPoint1.Value - 1) + ''', ' +
                                          'L_Code = ''' + IntToStr(UnitConfigWorkStation.CodeLine) + ''', ' +
                                          'Null_I = ''' + EditNull1.Text + ''', ' +
                                          'Max_I = ''' + EditMax1.Text + ''', ' +
                                          'Min_I = ''' + EditMin1.Text + ''', ' +
                                          'DateNull = ''' + FormatDateTime('dd.mm.yy hh:nn:ss', now) + ''', ' +
                                          'Color = ''' + IntToStr(PanelColor1.Color) + ''', ' +
                                          'Width = ''' + IntToStr(PanelWidthLine1.Height) + ''', ' +
                                          'Lc_Code = ''' + IntToStr(conContrl_1.Lc_Code) +
                                          ''' WHERE Dt_Code = ' + IntToStr(ComboBoxControllerChannel1.Tag),
                                      FormDlgConnect.Caption, 'SaveDataInBD', false) then exit;
            end;
        end;
      UnitConfigWorkStation.ChangeData:= true;
    end;
  ProcedureChangeData(false);
  FormConfigWorkStation.EquipmentList;    //обновляем список оборудования
//  CheckLinkWeigher(UnitConfigWorkStation.CodeLine);
  //восстанавливаем позицию курсора
  FormConfigWorkStation.DBGridEquipmentList.DataSource.DataSet.Locate('Ms_Code', FormDlgConnect.Tag, []);
end;

procedure TFormDlgConnect.ClearAllData;
begin
  //очищаем данне
  EditMeasurerName.Clear;
  ComboBoxControllerChannel1.ItemIndex:= -1;
  ShowHintController(ComboBoxControllerChannel1);
  SpinEditPoint1.Value:= 0;
  EditNull1.Text:= '0';
  EditMin1.Text:= '0';
  EditMax1.Text:= '0';
  PanelColorBack1.Color:= clWhite;
  PanelWidthLine1.Color:= clBlack;
  PanelWidthLine1.Height:= 1;
  PanelWidthLine1.Top:= LeftTopPanelWidht(PanelColorBack1.Height, PanelWidthLine1.Height);
  PanelColor1.Color:= clBlack;
  ComboBoxControllerChannel2.ItemIndex:= -1;
  ShowHintController(ComboBoxControllerChannel2);
  SpinEditPoint2.Value:= 0;
  EditNull2.Text:= '0';
  EditMin2.Text:= '0';
  EditMax2.Text:= '0';
  PanelColorBack2.Color:= clWhite;
  PanelWidthLine2.Color:= clBlack;
  PanelWidthLine2.Height:= 1;
  PanelWidthLine2.Top:= LeftTopPanelWidht(PanelColorBack2.Height, PanelWidthLine2.Height);
  PanelColor2.Color:= clBlack;
end;

procedure TFormDlgConnect.ComboBoxControllerChannel1Change(Sender: TObject);
begin
  ShowHintController(ComboBoxControllerChannel1);
  ProcedureChangeData;
end;

procedure TFormDlgConnect.ComboBoxControllerChannel2Change(Sender: TObject);
begin
  ShowHintController(ComboBoxControllerChannel2);
  ProcedureChangeData;
end;

procedure TFormDlgConnect.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ChangeData then CanClose:= SaveDataInBD;
end;

procedure TFormDlgConnect.FormCreate(Sender: TObject);
begin
  Application.OnMessage:= AppMessage;
  CmpName:= PanelButtonWidth.Name;
end;

procedure TFormDlgConnect.FormDestroy(Sender: TObject);
  var i: integer;
begin
//освобождаем память
  for i := 0 to ComboBoxControllerChannel1.Items.Count - 1 do
    TConnectControllers(ComboBoxControllerChannel1.Items.Objects[i]).Free;
end;

//заполняем массив занятыми каналами и поинтами
procedure TFormDlgConnect.FillArrayChAndPoint;
  var numCh, numPoint, numLines: integer;
begin
  FillChar(massBusyChannelAndPoint, sizeof(massBusyChannelAndPoint), 0);
  DM.ListLine(Lines, Caption);
  DM.ListLineChannel(Lines, LinesChannels, UsedChannels, Caption);      //UsedChannels в данной процедуре не используется
  for numLines:= 0 to Lines[MAXLINE] - 1 do
    for numCh:= 0 to length(LinesChannels[numLines].Channel) - 1 do
      for numPoint:= 0 to length(LinesChannels[numLines].Point) - 1 do
        if (LinesChannels[numLines].Channel[numCh] > 0) and
           (LinesChannels[numLines].Point[numCh] > 0) then
              massBusyChannelAndPoint[LinesChannels[numLines].Channel[numCh],
                                      LinesChannels[numLines].Point[numCh]]:= true;
end;

procedure TFormDlgConnect.ShowHintController(var cb: TComboBox);
  var ConnectControll: TConnectControllers;
      strTypeController: string;
begin
  cb.ShowHint:= true;
  cb.Hint:= '';
  if cb.ItemIndex < 0 then exit;
  ConnectControll:= cb.Items.Objects[cb.ItemIndex] as TConnectControllers;
  if ConnectControll.TypeController = 3 then  //значит MK003
    strTypeController:= 'Адрес: '
    else strTypeController:= 'Канал: ';

  cb.Hint:= 'Контроллер: ' + ConnectControll.Controller + '; ' +
            'Класс контроллера: ' + ConnectControll.NameClassController + '; ' +
            'Порт: COM' + inttostr(ConnectControll.PortNum) + '; ' +
            strTypeController  + inttostr(ConnectControll.Plata + 1);
end;

procedure TFormDlgConnect.ListControllers;
  var TypeController: integer;
      Cn_Code: integer;   //код контроллера в таблице Controllers Server.mdb
begin
  ComboBoxControllerChannel1.Clear;
  ComboBoxControllerChannel2.Clear;
  //узнаем какой тип контроллеров используется на данной станции
  if not DM.QueryWorkStation('SELECT TypeController FROM ParamStation',
      FormDlgConnect.Caption, 'ListControllers', true) then exit;

  if DM.DataSourceWorkStationMDB.DataSet.RecordCount = 0 then exit;  //если запись не найдена
  TypeController:= DM.ADOQueryWorkStationMDB.FieldByName('TypeController').AsInteger;  //тип контроллера MK001 - 1, MK002 - 2, MK003 - 3

  //выводим в список только те, что используются на данной станции
  if not DM.QueryWorkStation('SELECT LinkContr.*, SettingsCOMPort.* ' +
    'FROM LinkContr INNER JOIN SettingsCOMPort ON LinkContr.Sp_Code = SettingsCOMPort.Sp_Code',
      FormDlgConnect.Caption, 'ListControllers', true) then exit;

  DM.ADOQueryWorkStationMDB.First;
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      Cn_Code:= DM.ADOQueryWorkStationMDB.FieldByName('Cn_Code').AsInteger;

      if not DM.QueryServer('SELECT Controllers.*, TypeControllers.* ' +
        'FROM Controllers LEFT JOIN TypeControllers ON Controllers.Cn_TypeController = TypeControllers.Nc_Code ' +
        'WHERE Cn_Code = ' + inttostr(Cn_Code),
          FormDlgConnect.Caption, 'ListControllers', true) then exit;

      if DM.DataSourceServerMDB.DataSet.RecordCount > 0 then   //если запись найдена
        begin
          if TypeController = DM.ADOQueryServerMDB.FieldByName('Cn_TypeController').AsInteger then
            ComboBoxControllerChannel1.Items.AddObject(DM.ADOQueryWorkStationMDB.FieldByName('NameController').AsString,
                TObject(TConnectControllers.Create(DM.ADOQueryWorkStationMDB.FieldByName('Lc_Code').AsInteger,
                                               DM.ADOQueryWorkStationMDB.FieldByName('Cn_Code').AsInteger,
                                               DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger,
                                               DM.ADOQueryWorkStationMDB.FieldByName('Sp_Code').AsInteger,
                                               DM.ADOQueryWorkStationMDB.FieldByName('PortNum').AsInteger,
                                               DM.ADOQueryServerMDB.FieldByName('Cn_Name').AsString,
                                               DM.ADOQueryServerMDB.FieldByName('Nc_NameController').AsString,
                                               DM.ADOQueryServerMDB.FieldByName('Cn_TypeController').AsInteger)));
        end;

      DM.ADOQueryWorkStationMDB.Next;
    end;

  ComboBoxControllerChannel2.Items:= ComboBoxControllerChannel1.Items;
end;

//по номеру контроллера выбирает контроллер из списка
procedure TFormDlgConnect.SetIndexControllersFromList(var cb: TComboBox; Lc_Code: Int64);
  var i: integer;
  conContrl: TConnectControllers;
begin
   cb.ItemIndex:= -1;
   for i := 0 to cb.Items.Count - 1 do
    begin
      conContrl:= cb.Items.Objects[i] as TConnectControllers;
      if conContrl.Lc_Code = Lc_Code then
        begin
          cb.ItemIndex:= i;
          break;
        end;
    end;

   ShowHintController(cb);    //выводим информацию в hint о подключенных контроллерах
end;

procedure TFormDlgConnect.FormShow(Sender: TObject);
  var status, i: integer;
      Code1, Lc_Code: variant;
begin
  ListWeigher;    //список весов
  ListControllers; //список подключенных контроллеров
  ClearAllData;
  if not DM.QueryWorkStation('SELECT ColorBack FROM ParamLines WHERE L_Code = ' +
                                            IntToStr(UnitConfigWorkStation.CodeLine),
                                      FormDlgConnect.Caption, 'FormShow', true) then exit;
  try
    PanelColorBack1.Color:= DM.ADOQueryWorkStationMDB.FieldByName('ColorBack').AsInteger;
    PanelColorBack2.Color:= DM.ADOQueryWorkStationMDB.FieldByName('ColorBack').AsInteger;
  except
    PanelColorBack1.Color:= clWhite;
    PanelColorBack2.Color:= clWhite;
  end;

  if FormDlgConnect.Tag = 0 then      //новое оборудование
    begin
      FillArrayChAndPoint;
      GroupBoxFunctions.Enabled:= true;
      RadioButtonMB5Click(Sender);
      RadioButtonMB5.Checked:= true;
    end
    else begin
      GroupBoxFunctions.Enabled:= false;
//      if not DM.QueryWorkStation('SELECT ColorBack FROM ParamLines WHERE L_Code = ' +
//                                            IntToStr(UnitConfigWorkStation.CodeLine),
//                                      FormDlgConnect.Caption, true) then exit;
//
//      try
//        PanelColorBack1.Color:= DM.ADOQueryWorkStationMDB.FieldByName('ColorBack').AsInteger;
//        PanelColorBack2.Color:= DM.ADOQueryWorkStationMDB.FieldByName('ColorBack').AsInteger;
//      except
//        PanelColorBack1.Color:= clWhite;
//        PanelColorBack2.Color:= clWhite;
//      end;

      if not DM.QueryWorkStation('SELECT * FROM Measurer WHERE Ms_Code = ' +
                                              IntToStr(FormDlgConnect.Tag),
                                      FormDlgConnect.Caption, 'FormShow', true) then exit;

      DM.ADOQueryWorkStationMDB.First;
      while not DM.ADOQueryWorkStationMDB.EOF do
        begin
          EditMeasurerName.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Ms_Name').AsString);
          status:= DM.ADOQueryWorkStationMDB.FieldByName('Ms_Status').AsInteger;
          Code1:= DM.ADOQueryWorkStationMDB.FieldByName('Code1').AsVariant;
          Lc_Code:= DM.ADOQueryWorkStationMDB.FieldByName('Lc_Code').AsVariant;
          case status of
            1: begin
                  RadioButtonMB5.Checked:= true;
                  RadioButtonMB5Click(Sender);
                end;
            2: begin
                  RadioButtonAnalogWeigher.Checked:= true;
                  RadioButtonAnalogWeigherClick(Sender);
                end;
            3: begin
                  RadioButtonMotionSensor1.Checked:= true;
                  RadioButtonMotionSensor1Click(Sender);
                end;
            4: begin
                  RadioButtonOther.Checked:= true;
                  RadioButtonOtherClick(Sender);
                end;
            5: begin
                  RadioButtonMotionSensor2.Checked:= true;
                  RadioButtonMotionSensor2Click(Sender);
                end;
            6: begin
                  RadioButtonImpulsWeigher.Checked:= true;
                  RadioButtonImpulsWeigherClick(Sender);
                end;
          end;
          DM.ADOQueryWorkStationMDB.Next;
        end;
      if Status in [3, 5, 6] then      //(Status = 3) Or (Status = 5) Or (Status = 6) then
        begin
          if (Code1 = null) or (Lc_Code = null) then ComboBoxControllerChannel1.ItemIndex:= -1
            else SetIndexControllersFromList(ComboBoxControllerChannel1, integer(Lc_Code));
        end;

      if not DM.QueryWorkStation('SELECT * FROM Points WHERE Ms_Code = ' + IntToStr(FormDlgConnect.Tag),
                                      FormDlgConnect.Caption, 'FormShow', true) then exit;

      DM.ADOQueryWorkStationMDB.First;
      i:= 0;
      while not DM.ADOQueryWorkStationMDB.EOF do
        begin
          if Status in [1, 2, 4] then
            begin
              if i = 0 then
                begin           //заполняем первую строку
                  try
                    SetIndexControllersFromList(ComboBoxControllerChannel1,
                                                DM.ADOQueryWorkStationMDB.FieldByName('Lc_Code').AsInteger);
                  except
                    ComboBoxControllerChannel1.ItemIndex:= -1;
                  end;
                  ComboBoxControllerChannel1.Tag:= DM.ADOQueryWorkStationMDB.FieldByName('Dt_Code').AsInteger;
                  try
                    SpinEditPoint1.Value:= DM.ADOQueryWorkStationMDB.FieldByName('Point').AsInteger + 1;
                  except
                    SpinEditPoint1.Value:= 0;
                  end;
                  EditNull1.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Null_I').AsString);
                  EditMax1.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Max_I').AsString);
                  EditMin1.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Min_I').AsString);
                  try
                    PanelColor1.Color:= DM.ADOQueryWorkStationMDB.FieldByName('Color').AsInteger;
                    PanelWidthLine1.Color:= DM.ADOQueryWorkStationMDB.FieldByName('Color').AsInteger;
                  except
                    PanelColor1.Color:= clBlack;
                    PanelWidthLine1.Color:= clBlack;
                  end;
                  try
                    PanelWidthLine1.Height:= DM.ADOQueryWorkStationMDB.FieldByName('Width').AsInteger;
                    //центруем панель с отображением толщины линии
                    PanelWidthLine1.Top:= LeftTopPanelWidht(PanelColorBack1.Height, PanelWidthLine1.Height);
                  except
                    PanelWidthLine1.Height:= 1;
                    PanelWidthLine1.Top:= LeftTopPanelWidht(PanelColorBack1.Height, PanelWidthLine1.Height);
                  end;
                end
                else begin    //заполняем вторую строку
                  try
                    SetIndexControllersFromList(ComboBoxControllerChannel2,
                                                DM.ADOQueryWorkStationMDB.FieldByName('Lc_Code').AsInteger);
                  except
                    ComboBoxControllerChannel2.ItemIndex:= -1;
                  end;
                  ComboBoxControllerChannel2.Tag:= DM.ADOQueryWorkStationMDB.FieldByName('Dt_Code').AsInteger;
                  try
                    SpinEditPoint2.Value:= DM.ADOQueryWorkStationMDB.FieldByName('Point').AsInteger + 1;
                  except
                    SpinEditPoint2.Value:= 0;
                  end;
                  EditNull2.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Null_I').AsString);
                  EditMax2.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Max_I').AsString);
                  EditMin2.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Min_I').AsString);
                  try
                    PanelColor2.Color:= DM.ADOQueryWorkStationMDB.FieldByName('Color').AsInteger;
                    PanelWidthLine2.Color:= DM.ADOQueryWorkStationMDB.FieldByName('Color').AsInteger;
                  except
                    PanelColor2.Color:= clBlack;
                    PanelWidthLine2.Color:= clBlack;
                  end;
                  try
                    PanelWidthLine2.Height:= DM.ADOQueryWorkStationMDB.FieldByName('Width').AsInteger;
                    //центруем панель с отображением толщины линии
                    PanelWidthLine2.Top:= LeftTopPanelWidht(PanelColorBack2.Height, PanelWidthLine2.Height);
                  except
                    PanelWidthLine2.Height:= 1;
                    PanelWidthLine2.Top:= LeftTopPanelWidht(PanelColorBack2.Height, PanelWidthLine2.Height);
                  end;
                end;
            end;
          inc(i);
          DM.ADOQueryWorkStationMDB.Next;
        end;

      if CheckListBoxWeigherList.Count > 0 then
        begin
          for i := 0 to CheckListBoxWeigherList.Count - 1 do
            begin
              if not DM.QueryWorkStation('SELECT * FROM LinkW WHERE Ms_Code_MB = ' +
                                IntToStr(FormDlgConnect.Tag) + ' AND MS_Code_W = ' +
                                Trim(IntToStr(integer(CheckListBoxWeigherList.Items.Objects[i]))),
                                      FormDlgConnect.Caption, 'FormShow', true) then exit;

              dm.ADOQueryWorkStationMDB.First;
              while not DM.ADOQueryWorkStationMDB.EOF do   //если весы присутсвуют ставим флажок
                begin
                  CheckListBoxWeigherList.Checked[i]:= true;
                  DM.ADOQueryWorkStationMDB.Next;
                end;
            end;
        end;
    end;
  ProcedureChangeData(false);
  EditMeasurerName.SetFocus;
end;

procedure TFormDlgConnect.ListWeigher;  //получаем список весов
begin
  try
    ADOQueryWeigherList.SQL.Clear;
    ADOQueryWeigherList.SQL.Add('SELECT Ms_Code, Ms_Name FROM measurer WHERE L_Code =' +
       IntToStr(UnitConfigWorkStation.CodeLine) + ' AND (MS_Status = 2 OR MS_Status = 6) ORDER BY Num');
    ADOQueryWeigherList.Active:= true;
  except
    on e: Exception do
      begin
        Application.MessageBox(PChar('[ListWeigher]' + #13#10 +
                               e.Message + #13#10 +
                               '"' + ADOQueryWeigherList.SQL.Text +'"'),
                               PChar(FormDlgConnect.Caption),
                               MB_OK + MB_ICONSTOP);
        exit;
      end;
  end;

  ADOQueryWeigherList.First;
  CheckListBoxWeigherList.Items.Clear;
  while not ADOQueryWeigherList.EOF do
    begin
      CheckListBoxWeigherList.Items.AddObject(ADOQueryWeigherList.FieldByName('Ms_Name').AsString,
                                   TObject(integer(ADOQueryWeigherList.FieldByName('Ms_Code').AsInteger)));
      ADOQueryWeigherList.Next; // го на следующего
    end;
end;

procedure TFormDlgConnect.PanelColor2Click(Sender: TObject);
begin
  ColorDialog1.Color:= PanelColor2.Color;
  if ColorDialog1.Execute then
    PanelColor2.Color:= ColorDialog1.Color;
  PanelWidthLine2.Color:= PanelColor2.Color;
  ProcedureChangeData;
end;

procedure TFormDlgConnect.PanelColorBack1Click(Sender: TObject);
begin
  if RadioButtonMB5.Checked then PanelButtonWidth.Top:= 207
                            else PanelButtonWidth.Top:= 22;
  PanelButtonWidth.Visible:= true;
  case PanelWidthLine1.Height of
    1: BitBtn_1Pt.SetFocus;
    2: BitBtn_2Pt.SetFocus;
    3: BitBtn_3Pt.SetFocus;
    4: BitBtn_4Pt.SetFocus;
    5: BitBtn_5Pt.SetFocus;
  end;
  ProcedureChangeData;
end;

procedure TFormDlgConnect.PanelColorBack2Click(Sender: TObject);
begin
  if RadioButtonMB5.Checked then PanelButtonWidth.Top:= 238;

  PanelButtonWidth.Visible:= true;
  case PanelWidthLine2.Height of
    1: BitBtn_1Pt.SetFocus;
    2: BitBtn_2Pt.SetFocus;
    3: BitBtn_3Pt.SetFocus;
    4: BitBtn_4Pt.SetFocus;
    5: BitBtn_5Pt.SetFocus;
  end;
  ProcedureChangeData;
end;

procedure TFormDlgConnect.PanelColor1Click(Sender: TObject);
begin
  ColorDialog1.Color:= PanelColor1.Color;
  if ColorDialog1.Execute then
    PanelColor1.Color:= ColorDialog1.Color;
  PanelWidthLine1.Color:= PanelColor1.Color;
  ProcedureChangeData;
end;

procedure TFormDlgConnect.PanelWidthLine1Click(Sender: TObject);
begin
  PanelColorBack1Click(Sender);
end;

procedure TFormDlgConnect.PanelWidthLine2Click(Sender: TObject);
begin
  PanelColorBack2Click(Sender);
end;

procedure TFormDlgConnect.RadioButtonAnalogWeigherClick(Sender: TObject);
begin
  SelectShow(1);
end;

procedure TFormDlgConnect.RadioButtonImpulsWeigherClick(Sender: TObject);
begin
  SelectShow(2);
end;

procedure TFormDlgConnect.RadioButtonOtherClick(Sender: TObject);
begin
  SelectShow(1);
end;

procedure TFormDlgConnect.RadioButtonMB5Click(Sender: TObject);
begin
  SelectShow(0);
end;

procedure TFormDlgConnect.RadioButtonMotionSensor1Click(Sender: TObject);
begin
  SelectShow(2);
end;

procedure TFormDlgConnect.RadioButtonMotionSensor2Click(Sender: TObject);
begin
  SelectShow(2);
end;

procedure TFormDlgConnect.DefaultMB5;
begin
  //для МВ5 U1
  SpinEditPoint1.Value:= 1;
  EditNull1.Text:= floattostr(Unull_sig);
  EditMax1.Text:= floattostr(Umax_12/2);
  EditMin1.Text:= '0';
  PanelColor1.Color:= DefaultColorMB5[1];
  PanelWidthLine1.Color:= PanelColor1.Color;
  PanelWidthLine1.Height:= 2;
  //для МВ5 U2
  SpinEditPoint2.Value:= 2;
  EditNull2.Text:= floattostr(Unull_sig);
  EditMax2.Text:= floattostr(Umax_12/2);
  EditMin2.Text:= '0';
  PanelColor2.Color:= DefaultColorMB5[2];
  PanelWidthLine2.Color:= PanelColor2.Color;
  PanelWidthLine2.Height:= 2;
end;

//для аналоговых весов
procedure TFormDlgConnect.DefaultAnalogWeigher;
begin
  SpinEditPoint1.Value:= 3;    //по умолчанию вход 3
  EditNull1.Text:= floattostr(Unull_sig);
  EditMax1.Text:= floattostr(Umax_34);
  EditMin1.Text:= '0';
  PanelColor1.Color:= DefaultColorWeigher;
  PanelWidthLine1.Color:= PanelColor1.Color;
  PanelWidthLine1.Height:= 2;
end;

//для прочего
procedure TFormDlgConnect.DefaultOther;
  var numPoint: integer;
begin
  SpinEditPoint1.Value:= 4;    //по умолчанию вход 4
  EditNull1.Text:= floattostr(Unull_sig);
  EditMax1.Text:= floattostr(Umax_34);
  EditMin1.Text:= '0';
  PanelColor1.Color:= DefaultColorOther;
  PanelWidthLine1.Color:= PanelColor1.Color;
  PanelWidthLine1.Height:= 2;
end;

procedure TFormDlgConnect.SelectShow(IndexShow: integer);
begin
  case IndexShow of
    0: begin
          FormDlgConnect.Height:= 430;
          GroupBoxZnach.Height:= 200;
          PanelSmall.Visible:= true;
          PanelBig.Visible:= true;
          DefaultMB5;
        end;
    1: begin
          PanelSmall.Visible:= true;
          PanelBig.Visible:= false;
          GroupBoxZnach.Height:= 80;
          FormDlgConnect.Height:= 313;
          if RadioButtonAnalogWeigher.Checked then DefaultAnalogWeigher;
          if RadioButtonOther.Checked then DefaultOther;
        end;
    2: begin
          PanelSmall.Visible:= false;
          PanelBig.Visible:= false;
          GroupBoxZnach.Height:= 80;
          FormDlgConnect.Height:= 313;
        end;
  end;
end;

//чтобы убрать панель с выбором толщины при клике мышкой в любую область формы
procedure TFormDlgConnect.AppMessage(var Msg: TMsg; var Handled: Boolean);
var
 nm: string;
begin
 inherited;

 if Msg.message = WM_LBUTTONDOWN then
  begin
   if (FindControl(WindowFromPoint(Msg.pt)) is TPanel) then
    nm:= (FindControl(WindowFromPoint(Msg.pt)) as TPanel).Name;

   if (FindComponent(CmpName) is TPanel) and (nm <> CmpName) then
       (FindComponent(CmpName) as TPanel).Visible:= false;
  end;
end;

procedure TFormDlgConnect.ChangeDataTrue(Sender: TObject);
begin
  ProcedureChangeData;
end;

procedure TFormDlgConnect.ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //если данные были изменены, разрешаем кнопку "Применить"
end;

end.
