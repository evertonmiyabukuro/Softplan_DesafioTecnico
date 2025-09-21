object frPrincipal: TfrPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Busca e visualiza'#231#227'o de CEP'
  ClientHeight = 441
  ClientWidth = 891
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pcBuscaEVisualizacaoCeps: TPageControl
    Left = 0
    Top = 0
    Width = 891
    Height = 441
    ActivePage = tsBuscarCEP
    Align = alClient
    MultiLine = True
    TabOrder = 0
    TabPosition = tpBottom
    object tsBuscarCEP: TTabSheet
      Caption = 'Buscar CEP'
      object pnBuscarCep: TPanel
        Left = 120
        Top = 44
        Width = 625
        Height = 313
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 9
          Top = 27
          Width = 587
          Height = 15
          Caption = 
            'Para efetuar uma busca de CEP, preencha os dados abaixo e escolh' +
            'a o formato que voc'#234' deseja efetuar a busca.'
        end
        object lbCep: TLabel
          Left = 37
          Top = 115
          Width = 21
          Height = 15
          Caption = 'CEP'
        end
        object Label2: TLabel
          Left = 44
          Top = 164
          Width = 14
          Height = 15
          Caption = 'UF'
        end
        object Label3: TLabel
          Left = 21
          Top = 193
          Width = 37
          Height = 15
          Caption = 'Cidade'
        end
        object Label4: TLabel
          Left = 9
          Top = 222
          Width = 49
          Height = 15
          Caption = 'Endere'#231'o'
        end
        object rgBuscaPor: TRadioGroup
          Left = 64
          Top = 48
          Width = 537
          Height = 42
          Caption = 'Buscar por: '
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Cep'
            'Endere'#231'o Completo')
          TabOrder = 0
          OnClick = rgBuscaPorClick
        end
        object edCep: TMaskEdit
          Left = 64
          Top = 112
          Width = 118
          Height = 23
          EditMask = '00000\-999;1;_'
          MaxLength = 9
          TabOrder = 1
          Text = '89010-600'
        end
        object edCidade: TEdit
          Left = 64
          Top = 190
          Width = 210
          Height = 23
          TabOrder = 3
        end
        object edEndereco: TEdit
          Left = 64
          Top = 219
          Width = 210
          Height = 23
          TabOrder = 4
        end
        object cbUF: TComboBox
          Left = 64
          Top = 161
          Width = 120
          Height = 23
          ItemIndex = 23
          TabOrder = 2
          Text = 'SC'
          Items.Strings = (
            'AC'
            'AL'
            'AP'
            'AM'
            'BA'
            'CE'
            'DF'
            'ES'
            'GO'
            'MA'
            'MT'
            'MS'
            'MG'
            'PA'
            'PB'
            'PR'
            'PE'
            'PI'
            'RJ'
            'RN'
            'RS'
            'RO'
            'RR'
            'SC'
            'SP'
            'SE'
            'TO')
        end
        object rgConsultaVia: TRadioGroup
          Left = 322
          Top = 112
          Width = 281
          Height = 130
          Caption = 'Consulta via: '
          ItemIndex = 0
          Items.Strings = (
            'JSON'
            'XML')
          TabOrder = 5
          OnClick = rgConsultaViaClick
        end
        object btBuscar: TButton
          Left = 528
          Top = 265
          Width = 75
          Height = 25
          Caption = 'Buscar'
          TabOrder = 6
          OnClick = btBuscarClick
        end
      end
    end
    object tsConsultarCepsCadastrados: TTabSheet
      Caption = 'Consultar CEPs cadastrados'
      ImageIndex = 1
      object grResultadosCEP: TDBGrid
        Left = 0
        Top = 31
        Width = 883
        Height = 382
        Align = alBottom
        DataSource = dsDadosCepsCadastrados
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Title.Caption = 'C'#243'digo'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CEP'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LOGRADOURO'
            Title.Caption = 'Logradouro'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COMPLEMENTO'
            Title.Caption = 'Complemento'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BAIRRO'
            Title.Caption = 'Bairro'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LOCALIDADE'
            Title.Caption = 'Localidade'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UF'
            Width = 30
            Visible = True
          end>
      end
      object pnTop: TPanel
        Left = 0
        Top = 0
        Width = 883
        Height = 31
        Align = alClient
        TabOrder = 1
        object btConsultarCeps: TBitBtn
          Left = 0
          Top = 0
          Width = 177
          Height = 25
          Caption = 'Consultar CEPs cadastrados'
          TabOrder = 0
          OnClick = btConsultarCepsClick
        end
        object btExcluirRegistroSelecionado: TButton
          Left = 696
          Top = 0
          Width = 187
          Height = 25
          Caption = 'Excluir registro selecioando'
          TabOrder = 1
          OnClick = btExcluirRegistroSelecionadoClick
        end
      end
    end
  end
  object dsDadosCepsCadastrados: TDataSource
    Left = 580
    Top = 44
  end
end
