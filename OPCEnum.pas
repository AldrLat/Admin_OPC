unit OPCEnum;

interface

type
  TOPCServerType = (OPC_DA10 = 0x0001, OPC_DA20 = 0x0002, OPC_DA30 = 0x0004,
      OPC_XMLDA10 = 0x0008, OPC_DX10 = 0x0010, OPC_AE10 = 0x0020,
      OPC_DA = OPC_DA10 | OPC_DA20 | OPC_DA30,
      OPC_XMLDA = OPC_XMLDA10,
      OPC_DX = OPC_DX10,
      OPC_AE = OPC_AE10,
      OPC_ALL = OPC_DA | OPC_XMLDA | OPC_DX | OPC_AE
    );

implementation

end.
