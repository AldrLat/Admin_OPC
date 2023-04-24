unit UnitSettingsProgramm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Buttons, System.ImageList, Vcl.ImgList, FileCtrl, UnitDM, Vcl.Samples.Spin,
  UnitMyForm{обязательно ПОСЛЕДНИМ};

type
  TFormSettingsProgramm = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    EditUserConfigData: TEdit;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    Label4: TLabel;
    PanelColorEdit: TPanel;
    Panel2: TPanel;
    PanelColorEditView: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    TabSheet5: TTabSheet;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    PanelLeftMarkerColor: TPanel;
    TabSheet3: TTabSheet;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ButtonClose: TButton;
    ImageLeftView: TImage;
    ImageList1: TImageList;
    Label8: TLabel;
    ComboBoxLeftWidthLine: TComboBox;
    ComboBoxLeftStyleLine: TComboBox;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    ImageRightView: TImage;
    Label12: TLabel;
    PanelRightMarkerColor: TPanel;
    ComboBoxRightWidthLine: TComboBox;
    ComboBoxRightStyleLine: TComboBox;
    ColorDialog1: TColorDialog;
    ButtonDefaultColorEdit: TButton;
    ButtonPathUserConfigData: TButton;
    Label13: TLabel;
    EditFileCoefficientProb: TEdit;
    ButtonFileCoeffProb: TButton;
    Label14: TLabel;
    EditBackupBD: TEdit;
    ButtonBackupBD: TButton;
    EditLogFiles: TEdit;
    Label15: TLabel;
    ButtonLogFiles: TButton;
    GroupBox3: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    RadioButtonLocal: TRadioButton;
    RadioButtonNet: TRadioButton;
    EditPort: TEdit;
    EditAddress1: TEdit;
    EditAddress2: TEdit;
    EditAddress3: TEdit;
    EditAddress4: TEdit;
    RadioGroupRecLogRudaMonitor: TRadioGroup;
    TabSheet6: TTabSheet;
    CheckBoxShowPointChart: TCheckBox;
    Label21: TLabel;
    SpinRestoreScale: TSpinEdit;
    Label22: TLabel;
    Label23: TLabel;
    PanelBackgroundColorViewMode: TPanel;
    GroupBox4: TGroupBox;
    Label24: TLabel;
    SpinEditTimeChannelFind: TSpinEdit;
    Label25: TLabel;
    CheckBoxAutoscalingLeftAxisYMax: TCheckBox;
    Label26: TLabel;
    SpinEditLeftAxisYMax: TSpinEdit;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure ComboBoxLeftStyleLineDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure PenLineView(ImageViewLine: TImage; colorLine: TColor; widthLine: integer; Style: TPenStyle);
    procedure ComboBoxLeftWidthLineChange(Sender: TObject);
    procedure ComboBoxLeftStyleLineChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure PanelLeftMarkerColorClick(Sender: TObject);
    procedure PanelRightMarkerColorClick(Sender: TObject);
    procedure ComboBoxRightWidthLineChange(Sender: TObject);
    procedure ComboBoxRightStyleLineChange(Sender: TObject);
    procedure ComboBoxRightStyleLineDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure PanelColorEditClick(Sender: TObject);
    procedure ButtonDefaultColorEditClick(Sender: TObject);
    procedure ButtonPathUserConfigDataClick(Sender: TObject);
    procedure ButtonFileCoeffProbClick(Sender: TObject);
    procedure ButtonBackupBDClick(Sender: TObject);
    procedure ButtonLogFilesClick(Sender: TObject);
    procedure EnabledPortAdress(param: boolean);
    procedure RadioButtonLocalClick(Sender: TObject);
    procedure RadioButtonNetClick(Sender: TObject);
    procedure EditAddress1Exit(Sender: TObject);
    procedure EditAddress1KeyPress(Sender: TObject; var Key: Char);
    procedure EditAddress2KeyPress(Sender: TObject; var Key: Char);
    procedure EditAddress2Exit(Sender: TObject);
    procedure EditAddress3Exit(Sender: TObject);
    procedure EditAddress3KeyPress(Sender: TObject; var Key: Char);
    procedure EditAddress4KeyPress(Sender: TObject; var Key: Char);
    procedure EditAddress4Exit(Sender: TObject);
    procedure EditPortKeyPress(Sender: TObject; var Key: Char);
    procedure SpinRestoreScaleKeyPress(Sender: TObject; var Key: Char);
    procedure PanelBackgroundColorViewModeClick(Sender: TObject);
    procedure SpinEditTimeChannelFindKeyPress(Sender: TObject; var Key: Char);
    procedure ChangeDataTrue(Sender: TObject);
    procedure ProcedureChangeData(param: boolean = true);
    procedure FormShow(Sender: TObject);
    procedure SpinEditLeftAxisYMaxKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxAutoscalingLeftAxisYMaxClick(Sender: TObject);   //признак, что данные были изменены
  private
    { Private declarations }
    var
    ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                            //измененные данные записать в базу данных
  public
    { Public declarations }
  end;

