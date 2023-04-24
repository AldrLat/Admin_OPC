unit UnitDisp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Data.Win.ADODB, Vcl.ComCtrls, UnitDM, RudaGlobals,
  UnitMyForm{обязательно ПОСЛЕДНИМ};

type
  TFormDisp = class(TForm)
    Panel1: TPanel;
    ButtonClose: TButton;
    ListViewLinesDisp: TListView;
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ListViewLinesDispClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure AddDataM;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure WMCopyData(var MessageData: TWMCopyData); message WM_COPYDATA;
  public
    { Public declarations }
  end;

const tagDisp = 101;
var
  FormDisp: TFormDisp;
  pTransfer_DataParam: PTransferDataParam;

implementation

{$R *.dfm}

procedure TFormDisp.WMCopyData(var MessageData: TWMCopyData);
begin
  if MessageData.CopyDataStruct.dwData = CMD_M then
    begin
      pTransfer_DataParam:= MessageData.CopyDataStruct.lpData;
      AddDataM;
    end;
end;

procedure TFormDisp.AddDataM;
  var i, k, countcol: integer;
begin
  countcol:= ListViewLinesDisp.Columns.Count - 2; //номер последней колонки где хранится код L_Code
  for i := 0 to ListViewLinesDisp.Items.Count - 1 do
    if (ListViewLinesDisp.Items.Item[i].Checked) and
       (strtoint(ListViewLinesDisp.Items.Item[i].SubItems[countcol]) =
        integer(pTransfer_DataParam^.L_Code)) then
      begin
        ListViewLinesDisp.Items.Item[i].SubItems[0]:= FormatDateTime('dd.mm.yyyy hh:nn:ss', pTransfer_DataParam^._Date);
        for k := 0 to ListViewLinesDisp.Columns.Count - 1 do   //ищем колонку в Tag записна номер 100 значит колонка со значением дисперсии
          if ListViewLinesDisp.Columns[k].Tag = tagDisp then
            ListViewLinesDisp.Items.Item[i].SubItems[k - 1]:= Format('%.3n', [pTransfer_DataParam^.CurDisp]);
      end;
end;

procedure TFormDisp.ButtonCloseClick(Sender: TObject);
begin
  FormDisp.Close;
end;

procedure TFormDisp.FormCreate(Sender: TObject);
begin
  FormDisp.Caption:= ProgName_ShortStringVersion + FormDisp.Caption;

end;

procedure TFormDisp.FormResize(Sender: TObject);
begin
  ListViewLinesDisp.Columns[0].Width:= Trunc(ListViewLinesDisp.Width/3) - 5;
  ListViewLinesDisp.Columns[1].Width:= Trunc(ListViewLinesDisp.Width/3);
  ListViewLinesDisp.Columns[2].Width:= Trunc(ListViewLinesDisp.Width/3);
end;

procedure TFormDisp.FormShow(Sender: TObject);

begin
  with ListViewLinesDisp.Columns do //готовим колонки списка
    begin
      Clear; //удаляем все старые колонки
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Наименование конвейера';
        LC.Width:= 150;
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Дата/Время';
        LC.Width:= 150;
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Значение дисперсии';
        LC.Width:= 150;
        LC.Tag:= tagDisp;
      LC:=Add; //добавляем новую колонку
        LC.Caption:= 'Код линии';
        LC.Width:= 0;
    end;

  if not DM.QueryWorkStation('SELECT L_Code FROM ParamLines WHERE [Connect]',
                                  FormDisp.Caption, 'FormShow', true) then exit;
  if DM.ADOQueryWorkStationMDB.Eof then exit;
  ListViewLinesDisp.Items.Clear;
  while not DM.ADOQueryWorkStationMDB.EOF do
    begin
      if not DM.QueryServer('SELECT L_Name FROM Lines WHERE L_Code = ' +
                             DM.ADOQueryWorkStationMDB.FieldByName('L_Code').AsString,
                             FormDisp.Caption, 'FormShow', true) then exit;
      LI:= ListViewLinesDisp.Items.Add; //добавили элемент списка
      LI.Caption:= DM.ADOQueryServerMDB.FieldByName('L_Name').AsString;  //название конвейера
      LI.SubItems.Add('');
      LI.SubItems.Add('');
      LI.SubItems.Add(DM.ADOQueryWorkStationMDB.FieldByName('L_Code').AsString);
      DM.ADOQueryWorkStationMDB.Next;
    end;
end;

procedure TFormDisp.ListViewLinesDispClick(Sender: TObject);
 var row: integer;
     sName, lCode: string;
begin
  for row := 0 to ListViewLinesDisp.Items.Count - 1 do
    if ListViewLinesDisp.Items[row].Checked then
      begin
        lCode:= ListViewLinesDisp.Items[row].SubItems[2];
        sName:= 'M' + lCode;
        if not DM.QueryDataWS('SELECT M_Date, ValDisp FROM ' + sName +
                              ' WHERE M_Yes ORDER BY M_Date DESC',
                               FormDisp.Caption, 'ListViewLinesDispClick', true) then exit;
        if not DM.ADOQueryDataWSMDB.Eof then
          begin
            ListViewLinesDisp.Items[row].SubItems[0]:= FormatDateTime('dd.mm.yyyy hh:nn:ss',
                                     DM.ADOQueryDataWSMDB.FieldByName('M_Date').AsDateTime);
            if DM.ADOQueryDataWSMDB.FieldByName('ValDisp').AsString = null
              then ListViewLinesDisp.Items[row].SubItems[1]:= ''
              else ListViewLinesDisp.Items[row].SubItems[1]:= DM.ADOQueryDataWSMDB.FieldByName('ValDisp').AsString;
          end;
      end
      else begin
        ListViewLinesDisp.Items[row].SubItems[0]:= '';
        ListViewLinesDisp.Items[row].SubItems[1]:= '';
      end;
end;

procedure TFormDisp.Timer1Timer(Sender: TObject);
begin
  Label1.Caption:= TimeToStr(now);
end;

end.
