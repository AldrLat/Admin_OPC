object FormShowProgressCompressDB: TFormShowProgressCompressDB
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'FormShowProgressCompressDB'
  ClientHeight = 139
  ClientWidth = 428
  Color = clHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBarCompressDB: TProgressBar
    Left = 41
    Top = 90
    Width = 345
    Height = 25
    Step = 1
    TabOrder = 0
  end
  object StaticTextCompressDB: TStaticText
    Left = 44
    Top = 24
    Width = 340
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 'StaticTextCompressDB'
    Color = clHighlight
    ParentColor = False
    TabOrder = 1
  end
  object TimerCompressDB: TTimer
    Enabled = False
    Interval = 600
    OnTimer = TimerCompressDBTimer
    Left = 8
    Top = 24
  end
end