var
  FormSettingsProgramm: TFormSettingsProgramm;
  LeftMarker        : TMarker;
  RightMarker       : TMarker;
  ColorEdit         : integer;  //цвет объектов в режиме редактирования $00DEC4B0 - по умолчанию
  PathUserDataConfig: string;   //путь к каталогу с фалами персональной настройки программы
  PathFileCoeffProb : string;   //путь к файлам с коэффициентами из журнала проб
  PathBackUpBD      : string;   //путь к каталогу с резервными БД при их очистки или сжатии
  PathLogFiles      : string;   //путь к каталогу с лог-файлами всех программ СКРП

implementation

{$R *.dfm}

uses RudaGlobals;


function IndexToStyle(ind: integer): TPenStyle;
  begin
    case ind of
      0: result:= psSolid;
      1: result:= psDash;
      2: result:= psDot;
      3: result:= psDashDot;
      4: result:= psDashDotDot;
    else result:= psSolid;
    end;
  end;

procedure TFormSettingsProgramm.ButtonDefaultColorEditClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Установить цвет панели редактирования по умолчанию?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      ColorEdit:= DefaultColorEdit;
      PanelColorEdit.Color:= ColorEdit;
      PanelColorEditView.Color:= ColorEdit;
      ProcedureChangeData;
    end;
end;

procedure TFormSettingsProgramm.ButtonFileCoeffProbClick(Sender: TObject);
  var chosenDirectory : string;
begin
  if Trim(EditFileCoefficientProb.Text) = '' then chosenDirectory:= PathApp
                                             else chosenDirectory:= EditFileCoefficientProb.Text;

  if SelectDirectory (ProgName_ShortStringVersion + ' Выберите каталог', '',
            chosenDirectory, [sdNewFolder, sdNewUI]) then
    begin
      EditFileCoefficientProb.Text:= chosenDirectory;
      ProcedureChangeData;
    end;
end;

procedure TFormSettingsProgramm.ButtonLogFilesClick(Sender: TObject);
  var chosenDirectory : string;
begin
  if Trim(EditLogFiles.Text) = '' then chosenDirectory:= PathApp
                                  else chosenDirectory:= EditLogFiles.Text;

  if SelectDirectory (ProgName_ShortStringVersion + ' Выберите каталог для сохранения лог-файлов программ СКРП', '',
            chosenDirectory, [sdNewFolder, sdNewUI]) then
    begin
      EditLogFiles.Text:= chosenDirectory;
      ProcedureChangeData;
    end;
end;

procedure TFormSettingsProgramm.ButtonPathUserConfigDataClick(Sender: TObject);
  var chosenDirectory : string;
