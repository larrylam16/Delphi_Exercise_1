object WidgetForm: TWidgetForm
  Left = 0
  Top = 0
  Caption = 'WidgetForm'
  ClientHeight = 450
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object DisplayMemo: TMemo
    Left = 8
    Top = 88
    Width = 361
    Height = 329
    TabOrder = 0
  end
  object OpenFileButton: TButton
    Left = 248
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Open File'
    TabOrder = 1
    OnClick = OpenFileButtonClick
  end
  object ComboBox: TComboBox
    Left = 32
    Top = 32
    Width = 145
    Height = 24
    Style = csDropDownList
    TabOrder = 2
    OnChange = ComboBoxChange
  end
end
