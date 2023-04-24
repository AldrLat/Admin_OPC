object DM: TDM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 650
  Width = 485
  object DataSourceServerMDB: TDataSource
    DataSet = ADOQueryServerMDB
    Left = 392
    Top = 144
  end
  object ADOConnectionServerMDB: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'MSDASQL.1'
    Left = 64
    Top = 144
  end
  object ADOQueryServerMDB: TADOQuery
    Connection = ADOConnectionServerMDB
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'UPDATE ControlParam SET Cp_Name = "nono"  WHERE Cp_Code = 6')
    Left = 232
    Top = 144
  end
  object ADOConnectionAccessMDB: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'MSDASQL.1'
    Left = 64
    Top = 16
  end
  object ADOQueryAccessMDB: TADOQuery
    Connection = ADOConnectionAccessMDB
    ParamCheck = False
    Parameters = <>
    Left = 232
    Top = 16
  end
  object DataSourceAccessMDB: TDataSource
    DataSet = ADOQueryAccessMDB
    Left = 392
    Top = 16
  end
  object ADOConnectionDataMDB: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 64
    Top = 80
  end
  object ADOQueryDataMDB: TADOQuery
    Connection = ADOConnectionDataMDB
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM M1')
    Left = 232
    Top = 80
  end
  object DataSourceDataMDB: TDataSource
    DataSet = ADOQueryDataMDB
    Left = 392
    Top = 80
  end
  object ADOConnectionWorkStationMDB: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 64
    Top = 208
  end
  object ADOQueryWorkStationMDB: TADOQuery
    Connection = ADOConnectionWorkStationMDB
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <
      item
        Name = 'param1'
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = 'param2'
        DataType = ftDateTime
        Value = Null
      end>
    SQL.Strings = (
      'Select * FROM C1 WHERE '
      '                (C_Date >= :BeginDate) AND (C_Date < :EndDate) '
      '                AND (C_Yes = true) ORDER BY C_Date')
    Left = 232
    Top = 208
  end
  object DataSourceWorkStationMDB: TDataSource
    DataSet = ADOQueryWorkStationMDB
    Left = 392
    Top = 208
  end
  object ADOConnectionDataWSMDB: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 64
    Top = 272
  end
  object ADOQueryDataWSMDB: TADOQuery
    Connection = ADOConnectionDataWSMDB
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM M1')
    Left = 232
    Top = 272
  end
  object DataSourceDataWSMDB: TDataSource
    DataSet = ADOQueryDataWSMDB
    Left = 392
    Top = 272
  end
  object ADOQueryTempWS: TADOQuery
    Connection = ADOConnectionWorkStationMDB
    Parameters = <>
    Left = 232
    Top = 344
  end
  object DataSourceTempWS: TDataSource
    DataSet = ADOQueryTempWS
    Left = 392
    Top = 344
  end
  object ADOCommandWS: TADOCommand
    Connection = ADOConnectionWorkStationMDB
    Parameters = <>
    Left = 56
    Top = 472
  end
  object ADOCommandServer: TADOCommand
    Connection = ADOConnectionServerMDB
    Parameters = <>
    Left = 56
    Top = 576
  end
  object ADODataSetWS: TADODataSet
    Connection = ADOConnectionWorkStationMDB
    Parameters = <>
    Left = 56
    Top = 416
  end
  object DataSourceDataSetWS: TDataSource
    DataSet = ADODataSetWS
    Left = 176
    Top = 416
  end
  object ADOConnectionNetSQL: TADOConnection
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 400
    Top = 584
  end
  object PrintDialog1: TPrintDialog
    Left = 280
    Top = 536
  end
  object ADODataSetServer: TADODataSet
    Connection = ADOConnectionServerMDB
    Parameters = <>
    Left = 56
    Top = 528
  end
  object DataSourceDataSetServer: TDataSource
    DataSet = ADODataSetServer
    Left = 176
    Top = 528
  end
end
