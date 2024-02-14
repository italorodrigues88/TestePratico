object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Teste Pr'#225'tico MKdata'
  ClientHeight = 456
  ClientWidth = 849
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object sbPrinc: TStatusBar
    Left = 0
    Top = 437
    Width = 849
    Height = 19
    Panels = <
      item
        Text = 'Status do banco: Desconectado'
        Width = 250
      end
      item
        Text = 'Desenvolvido por '#205'talo Rodrigues'
        Width = 50
      end>
  end
  object pnlPrinc: TPanel
    Left = 0
    Top = 0
    Width = 849
    Height = 437
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = -6
  end
  object mmPrincipal: TMainMenu
    Left = 64
    Top = 38
    object Funcionario: TMenuItem
      Caption = 'Cadastro'
      object CadCliente: TMenuItem
        Caption = 'Cliente'
        OnClick = CadClienteClick
      end
    end
    object Sair: TMenuItem
      Caption = 'Sair'
      OnClick = SairClick
    end
  end
end
