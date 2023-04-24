unit UnitViewEquipment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, UnitDM, RudaGlobals, UnitMyForm{обязательно ПОСЛЕДНИМ};

type
  TFormViewEquipment = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Panel2: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    LabelTxtW: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label1: TLabel;
    LabelTxtDigIn: TLabel;
    PanelLine_U1: TPanel;
    PanelLine_U2: TPanel;
    Panel5: TPanel;
    PanelLine_W: TPanel;
    Ch_U1: TEdit;
    Ch_U2: TEdit;
    Ch_W: TEdit;
    Ch_DigIn: TEdit;
    P_U1: TEdit;
    P_U2: TEdit;
    P_W: TEdit;
    Panel7: TPanel;
    Ch_Other: TEdit;
    P_Other: TEdit;
    PanelLine_Other: TPanel;
    Label4: TLabel;
    Name_MB5: TEdit;
    Name_W: TEdit;
    Name_Other: TEdit;
    Name_DigIn: TEdit;
    PanelInfo: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    procedure FormShow(Sender: TObject);
//    procedure ListLineChannel;
//    procedure ListLine;
    procedure ListControllers;
    procedure ClearAll;
    procedure OtherOnOff(OnOff: boolean);
    procedure WeigherAnalogOrPulse(analog: boolean);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const TxtNo = 'X';
      TxtDigIn = 'ДИСКРЕТНЫЙ      ВХОД';
      TxtW = 'ВЕСЫ';
      PanelColorDef = clSilver;
      ColorContrNoIdentified = clRed;
var
  FormViewEquipment: TFormViewEquipment;
  LinesChannels: TLinesChannels;
  Lines: TLines;  //список кодов подключенных конвейеров (по порядку), последний байт - общее число конвейеров
  UsedChannels: TUsedChannels;
  Controllers: array [0.. MAXCHANNEL - 1] of TLinkContr; //список подключенных контроллеров
  ControllerIdentified: boolean;      //true - контроллер назначен на канал все хорошо
implementation

{$R *.dfm}

uses UnitConfigWorkStation;

procedure TFormViewEquipment.ListControllers;     //список контроллеров по порядку (номера L_Code)
  var i: integer;
  cnName: string;
begin
  FillChar(Controllers, sizeof(Controllers), 0);
  i:= 0;
  DM.QueryWorkStation('SELECT * FROM LinkContr ORDER BY Plata', FormViewEquipment.Caption,
                      'ListControllers', true);
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      Controllers[i].Plata:= DM.ADOQueryWorkStationMDB.FieldByName('Plata').AsInteger + 1;
      DM.QueryServer('SELECT Cn_Name FROM Controllers WHERE Cn_Code = ' +
                     DM.ADOQueryWorkStationMDB.FieldByName('Cn_Code').AsString,
                    FormViewEquipment.Caption, 'ListControllers', true);
      if not DM.ADOQueryServerMDB.EOF then
        begin
          cnName:= Trim(DM.ADOQueryServerMDB.FieldByName('Cn_Name').AsString);
          StrPCopy(Controllers[i].ContrName, cnName);
        end;
      inc(i);
      DM.ADOQueryWorkStationMDB.Next;
    end;
end;

procedure TFormViewEquipment.OtherOnOff(OnOff: boolean);
begin
  Name_Other.Visible:= OnOff;
  Ch_Other.Visible:= OnOff;
  P_Other.Visible:= OnOff;
  PanelLine_Other.Visible:= OnOff;
  Label1.Visible:= OnOff;
end;

procedure TFormViewEquipment.WeigherAnalogOrPulse(analog: boolean);
begin
  if analog then
    begin
      PanelLine_W.Width:= Panel2.Left - (P_W.Left + P_W.Width) - 2;//2 - зазор было 50;
      PanelLine_W.Left:= P_W.Left + P_W.Width + 2; //330;
      P_W.Visible:= true;
    end
    else begin
      PanelLine_W.Left:= Ch_W.Left + Ch_W.Width + 2;// 288;
      PanelLine_W.Width:= Panel2.Left - (Ch_W.Left + Ch_W.Width) - 2;
      P_W.Visible:= false;
    end;
end;

procedure TFormViewEquipment.Button1Click(Sender: TObject);
begin
  FormViewEquipment.Close;
end;

procedure TFormViewEquipment.ClearAll;
  var i: integer;
begin
  WeigherAnalogOrPulse(true);
  for i := 0 to FormViewEquipment.ComponentCount-1 do
    begin
      if FormViewEquipment.Components[i] is TEdit then
        case TEdit(FormViewEquipment.Components[i]).Tag of
          100: TEdit(FormViewEquipment.Components[i]).Text:= '';
          101, 102: begin
                      TEdit(FormViewEquipment.Components[i]).Text:= TxtNo;
                      TEdit(FormViewEquipment.Components[i]).Color:= clWindow;
                      TEdit(FormViewEquipment.Components[i]).ShowHint:= true;
                      TEdit(FormViewEquipment.Components[i]).Hint:= '';
                    end;
        end;
      if FormViewEquipment.Components[i] is TPanel then
        if TPanel(FormViewEquipment.Components[i]).Tag = 200 then
          TEdit(FormViewEquipment.Components[i]).Color:= PanelColorDef;
    end;

  LabelTxtDigIn.Caption:= TxtDigIn;
  LabelTxtW.Caption:= TxtW;
  OtherOnOff(false);
  ControllerIdentified:= true;
  PanelInfo.Visible:= false;
