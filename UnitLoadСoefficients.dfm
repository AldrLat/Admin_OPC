object FormLoadСoefficients: TFormLoadСoefficients
  Left = 0
  Top = 0
  Caption = #1057#1086#1093#1088#1072#1085#1077#1085#1085#1099#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
  ClientHeight = 282
  ClientWidth = 724
  Color = clBtnFace
  Constraints.MinHeight = 320
  Constraints.MinWidth = 740
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    000001002000000000000004000000000000000000000000000000000000FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00105B3FFF105B3FFF9DC4B3FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF009DC4B3FF146043FFFFFFFF00747474FF747474FF747474FF7474
    74FF747474FF747474FF747474FF747474FF747474FFFFFFFF00FFFFFF00FFFF
    FF00FFFFFF00196548FF9DC4B3FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF001F6B4DFF1F6B4DFF1F6B4DFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF002B7858FF2B7858FF2B7858FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF009DC4B3FF317F5EFF9DC4B3FFFFFFFF008C8C8CFF8C8C8CFF8C8C8CFF8C8C
    8CFF8C8C8CFF8C8C8CFF8C8C8CFF8C8C8CFF8C8C8CFFFFFFFF00FFFFFF00FFFF
    FF00FFFFFF009DC4B3FF378664FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF003D8C69FF3D8C69FF9DC4B3FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00499974FF499974FF499974FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF004E9E79FFFFFFFF00FFFFFF00A1A1A1FFA1A1A1FFA1A1A1FFA1A1
    A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFFFFFFF00FFFFFF00FFFF
    FF0052A37DFF52A37DFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF009DC4B3FF56A780FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    00008FFF0000C8030000CFFF00008FFF0000FFFF00008FFF000088030000CFFF
    00008FFF0000FFFF00008FFF0000D80300009FFF00009FFF0000FFFF0000}
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    724
    282)
  TextHeight = 15
  object DBGridLoadСoefficients: TDBGrid
    Left = 8
    Top = 8
    Width = 708
    Height = 209
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSourceLoadСoefficients
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = DBGridLoadСoefficientsDrawColumnCell
    Columns = <
      item
        Expanded = False
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'N '#1087'/'#1087
        Width = 40
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Res_Date'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_Name'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K1'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K1'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K2'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K2'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K3'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K3'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K4'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K4'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K5'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K5'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K6'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K6'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K7'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K7'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K8'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K8'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K9'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K9'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K10'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K10'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K11'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K11'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K12'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K12'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K13'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K13'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_K14'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'K14'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Res_Order'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CfRes_Code'
        Visible = False
      end>
  end
  object ButtonLoad: TButton
    Left = 181
    Top = 238
    Width = 75
    Height = 25
    Anchors = []
    Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
    TabOrder = 1
    OnClick = ButtonLoadClick
  end
  object ButtonDelete: TButton
    Left = 325
    Top = 238
    Width = 75
    Height = 25
    Anchors = []
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 2
    OnClick = ButtonDeleteClick
  end
  object ButtonClose: TButton
    Left = 469
    Top = 238
    Width = 75
    Height = 25
    Anchors = []
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = ButtonCloseClick
  end
  object ADOQueryLoadСoefficients: TADOQuery
    Connection = DM.ADOConnectionWorkStationMDB
    CursorType = ctStatic
    AfterScroll = ADOQueryLoadСoefficientsAfterScroll
    DataSource = DM.DataSourceWorkStationMDB
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM CfReserveCopyCoefficients')
    Left = 184
    Top = 64
  end
  object DataSourceLoadСoefficients: TDataSource
    DataSet = ADOQueryLoadСoefficients
    Left = 408
    Top = 64
  end
end
