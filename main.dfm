object Form1: TForm1
  Left = 210
  Top = 73
  Width = 1232
  Height = 556
  Caption = 'Newton system'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 112
    Width = 505
    Height = 400
    Caption = 'Classic arithmetic'
    TabOrder = 0
    object labelInitialValues: TLabel
      Left = 16
      Top = 72
      Width = 64
      Height = 13
      Caption = 'Initival values'
    end
    object labelComputedResults: TLabel
      Left = 264
      Top = 72
      Width = 81
      Height = 13
      Caption = 'Computed results'
    end
    object labelNumberOfVariables: TLabel
      Left = 16
      Top = 24
      Width = 94
      Height = 13
      Caption = 'Number of variables'
    end
    object inputEntries: TEdit
      Left = 16
      Top = 40
      Width = 145
      Height = 21
      TabOrder = 0
    end
    object inputLoadEntries: TButton
      Left = 166
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 1
      OnClick = inputLoadEntriesClick
    end
    object inputShowEntries: TStringGrid
      Left = 16
      Top = 88
      Width = 225
      Height = 265
      ColCount = 2
      RowCount = 4
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 2
      Visible = False
      RowHeights = (
        24
        24
        24
        24)
    end
    object outputShowResults: TStringGrid
      Left = 264
      Top = 88
      Width = 225
      Height = 265
      ColCount = 2
      RowCount = 4
      TabOrder = 3
      Visible = False
      ColWidths = (
        64
        156)
    end
    object inputCompute: TButton
      Left = 416
      Top = 360
      Width = 75
      Height = 25
      Caption = 'Compute'
      TabOrder = 4
      OnClick = inputComputeClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 528
    Top = 112
    Width = 681
    Height = 401
    Caption = 'Interval arithmetic'
    TabOrder = 1
    object labelNumberOfIntervals: TLabel
      Left = 16
      Top = 24
      Width = 91
      Height = 13
      Caption = 'Number of intervals'
    end
    object labelInitialIntervals: TLabel
      Left = 16
      Top = 72
      Width = 64
      Height = 13
      Caption = 'Inital intervals'
    end
    object labelComputedIntervals: TLabel
      Left = 264
      Top = 72
      Width = 90
      Height = 13
      Caption = 'Computed intervals'
    end
    object inputShowEntriesInt: TStringGrid
      Left = 16
      Top = 88
      Width = 225
      Height = 265
      ColCount = 3
      RowCount = 4
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      Visible = False
    end
    object outputShowResultsInt: TStringGrid
      Left = 265
      Top = 88
      Width = 400
      Height = 265
      ColCount = 3
      RowCount = 4
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 1
      Visible = False
      ColWidths = (
        64
        159
        170)
    end
    object inputEntriesInt: TEdit
      Left = 16
      Top = 40
      Width = 145
      Height = 21
      TabOrder = 2
    end
    object inputLoadEntriesInt: TButton
      Left = 168
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 3
      OnClick = inputLoadEntriesIntClick
    end
    object inputComputeInt: TButton
      Left = 592
      Top = 360
      Width = 75
      Height = 25
      Caption = 'Compute'
      TabOrder = 4
      OnClick = inputComputeIntClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 16
    Width = 505
    Height = 81
    Caption = 'Parameters'
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 139
      Height = 13
      Caption = 'Maximum number of iterations'
    end
    object Label2: TLabel
      Left = 264
      Top = 24
      Width = 18
      Height = 13
      Caption = 'Eps'
    end
    object inputMit: TEdit
      Left = 16
      Top = 40
      Width = 225
      Height = 21
      TabOrder = 0
      Text = '10'
    end
    object inputEps: TEdit
      Left = 264
      Top = 40
      Width = 225
      Height = 21
      TabOrder = 1
      Text = '1e-16'
    end
  end
  object GroupBox4: TGroupBox
    Left = 528
    Top = 16
    Width = 681
    Height = 81
    Caption = 'Computed values'
    TabOrder = 3
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 43
      Height = 13
      Caption = 'Iterations'
    end
    object Label4: TLabel
      Left = 264
      Top = 24
      Width = 91
      Height = 13
      Caption = 'Additional message'
    end
    object outputIt: TEdit
      Left = 16
      Top = 40
      Width = 225
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = '-'
    end
    object outputMessage: TEdit
      Left = 264
      Top = 40
      Width = 225
      Height = 21
      Enabled = False
      TabOrder = 1
      Text = '-'
    end
  end
end
