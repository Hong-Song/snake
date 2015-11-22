object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 448
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 39
    Width = 377
    Height = 218
  end
  object btnStart: TSpeedButton
    Left = 16
    Top = 8
    Width = 55
    Height = 22
    Caption = 'Start'
    OnClick = btnStartClick
  end
  object btnPause: TSpeedButton
    Left = 69
    Top = 8
    Width = 52
    Height = 22
    Caption = 'Pause'
    OnClick = btnPauseClick
  end
  object btnContinue: TSpeedButton
    Left = 120
    Top = 8
    Width = 73
    Height = 22
    Caption = 'Continue'
    OnClick = btnContinueClick
  end
  object lblLength: TLabel
    Left = 288
    Top = 8
    Width = 43
    Height = 13
    Caption = 'lblLength'
  end
end
