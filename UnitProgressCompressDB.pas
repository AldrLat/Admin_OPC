unit UnitProgressCompressDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, ComObj,
  ThreadCompressDB, System.SyncObjs;

type
  TFormProgressCompressDB = class(TForm)
    ButtonCancelCompressDB: TButton;
    Timer1: TTimer;
    RichEditCompressDB: TRichEdit;
    ButtonCloseCompressDB: TButton;
    procedure ClearAll;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ButtonCloseCompressDBClick(Sender: TObject);
    procedure ButtonCancelCompressDBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const ShowJobText: array [0..4] of string = ('∆дите', 'жƒите', 'жд»те', 'жди“е', 'ждит≈');
var
  FormProgressCompressDB: TFormProgressCompressDB;
  CompressDB: TCompressDB;
  CurrentIndexShowJob: integer;
  EditDataInRichEdit: TEvent;

implementation
uses UnitDM;

{$R *.dfm}

procedure TFormProgressCompressDB.ButtonCancelCompressDBClick(Sender: TObject);
begin
  if CompressDB <> nil then CompressDB.Suspend; //пауза
  if Application.MessageBox('ќстановить процесс сжати€ базы данных?',
                             PChar(ProgName_ShortStringVersion + ' ¬Ќ»ћјЌ»≈ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES  then
  begin
    CompressDB.Terminate;
  end;
  if CompressDB <> nil then CompressDB.Resume; //запустили
end;

procedure TFormProgressCompressDB.ButtonCloseCompressDBClick(Sender: TObject);
begin
  Timer1.Enabled:= false;
  if EditDataInRichEdit <> nil then EditDataInRichEdit.Free;

  try
    if CompressDB <> nil then
    begin
      CompressDB.Terminate;
      CompressDB:= nil;
    end;
  except

  end;

  Close;
end;

procedure TFormProgressCompressDB.ClearAll;
begin
  RichEditCompressDB.Clear;
  Application.ProcessMessages;
end;

procedure TFormProgressCompressDB.FormShow(Sender: TObject);
begin
  with FormProgressCompressDB do  //чтобы она была поверх всех окон
    SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Width, Height,
        SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

  Caption:= ProgName_ShortStringVersion + ' —жатие баз данных';
  ClearAll;
  RichEditCompressDB.Lines.Add('—жатие баз данных:' + #13);
  ButtonCloseCompressDB.Enabled:= false;
  ButtonCancelCompressDB.Enabled:= true;

  //¬начале нужно создать экземпл€р потока:
  CompressDB:= TCompressDB.Create(False);    //false - сразу запускаем поток
  CompressDB.FreeOnTerminate:= true;
  CompressDB.Priority:= tpLower;

  CurrentIndexShowJob:= 0;
  EditDataInRichEdit := tevent.create(nil, true, true, '');    //первоначально - свободно
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
    while FindText(SearchText, startpos, endpos, [])<>-1 do
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

procedure TFormProgressCompressDB.Timer1Timer(Sender: TObject);
  var s: string;
      before, after : string;
      indexLine: integer;
begin
  //чтобы отображать какое-то движение
  if CompressDB.Suspended then exit;  //если поток на паузе выходим

  EditDataInRichEdit.WaitFor(INFINITE);
  EditDataInRichEdit.ResetEvent;   // ѕереводим в ожидание дл€ редактировани€ RichEdit

  SearchAndReplace(RichEditCompressDB,
    Format('  - %s - %s', [CurrentCompressNameDB, ShowJobText[0]]),
    Format('  - %s - %s', [CurrentCompressNameDB, ShowJobText[CurrentIndexShowJob]]));
  if CurrentIndexShowJob = High(ShowJobText) then CurrentIndexShowJob:= Low(ShowJobText) else inc(CurrentIndexShowJob);

  Application.ProcessMessages;
  EditDataInRichEdit.SetEvent; //освобождаем событие
end;

end.