begin
  if Trim(EditUserConfigData.Text) = '' then chosenDirectory:= PathApp
                                        else chosenDirectory:= EditUserConfigData.Text;

  if SelectDirectory (ProgName_ShortStringVersion + ' Выберите каталог', '', chosenDirectory, [sdNewFolder, sdNewUI]) then
    begin
      EditUserConfigData.Text:= chosenDirectory;
      ProcedureChangeData;
    end;
end;

procedure TFormSettingsProgramm.ButtonBackupBDClick(Sender: TObject);
  var chosenDirectory : string;
begin
  if Trim(EditBackupBD.Text) = '' then chosenDirectory:= PathApp
                                  else chosenDirectory:= EditBackupBD.Text;

  if SelectDirectory (ProgName_ShortStringVersion + ' Выберите каталог для резервного копирования БД', '',
            chosenDirectory, [sdNewFolder, sdNewUI]) then
    begin
      EditBackupBD.Text:= chosenDirectory;
      ProcedureChangeData;
    end;
end;

procedure TFormSettingsProgramm.ButtonCancelClick(Sender: TObject);
begin
  if ChangeData then
    if Application.MessageBox(PChar('Отменить измененные параметры?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
      begin
        LoadSettings;
        ProcedureChangeData(false);
      end;
end;

procedure TFormSettingsProgramm.ButtonCloseClick(Sender: TObject);
begin
  if ChangeData then SaveSettings;
  LoadSettings;
  Close;
end;

procedure TFormSettingsProgramm.ButtonSaveClick(Sender: TObject);
begin
  if ChangeData then
    begin
      SaveSettings;
      ProcedureChangeData(false);
    end;
end;

procedure TFormSettingsProgramm.ComboBoxLeftStyleLineChange(Sender: TObject);
begin
  LeftMarker.Style:= IndexToStyle(ComboBoxLeftStyleLine.ItemIndex);
  PenLineView(ImageLeftView, LeftMarker.Color, LeftMarker.Width, LeftMarker.Style);
  ProcedureChangeData;
end;

procedure TFormSettingsProgramm.ComboBoxLeftStyleLineDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (* Заполняем прямоугольник *)
  ComboBoxLeftStyleLine.canvas.fillrect(rect);

  (* Рисуем сам битмап *)
  ImageList1.Draw(ComboBoxLeftStyleLine.Canvas,rect.left,rect.top,Index);

  (* Пишем текст после картинки *)
  ComboBoxLeftStyleLine.canvas.textout(rect.left+imagelist1.width+2,rect.top,
                          ComboBoxLeftStyleLine.items[index]);
end;

procedure TFormSettingsProgramm.ComboBoxLeftWidthLineChange(Sender: TObject);
begin
  LeftMarker.Width:= ComboBoxLeftWidthLine.ItemIndex + 1;
  PenLineView(ImageLeftView, LeftMarker.Color, LeftMarker.Width, LeftMarker.Style);
  ProcedureChangeData;
end;

procedure TFormSettingsProgramm.ComboBoxRightStyleLineChange(Sender: TObject);
begin
  RightMarker.Style:= IndexToStyle(ComboBoxRightStyleLine.ItemIndex);
  PenLineView(ImageRightView, RightMarker.Color, RightMarker.Width, RightMarker.Style);
  ProcedureChangeData;
end;

procedure TFormSettingsProgramm.ComboBoxRightStyleLineDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (* Заполняем прямоугольник *)
  ComboBoxRightStyleLine.canvas.fillrect(rect);

  (* Рисуем сам битмап *)
  ImageList1.Draw(ComboBoxRightStyleLine.Canvas,rect.left,rect.top,Index);

  (* Пишем текст после картинки *)
  ComboBoxRightStyleLine.canvas.textout(rect.left+imagelist1.width+2,rect.top,
                          ComboBoxRightStyleLine.items[index]);
end;

procedure TFormSettingsProgramm.ComboBoxRightWidthLineChange(Sender: TObject);
begin
  RightMarker.Width:= ComboBoxRightWidthLine.ItemIndex + 1;
  PenLineView(ImageRightView, RightMarker.Color, RightMarker.Width, RightMarker.Style);
  ProcedureChangeData;
end;

procedure TFormSettingsProgramm.FormCreate(Sender: TObject);
begin
  FormSettingsProgramm.Caption:= ProgName_ShortStringVersion +
                                        FormSettingsProgramm.Caption;
  LoadSettings;
  RadioGroupRecLogRudaMonitor.Hint:= 'Уровень подробности сохранения данных работы программы "Сбор и обработка данных" в лог-файл.' + #10#13 +
                                     IncludeTrailingPathDelimiter(EditLogFiles.Text) + logFileName + #10#13 + #10#13 +
                                     'Чем выше уровень, тем подробней сохраняются данные.';
end;

procedure TFormSettingsProgramm.FormShow(Sender: TObject);
begin
  ProcedureChangeData(false);
end;

procedure TFormSettingsProgramm.PanelBackgroundColorViewModeClick(
  Sender: TObject);
begin
  ColorDialog1.Color:= PanelBackgroundColorViewMode.Color;
  if ColorDialog1.Execute then
    begin
      PanelBackgroundColorViewMode.Color:= ColorDialog1.Color;
      ProcedureChangeData;
    end;
end;

procedure TFormSettingsProgramm.PanelColorEditClick(Sender: TObject);
begin
  ColorDialog1.Color:= ColorEdit;
  if ColorDialog1.Execute then
    begin
      ColorEdit:= ColorDialog1.Color;
      ProcedureChangeData;
    end;
  PanelColorEdit.Color:= ColorEdit;
  PanelColorEditView.Color:= ColorEdit;
end;

procedure TFormSettingsProgramm.PanelLeftMarkerColorClick(Sender: TObject);
begin
  ColorDialog1.Color:= PanelLeftMarkerColor.Color;
  if ColorDialog1.Execute then
    begin
      PanelLeftMarkerColor.Color:= ColorDialog1.Color;
      ProcedureChangeData;
    end;
  LeftMarker.Color:= PanelLeftMarkerColor.Color;
  PenLineView(ImageLeftView, LeftMarker.Color, LeftMarker.Width, LeftMarker.Style);
end;

procedure TFormSettingsProgramm.PanelRightMarkerColorClick(Sender: TObject);
begin
  ColorDialog1.Color:= PanelRightMarkerColor.Color;
  if ColorDialog1.Execute then
    begin
      PanelRightMarkerColor.Color:= ColorDialog1.Color;
      ProcedureChangeData;
    end;
  RightMarker.Color:= PanelRightMarkerColor.Color;
  PenLineView(ImageRightView, RightMarker.Color, RightMarker.Width, RightMarker.Style);
end;

procedure TFormSettingsProgramm.PenLineView(ImageViewLine: TImage; colorLine: TColor;
                                            widthLine: integer; Style: TPenStyle);
  const beginLeft = 5;   //отступ линии от левого края Image

  var i, beginTop, lenghtLine: integer;
begin
  //стереть изображение
  ImageViewLine.Canvas.Pen.Color:= GroupBox1.Color;
  ImageViewLine.Canvas.Rectangle(0,0,ImageViewLine.Width,ImageViewLine.Height);

  beginTop:= (ImageLeftView.Height - widthLine) div 2;
  lenghtLine:= ImageLeftView.Width - beginLeft;
  ImageViewLine.Canvas.Pen.Width:= 1;
  ImageViewLine.Canvas.Pen.Color:= colorLine;
  ImageViewLine.Canvas.Pen.Style:= Style;
  for i := 0 to widthLine - 1 do
    begin
      ImageViewLine.Canvas.MoveTo(beginLeft, beginTop + i);
      ImageViewLine.Canvas.LineTo(lenghtLine, beginTop + i);
    end;
end;

procedure TFormSettingsProgramm.RadioButtonLocalClick(Sender: TObject);
begin
  EnabledPortAdress(false);
end;

procedure TFormSettingsProgramm.RadioButtonNetClick(Sender: TObject);
begin
  EnabledPortAdress(true);
end;

procedure TFormSettingsProgramm.EditAddress1Exit(Sender: TObject);
begin
  if strtoint(EditAddress1.Text) > 255 then
    begin
      Application.MessageBox(PChar('Значение должно быть от 0 до 255'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                             MB_OK + MB_ICONSTOP);
      EditAddress1.SetFocus;
    end;
end;

procedure TFormSettingsProgramm.EditAddress1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if not DM.CheckIntPressKey('"' + Copy(Label5.Caption, 1 ,Length(Label5.Caption)-1) + '"', Key)
    then EditAddress1.SetFocus;
end;

procedure TFormSettingsProgramm.EditAddress2Exit(Sender: TObject);
begin
  if strtoint(EditAddress2.Text) > 255 then
    begin
      Application.MessageBox(PChar('Значение должно быть от 0 до 255'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                             MB_OK + MB_ICONSTOP);
      EditAddress2.SetFocus;
    end;
end;

procedure TFormSettingsProgramm.EditAddress2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if not DM.CheckIntPressKey('"' + Copy(Label5.Caption, 1 ,Length(Label5.Caption)-1) + '"', Key)
    then EditAddress2.SetFocus;
end;

procedure TFormSettingsProgramm.EditAddress3Exit(Sender: TObject);
begin
  if strtoint(EditAddress3.Text) > 255 then
    begin
      Application.MessageBox(PChar('Значение должно быть от 0 до 255'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                             MB_OK + MB_ICONSTOP);
      EditAddress3.SetFocus;
    end;
end;

procedure TFormSettingsProgramm.EditAddress3KeyPress(Sender: TObject;
  var Key: Char);
begin
  if not DM.CheckIntPressKey('"' + Copy(Label5.Caption, 1 ,Length(Label5.Caption)-1) + '"', Key)
    then EditAddress3.SetFocus;
end;

procedure TFormSettingsProgramm.EditAddress4Exit(Sender: TObject);
begin
  if strtoint(EditAddress4.Text) > 255 then
    begin
      Application.MessageBox(PChar('Значение должно быть от 0 до 255'),
                             PChar(ProgName_ShortStringVersion + ' Ошибка ввода !!!'),
                             MB_OK + MB_ICONSTOP);
      EditAddress4.SetFocus;
    end;
end;

procedure TFormSettingsProgramm.EditAddress4KeyPress(Sender: TObject;
  var Key: Char);
begin
  if not DM.CheckIntPressKey('"' + Copy(Label5.Caption, 1 ,Length(Label5.Caption)-1) + '"', Key)
    then EditAddress4.SetFocus;
end;

procedure TFormSettingsProgramm.EditPortKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not DM.CheckIntPressKey('"' + Copy(Label9.Caption, 1 ,Length(Label9.Caption)-1) + '"', Key)
    then EditPort.SetFocus;
end;

procedure TFormSettingsProgramm.EnabledPortAdress(param: boolean);
begin
  EditAddress1.Enabled:= param;
  EditAddress2.Enabled:= param;
  EditAddress3.Enabled:= param;
  EditAddress4.Enabled:= param;
  EditPort.Enabled:= param;
end;

procedure DecoderIP(param: string; var adr1, adr2, adr3, adr4: string);
  var i: integer;
      fL : TStringList;
begin
  adr1:= '0'; adr2:= '0'; adr3:= '0'; adr4:= '0';
  fL := TStringList.Create;
  try
    fL.Delimiter := '.';
    fL.StrictDelimiter := True;
    fL.DelimitedText := param;
    for i := 0 to fl.Count - 1 do
      begin
        if CheckNumeric(fL[i]) then
          begin
            if strtoint(fL[i]) > 255 then fL[i]:= '255';
            if strtoint(fL[i]) < 0 then  fL[i]:= '0';
          end
          else fL[i]:= '0';
        case i of
          0: adr1:= fL[i];
          1: adr2:= fL[i];
          2: adr3:= fL[i];
          3: adr4:= fL[i];
        end;
      end;
  finally
    fL.Free
  end;
end;

procedure TFormSettingsProgramm.LoadSettings;

  function ReadRegPath(Section, KeyRead: string): string;
      var err: boolean; //если true - ошибка
    begin
      if ReadFromRegVariant(RootKey_HKCU, SubKey, Section, KeyRead, asString, ParamVariant)
        then result:= ParamVariant
        else result:= PathApp;
      err:= false;
      if not DirectoryExists(result) then
        if not ForceDirectories(result) then
            err:= true;
      if err then result:= PathApp
    end;

  var intTemp: integer;
      boolTemp: boolean;
      adr1, adr2, adr3, adr4: string;
begin
  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'LeftMarker', 'ColorLine', asInteger, ParamVariant)
    then LeftMarker.Color:= ParamVariant
    else LeftMarker.Color:= clRed;
  PanelLeftMarkerColor.Color:= LeftMarker.Color;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'LeftMarker', 'Width', asInteger,ParamVariant)
    then LeftMarker.Width:= ParamVariant
    else LeftMarker.Width:= 2;
  try
    ComboBoxLeftWidthLine.ItemIndex:= LeftMarker.Width - 1;
  except
    LeftMarker.Width:= 1;
    ComboBoxLeftWidthLine.ItemIndex:= LeftMarker.Width - 1;
  end;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'LeftMarker', 'Style', asInteger, ParamVariant)
    then intTemp:= ParamVariant
    else intTemp:= 1;  //psDash
  try
    ComboBoxLeftStyleLine.ItemIndex:= intTemp;
    LeftMarker.Style:= IndexToStyle(ComboBoxLeftStyleLine.ItemIndex);
  except
    ComboBoxLeftStyleLine.ItemIndex:= 0;
    LeftMarker.Style:= IndexToStyle(ComboBoxLeftStyleLine.ItemIndex);
  end;
  PenLineView(ImageLeftView, LeftMarker.Color, LeftMarker.Width, LeftMarker.Style);

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'RightMarker', 'ColorLine', asInteger, ParamVariant)
    then RightMarker.Color:= ParamVariant
    else RightMarker.Color:= clRed;
  PanelRightMarkerColor.Color:= RightMarker.Color;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'RightMarker', 'Width', asInteger, ParamVariant)
    then RightMarker.Width:= ParamVariant
    else RightMarker.Width:= 2;
  try
    ComboBoxRightWidthLine.ItemIndex:= RightMarker.Width - 1;
  except
    RightMarker.Width:= 1;
    ComboBoxRightWidthLine.ItemIndex:= RightMarker.Width - 1;
  end;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'RightMarker', 'Style', asInteger, ParamVariant)
    then intTemp:= ParamVariant
    else intTemp:= 1;  //psDash
  try
    ComboBoxRightStyleLine.ItemIndex:= intTemp;
    RightMarker.Style:= IndexToStyle(ComboBoxRightStyleLine.ItemIndex);
  except
    ComboBoxRightStyleLine.ItemIndex:= 0;
    RightMarker.Style:= IndexToStyle(ComboBoxRightStyleLine.ItemIndex);
  end;
  PenLineView(ImageRightView, RightMarker.Color, RightMarker.Width, RightMarker.Style);

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'ShowPointChart', asBoolean, ParamVariant)
    then CheckBoxShowPointChart.Checked:= ParamVariant
    else CheckBoxShowPointChart.Checked:= false;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'AutoscalingLeftAxisYMax', asBoolean, ParamVariant)
    then CheckBoxAutoscalingLeftAxisYMax.Checked:= ParamVariant
    else CheckBoxAutoscalingLeftAxisYMax.Checked:= false;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'LeftAxisYMax', asInteger, ParamVariant)
    then SpinEditLeftAxisYMax.Value:= ParamVariant
    else SpinEditLeftAxisYMax.Value:= 10;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'LocalClient', asBoolean, ParamVariant)
    then boolTemp:= ParamVariant
    else boolTemp:= false;
  RadioButtonLocal.Checked:= boolTemp;
  RadioButtonNet.Checked:= not RadioButtonLocal.Checked;
  EnabledPortAdress(not boolTemp);

  //считываем сетевые настройки
  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'Address', asString, ParamVariant)
    then begin
      DecoderIP(ParamVariant, adr1, adr2, adr3, adr4);
      EditAddress1.Text:= adr1;
      EditAddress2.Text:= adr2;
      EditAddress3.Text:= adr3;
      EditAddress4.Text:= adr4;
    end
    else begin                //локальный компьютер
      EditAddress1.Text:= '127';
      EditAddress2.Text:= '0';
      EditAddress3.Text:= '0';
      EditAddress4.Text:= '1';
    end;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'Port', asInteger, ParamVariant)
    then EditPort.Text:= inttostr(ParamVariant)
    else EditPort.Text:= '22500';

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'RestoreScaleSignal', asInteger, ParamVariant)
    then SpinRestoreScale.Value:= ParamVariant
    else SpinRestoreScale.Value:= 120;

  //цвет панели просмотра
  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'BackgroundColorViewMode', asInteger, ParamVariant)
    then intTemp:= ParamVariant
    else intTemp:= DefaultColorEditBackView;
  PanelBackgroundColorViewMode.Color:= intTemp;

  //цвет панели редактирования
  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'ColorEdit', asInteger, ParamVariant)
    then ColorEdit:= ParamVariant
    else ColorEdit:= DefaultColorEdit;
  PanelColorEdit.Color:= ColorEdit;
  PanelColorEditView.Color:= PanelColorEdit.Color;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'LevelRecLogRudaMonitor', asInteger, ParamVariant)
    then intTemp:= ParamVariant
    else intTemp:= 0;
  if (intTemp >= 0) and (intTemp < 5) then RadioGroupRecLogRudaMonitor.ItemIndex:= intTemp
                                      else RadioGroupRecLogRudaMonitor.ItemIndex:= 0;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Settings', 'TimeChannelFind', asInteger, ParamVariant)
    then SpinEditTimeChannelFind.Value:= ParamVariant
    else SpinEditTimeChannelFind.Value:= defTimeChannelFind;

  //каталог персональных пользовательских настроек программы
  PathUserDataConfig:= ReadRegPath('Path', 'UserDataConfig');
  EditUserConfigData.Text:= PathUserDataConfig;
  //путь к файлам с коэффициентами из журнала проб
  PathFileCoeffProb:= ReadRegPath('Path', 'FileCoeffProb');
  EditFileCoefficientProb.Text:= PathFileCoeffProb;
  //путь к файлам копии базы данных при стирании и сжатии данных
  PathBackUpBD:= ReadRegPath('Path', 'BackUpBD');
  EditBackupBD.Text:= PathBackUpBD;
  //путь к каталогу с лог-файлами всех программ СКРП
  PathLogFiles:= ReadRegPath('Path', 'LogFiles');
  EditLogFiles.Text:= PathLogFiles;
