unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.DApt, ConexaoModel, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Phys.MySQLDef,
  FireDAC.Comp.UI, FireDAC.Phys.MySQL;

type
  TDM = class(TDataModule)
    SQL: TFDConnection;
    quCliente: TFDQuery;
    dsCliente: TDataSource;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    quClienteCLIENTE_ID: TLargeintField;
    quClienteNOME: TStringField;
    quClienteCPF_CNPJ: TStringField;
    quClienteLAGRADOURO: TStringField;
    quClienteATIVO: TStringField;
    quTelefones: TFDQuery;
    dsTelefones: TDataSource;
    quTelefonesCLIENTE_ID: TLargeintField;
    quTelefonesFONE: TStringField;
    quTelefonesDATA_INCLUSAO: TSQLTimeStampField;
    quTelefonesOBSE: TStringField;
    quTelefonesFONE_FORMAT: TStringField;
    quClienteDATA_INCLUSAO: TSQLTimeStampField;
    procedure SQLBeforeConnect(Sender: TObject);
    procedure AlterConexao(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FConexao : TConexao;
  public
    { Public declarations }
    procedure ConectarSQL;
  end;

var
  DM: TDM;

implementation

uses
  uMain;

{$R *.dfm}

{ TDM }

procedure TDM.AlterConexao(Sender: TObject);
begin
  frmMain.pAtualizaConexao(SQL.Connected)
end;

procedure TDM.ConectarSQL;
begin
  if SQL.Connected then
    Exit;

  FConexao := TConexao.Create;
  try
    SQL.Connected := True;
  finally
    FreeAndNil(FConexao);
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  ConectarSQL;
end;

procedure TDM.SQLBeforeConnect(Sender: TObject);
begin
  if not FConexao.Carregar then
    raise Exception.Create('Erro ao carregar arquivo de configurações');

  SQL.Params.Values['Server'] := FConexao.Servidor;
  SQL.Params.Database         := FConexao.Banco;
  SQL.Params.UserName         := FConexao.Usuario;
  SQL.Params.Password         := FConexao.Senha;
  SQL.Params.DriverID         := 'MSSQL';
end;

end.
