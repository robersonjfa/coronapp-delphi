object DtmDados: TDtmDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 250
  Width = 559
  object FDConexao: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDRegistroInsert: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      
        'insert into usuario(nome, email, senha) values(:nome, :email, :s' +
        'enha)')
    Left = 144
    Top = 16
    ParamData = <
      item
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        Name = 'EMAIL'
        ParamType = ptInput
      end
      item
        Name = 'SENHA'
        ParamType = ptInput
      end>
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 48
    Top = 88
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 176
    Top = 88
  end
  object FDRegistroQuery: TFDQuery
    Filtered = True
    Connection = FDConexao
    SQL.Strings = (
      'select * from usuario')
    Left = 248
    Top = 16
  end
  object FDLoginQuery: TFDQuery
    Connection = FDConexao
    SQL.Strings = (
      'select nome from usuario where email = :email and senha = :senha')
    Left = 48
    Top = 160
    ParamData = <
      item
        Name = 'EMAIL'
        ParamType = ptInput
      end
      item
        Name = 'SENHA'
        ParamType = ptInput
      end>
  end
end
