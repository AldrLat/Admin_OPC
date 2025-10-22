unit UnitSetupOPCServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Menus, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, OPCDA, OPCHDA, OPCtypes,
  ActiveX, OPCCOMN, ComObj, OPCEnum, RudaMonitor_TLB, UnitDM, comcat;

type
  TFormSetupOpcServer = class(TForm)
    ImageList1: TImageList;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    CreateNewOPCserver: TToolButton;
    Panel2: TPanel;
    ButtonClose: TButton;
    Panel3: TPanel;
    TreeViewOPCServer: TTreeView;
    RadioButtonAllOPCServer: TRadioButton;
    RadioButtonSCRPOPCServer: TRadioButton;
    ToolButtonDeleteOPCServer: TToolButton;
    ToolButton2: TToolButton;
    ToolButtonConnectOPCServer: TToolButton;
    ToolButtonDisconnectOPCServer: TToolButton;
    ToolButton1: TToolButton;
    ToolButtonRefreshListOPCServers: TToolButton;
    Panel4: TPanel;
    Label1: TLabel;
    EditGUID: TEdit;
    Label2: TLabel;
    EditUserType: TEdit;
    Bevel1: TBevel;
    CheckBoxOPCServerDA: TCheckBox;
    CheckBoxOPCServerHDA: TCheckBox;
    TreeViewBrowseTag: TTreeView;
    Label3: TLabel;
    EditServerName: TEdit;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;


    procedure ButtonCloseClick(Sender: TObject);
    procedure CreateNewOPCserverClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReadListOPCServer(all: boolean);
    procedure RadioButtonAllOPCServerClick(Sender: TObject);
    procedure RadioButtonSCRPOPCServerClick(Sender: TObject);
