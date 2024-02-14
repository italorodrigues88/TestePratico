unit ConexaoModel;

interface

uses
  System.IniFiles;

type

  TConexao = class
  private
    FArquivo   : TIniFile;
    FUsuario   : String;
    FServidor  : String;
    FSenha     : String;
    FBanco     : String;
  public
    property Servidor   : String     read FServidor;
    property Banco      : String     read FBanco;
    property Usuario    : String     read FUsuario;
    property Senha      : String     read FSenha;

    function Carregar: Boolean;
  end;

const
  DirConfig = '.\Config\Configura.INI';

implementation

uses
  System.SysUtils;
{ TConexao }

function TConexao.Carregar: Boolean;
begin
  Result := False;
  if not FileExists(DirConfig) then
    Exit;

  FArquivo := TIniFile.Create(DirConfig);
  try
    FServidor:= FArquivo.ReadString ('DBSQL' ,'servidor' , '');
    FUsuario := FArquivo.ReadString ('DBSQL' ,'usuario'  , '');
    FSenha   := FArquivo.ReadString ('DBSQL' ,'senha'    , '');
    FBanco   := FArquivo.ReadString ('DBSQL' ,'banco'    , '');

    Result   := True
  finally
    FreeAndNil(FArquivo);
  end;

end;

end.