end;

procedure TFormSettingsProgramm.SaveSettings;

  procedure WriteRegPath(MyEdit: TEdit; Section, KeyRead: string; var peremen: string); //запись в реестр путь к папке
    begin
      if not DirectoryExists(MyEdit.Text) then
        if not ForceDirectories(MyEdit.Text) then
          begin
            PageControl1.TabIndex:=0;
            MyEdit.SetFocus;
            MyEdit.SelectAll;
            Application.MessageBox(PChar('Невозможно создать каталог: ' +
                MyEdit.Text + #10#13 + 'Проверьте правильность пути.'),
                             PChar(ProgName_ShortStringVersion + ' ОШИБКА !!!'),
                             MB_OK + MB_ICONERROR);
            exit;
          end;
      peremen:= MyEdit.Text;
      WriteToRegVariant(RootKey_HKCU, SubKey, Section, KeyRead, peremen);
    end;

  function StyleToIndex(PenStyle: TPenStyle): integer;
    begin
      case PenStyle of
             psSolid: result:= 0;
              psDash: result:= 1;
               psDot: result:= 2;
           psDashDot: result:= 3;
        psDashDotDot: result:= 4;
      end;
    end;

begin
  if Application.MessageBox(PChar('Сохранить измененные данные?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      WriteToRegVariant(RootKey_HKCU, SubKey, 'LeftMarker', 'ColorLine', LeftMarker.Color);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'LeftMarker', 'Width', LeftMarker.Width);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'LeftMarker', 'Style', StyleToIndex(LeftMarker.Style));

      WriteToRegVariant(RootKey_HKCU, SubKey, 'RightMarker', 'ColorLine', RightMarker.Color);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'RightMarker', 'Width', RightMarker.Width);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'RightMarker', 'Style', StyleToIndex(RightMarker.Style));

      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'BackgroundColorViewMode',
                           PanelBackgroundColorViewMode.Color);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'ColorEdit', ColorEdit);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'ShowPointChart', CheckBoxShowPointChart.Checked);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'AutoscalingLeftAxisYMax', CheckBoxAutoscalingLeftAxisYMax.Checked);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'LeftAxisYMax', SpinEditLeftAxisYMax.Value);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'RestoreScaleSignal', SpinRestoreScale.Value);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'LocalClient', RadioButtonLocal.Checked);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'Address',
        EditAddress1.Text + '.' + EditAddress2.Text + '.' + EditAddress3.Text + '.' + EditAddress4.Text);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'Port', strtoint(EditPort.Text));
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'LevelRecLogRudaMonitor', RadioGroupRecLogRudaMonitor.ItemIndex);
      WriteToRegVariant(RootKey_HKCU, SubKey, 'Settings', 'TimeChannelFind', SpinEditTimeChannelFind.Value);

      WriteRegPath(EditUserConfigData, 'Path', 'UserDataConfig', PathUserDataConfig);
      WriteRegPath(EditFileCoefficientProb, 'Path', 'FileCoeffProb', PathFileCoeffProb);
      WriteRegPath(EditBackupBD, 'Path', 'BackUpBD', PathBackUpBD);
      WriteRegPath(EditLogFiles, 'Path', 'LogFiles', PathLogFiles);
    end;