//    procedure ServerList;
    procedure ListNodesOPCDAServer(serverName: string);
    procedure ListNodesOPCHDAServer(serverName: string);
    procedure DisplayChildren(OPCBrowse: IOPCBrowse;
                              OPCBrowseServerAddressSpace: IOPCBrowseServerAddressSpace);
    procedure DisplayChildrenHDA(OPCHDA_Browser: IOPCHDA_Browser);
    procedure EnabledDisabledButton(param: boolean);
    procedure ToolButtonRefreshListOPCServersClick(Sender: TObject);
    procedure ToolButtonDeleteOPCServerClick(Sender: TObject);
    procedure TreeViewOPCServerChange(Sender: TObject; Node: TTreeNode);
    procedure ClearInfoOPCServer;
    procedure TreeViewOPCServerClick(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure CheckBoxOPCServerDAClick(Sender: TObject);
    procedure CheckBoxOPCServerHDAClick(Sender: TObject);
    procedure TreeViewOPCServerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSetupOpcServer: TFormSetupOpcServer;
  ParamVariant: Variant;
  serverName: string;
  CurrentBranch: TTreeNode;
  FirstStart: boolean;
  StatusServerDA: POPCSERVERSTATUS;
  PropertiesOPCServer: OPCServerProperty;
implementation

{$R *.dfm}

uses UnitCreateOPCserver, UnitSettingsWorkStation,
  UnitViewPropertiesOPCServer, UnitSelectRegServer, RudaGlobals;

procedure TFormSetupOpcServer.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSetupOpcServer.CreateNewOPCserverClick(Sender: TObject);
begin
//  FormCreateOPCserver.ShowModal;
  FormRegOPCServers.ShowModal;
end;

procedure TFormSetupOpcServer.FormCreate(Sender: TObject);
begin
  Caption:= ProgName_ShortStringVersion + Caption;
end;

procedure TFormSetupOpcServer.RadioButtonAllOPCServerClick(Sender: TObject);
begin
  WriteToRegVariant(RootKey_HKCU, SubKey, 'OPC', 'ViewOPCServer', RadioButtonAllOPCServer.Checked);
  if not FirstStart then ReadListOPCServer(RadioButtonAllOPCServer.Checked);
end;

procedure TFormSetupOpcServer.RadioButtonSCRPOPCServerClick(Sender: TObject);
begin
  RadioButtonAllOPCServerClick(Sender);
end;

//ищем полный путь к узлу
function GetParentText(Node: TTreeNode): string;
begin
  result:= '';
  if not Assigned(Node) then exit;
  while Assigned(Node) do
    begin
      result:= '.' + Node.Text + result;
      Node:= Node.Parent;
    end;
  delete(result, 1, 1);
end;

function GetDescriptionDA(ItemName: string; Node: TTreeNode; var DataTypes: TVarType): string;
var OPCItemProperties: IOPCItemProperties;
    i: integer;
    sPath, stEngUnits: string;
    pdwCount: DWORD;
    ppDescriptions: POleStrList;
    ppvtDataTypes: PVarTypeList;
    szItemID: PWideChar;
    ppvData: POleVariantArray;
    ppErrors: PResultList;
    pdwPropertyIDs: PDWORDARRAY;
begin
  result:= '';
  stEngUnits:= '';
  sPath:= GetParentText(Node);
  if sPath = '' then sPath:= ItemName
                else sPath:= sPath + '.' + ItemName;

  try
    OPCItemProperties:= ServerIfDA as IOPCItemProperties;
  except
    on E: Exception do
      begin
        OPCItemProperties:= nil;
        MessageBox(0, PChar('Ошибка интерфейса IOPCItemProperties [' + E.Message + ']'),
                   PChar(FormSetupOpcServer.Caption), MB_OK+MB_ICONERROR);
        exit;
      end;
  end;

  szItemID:= PWideChar(WideString(sPath));
//  dwPropertyIDs:= 101;  //читаем описание Item
  if OPCItemProperties <> nil then
    begin
      //узнаем какие свойства поддерживает Item
      if OPCItemProperties.QueryAvailableProperties(szItemID, pdwCount, pdwPropertyIDs,
          ppDescriptions, ppvtDataTypes) = S_OK then
        begin
          //считываем все поддерживаемые Item`ом свойсва
          if OPCItemProperties.GetItemProperties(szItemID, pdwCount, pdwPropertyIDs, ppvData, ppErrors) = S_OK then
            begin
              for i := 0 to pdwCount - 1 do
                begin
                  case pdwPropertyIDs[i] of
                    //тип Item
                      OPC_PROPERTY_DATATYPE: DataTypes:= ppvData[i];
                    //единицы измерения
                    OPC_PROPERTY_EU_UNITS: stEngUnits:= trim(string(ppvData^[i]));
                    //описание Item
                    OPC_PROPERTY_DESCRIPTION: if trim(string(ppvData^[i])) <> '' then
                                                result:= ' - ' + trim(string(ppvData^[i]));
                  end;

                end;
              if stEngUnits <> '' then result:= result + ' (ед. изм. - ' + stEngUnits + ')';

              CoTaskMemFree(ppvData);
              CoTaskMemFree(ppErrors);
            end;
          CoTaskMemFree(pdwPropertyIDs);
          CoTaskMemFree(ppDescriptions);
          CoTaskMemFree(ppvtDataTypes);
        end;

    end;
  OPCItemProperties:= nil;
end;

function GetDescriptionHDA(ItemName: string; Node: TTreeNode; var DataTypes: TVarType): string;
var OPCHDA_SyncRead: IOPCHDA_SyncRead;
    i: integer;
    sPath: string;
    szItemID: PWideChar;
    ItemIDList: TOleStrList;
    ClientList: OPCHANDLEARRAY;
    pdwCount: DWORD;
    ppdwAttrID: PDWORDARRAY;
    ppszAttrName: POleStrList;
    ppszAttrDesc: POleStrList;
    ppvtAttrDataType: PVarTypeList;
    pphServer: POPCHANDLEARRAY;
    ppErrors: PResultList;
    htStartTime, htEndTime: OPCHDA_TIME;
    dwAttributeIDs: DWORDARRAY;
    dwNumAttributes: DWORD;
    ppAttributeValues: POPCHDA_ATTRIBUTEARRAY;
    AttributeValues: OPCHDA_ATTRIBUTE;
    stDescription, stEngUnits: string;
begin
  result:= '';
  stEngUnits:= '';
  sPath:= GetParentText(Node);
  if sPath = '' then sPath:= ItemName
                else sPath:= sPath + '.' + ItemName;

  try
    OPCHDA_SyncRead:= ServerIfHDA as IOPCHDA_SyncRead;
  except
    on E: Exception do
      begin
        OPCHDA_SyncRead:= nil;
        MessageBox(0, PChar('Ошибка интерфейса IOPCHDA_SyncRead [' + E.Message + ']'),
                   PChar(FormSetupOpcServer.Caption), MB_OK+MB_ICONERROR);
        exit;
      end;
  end;

  if ServerIfHDA.GetItemAttributes(pdwCount, ppdwAttrID, ppszAttrName,
                                   ppszAttrDesc, ppvtAttrDataType) = S_OK then
    begin
      szItemID:= PWideChar(WideString(sPath));
      ItemIDList[0]:= szItemID;
      ClientList[0]:= 111;    //хэндл клиента от болды
      if ServerIfHDA.GetItemHandles(1, @ItemIDList, @ClientList, pphServer,
                                    ppErrors) = S_OK then
        begin
          htStartTime.bString:= true;
          htStartTime.szTime:= 'NOW';
          htStartTime.ftTime.dwHighDateTime:= 0;
          htStartTime.ftTime.dwLowDateTime:= 0;

          htEndTime.bString:= true;
          htEndTime.szTime:= '';
          htEndTime.ftTime.dwHighDateTime:= 0;
          htEndTime.ftTime.dwLowDateTime:= 0;

          dwNumAttributes:= 3;
          dwAttributeIDs[0]:= OPCHDA_DATA_TYPE;
          dwAttributeIDs[1]:= OPCHDA_DESCRIPTION;
          dwAttributeIDs[2]:= OPCHDA_ENG_UNITS;
          if OPCHDA_SyncRead.ReadAttribute(htStartTime, htEndTime, pphServer^[0], dwNumAttributes,
                                           @dwAttributeIDs, ppAttributeValues, ppErrors) = S_OK then
            begin
             for i := 0 to dwNumAttributes - 1 do
              begin
                AttributeValues:= ppAttributeValues^[i];
                case ppAttributeValues^[i].dwAttributeID of
                  OPCHDA_DATA_TYPE: DataTypes:= ppAttributeValues^[i].vAttributeValues^[0];
                  OPCHDA_DESCRIPTION: begin
                    stDescription:= trim(string(ppAttributeValues^[i].vAttributeValues^[0]));
                    if stDescription <> '' then result:= ' - ' + stDescription;
                  end;
                  OPCHDA_ENG_UNITS: begin
                    stEngUnits:= trim(string(ppAttributeValues^[i].vAttributeValues^[0]));
                    if stEngUnits <> '' then result:= result + ' (ед. изм. -  ' + stEngUnits + ')';
                  end;
                end;
              end;

            end;
          CoTaskMemFree(ppAttributeValues);
          ServerIfHDA.ReleaseItemHandles(1, pphServer, ppErrors);
        end;
      CoTaskMemFree(ppdwAttrID);
      CoTaskMemFree(ppszAttrName);
      CoTaskMemFree(ppszAttrDesc);
      CoTaskMemFree(ppvtAttrDataType);
      CoTaskMemFree(pphServer);
    end;
  OPCHDA_SyncRead:= nil;
end;

procedure TFormSetupOpcServer.DisplayChildren(OPCBrowse: IOPCBrowse;
                                              OPCBrowseServerAddressSpace: IOPCBrowseServerAddressSpace);
  var HR: HResult;
      EnumString: IEnumString;
      strName: PWideChar;
      stName: string;
      cnt: LongInt;
      CurBranch, node: TTreeNode;
      DataTypes: TVarType;
begin
  TreeViewBrowseTag.Items.BeginUpdate;
  if OPCBrowse <> nil then exit;     //не реализовано

  if OPCBrowseServerAddressSpace <> nil then
    begin
      HR:= OPCBrowseServerAddressSpace.BrowseOPCItemIDs(OPC_LEAF, '', VT_EMPTY, 0, EnumString);

      while EnumString.Next(1,strName, @cnt) = S_OK do
        begin
          stName:= string(strName) + GetDescriptionDA(string(strName), CurrentBranch, DataTypes);
          node:= TreeViewBrowseTag.Items.AddChild(CurrentBranch, stName);
          if DataTypes = VT_BOOL then node.ImageIndex:= 12
                                 else node.ImageIndex:= 9;
          node.SelectedIndex:= node.ImageIndex;
        end;

      HR:= OPCBrowseServerAddressSpace.BrowseOPCItemIDs(OPC_BRANCH, '', VT_EMPTY, 0, EnumString);
      while EnumString.Next(1,strName, @cnt) = S_OK do
        begin
          CurBranch:= CurrentBranch;
          CurrentBranch:= TreeViewBrowseTag.Items.AddChild(CurrentBranch, string(strName));
          CurrentBranch.ImageIndex:= 8;
          CurrentBranch.SelectedIndex := CurrentBranch.ImageIndex;
          OPCBrowseServerAddressSpace.ChangeBrowsePosition(OPC_BROWSE_DOWN, strName);
          DisplayChildren(nil, OPCBrowseServerAddressSpace);
          OPCBrowseServerAddressSpace.ChangeBrowsePosition(OPC_BROWSE_UP, '');
          CurrentBranch:= CurBranch;
        end;
    end;
  if TreeViewBrowseTag.Items.Count = 0 then
    begin
      node:= TreeViewBrowseTag.Items.Add(nil, 'Тегов не обнаружено');
      node.ImageIndex:= 11;
    end;
  TreeViewBrowseTag.Items.EndUpdate;
end;

procedure TFormSetupOpcServer.DisplayChildrenHDA(OPCHDA_Browser: IOPCHDA_Browser);
  var HR: HResult;
      EnumString: IEnumString;
      strName: PWideChar;
      cnt: LongInt;
      CurBranch, node: TTreeNode;
      DataTypes: TVarType;
      stName: string;
begin
  TreeViewBrowseTag.Items.BeginUpdate;

  if OPCHDA_Browser <> nil then
    begin
      HR:= OPCHDA_Browser.GetEnum(OPCHDA_LEAF, EnumString);
//      HR:= OPCHDA_Browser.GetEnum(OPCHDA_ITEMS, EnumString);

      while EnumString.Next(1,strName, @cnt) = S_OK do
        begin
          stName:= string(strName) + GetDescriptionHDA(string(strName), CurrentBranch, DataTypes);
          node:= TreeViewBrowseTag.Items.AddChild(CurrentBranch, string(stName));
          if DataTypes = VT_BOOL then node.ImageIndex:= 12
                                 else node.ImageIndex:= 9;
          node.SelectedIndex:= node.ImageIndex;
        end;

      HR:= OPCHDA_Browser.GetEnum(OPCHDA_BRANCH, EnumString);
      while EnumString.Next(1,strName, @cnt) = S_OK do
        begin
          CurBranch:= CurrentBranch;
          CurrentBranch:= TreeViewBrowseTag.Items.AddChild(CurrentBranch, string(strName));
          CurrentBranch.ImageIndex:= 8;
          CurrentBranch.SelectedIndex := CurrentBranch.ImageIndex;
          OPCHDA_Browser.ChangeBrowsePosition(OPC_BROWSE_DOWN, strName);
          DisplayChildrenHDA(OPCHDA_Browser);
          OPCHDA_Browser.ChangeBrowsePosition(OPC_BROWSE_UP, '');
          CurrentBranch:= CurBranch;
        end;
    end;
  if TreeViewBrowseTag.Items.Count = 0 then
    begin
      node:= TreeViewBrowseTag.Items.Add(nil, 'Тегов не обнаружено');
      node.ImageIndex:= 11;
    end;
  TreeViewBrowseTag.Items.EndUpdate;
end;

procedure PropertiesServerDA(ServerIf: IOPCServer; ServerName: string);
  var e: TOPCEnum;
      GUID: TGUID;
begin
  FillChar(StatusServerDA, sizeof(StatusServerDA), 0);
  FillChar(PropertiesOPCServer, sizeof(PropertiesOPCServer), 0);
  if ServerIf <> nil then
    try
      if ServerIf.GetStatus(StatusServerDA) = S_OK then
        begin
          PropertiesOPCServer.TypeServer:= OPC_DA_Server;
          PropertiesOPCServer.StartTime:= FileTimeToDateTime(StatusServerDA.ftStartTime);
          PropertiesOPCServer.CurrentTime:= FileTimeToDateTime(StatusServerDA.ftCurrentTime);
          PropertiesOPCServer.LastUpdateTime:= FileTimeToDateTime(StatusServerDA.ftLastUpdateTime);
          case StatusServerDA.dwServerState of
            OPC_STATUS_RUNNING:     PropertiesOPCServer.ServerState:= 'сервер запущен';
            OPC_STATUS_FAILED:      PropertiesOPCServer.ServerState:= 'на сервера ошибка';
            OPC_STATUS_NOCONFIG:    PropertiesOPCServer.ServerState:= 'сервер загружает конфигурационную информацию';
            OPC_STATUS_SUSPENDED:   PropertiesOPCServer.ServerState:= 'сервер приостановлен';
            OPC_STATUS_TEST:        PropertiesOPCServer.ServerState:= 'сервер находится в тестовом режиме';
            OPC_STATUS_COMM_FAULT:  PropertiesOPCServer.ServerState:= 'сервер сбоит';  //  OPC DA 3.0
          end;
          PropertiesOPCServer.MajorVersion:= StatusServerDA.wMajorVersion;
          PropertiesOPCServer.MinorVersion:= StatusServerDA.wMinorVersion;
          PropertiesOPCServer.BuildNumber:= StatusServerDA.wBuildNumber;
          PropertiesOPCServer.VendorInfo:= StatusServerDA.szVendorInfo;
          PropertiesOPCServer.ServerName:= ServerName;
          GUID:= e.CLSIDFromProgID(PChar(ServerName));
          PropertiesOPCServer.GUID:= GUID;
          PropertiesOPCServer.Description:= e.UserTypeFromCLSID(GUID);
          CoTaskMemFree(StatusServerDA);
        end;
      except
        on E: Exception do begin
          ShowMessage('При определении свойств сервера ' + ServerName + ' возникла ошибка: ' + E.Message);
        end;
    end;
end;

procedure PropertiesServerHDA(ServerIf: IOPCHDA_Server; ServerName: string);

  var pwStatus:                   OPCHDA_SERVERSTATUS;
      pftCurrentTime:             PFileTimeArray;
      pftStartTime:               PFileTimeArray;
      pwMajorVersion:             Word;
      pwMinorVersion:             Word;
      pwBuildNumber:              Word;
      pdwMaxReturnValues:         DWORD;
      ppszStatusString:           POleStr;
      ppszVendorInfo:             POleStr;
      e: TOPCEnum;
      GUID: TGUID;
      HR: HResult;

begin
  FillChar(PropertiesOPCServer, sizeof(PropertiesOPCServer), 0);
  if ServerIf <> nil then
    try
      HR:= ServerIf.GetHistorianStatus(pwStatus, pftCurrentTime, pftStartTime,
           pwMajorVersion, pwMinorVersion, pwBuildNumber, pdwMaxReturnValues,
           ppszStatusString, ppszVendorInfo);
      if HR = S_OK then
        begin
          PropertiesOPCServer.TypeServer:= OPC_HDA_Server;
          PropertiesOPCServer.StartTime:= FileTimeToDateTime(pftStartTime[0]);
          PropertiesOPCServer.CurrentTime:= FileTimeToDateTime(pftCurrentTime[0]);;
          case pwStatus of
            OPCHDA_UP:            PropertiesOPCServer.ServerState:= 'сервер запущен';
            OPCHDA_DOWN:          PropertiesOPCServer.ServerState:= 'сервер не запущен';
            OPCHDA_INDETERMINATE: PropertiesOPCServer.ServerState:= ppszStatusString;
          end;
          PropertiesOPCServer.MajorVersion:= pwMajorVersion;
          PropertiesOPCServer.MinorVersion:= pwMinorVersion;
          PropertiesOPCServer.BuildNumber:= pwBuildNumber;
          PropertiesOPCServer.VendorInfo:= ppszVendorInfo;
          PropertiesOPCServer.ServerName:= ServerName;
          GUID:= e.CLSIDFromProgID(PChar(ServerName));
          PropertiesOPCServer.GUID:= GUID;
          PropertiesOPCServer.Description:= e.UserTypeFromCLSID(GUID);
          CoTaskMemFree(pftCurrentTime);
          CoTaskMemFree(pftStartTime);
        end;

      except
        on E: Exception do begin
          ShowMessage('При определении свойств сервера ' + ServerName + ' возникла ошибка: ' + E.Message);
        end;
    end;
end;

procedure TFormSetupOpcServer.ListNodesOPCDAServer(serverName: string);
  var
      OPCBrowseServerAddressSpace: IOPCBrowseServerAddressSpace;
      OPCBrowse: IOPCBrowse;
      EnumString: IEnumString;
      strName: PWideChar;
      NameSpeceType: OPCNAMESPACETYPE;
      sErr, stName: string;
      HR: HResult;
      node: TTreeNode;
      DataTypes: TVarType;
begin
  TreeViewBrowseTag.Items.Clear;
  CurrentBranch:= nil;
  try
    // we will use the custom OPC interfaces, and OPCProxy.dll will handle
    // marshaling for us automatically (if registered)
    ServerIfDA:= CreateComObject(ProgIDToClassID(serverName)) as IOPCServer;
  except
    on E: EOleSysError do
      begin
        ServerIfDA:= nil;
        MessageBox(0, PChar('Ошибка OPC DA сервера ' + serverName + '.' + #10#13 + E.Message),
                   PChar(FormSetupOpcServer.Caption), MB_OK+MB_ICONERROR);
        exit;
      end;
  end;
  sErr:= '';
  if ServerIfDA <> nil then
    begin
      try
        OPCBrowseServerAddressSpace:= ServerIfDA as IOPCBrowseServerAddressSpace;
      except
        on E: Exception do
          begin
            OPCBrowseServerAddressSpace:= nil;
            ServerIfDA:= nil;
            sErr:= 'Ошибка интерфейса OPCBrowseServerAddressSpace [' + E.Message + ']';
          end;
      end;

      if OPCBrowseServerAddressSpace <> nil then
        begin
          if OPCBrowseServerAddressSpace.QueryOrganization(NameSpeceType) = S_OK then
            begin
              case NameSpeceType of
                OPC_NS_FLAT: begin
                              HR:= OPCBrowseServerAddressSpace.BrowseOpcItemIds(OPC_FLAT, '', VT_EMPTY, 0, EnumString);
                              if HR <> S_FALSE then
                                begin
                                  OleCheck(HR);
                                  while EnumString.Next(1, strName, nil) = S_OK do
                                    begin
                                      stName:= string(strName) + GetDescriptionDA(string(strName), CurrentBranch, DataTypes);
                                      node:= TreeViewBrowseTag.Items.AddChild(CurrentBranch, stName);
                                      if DataTypes = VT_BOOL then node.ImageIndex:= 12
                                                             else node.ImageIndex:= 9;
                                      node.SelectedIndex:= node.ImageIndex;
                                    end;
                                end;
                             end;
                OPC_NS_HIERARCHIAL: begin
                                      HR:= OPCBrowseServerAddressSpace.ChangeBrowsePosition(OPC_BROWSE_TO, '');
                                      if HR = E_INVALIDARG then
                                        repeat
                                          HR:= OPCBrowseServerAddressSpace.ChangeBrowsePosition(OPC_BROWSE_UP, '')
                                        until HR <> S_OK
                                      else OleCheck(HR);
                                      DisplayChildren(nil, OPCBrowseServerAddressSpace);
                                    end;
              end;
            end;
        end
        else begin
          try
            OPCBrowse:= ServerIfDA as IOPCBrowse;
          except
            on E: Exception do
              begin
                OPCBrowse:= nil;
                ServerIfDA:= nil;
                if sErr <> '' then sErr:= sErr + #10#13;
                sErr:= sErr + 'Ошибка интерфейса OPCBrowse [' + E.Message + ']';
                MessageBox(0, PChar(sErr), PChar(FormSetupOpcServer.Caption), MB_OK+MB_ICONERROR);
                exit;
              end;
          end;
          if OPCBrowse <> nil then
            begin
              DisplayChildren(OPCBrowse, nil);
            end;
        end;
      PropertiesServerDA(ServerIfDA, serverName);
      ServerIfDA:= nil;
    end
    else begin
//    Writeln('Unable to connect to OPC server');
      Exit;
    end;
end;

procedure TFormSetupOpcServer.ListNodesOPCHDAServer(serverName: string);
  var dwCount:   DWORD;
      pdwAttrID: PDWORDARRAY;
      pOperator: OPCHDA_OPERATORCODES; //POPCHDA_OPERATORCODESARRAY;
      vFilter:   POleVariantArray;
      OPCHDA_Browser: IOPCHDA_Browser;
      ppErrors: PResultList;
      HR: HResult;
      //GetAggregates
      pdwCount:                   DWORD;
      ppdwAggrID:                 PDWORDARRAY;
      ppszAggrName:               POleStrList;
      ppszAggrDesc:               POleStrList;
begin
  TreeViewBrowseTag.Items.Clear;
  CurrentBranch:= nil;
  try
    // we will use the custom OPC interfaces, and OPCProxy.dll will handle
    // marshaling for us automatically (if registered)
    ServerIfHDA:= CreateComObject(ProgIDToClassID(serverName)) as IOPCHDA_Server;
  except
    on E: EOleSysError do
      begin
        ServerIfHDA:= nil;
        MessageBox(0, PChar('Ошибка OPC HDA сервера ' + serverName + '.' + #10#13 + E.Message),
                   PChar(FormSetupOpcServer.Caption), MB_OK+MB_ICONERROR);
        exit;
      end;
  end;
  if ServerIfHDA <> nil then
    begin
      try
//        HR:= ServerIf.GetAggregates(pdwCount, ppdwAggrID, ppszAggrName, ppszAggrDesc);
        dwCount:= 0;
        pdwAttrID:= 0;
        pOperator:= OPCHDA_EQUAL;
        HR:= ServerIfHDA.CreateBrowse(dwCount, @pdwAttrID, pOperator, @vFilter,
                                   OPCHDA_Browser, ppErrors);
      except
        on E: Exception do
          begin
            OPCHDA_Browser:= nil;
            ServerIfHDA:= nil;
            MessageBox(0, PChar('Ошибка интерфейса IOPCHDA_Browser.' + #10#13 + E.Message),
                   PChar(FormSetupOpcServer.Caption), MB_OK+MB_ICONERROR);
          end;
      end;
      if HR = S_OK then
        begin
          //переходим в корень
          OPCHDA_Browser.ChangeBrowsePosition(OPCHDA_BROWSE_DIRECT, '');
          DisplayChildrenHDA(OPCHDA_Browser);
        end;
      PropertiesServerHDA(ServerIfHDA, serverName);
      ServerIfHDA:= nil;
    end
    else begin
      //ошибка
      exit
    end;
end;

procedure TFormSetupOpcServer.N1Click(Sender: TObject);
begin
  FormPropertiesOPCServer.ShowModal;
end;

procedure TFormSetupOpcServer.ToolButton3Click(Sender: TObject);
begin
  with TreeViewBrowseTag do
   begin
      Items.BeginUpdate;
      FullExpand;
      Items.EndUpdate;
   end;
end;

procedure TFormSetupOpcServer.ToolButton4Click(Sender: TObject);
begin
  with TreeViewBrowseTag do
   begin
      Items.BeginUpdate;
      FullCollapse;
      Items.EndUpdate;
   end;
end;

procedure TFormSetupOpcServer.ToolButtonDeleteOPCServerClick(Sender: TObject);
  var Node: TTreeNode;
      hProcess: THandle;
      sel: integer;
      DelOk: boolean;
      ServerName: string;
begin
  Node:= TreeViewOPCServer.Selected;
  sel:= TreeViewOPCServer.Selected.Index;
  ServerName:= Trim(Node.Text);
  if Application.MessageBox(PChar('Удалить OPC-сервер "' + ServerName + '" ?'),
                             PChar(ProgName_ShortStringVersion + ' ВНИМАНИЕ !!!'),
                             MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      DelOk:= true;
      if TreeViewOPCServer.Items.Item[sel].Data = pointer(OPC_DA_Server) then
        begin
          if FileExists(PathFileNameOPCDAServer) then
            begin
//          if DM.RunAsAdmin(Handle, PathFileNameOPCServer, Trim(Node.Text) + ' ' +
//                                              GUIDToString(CLASS_DA3) +
//                                              ' /unregserver', hProcess) then
              if DM.RunAsAdmin(Handle, PathFileNameOPCDAServer, ' /unregserver /OPC_DA', hProcess) then
                begin
                  if hProcess <> 0 then
                    if WaitForSingleObject(hProcess, 5000) <> WAIT_OBJECT_0 then
                      begin
                        CloseHandle(hProcess);
                        Application.MessageBox(PChar('Не удалось удалить OPC-сервер "' + ServerName +
                          '". Истекло время ожидания на удаление сервера.'), 'Ошибка', MB_OK or MB_ICONERROR);
                        DelOk:= false;
                      end;
                end
                else begin
                  DM.log('Ошибка удаления OPC-сервера "' + ServerName + '"', 0);
                  DelOk:= false;
                end;
            end
            else begin
              Application.MessageBox(PChar('Файл "' + PathFileNameOPCDAServer +
                '" не найден. Удалить OPC сервер "' + ServerName + '" невозможно.'),
                'Ошибка', MB_OK or MB_ICONERROR);
              exit;
            end;
        end;

      if TreeViewOPCServer.Items.Item[sel].Data = pointer(OPC_HDA_Server) then
        begin
          if FileExists(PathFileNameOPCHDAServer) then
            begin
              if DM.RunAsAdmin(Handle, PathFileNameOPCHDAServer, ' /unregserver /OPC_HDA', hProcess) then
                begin
                  if hProcess <> 0 then
                    if WaitForSingleObject(hProcess, 5000) <> WAIT_OBJECT_0 then
                      begin
                        CloseHandle(hProcess);
                        Application.MessageBox(PChar('Не удалось удалить OPC-сервер "' + ServerName +
                          '". Истекло время ожидания на удаление сервера.'), 'Ошибка', MB_OK or MB_ICONERROR);
                        DelOk:= false;
                      end;
                end
                else begin
                  DM.log('Ошибка удаления OPC-сервера "' + ServerName + '"', 0);
                  DelOk:= false;
                end;
            end
            else begin
              Application.MessageBox(PChar('Файл "' + PathFileNameOPCHDAServer +
                '" не найден. Удалить OPC сервер "' + ServerName + '" невозможно.'),
                'Ошибка', MB_OK or MB_ICONERROR);
              exit;
            end;
        end;
      ToolButtonRefreshListOPCServersClick(Sender);
      if DelOk then
        Application.MessageBox(PChar('OPC-сервер "' + ServerName + '" успешно удален.'),
                PChar(Caption), MB_OK or MB_ICONINFORMATION);
    end;
  FormSettingsWorkStation.ReadOPCServerName;
end;

procedure TFormSetupOpcServer.ToolButtonRefreshListOPCServersClick(
  Sender: TObject);
begin
  RadioButtonAllOPCServerClick(Sender);
end;

procedure TFormSetupOpcServer.TreeViewOPCServerChange(Sender: TObject;
  Node: TTreeNode);
  var e: TOPCEnum;
      ProgID: string;
      GUID: TGUID;
begin
  ProgID:= Node.Text;
  EditServerName.Text:= ProgID;
  GUID:= e.CLSIDFromProgID(PChar(ProgID));
  EnabledDisabledButton((GUID = GUID_RudaOPCDA) or (GUID = GUID_RudaOPCHDA));
  EditGUID.Text:= GUIDtoString(GUID);
  EditUserType.Text:= e.UserTypeFromCLSID(GUID);
  TreeViewBrowseTag.Items.Clear;
end;

procedure TFormSetupOpcServer.TreeViewOPCServerClick(Sender: TObject);
  var sel: integer;
begin
  if TreeViewOPCServer.Items.Count > 0 then
    begin
      Screen.Cursor:= crHourGlass;
      if TreeViewOPCServer.Selected = nil then exit
                                          else sel:= TreeViewOPCServer.Selected.Index;
      ServerName:= TreeViewOPCServer.Items.Item[sel].Text;
      if TreeViewOPCServer.Items.Item[sel].Data = pointer(OPC_DA_Server) then ListNodesOPCDAServer(serverName);
      if TreeViewOPCServer.Items.Item[sel].Data = pointer(OPC_HDA_Server) then ListNodesOPCHDAServer(serverName);
      Screen.Cursor:= crDefault;
    end
    else exit;
end;

procedure TFormSetupOpcServer.TreeViewOPCServerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (TreeViewOPCServer.Items.Count > 0) and
     (Button = mbRight) then
    TreeViewOPCServer.PopupMenu:= PopupMenu1
    else TreeViewOPCServer.PopupMenu:= nil;
end;

procedure TFormSetupOpcServer.ReadListOPCServer(all: boolean);
  var ListOPCServer, ListUserType: TStrings;
      i: integer;
      e: TOPCEnum;
      sTemp: AnsiString;
      Node: TTreeNode;
begin
  TreeViewOPCServer.Items.Clear;
  ListOPCServer:= TStringList.Create;
  ListUserType:= TStringList.Create;
  ClearInfoOPCServer;
  try
    //ищем OPC DA сервера
    if CheckBoxOPCServerDA.Checked then
      begin
        ListOPCServer.Clear;
        ListUserType.Clear;
        if all then   //ищем все OPC серверы
          begin
            e.Enum(ListOPCServer, ListUserType, OPC_DA);
          end
          else begin //ищем только OPC серверы для RUDA
            if e.ProgIDFromCLSID(GUID_RudaOPCDA, sTemp) = s_OK then ListOPCServer.Add(sTemp);
          end;
        if ListOPCServer.Count > 0 then
          begin
            for i := 0 to ListOPCServer.Count - 1 do
              begin
                node:= TreeViewOPCServer.Items.Add(nil, ListOPCServer.Strings[i]);
                node.ImageIndex:= 5;
                node.SelectedIndex:= Node.ImageIndex;
                node.Data:= pointer(OPC_DA_Server);      //вопрос с освобождением памяти
              end;
          end;
      end;

    //ищем OPC HDA сервера
    if CheckBoxOPCServerHDA.Checked then
      begin
        ListOPCServer.Clear;
        ListUserType.Clear;
        if all then   //ищем все OPC серверы
          begin
            e.Enum(ListOPCServer, ListUserType, OPC_HDA);
          end
          else begin //ищем только OPC серверы для RUDA
            if e.ProgIDFromCLSID(GUID_RudaOPCHDA, sTemp) = s_OK then ListOPCServer.Add(sTemp);
          end;
        if ListOPCServer.Count > 0 then
          begin
            for i := 0 to ListOPCServer.Count - 1 do
              begin
                node:= TreeViewOPCServer.Items.Add(nil, ListOPCServer.Strings[i]);
                node.ImageIndex:= 10;
                node.SelectedIndex:= Node.ImageIndex;
                node.Data:= pointer(OPC_HDA_Server);    //вопрос с освобождением памяти
              end;
          end;
      end;
      if TreeViewOPCServer.Items.Count > 0 then
        begin
          TreeViewOPCServer.SetFocus;
          TreeViewOPCServer.Items.Item[0].Selected:= true;      //ставим на первую позицию
        end
        else EnabledDisabledButton(false);

      CreateNewOPCserver.Enabled:= not ((e.ProgIDFromCLSID(GUID_RudaOPCDA, sTemp) = s_OK) and (e.ProgIDFromCLSID(GUID_RudaOPCHDA, sTemp) = s_OK));
  finally
    ListUserType.Free;
    ListOPCServer.Free;
  end;
end;

procedure TFormSetupOpcServer.EnabledDisabledButton(param: boolean);
begin
  ToolButtonDeleteOPCServer.Enabled:= param;
//  ToolButtonConnectOPCServer.Enabled:= param;
//  ToolButtonDisconnectOPCServer.Enabled:= param;
end;

procedure TFormSetupOpcServer.CheckBoxOPCServerDAClick(Sender: TObject);
begin
  WriteToRegVariant(RootKey_HKCU, SubKey, 'OPC', 'OPCServerDA', CheckBoxOPCServerDA.Checked);
  if not FirstStart then ReadListOPCServer(RadioButtonAllOPCServer.Checked);
end;

procedure TFormSetupOpcServer.CheckBoxOPCServerHDAClick(Sender: TObject);
begin
  WriteToRegVariant(RootKey_HKCU, SubKey, 'OPC', 'OPCServerHDA', CheckBoxOPCServerHDA.Checked);
  if not FirstStart then ReadListOPCServer(RadioButtonAllOPCServer.Checked);
end;

procedure TFormSetupOpcServer.ClearInfoOPCServer;
begin
  EditServerName.Clear;
  EditUserType.Clear;
  EditGUID.Clear;
  TreeViewBrowseTag.Items.Clear;
end;

procedure TFormSetupOpcServer.FormShow(Sender: TObject);
begin
  FirstStart:= true;
  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'OPC', 'OPCServerDA', asBoolean, ParamVariant)
    then CheckBoxOPCServerDA.Checked:= ParamVariant
    else CheckBoxOPCServerDA.Checked:= true;
  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'OPC', 'OPCServerHDA', asBoolean, ParamVariant)
    then CheckBoxOPCServerHDA.Checked:= ParamVariant
    else CheckBoxOPCServerHDA.Checked:= true;
  ReadFromRegVariant(RootKey_HKCU, SubKey, 'OPC', 'ViewOPCServer', asBoolean, ParamVariant);
  RadioButtonAllOPCServer.Checked:= ParamVariant;
  RadioButtonSCRPOPCServer.Checked:= not ParamVariant;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Path', 'RudaMonitor', asString, ParamVariant)
        then PathFileNameOPCDAServer:= ParamVariant
        else PathFileNameOPCDAServer:= PathApp + FileNameOPCServer;

  if ReadFromRegVariant(RootKey_HKCU, SubKey, 'Path', 'OPCHDAServer', asString, ParamVariant)
        then PathFileNameOPCHDAServer:= ParamVariant
        else PathFileNameOPCHDAServer:= PathApp + FileNameOPCHDAServer;

  FirstStart:= false;
  RadioButtonAllOPCServerClick(Sender);
end;

end.