end;

procedure ControllCheck(var Edit: TEdit; NumCh: byte);
  var i: integer;
      booltemp: boolean;
begin
  booltemp:= false;
  for i:= 0 to MAXCHANNEL - 1 do
    if NumCh = Controllers[i].Plata then booltemp:= true;

  if not booltemp then //контроллер не найден
    begin
      ControllerIdentified:= false;
      Edit.Color:= ColorContrNoIdentified;
    end;

end;

procedure TFormViewEquipment.FormCreate(Sender: TObject);
begin
  Panel3.Color:= ColorContrNoIdentified;
  Label2.Caption:= '- не назначен контроллер на канал' +#10#13 + '  ("Рабочая станция"->"Настройка технических параметров"->"Подключение контроллеров")'
end;

procedure TFormViewEquipment.FormShow(Sender: TObject);
  var n, i: integer;
    boolTemp: boolean;
begin
  ClearAll;
  ListControllers;
  DM.ListLine(Lines, Caption);
  DM.ListLineChannel(Lines, LinesChannels, UsedChannels, Caption);

  boolTemp:= false; //линию не нашли
  for i := 0 to Lines[MAXLINE] - 1 do     //было в старой версии MAXCHANNEL
    if Lines[i] = CodeLine then
      begin
        boolTemp:= true;
        break;
      end;

  if boolTemp then  //такая линия найдена. в i содержится порядковый номер записи по этой линии
    begin
      FormViewEquipment.Caption:= 'Схема оборудования конвейера ' +
                                    ' - ' + PChar(@LinesChannels[i].L_Name);
      for n := 0 to MAXPIP - 1 do
        case LinesChannels[i].Measurer[n] of
          1: begin   //U1
                Name_MB5.Text:= PChar(@LinesChannels[i].NameMeasurer[n]);
                Ch_U1.Text:= PChar(@LinesChannels[i].NameController[n]);//inttostr(LinesChannels[i].Channel[n]);
                Ch_U1.Hint:= Ch_U1.Text;
                ControllCheck(Ch_U1, LinesChannels[i].Channel[n]);
                P_U1.Text:= inttostr(LinesChannels[i].Point[n]);
                PanelLine_U1.Color:= LinesChannels[i].ColorLine[n];
             end;
          2: begin  //U2
                Name_MB5.Text:= PChar(@LinesChannels[i].NameMeasurer[n]);
                Ch_U2.Text:= PChar(@LinesChannels[i].NameController[n]);//inttostr(LinesChannels[i].Channel[n]);
                Ch_U2.Hint:= Ch_U2.Text;
                ControllCheck(Ch_U2, LinesChannels[i].Channel[n]);
                P_U2.Text:= inttostr(LinesChannels[i].Point[n]);
                PanelLine_U2.Color:= LinesChannels[i].ColorLine[n];
             end;
          3: begin  //весы аналоговые
                WeigherAnalogOrPulse(true);
                LabelTxtW.Caption:= TxtW + ' (аналоговые)';
                Name_W.Text:= PChar(@LinesChannels[i].NameMeasurer[n]);
                Ch_W.Text:= PChar(@LinesChannels[i].NameController[n]);//inttostr(LinesChannels[i].Channel[n]);
                Ch_W.Hint:= Ch_W.Text;
                ControllCheck(Ch_W, LinesChannels[i].Channel[n]);
                P_W.Text:= inttostr(LinesChannels[i].Point[n]);
                PanelLine_W.Color:= LinesChannels[i].ColorLine[n];
             end;
          4: begin  //прочее
                OtherOnOff(true);
                Name_Other.Text:= PChar(@LinesChannels[i].NameMeasurer[n]);
                Ch_Other.Text:= PChar(@LinesChannels[i].NameController[n]);//inttostr(LinesChannels[i].Channel[n]);
                Ch_Other.Hint:= Ch_Other.Text;
                ControllCheck(Ch_Other, LinesChannels[i].Channel[n]);
                P_Other.Text:= inttostr(LinesChannels[i].Point[n]);
                PanelLine_Other.Color:= LinesChannels[i].ColorLine[n];
             end;
         10,
         11: begin  //дискретный вход 1 и 2  (датчик движения)
                if LinesChannels[i].Measurer[n] = 10 then LabelTxtDigIn.Caption:= TxtDigIn + ' 1'
                                                     else LabelTxtDigIn.Caption:= TxtDigIn + ' 2';

                Name_DigIn.Text:= PChar(@LinesChannels[i].NameMeasurer[n]);
                Ch_DigIn.Text:= PChar(@LinesChannels[i].NameController[n]);//inttostr(LinesChannels[i].Channel[n]);
                Ch_DigIn.Hint:= Ch_DigIn.Text;
                ControllCheck(Ch_DigIn, LinesChannels[i].Channel[n]);
             end;
         12: begin  //весы импульсные
                WeigherAnalogOrPulse(false);
                LabelTxtW.Caption:= TxtW + ' (импульсные)';
                Name_W.Text:= PChar(@LinesChannels[i].NameMeasurer[n]);
                Ch_W.Text:= PChar(@LinesChannels[i].NameController[n]);//inttostr(LinesChannels[i].Channel[n]);
                Ch_W.Hint:= Ch_W.Text;
                ControllCheck(Ch_W, LinesChannels[i].Channel[n]);
             end;
        end;
    end;

  PanelInfo.Visible:= not ControllerIdentified;
  Button1.SetFocus;
end;

end.