end;

procedure TFormSettingsProgramm.SpinEditLeftAxisYMaxKeyPress(Sender: TObject;
  var Key: Char);
begin
  DM.CheckIntPressKey('"' + Copy(Label26.Caption, 1 ,Length(Label26.Caption)) + '"', Key);
  ProcedureChangeData;
end;

procedure TFormSettingsProgramm.SpinEditTimeChannelFindKeyPress(Sender: TObject;
  var Key: Char);
begin
  DM.CheckIntPressKey('"' + Copy(Label24.Caption, 1 ,Length(Label24.Caption)) + '"', Key);
  ProcedureChangeData;
end;

procedure TFormSettingsProgramm.SpinRestoreScaleKeyPress(Sender: TObject;
  var Key: Char);
begin
  DM.CheckIntPressKey('"' + Copy(Label21.Caption, 1 ,Length(Label21.Caption)) + '"', Key);
  ProcedureChangeData;
end;

procedure TFormSettingsProgramm.ChangeDataTrue(Sender: TObject);
begin
  ProcedureChangeData;
end;

procedure TFormSettingsProgramm.CheckBoxAutoscalingLeftAxisYMaxClick(
  Sender: TObject);
begin
  SpinEditLeftAxisYMax.Enabled:= not CheckBoxAutoscalingLeftAxisYMax.Checked;
  Label26.Enabled:= not CheckBoxAutoscalingLeftAxisYMax.Checked;
  ProcedureChangeData;
end;

procedure TFormSettingsProgramm.ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //если данные были изменены, разрешаем кнопку "Применить"
end;

end.
