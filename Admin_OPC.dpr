program Admin_OPC;

uses
  Vcl.Forms,
  Windows,
  Dialogs,
  MainUnit in 'MainUnit.pas' {FormRudaAdmin},
  UnitEnterPassword in 'UnitEnterPassword.pas' {FormEnterUser},
  About in 'About.pas' {FormAbout},
  UnitEnterprise—ompany in 'UnitEnterprise—ompany.pas' {FormEnterprise—ompany},
  Unit—oefficients in 'Unit—oefficients.pas' {Form—oefficients},
  Unit—ontrollersSKRP in 'Unit—ontrollersSKRP.pas' {Form—ontrollersSKRP},
  UnitTypeOre in 'UnitTypeOre.pas' {FormTypeOre},
  UnitConnectControllers in 'UnitConnectControllers.pas' {FormConnectControllers},
  UnitTableInformationSignals in 'UnitTableInformationSignals.pas' {FormTableInformationSignals},
  UnitConfigWorkStation in 'UnitConfigWorkStation.pas' {FormConfigWorkStation},
  UnitDlgConnect in 'UnitDlgConnect.pas' {FormDlgConnect},
  UnitDlgLink in 'UnitDlgLink.pas' {FormDlgLink},
  UnitDM in 'UnitDM.pas' {DM: TDataModule},
  UnitSettingsWorkStation in 'UnitSettingsWorkStation.pas' {FormSettingsWorkStation},
  UnitDisp in 'UnitDisp.pas' {FormDisp},
  UnitTestState in 'UnitTestState.pas' {FormTestState},
  UnitWinInfSignal in 'UnitWinInfSignal.pas' {FormWinInfSignal},
  UnitSettingsProgramm in 'UnitSettingsProgramm.pas' {FormSettingsProgramm},
  Vcl.CustomizeDlg in 'Vcl.CustomizeDlg.pas' {CustomizeFrm},
  UnitClearBD in 'UnitClearBD.pas' {FormClearBD},
  UnitViewEquipment in 'UnitViewEquipment.pas' {FormViewEquipment},
  UnitSetupOPCServer in 'OPC_Unit\UnitSetupOPCServer.pas' {FormSetupOpcServer},
  UnitCreateOPCserver in 'OPC_Unit\UnitCreateOPCserver.pas' {FormCreateOPCserver},
  OPCDA in '..\OPC\OPCDA.pas',
  OPCtypes in '..\OPC\OPCtypes.pas',
  comcat in '..\OPC\comcat.pas',
  OPCCOMN in '..\OPC\OPCCOMN.pas',
  OPCEnum in '..\OPC\OPCEnum.pas',
  RudaMonitor_TLB in '..\RudaMonitor_OPC\RudaMonitor_TLB.pas',
  OPCHDA in '..\OPC\OPCHDA.pas',
  UnitMyForm in 'UnitMyForm.pas',
  UnitViewPropertiesOPCServer in 'OPC_Unit\UnitViewPropertiesOPCServer.pas' {FormPropertiesOPCServer},
  Vcl.Themes,
  Vcl.Styles,
  UnitSelectRegServer in 'OPC_Unit\UnitSelectRegServer.pas' {FormRegOPCServers},
  RudaGlobals in '..\RudaMonitor_OPC\OPC_Unit\RudaGlobals.pas',
  EnumSerialPorts in 'EnumSerialPorts.pas',
  UnitLineSettingsConnection in 'UnitLineSettingsConnection.pas' {FormLineSettingsConnection},
  ThreadConnectNetSQL in 'ThreadConnectNetSQL.pas',
  UnitEditOrderProba in 'UnitEditOrderProba.pas' {FormEditOrderProba},
  UnitProgressCompressDB in 'UnitProgressCompressDB.pas' {FormProgressCompressDB},
  UnitShowProgressCompressDB in 'UnitShowProgressCompressDB.pas' {FormShowProgressCompressDB},
  ThreadCompressDB in 'ThreadCompressDB.pas',
  UnitLoad—oefficients in 'UnitLoad—oefficients.pas' {FormLoad—oefficients};

{$R *.res}
//¡ÎÓÍËÓ‚‡ÌËÂ Á‡ÔÛÒÍ‡ ‚ÚÓÓ„Ó ˝ÍÁÂÏÔÎˇ‡ ÔÓ„‡ÏÏ˚
var HM: THandle;
  function Check: boolean;
    begin
     HM := OpenMutex(MUTEX_ALL_ACCESS, false, 'RudaSetting');
     Result := (HM <> 0);
     if HM = 0 then HM := CreateMutex(nil, false, 'RudaSetting');
    end;

begin
  //¡ÎÓÍËÓ‚‡ÌËÂ Á‡ÔÛÒÍ‡ ‚ÚÓÓ„Ó ˝ÍÁÂÏÔÎˇ‡ ÔÓ„‡ÏÏ˚
  if Check then
    begin
      MessageDlg('œËÎÓÊÂÌËÂ ' + ProgrammName + ' ' + ProgrammNameVer + ' ÛÊÂ Á‡ÔÛ˘ÂÌÓ.', mtWarning, [mbOk], 0);
      exit;
    end;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.HelpFile := '';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormRudaAdmin, FormRudaAdmin);
  Application.CreateForm(TFormSettingsProgramm, FormSettingsProgramm);
  Application.CreateForm(TFormEnterUser, FormEnterUser);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormEnterprise—ompany, FormEnterprise—ompany);
  Application.CreateForm(TForm—oefficients, Form—oefficients);
  Application.CreateForm(TForm—ontrollersSKRP, Form—ontrollersSKRP);
  Application.CreateForm(TFormTypeOre, FormTypeOre);
  Application.CreateForm(TFormConnectControllers, FormConnectControllers);
  Application.CreateForm(TFormTableInformationSignals, FormTableInformationSignals);
  Application.CreateForm(TFormConfigWorkStation, FormConfigWorkStation);
  Application.CreateForm(TFormDlgConnect, FormDlgConnect);
  Application.CreateForm(TFormDlgLink, FormDlgLink);
  Application.CreateForm(TFormSettingsWorkStation, FormSettingsWorkStation);
  Application.CreateForm(TFormDisp, FormDisp);
  Application.CreateForm(TFormClearBD, FormClearBD);
  Application.CreateForm(TFormViewEquipment, FormViewEquipment);
  Application.CreateForm(TFormSetupOpcServer, FormSetupOpcServer);
  Application.CreateForm(TFormSetupOpcServer, FormSetupOpcServer);
  Application.CreateForm(TFormCreateOPCserver, FormCreateOPCserver);
  Application.CreateForm(TFormPropertiesOPCServer, FormPropertiesOPCServer);
  Application.CreateForm(TFormRegOPCServers, FormRegOPCServers);
  Application.CreateForm(TFormLineSettingsConnection, FormLineSettingsConnection);
  Application.CreateForm(TFormEditOrderProba, FormEditOrderProba);
  Application.CreateForm(TFormProgressCompressDB, FormProgressCompressDB);
  Application.CreateForm(TFormShowProgressCompressDB, FormShowProgressCompressDB);
  Application.CreateForm(TFormLoad—oefficients, FormLoad—oefficients);
  Application.Run;
end.
