object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 354
  Width = 546
  object SQL: TFDConnection
    Params.Strings = (
      'Server=ITALO-PC'
      'Password=010509'
      'Database=dbTeste'
      'DriverID=MSSQL'
      'User_Name=SA')
    AfterConnect = AlterConexao
    BeforeConnect = SQLBeforeConnect
    AfterDisconnect = AlterConexao
    Left = 64
    Top = 32
  end
  object quCliente: TFDQuery
    Connection = SQL
    SQL.Strings = (
      'DECLARE @NOME VARCHAR(60) = :NOME,'
      #9#9'@ATIVO INTEGER = :ATIVO'
      'SELECT CLIENTE_ID,'
      #9'   NOME,'
      #9'   CASE LEN(CPF_CNPJ) WHEN 11'
      
        #9#9#9#9'THEN SUBSTRING(CPF_CNPJ,1,3) + '#39'.'#39' + SUBSTRING(CPF_CNPJ,4,3)' +
        ' + '#39'.'#39' + SUBSTRING(CPF_CNPJ,7,3) + '#39'-'#39' + SUBSTRING(CPF_CNPJ,10,2' +
        ')'
      
        #9#9#9#9'ELSE SUBSTRING(CPF_CNPJ,1,2) + '#39'.'#39' + SUBSTRING(CPF_CNPJ,3,3)' +
        ' + '#39'.'#39' + SUBSTRING(CPF_CNPJ,6,3) + '#39'/'#39' + SUBSTRING(CPF_CNPJ,9,4)' +
        ' + '#39'-'#39' + SUBSTRING(CPF_CNPJ,13,2)'
      #9'   END CPF_CNPJ,'
      #9'   LAGRADOURO,'
      #9'   CASE WHEN ATIVO = 0 THEN '#39'N'#227'o'#39' ELSE '#39'Sim'#39' END ATIVO'
      'FROM tbcliente'
      'WHERE ((@ATIVO = -1) OR (@ATIVO = ATIVO))'
      '  AND ((@NOME = '#39#39') OR (NOME LIKE '#39'%'#39'+@NOME+'#39'%'#39'))')
    Left = 160
    Top = 32
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        Name = 'ATIVO'
        ParamType = ptInput
      end>
    object quClienteCLIENTE_ID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'CLIENTE_ID'
      Origin = 'CLIENTE_ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object quClienteNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 60
    end
    object quClienteCPF_CNPJ: TStringField
      FieldName = 'CPF_CNPJ'
      Origin = 'CPF_CNPJ'
      ReadOnly = True
      Size = 18
    end
    object quClienteLAGRADOURO: TStringField
      FieldName = 'LAGRADOURO'
      Origin = 'LAGRADOURO'
      Size = 55
    end
    object quClienteATIVO: TStringField
      FieldName = 'ATIVO'
      Origin = 'ATIVO'
      ReadOnly = True
      Required = True
      Size = 3
    end
  end
  object dsCliente: TDataSource
    DataSet = quCliente
    Left = 160
    Top = 88
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 64
    Top = 88
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 144
  end
  object quTelefones: TFDQuery
    Connection = SQL
    SQL.Strings = (
      
        'SELECT '#39'('#39'+SUBSTRING(FONE,1,2) + '#39') '#39'+ SUBSTRING(FONE,3,5) + '#39'-'#39 +
        ' + SUBSTRING(FONE,8,4) FONE_FORMAT,'
      #9'   *'
      '  FROM tbcliente_fone'
      ' WHERE CLIENTE_ID = :CLIENTE_ID'
      ' ORDER BY DATA_INCLUSAO DESC')
    Left = 232
    Top = 32
    ParamData = <
      item
        Name = 'CLIENTE_ID'
        ParamType = ptInput
      end>
    object quTelefonesCLIENTE_ID: TLargeintField
      FieldName = 'CLIENTE_ID'
      Origin = 'CLIENTE_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object quTelefonesFONE: TStringField
      FieldName = 'FONE'
      Origin = 'FONE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 11
    end
    object quTelefonesDATA_INCLUSAO: TSQLTimeStampField
      FieldName = 'DATA_INCLUSAO'
      Origin = 'DATA_INCLUSAO'
      Required = True
    end
    object quTelefonesOBSE: TStringField
      FieldName = 'OBSE'
      Origin = 'OBSE'
      Size = 150
    end
    object quTelefonesFONE_FORMAT: TStringField
      FieldName = 'FONE_FORMAT'
      Origin = 'FONE_FORMAT'
      ReadOnly = True
      Size = 15
    end
  end
  object dsTelefones: TDataSource
    DataSet = quTelefones
    Left = 232
    Top = 88
  end
end
