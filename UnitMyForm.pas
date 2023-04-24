//Этот Unit отвечат за то, чтобы главная форма была поверх дочерних
//Чтобы работало, надо во всех дочерних формахдобавить в Uses ПОСЛЕДНИМ этот модуль
//
unit UnitMyForm;

interface
uses Forms, Controls;

type
  TForm = class(Forms.TForm)
  private
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    { Public declarations }

  end;

implementation

{ TForm }
procedure TForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := Application.Handle;
end;

end.
