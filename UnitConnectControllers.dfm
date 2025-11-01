object FormConnectControllers: TFormConnectControllers
  Left = 0
  Top = 0
  HelpContext = 42
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = ' '#1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1082#1086#1085#1090#1088#1086#1083#1083#1077#1088#1086#1074
  ClientHeight = 650
  ClientWidth = 899
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    000001002000000000000004000000000000000000000000000000000000FFFF
    FF00000000230000003300000033000000330000003300000033000000330000
    0033000000220000000000000000000000000000000000000000FFFFFF00FFFF
    FF008B7964C096816AFF957F66FFB8AFA6FF717376FF918170FF988671FF9685
    73FF86796BBB0000003300000000000000000000000000000000FFFFFF00FFFF
    FF0098846CFFD5CAB7FFD1C5AFFF818488FFCCCDD0FF6B737DFFBD833CFFBA82
    3FFFB98341FFB98444FF00000033000000000000000000000000FFFFFF00FFFF
    FF0098836DFFD7CDBAFFDECBB8FFD2C6B0FF7E8690FFB97F37FFFAC173FFF3BA
    6CFFF0B665FFE5B56DFFB78344FF000000330000000000000000FFFFFF00FFFF
    FF009A856DFFDAD0C0FFCEC2AFFFD1C6B5FFB77C34FFF4C98EFFF7C078FFF2BB
    70FFEBBF81FFB17D3FFFEFB35DFFBA8443FF0000000000000000FFFFFF00FFFF
    FF009A856FFFDFD7C6FFD1C5B2FFD2C9BAFFB47A35FFF8D19DFFF8C27DFFF2CB
    94FFAF7A3BFFF4BA6BFFDEAC63DDBD833CFF0000003300000000FFFFFF00FFFF
    FF009C8771FFE4DBCEFFB9A28AFFBAA692FFB37A34FFFFDBAEFFFBD7A7FFAD78
    37FFF9C37BFFE6BA7BDFB87F3BFFC2C6CFFF717478FF00000033FFFFFF00FFFF
    FF009D8871FFE6DFD3FFF0DFD0FFF1E3D8FFB37931FFFFE8C0FFAD7734FFFFCC
    88FFE9C493FFB7803EFF00000000848A91FFD2D1CFFF717272FFFFFFFF00FFFF
    FF009F8A73FFEBE5D9FFB7A087FFB8A38CFFB9A693FFB17831FFFFD79AFFFFDE
    B5FFB67D37FF000000330000000000000000868788FFD5D3D2FFFFFFFF00FFFF
    FF00A08A75FFEEE8DFFFEEDECEFFEFDFD1FFF0E1D4FFF0E4DAFFB37930FFB57A
    30FFBEC2CBFF6D7279FF00000033000000000000000000000000FFFFFF00FFFF
    FF00A28C75FFF2ECE4FFB69E85FFB7A087FFB7A189FFB8A28BFFB8A38DFFF5F1
    EAFF7F8388FFD0CFCEFF707172FF000000000000000000000000FFFFFF00FFFF
    FF00A28D77FFF5F0E8FFECDACAFFECDBCCFFEDDCCCFFEDDCCCFFEDDBCCFFF6F1
    E9FFA48D74FF838587FFD5D3D2FF000000000000000000000000FFFFFF00FFFF
    FF00A58F79FFF8F3ECFFDACAB6FFD9CAB6FFDACAB7FFD9CAB6FFDACAB6FFF8F3
    ECFFA68F77FF0000000000000000000000000000000000000000FFFFFF00FFFF
    FF00A6917BFFFCF9F3FFF8F3EFFFF8F2EEFFF8F2EEFFF8F2EEFFF8F3EFFFFCF9
    F3FFA7917AFF0000000000000000000000000000000000000000FFFFFF00FFFF
    FF00AB9780ACC5B5A0FFD9CBB7FFD8CAB6FFD8CAB5FFD8CAB6FFD9CBB7FFC5B5
    A0FFAB967FAC0000000000000000000000000000000000000000FFFFFF00FFFF
    FF0000000000AC9883ACAC9782FFAB9781FFAB9781FFAB9781FFAC9782FFAC98
    83AC000000000000000000000000000000000000000000000000FFFFFF00803F
    0000801F0000800F000080070000800700008003000080010000801100008019
    0000800F0000800F0000800F0000803F0000803F0000803F0000C07F0000}
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMain: TPanel
    Left = 433
    Top = 49
    Width = 466
    Height = 601
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 14
      Top = 6
      Width = 443
      Height = 547
      Caption = ' '#1050#1086#1085#1090#1088#1086#1083#1083#1077#1088' '#1074' '#1089#1080#1089#1090#1077#1084#1077' '
      TabOrder = 0
      object Label1: TLabel
        Left = 118
        Top = 56
        Width = 65
        Height = 13
        Caption = #1050#1086#1085#1090#1088#1086#1083#1083#1077#1088':'
      end
      object Label6: TLabel
        Left = 117
        Top = 89
        Width = 66
        Height = 13
        Caption = #1051#1080#1085#1080#1103' '#1089#1074#1103#1079#1080':'
      end
      object LabelNumCh: TLabel
        Left = 32
        Top = 122
        Width = 151
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1050#1072#1085#1072#1083' / '#1040#1076#1088#1077#1089' '#1082#1086#1085#1090#1088#1086#1083#1083#1077#1088#1072':'
      end
      object Label2: TLabel
        Left = 10
        Top = 24
        Width = 173
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1086#1085#1090#1088#1086#1083#1083#1077#1088#1072' '#1074' '#1089#1080#1089#1090#1077#1084#1077':'
      end
      object ComboBoxControllersList: TComboBox
        Left = 184
        Top = 53
        Width = 249
        Height = 22
        HelpContext = 42
        Style = csOwnerDrawFixed
        TabOrder = 0
        OnChange = ComboBoxControllersListChange
      end
      object comboBoxLineConnection: TComboBox
        Left = 184
        Top = 86
        Width = 249
        Height = 22
        Style = csOwnerDrawFixed
        Sorted = True
        TabOrder = 1
        OnChange = comboBoxLineConnectionChange
      end
      object SpinEditNumCh: TSpinEdit
        Left = 184
        Top = 119
        Width = 51
        Height = 22
        HelpContext = 42
        TabStop = False
        MaxLength = 1
        MaxValue = 8
        MinValue = 1
        TabOrder = 2
        Value = 1
        OnChange = SpinEditNumChChange
        OnKeyPress = SpinEditNumChKeyPress
      end
      object EditСontrollerNameInSystem: TEdit
        Left = 184
        Top = 21
        Width = 249
        Height = 21
        HelpContext = 45
        MaxLength = 50
        TabOrder = 3
        Text = 'Edit'#1057'ontrollerNameInSystem'
        OnKeyPress = EditСontrollerNameInSystemKeyPress
      end
      object PageControl1: TPageControl
        Left = 10
        Top = 152
        Width = 423
        Height = 385
        ActivePage = TabSheetDataController
        TabOrder = 4
        OnChange = PageControl1Change
        object TabSheet1: TTabSheet
          Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1082#1086#1085#1090#1088#1086#1083#1083#1077#1088#1072
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object StringGridParamControllers: TStringGrid
            Left = 0
            Top = 0
            Width = 415
            Height = 357
            HelpContext = 42
            Align = alClient
            ColCount = 2
            Enabled = False
            RowCount = 6
            ScrollBars = ssNone
            TabOrder = 0
            OnDrawCell = StringGridParamControllersDrawCell
            ColWidths = (
              64
              64)
            RowHeights = (
              24
              24
              24
              24
              24
              24)
          end
        end
        object TabSheet2: TTabSheet
          Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1083#1080#1085#1080#1080' '#1089#1074#1103#1079#1080
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object StringGridParamLineConnection: TStringGrid
            Left = 0
            Top = 0
            Width = 415
            Height = 357
            HelpContext = 42
            Align = alClient
            ColCount = 2
            Enabled = False
            RowCount = 6
            ScrollBars = ssNone
            TabOrder = 0
            OnDrawCell = StringGridParamLineConnectionDrawCell
            ColWidths = (
              64
              64)
            RowHeights = (
              24
              24
              24
              24
              24
              24)
          end
        end
        object TabSheetDataController: TTabSheet
          Caption = #1044#1072#1085#1085#1099#1077' '#1082#1086#1085#1090#1088#1086#1083#1083#1077#1088#1072
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Label5: TLabel
            Left = 40
            Top = 41
            Width = 195
            Height = 13
            Caption = #1054#1073#1097#1077#1077' '#1074#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099' '#1082#1086#1085#1090#1088#1086#1083#1083#1077#1088#1072', '#1095':'
          end
          object Label7: TLabel
            Left = 34
            Top = 14
            Width = 201
            Height = 13
            Caption = #1042#1088#1077#1084#1103' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1076#1072#1085#1085#1099#1093':'
          end
          object LabelErrDataController: TLabel
            Left = 16
            Top = 310
            Width = 385
            Height = 16
            AutoSize = False
            Caption = 'LabelErrDataController'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelStatusRequest: TLabel
            Left = 16
            Top = 286
            Width = 96
            Height = 13
            Caption = 'LabelStatusRequest'
          end
          object EditTotalWorkTime: TEdit
            Left = 241
            Top = 38
            Width = 136
            Height = 21
            Alignment = taRightJustify
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 0
            Text = '25'
          end
          object ButtonRefreshDataController: TButton
            Left = 300
            Top = 329
            Width = 112
            Height = 25
            Caption = #1057#1095#1080#1090#1072#1090#1100' '#1076#1072#1085#1085#1099#1077
            TabOrder = 1
            OnClick = ButtonRefreshDataControllerClick
          end
          object EditDateTimeLastData: TEdit
            Left = 241
            Top = 11
            Width = 136
            Height = 21
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 2
            Text = '25'
          end
          object GroupBox2: TGroupBox
            Left = 11
            Top = 71
            Width = 390
            Height = 88
            Caption = ' '#1044#1072#1085#1085#1099#1077' '#1087#1086' '#1086#1073#1084#1077#1085#1091' '#1086#1090' '#1082#1086#1085#1090#1088#1086#1083#1083#1077#1088#1072' '
            TabOrder = 3
            object Label3: TLabel
              Left = 37
              Top = 29
              Width = 187
              Height = 13
              Caption = #1063#1080#1089#1083#1086' '#1087#1088#1080#1085#1103#1090#1099#1093' '#1087#1072#1082#1077#1090#1086#1074' '#1089' '#1086#1096#1080#1073#1082#1086#1081':'
            end
            object Label4: TLabel
              Left = 125
              Top = 55
              Width = 99
              Height = 13
              Caption = #1063#1080#1089#1083#1086' '#1086#1096#1080#1073#1086#1082' CRC:'
            end
            object EditCountReceivedPacketsWithError: TEdit
              Left = 230
              Top = 26
              Width = 136
              Height = 21
              Alignment = taRightJustify
              ReadOnly = True
              TabOrder = 0
              Text = '25'
            end
            object EditCountCRCError: TEdit
              Left = 230
              Top = 52
              Width = 136
              Height = 21
              Alignment = taRightJustify
              ReadOnly = True
              TabOrder = 1
              Text = '25'
            end
          end
          object GroupBox3: TGroupBox
            Left = 11
            Top = 165
            Width = 390
            Height = 115
            Caption = ' '#1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1079#1072#1087#1088#1086#1089#1072#1084' '#1055#1054' '#1057#1050#1056#1055' '
            TabOrder = 4
            object Label8: TLabel
              Left = 104
              Top = 29
              Width = 120
              Height = 13
              Caption = #1054#1073#1097#1077#1077' '#1095#1080#1089#1083#1086' '#1079#1072#1087#1088#1086#1089#1086#1074':'
            end
            object Label9: TLabel
              Left = 17
              Top = 55
              Width = 207
              Height = 13
              Caption = #1063#1080#1089#1083#1086' '#1079#1072#1087#1088#1086#1089#1086#1074' '#1089' '#1086#1096#1080#1073#1082#1086#1081' "'#1053#1077#1090' '#1086#1090#1074#1077#1090#1072'":'
            end
            object Label10: TLabel
              Left = 62
              Top = 83
              Width = 162
              Height = 13
              Caption = #1063#1080#1089#1083#1086' '#1079#1072#1087#1088#1086#1089#1086#1074' '#1089' '#1086#1096#1080#1073#1082#1086#1081' CRC:'
            end
            object EditNumberRequests: TEdit
              Left = 230
              Top = 26
              Width = 136
              Height = 21
              Alignment = taRightJustify
              ReadOnly = True
              TabOrder = 0
              Text = '25'
            end
            object EditNumberRequestsNoAnswer: TEdit
              Left = 230
              Top = 52
              Width = 136
              Height = 21
              Alignment = taRightJustify
              ReadOnly = True
              TabOrder = 1
              Text = '25'
            end
            object EditNumberRequestsCRCErr: TEdit
              Left = 230
              Top = 80
              Width = 136
              Height = 21
              Alignment = taRightJustify
              ReadOnly = True
              TabOrder = 2
              Text = '25'
            end
          end
        end
      end
    end
    object ButtonSave: TButton
      Left = 71
      Top = 565
      Width = 75
      Height = 25
      HelpContext = 42
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      OnClick = ButtonSaveClick
    end
    object ButtonCancel: TButton
      Left = 195
      Top = 565
      Width = 75
      Height = 25
      HelpContext = 42
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 2
      OnClick = ButtonCancelClick
    end
    object ButtonClose: TButton
      Left = 320
      Top = 565
      Width = 75
      Height = 25
      HelpContext = 42
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 3
      OnClick = ButtonCloseClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 49
    Width = 433
    Height = 601
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object DBGridConnectControllers: TDBGrid
      Left = 0
      Top = 0
      Width = 433
      Height = 601
      HelpContext = 42
      Align = alClient
      DataSource = DataSourceConnectControllers
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DBGridConnectControllersCellClick
      OnColEnter = DBGridConnectControllersColEnter
      OnColExit = DBGridConnectControllersColExit
      OnDrawColumnCell = DBGridConnectControllersDrawColumnCell
      OnKeyDown = DBGridConnectControllersKeyDown
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 899
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object SpeedButtonAddConnect: TSpeedButton
      Left = 472
      Top = 10
      Width = 160
      Height = 27
      HelpContext = 42
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000C40E0000C40E00000000000000000000FFFFFFDCDCDC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCDDDDDDFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCDDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA89A8A
        96816A957F66B8AFA6717376918170988671968573A69D92CCCCCCFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F7F7F7F7F7F7FB8AFA67173767F7F7F7F
        7F7F968573A69D92CCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF98846C
        D5CAB7D1C5AF818488CCCDD06B737DBD833CBA823FB98341B98444CCCCCCFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FD5CAB7D1C5AF818488CCCDD06B737D7F
        7F7F7F7F7F7F7F7F7F7F7FCCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF98836D
        D7CDBADECBB8D2C6B07E8690B97F37FAC173F3BA6CF0B665E5B56DB78344CCCC
        CCFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FD7CDBADECBB8D2C6B07E86907F7F7FCC
        CCCCCCCCCCCCCCCCCCCCCC7F7F7FCCCCCCFFFFFFFFFFFFFFFFFFFFFFFF9A856D
        DAD0C0CEC2AFD1C6B5B77C34F4C98EF7C078F2BB70EBBF81B17D3FEFB35DBA84
        43FFFFFFFFFFFFFFFFFFFFFFFF7F7F7FDAD0C0CEC2AFD1C6B57F7F7FCCCCCCCC
        CCCCCCCCCCCCCCCC7F7F7FCCCCCC7F7F7FFFFFFFFFFFFFFFFFFFFFFFFF9A856F
        DFD7C6D1C5B2D2C9BAB47A35F8D19DF8C27DF2CB94AF7A3BF4BA6BE2B778BD83
        3CCCCCCCFFFFFFFFFFFFFFFFFF7F7F7FDFD7C6D1C5B2D2C9BA7F7F7FCCCCCCCC
        CCCCCCCCCC7F7F7FCCCCCCCCCCCC7F7F7FCCCCCCFFFFFFFFFFFFFFFFFF9C8771
        E4DBCEB9A28ABAA692B37A34FFDBAEFBD7A7AD7837F9C37BE9C38CB87F3BC2C6
        CF717478CCCCCCFFFFFFFFFFFF7F7F7FE4DBCEB9A28ABAA6927F7F7FCCCCCCCC
        CCCC7F7F7FCCCCCCCCCCCC7F7F7FC2C6CF717478CCCCCCFFFFFFFFFFFF9D8871
        E6DFD3F0DFD0F1E3D8B37931FFE8C0AD7734FFCC88E9C493B7803EFFFFFF848A
        91D2D1CF717272FFFFFFFFFFFF7F7F7FE6DFD3F0DFD0F1E3D87F7F7FCCCCCC7F
        7F7FCCCCCCCCCCCC7F7F7FFFFFFF848A91D2D1CF717272FFFFFFFFFFFFE1E1E1
        CCCCCCCCCCCCCCCCCCE1E1E1FFFFFFFFD79AFFDEB5B67D37CCCCCCFFFFFFFFFF
        FF868788D5D3D2FFFFFFFFFFFF7F7F7FEBE5D9B7A087B8A38CB9A6937F7F7FCC
        CCCCCCCCCC7F7F7FCCCCCCFFFFFFFFFFFF868788D5D3D2FFFFFFCCCCCC56B58E
        009F5E009D5D009E5E53B18CE1E1E1B37930B57A30BEC2CB6D7279CCCCCCFFFF
        FFFFFFFFFFFFFFFFFFFFCCCCCC7F7F7F7F7F7F7F7F7F7F7F7FCCCCCCE1E1E17F
        7F7F7F7F7FBEC2CB6D7279CCCCCCFFFFFFFFFFFFFFFFFFFFFFFF43785E00AA6A
        00BA8677DFC400BA8600A66A53B18CB8A38DF5F1EA7F8388D0CFCE707172FFFF
        FFFFFFFFFFFFFFFFFFFFCCCCCC7F7F7FCCCCCCCCCCCCCCCCCC7F7F7FCCCCCCB8
        A38DC3C3C37F8388D0CFCE707172FFFFFFFFFFFFFFFFFFFFFFFF00A65D00C28C
        00BB82FFFFFF00BB8200C08C009E5EEDDBCCF6F1E9A48D74838587D5D3D2FFFF
        FFFFFFFFFFFFFFFFFFFF7F7F7FCCCCCCCCCCCCFFFFFFCCCCCCCCCCCC7F7F7FED
        DBCCC3C3C37F7F7F838587D5D3D2FFFFFFFFFFFFFFFFFFFFFFFF009D5673E5CB
        FFFFFFFFFFFFFFFFFF77E5CC009C5CDACAB6F8F3ECA68F77FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF7F7F7FCCCCCCFFFFFFFFFFFFFFFFFFCCCCCC7F7F7FDA
        CAB6C3C3C37F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00954D00CA93
        00C78EFFFFFF00C88F00CC98009D5DF8F3EFFCF9F3A7917AFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF7F7F7FCCCCCCCCCCCCFFFFFFCCCCCCCCCCCC7F7F7FC3
        C3C3C3C3C37F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF59C49F00A867
        00D29B73EDD300D49E00AF7268C6A1D9CBB7C5B5A0C6B8A9FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFCCCCCC7F7F7FCCCCCCCCCCCCCCCCCC7F7F7FCCCCCCD9
        CBB7C5B5A07F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9FFFF57C7A3
        009B53009E5600A15B6FCAA5FFFFFFAC9782C7BAABFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFE3FFFFCCCCCC7F7F7F7F7F7F7F7F7FCCCCCCFFFFFF7F
        7F7F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      NumGlyphs = 2
      OnClick = SpeedButtonAddConnectClick
    end
    object SpeedButtonDeleteConnect: TSpeedButton
      Left = 709
      Top = 10
      Width = 160
      Height = 27
      HelpContext = 42
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000C40E0000C40E00000000000000000000FFFFFFDCDCDC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCDDDDDDFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCDDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA89A8A
        96816A957F66B8AFA6717376918170988671968573A69D92CCCCCCFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F7F7F7F7F7F7FB8AFA67173767F7F7F7F
        7F7F968573A69D92CCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF98846C
        D5CAB7D1C5AF818488CCCDD06B737DBD833CBA823FB98341B98444CCCCCCFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FD5CAB7D1C5AF818488CCCDD06B737D7F
        7F7F7F7F7F7F7F7F7F7F7FCCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF98836D
        D7CDBADECBB8D2C6B07E8690B97F37FAC173F3BA6CF0B665E5B56DB78344CCCC
        CCFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FD7CDBADECBB8D2C6B07E86907F7F7FCC
        CCCCCCCCCCCCCCCCCCCCCC7F7F7FCCCCCCFFFFFFFFFFFFFFFFFFFFFFFF9A856D
        DAD0C0CEC2AFD1C6B5B77C34F4C98EF7C078F2BB70EBBF81B17D3FEFB35DBA84
        43FFFFFFFFFFFFFFFFFFFFFFFF7F7F7FDAD0C0CEC2AFD1C6B57F7F7FCCCCCCCC
        CCCCCCCCCCCCCCCC7F7F7FCCCCCC7F7F7FFFFFFFFFFFFFFFFFFFFFFFFF9A856F
        DFD7C6D1C5B2D2C9BAB47A35F8D19DF8C27DF2CB94AF7A3BF4BA6BE2B778BD83
        3CCCCCCCFFFFFFFFFFFFFFFFFF7F7F7FDFD7C6D1C5B2D2C9BA7F7F7FCCCCCCCC
        CCCCCCCCCC7F7F7FCCCCCCCCCCCC7F7F7FCCCCCCFFFFFFFFFFFFFFFFFF9C8771
        E4DBCEB9A28ABAA692B37A34FFDBAEFBD7A7AD7837F9C37BE9C38CB87F3BC2C6
        CF717478CCCCCCFFFFFFFFFFFF7F7F7FE4DBCEB9A28ABAA6927F7F7FCCCCCCCC
        CCCC7F7F7FCCCCCCCCCCCC7F7F7FC2C6CF717478CCCCCCFFFFFFFFFFFF9D8871
        E6DFD3F0DFD0F1E3D8B37931FFE8C0AD7734FFCC88E9C493B7803EFFFFFF848A
        91D2D1CF717272FFFFFFFFFFFF7F7F7FE6DFD3F0DFD0F1E3D87F7F7FCCCCCC7F
        7F7FCCCCCCCCCCCC7F7F7FFFFFFF848A91D2D1CF717272FFFFFFFFFFFF9F8A73
        EBE5D9B7A087B8A38CB9A693B17831FFD79AFFDEB5B67D37CCCCCCFFFFFFFFFF
        FF868788D5D3D2FFFFFFFFFFFF7F7F7FEBE5D9B7A087B8A38CB9A6937F7F7FCC
        CCCCCCCCCC7F7F7FCCCCCCFFFFFFFFFFFF868788D5D3D2FFFFFFCCCCCC7384D1
        374DCC384DCB384DCC7482CCE1E1E1B37930B57A30BEC2CB6D7279CCCCCCFFFF
        FFFFFFFFFFFFFFFFFFFFCCCCCC7F7F7F7F7F7F7F7F7F7F7F7FCCCCCCE1E1E17F
        7F7F7F7F7FBEC2CB6D7279CCCCCCFFFFFFFFFFFFFFFFFFFFFFFF6545A03352DC
        375DF9375DFA385DF93852D77381CCB8A38DF5F1EA7F8388D0CFCE707172FFFF
        FFFFFFFFFFFFFFFFFFFFCCCCCC7F7F7FCCCCCCCCCCCCCCCCCC7F7F7FCCCCCCB8
        A38DC3C3C37F8388D0CFCE707172FFFFFFFFFFFFFFFFFFFFFFFF2449D83E65FE
        3B60FA3A5DF83C60FA4165FB344BCCEDDBCCF6F1E9A48D74838587D5D3D2FFFF
        FFFFFFFFFFFFFFFFFFFF7F7F7FCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC7F7F7FED
        DBCCC3C3C37F7F7F838587D5D3D2FFFFFFFFFFFFFFFFFFFFFFFF2040D1A6B8FF
        FFFFFFFFFFFFFFFFFFA9BAFF3148CADACAB6F8F3ECA68F77FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF7F7F7FCCCCCCE3FFFFE3FFFFE3FFFFCCCCCC7F7F7FDA
        CAB6C3C3C37F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1E37CA5874FE
        5775FE5473FD5776FE5D79FF334ACBF8F3EFFCF9F3A7917AFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF7F7F7FCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC7F7F7FC3
        C3C3C3C3C37F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7993E03951DB
        6B86FF718BFF6E89FF465EDE8795E1D9CBB7C5B5A0C6B8A9FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFCCCCCC7F7F7FCCCCCCCCCCCCCCCCCC7F7F7FCCCCCCD9
        CBB7C5B5A07F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3FFFF7695E4
        203FCF2344D12849D28A9AE5FFFFFFAC9782C7BAABFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFE3FFFFCCCCCC7F7F7F7F7F7F7F7F7FCCCCCCFFFFFF7F
        7F7F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      NumGlyphs = 2
      OnClick = SpeedButtonDeleteConnectClick
    end
    object SpeedButtonSettingsCommunication: TSpeedButton
      Left = 19
      Top = 10
      Width = 191
      Height = 27
      HelpContext = 42
      Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1074#1103#1079#1080
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF3F2F1D4D2CFF0EFEEFFFFFFFEFEFEFCFCFCFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F2F1D4
        D2CFF0EFEEFFFFFFFEFEFEFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFCD9B6FE9B989A6907DFBFBFACBBDB1A2886FDAD6
        D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC2BDBAC2
        BDBAA6907DFBFBFACBBDB1A2886FDAD6D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFBFBFBFFFFFFFFFEFEDDA066EDC69BEFCCA9A69180D29B65DEA15FB781
        4EE2DFDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFFFFFFFFEFEC2BDBAD3
        CECAD3CECAA69180C2BDBAC2BDBAC2BDBAE2DFDDFFFFFFFFFFFFFFFFFFFFFFFF
        CFC2B69E734DD3CECAAD9077DA954DFFE9CAFFEACDE0A666DA964DEEBC7EFBCF
        91B29E8EFFFFFFFFFFFFFFFFFFFFFFFFCFC2B6877C76D3CECAAD9077C2BDBAD3
        CECAD3CECAC2BDBAC2BDBAC2BDBAD3CECAB29E8EFFFFFFFFFFFFFFFFFFEAE0D8
        C26B13CE720BC8690BCD720FD88C38FFE0B5FFE1B7F9D4A3F6CB92FED69CF5BB
        74B6661CC2BAB3FFFFFFFFFFFFEAE0D8877C76877C76877C76877C76C2BDBAD3
        CECAD3CECAD3CECAD3CECAD3CECACBBDB1ABA39EC2BAB3FFFFFFFFFFFFF3E3D6
        D0730DF8BC6BF0B05DE49B45FCD092FFD8A0FFD9A2FFD79FFFD498FFD08CF2B3
        62CB6B03BE7229F3F2F0FFFFFFF3E3D6877C76C2BDBAC2BDBAC2BDBAD3CECAD3
        CECAD3CECAD3CECAD3CECAD3CECACBBDB1ABA39EABA39EF3F2F0FFFFFFFFFFFF
        D99D63FFD08EFFD294FFD292FECF8BF4D5ABFDEBD2FEEED9F6D8B2FEC779FFC3
        70F9B458F7A84AE8E4E0FFFFFFFFFFFFC2BDBAD3CECAD3CECAD3CECADBD0C8DB
        D0C8FDEBD2FEEED9DBD0C8D3CECACBBDB1CBBDB1CBBDB1E8E4E0D4C6BDA9907C
        BE6814F2B15EFFD293F0C790F6EDE0FFFFFFFFFFFFFFFFFFF7F2ECFEB25BFFBB
        5EF4AB4FD8B99FFFFFFFD4C6BDA9907C877C76C2BDBAD3CECAC2BDBAF6EDE0FF
        FFFFFFFFFFFFFFFFF7F2ECCBBDB1CBBDB1CBBDB1D8B99FFFFFFFC08049CA6A01
        CF7107FDC982F2C485F2EBE3FFFFFFFFFFFFFFFFFFFFFFFFDDCAB6FEAF57FEB3
        4DE4902FBCAFA6FFFFFFABA39E877C76877C76DBD0C8DBD0C8F2EBE3FFFFFFFF
        FFFFFFFFFFFFFFFFDDCAB6CBBDB1CBBDB1ABA39EBCAFA6FFFFFFD08038F1AD55
        F8BE70FFD293CFB798FFFFFFFFFFFFFFFFFFFFFFFFF3F0EED3955AF3A451FEAB
        3BFAA22AC09166FFFFFFABA39EC2BDBAC2BDBAD3CECACFB798FFFFFFFFFFFFFF
        FFFFFFFFFFF3F0EEABA39ECBBDB1CBBDB1CBBDB1ABA39EFFFFFFDD9A5CFFD08E
        FFD497FFD395B9A897FEFEFEFFFFFFFEFEFEDFDBD8B68259DD8D46E6943FFB9F
        26EB9D4DF0E3D8FFFFFFABA39ED3CECAD3CECAD3CECAB9A897FEFEFEFFFFFFFE
        FEFEDFDBD8ABA39EABA39EABA39EABA39EABA39EF0E3D8FFFFFFF6EAE1B97441
        EA9D3FFFD79EC57A37967662A48E809B7760BA6F3AC6763ACC7B38F79C25CC9F
        78FFFFFFFFFFFFFFFFFFF6EAE1877C76ABA39ED3CECA877C76967662A48E809B
        7760ABA39E877C76877C76C2BDBACC9F78FFFFFFFFFFFFFFFFFFFFFFFFC5732A
        E59331FFDCABECAF69B3622DAF602FAF602FAF602FC67532F5B768FEAF45C1A7
        92FFFFFFFFFFFFFFFFFFFFFFFF877C76ABA39ED3CECAC2BDBA877C76877C7687
        7C76877C76877C76C2BDBAC2BDBAC1A792FFFFFFFFFFFFFFFFFFFFFFFFE29F65
        FEDDAEF6BD80FEDCABF6C688DC9C5DDB9958EFB46EF5B46AE9B990E2B085FDFB
        F9FFFFFFFFFFFFFFFFFFFFFFFFDBD0C8D3CECAC2BDBAD3CECAC2BDBAC2BDBAC2
        BDBAC2BDBAC2BDBAC2BDBAE2B085FDFBF9FFFFFFFFFFFFFFFFFFFFFFFFFDF6F2
        EFC7ABEFD8C7E59431FEE1B9F0B47CF4BE85FDD195D8C0AEFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBD0C8EFD8C7877C76D3CECAABA39EC2
        BDBADBD0C8D8C0AEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFBF3EEEDB17DE4B48EFEFDFDF5DAC5F4DAC7FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF3EEDBD0C8DBD0C8FEFDFDF5
        DAC5F4DAC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      NumGlyphs = 2
      OnClick = SpeedButtonSettingsCommunicationClick
    end
  end
  object PanelSettingsCommunication: TPanel
    Left = 433
    Top = 49
    Width = 466
    Height = 601
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    object LabelText: TLabel
      Left = 43
      Top = 38
      Width = 381
      Height = 122
      Alignment = taCenter
      AutoSize = False
      Caption = 'LabelText'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
    object LabelInfoCommunication: TLabel
      Left = 43
      Top = 162
      Width = 381
      Height = 125
      AutoSize = False
      Caption = 'LabelInfoCommunication'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object ButtonBack: TButton
      Left = 71
      Top = 565
      Width = 75
      Height = 25
      HelpContext = 42
      Caption = #1053#1072#1079#1072#1076
      TabOrder = 0
      OnClick = ButtonBackClick
    end
    object ButtonCancelSettingsCommunication: TButton
      Left = 195
      Top = 565
      Width = 75
      Height = 25
      HelpContext = 42
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = ButtonCancelSettingsCommunicationClick
    end
    object ButtonNext: TButton
      Left = 320
      Top = 565
      Width = 75
      Height = 25
      HelpContext = 42
      Caption = #1044#1072#1083#1077#1077
      TabOrder = 2
      OnClick = ButtonNextClick
    end
  end
  object DataSourceConnectControllers: TDataSource
    DataSet = ADODataSetConnectControllers
    Left = 256
    Top = 288
  end
  object ADODataSetConnectControllers: TADODataSet
    Connection = DM.ADOConnectionWorkStationMDB
    CursorType = ctStatic
    BeforeScroll = ADODataSetConnectControllersBeforeScroll
    AfterScroll = ADODataSetConnectControllersAfterScroll
    CommandText = 
      'SELECT LinkContr.*, SettingsCOMPort.*'#13#10'FROM LinkContr LEFT JOIN ' +
      'SettingsCOMPort ON LinkContr.Sp_Code = SettingsCOMPort.Sp_Code'
    FieldDefs = <
      item
        Name = 'Lc_Code'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'Plata'
        Attributes = [faFixed]
        DataType = ftWord
      end
      item
        Name = 'Cn_Code'
        Attributes = [faFixed]
        DataType = ftWord
      end
      item
        Name = 'Sp_Code'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'NameController'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'PlataAddress'
        Attributes = [faFixed]
        DataType = ftWord
      end
      item
        Name = 'Sel'
        Attributes = [faFixed]
        DataType = ftBoolean
      end
      item
        Name = 'Sp_Code_1'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'PortNum'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'BaudRate'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'DataBits'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Parity'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'StopBits'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'NameConnection'
        DataType = ftWideString
        Size = 128
      end
      item
        Name = 'TypeController'
        Attributes = [faFixed]
        DataType = ftInteger
      end>
    Parameters = <>
    StoreDefs = True
    Left = 80
    Top = 288
    object ADODataSetConnectControllersSel: TBooleanField
      DisplayLabel = ' '
      FieldName = 'Sel'
      OnGetText = ADODataSetConnectControllersSelGetText
    end
    object ADODataSetConnectControllersNameController: TWideStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077'  '#1082#1086#1085#1090#1088#1086#1083#1083#1077#1088#1072
      FieldName = 'NameController'
      Size = 50
    end
    object ADODataSetConnectControllersNameConnection: TWideStringField
      DisplayLabel = #1051#1080#1085#1080#1103' '#1089#1074#1103#1079#1080
      FieldName = 'NameConnection'
      Size = 128
    end
    object ADODataSetConnectControllersPlataAddress: TWordField
      Alignment = taCenter
      DisplayLabel = #1040#1076#1088#1077#1089'/'#1050#1072#1085#1072#1083
      FieldName = 'PlataAddress'
      OnGetText = ADODataSetConnectControllersPlataAddressGetText
    end
    object ADODataSetConnectControllersLc_Code: TAutoIncField
      FieldName = 'Lc_Code'
      ReadOnly = True
    end
    object ADODataSetConnectControllersPlata: TWordField
      FieldName = 'Plata'
    end
    object ADODataSetConnectControllersCn_Code: TWordField
      FieldName = 'Cn_Code'
    end
    object ADODataSetConnectControllersSp_Code: TIntegerField
      FieldName = 'Sp_Code'
    end
  end
  object TimerShowButtonRefreshDataController: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerShowButtonRefreshDataControllerTimer
    Left = 192
    Top = 137
  end
end
