unit EnumSerialPorts;
{
  Модуль перечисления последовательных портов.
  Используется WMI, берется минимальная информация.
  $Author: Roman $
  $Date:: 2012-02-21 15:37:00#$
}

interface

uses SysUtils, Generics.Collections, ActiveX;

type
  TSerialPortInfo = record
    Caption: string;
    DeviceID: string;
//    MaxBaudRate: cardinal;
//    ProviderType: string;
  end;

  TSerialPortEnum = class(TEnumerable<TSerialPortInfo>)
  strict private
    FWMIService: Variant;
  protected
    function DoGetEnumerator: TEnumerator<TSerialPortInfo>; override;
    type
      TPortEnum = class(TEnumerator<TSerialPortInfo>)
      strict private
        FEnum: IEnumVARIANT;
        FCurrentElem: OleVariant;
      protected
        function DoGetCurrent: TSerialPortInfo; override;
        function DoMoveNext: Boolean; override;
      public
        constructor Create(Enum: IEnumVariant);
        destructor Destroy; override;
      end;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses COMObj, Variants;

//стандартные флаги для запроса
const
  wbemFlagForwardOnly = $20;
  wbemFlagBidirectional = $0;
  wbemFlagReturnImmediately = $10;
  wbemFlagReturnWhenComplete = $0;
  wbemQueryFlagPrototype = $2;
  wbemFlagUseAmendedQualifiers = $20000;

function GetVariantEnumerator(obj: Variant): IEnumVariant;
var
  Enum: IUnknown;
begin
  Enum := obj._NewEnum;
  OleCheck(Enum.QueryInterface(IEnumVariant, Result));
end;

function GetObject(const ObjName: WideString): Variant;
var
  Temp: IDispatch;
begin
  OleCheck(CoGetObject(PWideChar(ObjName), nil, IDispatch, @Temp));  //[dcc32 Error] EnumSerialPorts.pas(68): E2010 Incompatible types: 'PWideChar' and 'PWideString'
  Result := Temp;
end;

{ TSerialPortList }
const
  strMonName: WideString = 'winmgmts:\\.\root\CIMV2';
  strQueryList: WideString =  'SELECT * FROM Win32_PnPEntity WHERE ClassGuid = ''{4d36e978-e325-11ce-bfc1-08002be10318}''';

constructor TSerialPortEnum.Create;
begin
  inherited;
  FWMIService := GetObject(strMonName);
end;

destructor TSerialPortEnum.Destroy;
begin
  FWMIService := Unassigned;
  inherited;
end;

function TSerialPortEnum.DoGetEnumerator: TEnumerator<TSerialPortInfo>;
var
  Items: OleVariant;
begin
  Items := FWMIService.ExecQuery(strQueryList, 'WQL', wbemFlagForwardOnly);   //wbemFlagForwardOnly
  Result := TPortEnum.Create(GetVariantEnumerator(Items));
end;

{ TSerialPortList.TPortEnum }

constructor TSerialPortEnum.TPortEnum.Create(Enum: IEnumVariant);
begin
  inherited Create;
  FEnum := Enum;
end;

destructor TSerialPortEnum.TPortEnum.Destroy;
begin
  FEnum := nil;
  inherited;
end;

function TSerialPortEnum.TPortEnum.DoGetCurrent: TSerialPortInfo;
begin
  Result.Caption := FCurrentElem.Caption;
  Result.DeviceID := FCurrentElem.DeviceID;
//  Result.MaxBaudRate := FCurrentElem.MaxBaudRate;
//  Result.ProviderType := FCurrentElem.ProviderType;
end;

function TSerialPortEnum.TPortEnum.DoMoveNext: Boolean;
var
  Fetched: Cardinal;
begin
  Result := (FEnum.Next(1, FCurrentElem, Fetched) = S_OK);
end;

end.
