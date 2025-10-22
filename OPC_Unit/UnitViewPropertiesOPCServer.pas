unit UnitViewPropertiesOPCServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TFormPropertiesOPCServer = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Image1: TImage;
    LabelDescription: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    LabelGUID: TLabel;
    LabelServerName: TLabel;
    LabelTypeServer: TLabel;
    Label6: TLabel;
    LabelMajorVersion: TLabel;
    LabelMinorVersion: TLabel;
    LabelBuildNumber: TLabel;
    Label7: TLabel;
    LabelServerState: TLabel;
    Label8: TLabel;
    LabelStartTime: TLabel;
    LabelTitleLastUpdate: TLabel;
    LabelLastUpdateTime: TLabel;
    Label10: TLabel;
    LabelVendorInfo: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClearLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPropertiesOPCServer: TFormPropertiesOPCServer;

implementation

{$R *.dfm}

uses UnitDM, UnitSetupOPCServer, RudaGlobals;

procedure TFormPropertiesOPCServer.Button1Click(Sender: TObject);
begin
  FormPropertiesOPCServer.Close;
end;

procedure TFormPropertiesOPCServer.ClearLabel;
begin
  LabelDescription.Caption:= '';
  LabelTypeServer.Caption:= '';
  LabelServerName.Caption:= '';
  LabelGUID.Caption:= '';
  LabelMajorVersion.Caption:= '';
  LabelMinorVersion.Caption:= '';
  LabelBuildNumber.Caption:= '';
  LabelServerState.Caption:= '';
  LabelStartTime.Caption:= '';
  LabelLastUpdateTime.Caption:= '';
  LabelVendorInfo.Caption:= '';
end;

procedure TFormPropertiesOPCServer.FormShow(Sender: TObject);
begin
  ClearLabel;
  case PropertiesOPCServer.TypeServer of
                 0: exit;
     OPC_DA_Server: begin
                      FormSetupOpcServer.ImageListEnabled.GetIcon(5, Icon);
                      LabelTypeServer.Caption:= 'OPC Data Access v2.05 server';
                      LabelTitleLastUpdate.Visible:= true;
                      LabelLastUpdateTime.Visible:= true;
                      LabelLastUpdateTime.Caption:= DateTimeToStr(PropertiesOPCServer.LastUpdateTime);
                    end;
    OPC_HDA_Server: begin
                      FormSetupOpcServer.ImageListEnabled.GetIcon(10, Icon);
                      LabelTypeServer.Caption:= 'OPC Historical Data Access v1.2 server';
                      LabelTitleLastUpdate.Visible:= false;
                      LabelLastUpdateTime.Visible:= false;
                    end;
  end;
  LabelDescription.Caption:= PropertiesOPCServer.Description;
  LabelServerName.Caption:= PropertiesOPCServer.ServerName;
  LabelGUID.Caption:= GUIDtoString(PropertiesOPCServer.GUID);
  LabelMajorVersion.Caption:= inttostr(PropertiesOPCServer.MajorVersion);
  LabelMinorVersion.Caption:= inttostr(PropertiesOPCServer.MinorVersion);
  LabelBuildNumber.Caption:= inttostr(PropertiesOPCServer.BuildNumber);
  LabelServerState.Caption:= PropertiesOPCServer.ServerState;
  LabelStartTime.Caption:= DateTimeToStr(PropertiesOPCServer.StartTime);
  LabelVendorInfo.Caption:= PropertiesOPCServer.VendorInfo;
end;

end.
