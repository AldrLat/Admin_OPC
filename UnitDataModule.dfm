object FormDataModule: TFormDataModule
  OldCreateOrder = False
  Height = 615
  Width = 354
  object ADOConnectionAccessMDB: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\!Sasha\My_Projec' +
      't\SCRP\Admin\Win32\Debug\RudaData\Access.mdb;Persist Security In' +
      'fo=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 80
  end
  object ADOQueryAccessMDB: TADOQuery
    Connection = ADOConnectionAccessMDB
    ParamCheck = False
    Parameters = <>
    Left = 192
    Top = 80
  end
  object ADOConnectionDataMDB: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\My_Project\SCRP\' +
      'Admin\Win32\Debug\RudaData\Data.mdb;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 128
  end
  object ADOQueryDataMDB: TADOQuery
    Connection = ADOConnectionDataMDB
    ParamCheck = False
    Parameters = <>
    Left = 192
    Top = 128
  end
  object ADOConnectionServerMDB: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\!S' +
      'asha\My_Project\SCRP\Admin\Win32\Debug\RudaData\Server.mdb;Mode=' +
      'Share Deny None;Persist Security Info=False;Jet OLEDB:System dat' +
      'abase="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password=' +
      '"";Jet OLEDB:Engine Type=4;Jet OLEDB:Database Locking Mode=0;Jet' +
      ' OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transacti' +
      'ons=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create System' +
      ' Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't' +
      ' Copy Locale on Compact=False;Jet OLEDB:Compact Without Replica ' +
      'Repair=False;Jet OLEDB:SFP=False;'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 176
  end
  object ADOQueryServerMDB: TADOQuery
    Connection = ADOConnectionServerMDB
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM USERS')
    Left = 192
    Top = 176
  end
  object ADOConnectionWorkStationMDB: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 232
  end
  object ADOQueryWorkStationMDB: TADOQuery
    Connection = ADOConnectionWorkStationMDB
    ParamCheck = False
    Parameters = <>
    Left = 192
    Top = 232
  end
  object DataSourceAccessMDB: TDataSource
    DataSet = ADOQueryAccessMDB
    Left = 48
    Top = 296
  end
  object DataSourceDataMDB: TDataSource
    DataSet = ADOQueryDataMDB
    Left = 48
    Top = 352
  end
  object DataSourceServerMDB: TDataSource
    DataSet = ADOQueryServerMDB
    Left = 48
    Top = 408
  end
  object DataSourceWorkStationMDB: TDataSource
    DataSet = ADOQueryWorkStationMDB
    Left = 48
    Top = 464
  end
end
