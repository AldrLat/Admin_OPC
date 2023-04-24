unit UnitEditOrderProba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormEditOrderProba = class(TForm)
    Label1: TLabel;
    EditOrderProby: TEdit;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    ButtonClose: TButton;
    Label2: TLabel;
    EditNumProby: TEdit;
    Label3: TLabel;
    EditDataBeginProby: TEdit;
    EditDataEndProby: TEdit;
    Label4: TLabel;
    LabelCaption: TLabel;
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SetPositionWin;
    procedure GetData;
    procedure ProcedureChangeData(param: boolean = true);
    procedure EditOrderProbyChange(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);   //признак, что данные были изменены
    procedure SaveSettings;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEditOrderProba: TFormEditOrderProba;
  ChangeData: boolean;  //произошли ли изменения с данными для диалога, чтобы
                            //измененные данные записать в базу данных

implementation

uses UnitWinInfSignal, UnitDM, MainUnit;

{$R *.dfm}

procedure TFormEditOrderProba.ButtonCancelClick(Sender: TObject);
begin
  if ChangeData then
    if Application.MessageBox(PChar('Отменить введенное примечание?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
      begin
        if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
        GetData;
        ProcedureChangeData(false);
      end;
end;

procedure TFormEditOrderProba.ButtonCloseClick(Sender: TObject);
begin
  if ChangeData then SaveSettings;
  Close;
end;

procedure TFormEditOrderProba.ButtonSaveClick(Sender: TObject);
begin
  if ChangeData then
    begin
      SaveSettings;
      ProcedureChangeData(false);
    end;
end;

procedure TFormEditOrderProba.ProcedureChangeData(param: boolean = true);   //признак, что данные были изменены
begin
  ChangeData:= param;
  ButtonSave.Enabled:= param;   //если данные были изменены, разрешаем кнопку "Применить"
end;

procedure TFormEditOrderProba.SetPositionWin; //устанавливаем форму по центру вызванного ее окна
begin
  Left:= PositionForm.X + PositionForm.WidthWin div 2 - Width div 2;
  Top:= PositionForm.Y + PositionForm.HeightWin div 2 - Height div 2;
end;

procedure TFormEditOrderProba.SaveSettings;
begin
  if FormRudaAdmin.StateProcessCompressDBinProcessing then exit;   //проверям на состояние сжатия баз данных. если сейчас сжимаются - выходим.
  if Application.MessageBox(PChar('Сохранить премечание пробы №' + EditNumProby.Text + ' ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
    begin
      if not DM.QueryWorkStation('UPDATE Jornal SET Prim = ''' + Trim(EditOrderProby.Text) +
                                      ''' WHERE J_Code = ' + IntToStr(JCodeForm),
                                      Caption, 'FormShow', false) then
        begin
          //ошибка
        end;
    end;
end;

procedure TFormEditOrderProba.GetData;
begin
  EditNumProby.Clear;
  EditDataBeginProby.Clear;
  EditDataEndProby.Clear;
  EditOrderProby.Clear;
  LabelCaption.Caption:= '';

  if DM.QueryWorkStation('SELECT * FROM Jornal WHERE J_Code = ' + IntToStr(JCodeForm) +
                         ' ORDER BY J_Num', Caption, 'FormShow', true) then
    begin
      EditNumProby.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('J_Num').AsString);
      EditDataBeginProby.Text:= FormatDateTime('dd.mm.yyyy hh:nn:ss', DM.ADOQueryWorkStationMDB.FieldByName('J_DateBeg').AsDateTime);
      EditDataEndProby.Text:= FormatDateTime('dd.mm.yyyy hh:nn:ss', DM.ADOQueryWorkStationMDB.FieldByName('J_DateEnd').AsDateTime);
      EditOrderProby.Text:= Trim(DM.ADOQueryWorkStationMDB.FieldByName('Prim').AsString);
    end
    else begin
      //ошибка
    end;

  if ModeEnterProba = Edit_OrderProba then
    begin
      LabelCaption.Caption:= CaptionForm;
    end
    else if ModeEnterProba = New_OrderProba then
          begin
            LabelCaption.Caption:= 'Добавить примечание?';
          end
end;

procedure TFormEditOrderProba.EditOrderProbyChange(Sender: TObject);
begin
  ProcedureChangeData;
end;

procedure TFormEditOrderProba.FormShow(Sender: TObject);
begin
  SetPositionWin;
  GetData;
  ProcedureChangeData(false);
end;

end.
