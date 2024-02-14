unit ClienteRepository;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
  uDM, ClienteModel, Data.DB, System.Generics.Collections;

type
  TClienteRepository = class
  private
    FQuery     : TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
    procedure pNovoCliente(ACliente: TClienteModel);
    procedure pAlterarCliente(ACliente: TClienteModel);
    procedure pApagarCliente(ACliente: TClienteModel);
    procedure pNovoTelefone(ATelefone: TTelefone);
    procedure pAlterarTelefone(ATelefone: TTelefone);
    procedure pApagarTelefone(ATelefone: TTelefone);
    procedure pSelecionarLista(AFiltro: string = '');
    function fBuscaCliente(AID: Integer): TClienteModel;
    function fBuscaIDCliente(ACliente: TClienteModel): Integer;
  end;

implementation

{ TClienteRepository }

constructor TClienteRepository.Create;
begin
  FQuery := TFDQuery.Create(Nil);
  FQuery.Connection := DM.SQL;
end;

destructor TClienteRepository.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

function TClienteRepository.fBuscaCliente(AID: Integer): TClienteModel;
begin
  Result := nil;
  with FQuery do
  begin
    Close;

    SQL.Clear;
    SQL.Add('SELECT *                        ');
    SQL.Add('  FROM tbcliente                ');
    SQL.Add(' WHERE CLIENTE_ID = :CLIENTE_ID ');
    ParamByName('CLIENTE_ID').Value  := AID;
    Open;

    if not IsEmpty then
    begin
      Result := TClienteModel.Create;
      Result.IDCliente    := FieldByName('CLIENTE_ID').AsLargeInt;
      Result.Nome         := FieldByName('NOME').AsString;
      Result.TipoPessoa   := TTipoPessoa(FieldByName('TIPO_PESSOA').AsInteger);
      Result.CPF_CNPJ     := FieldByName('CPF_CNPJ').AsString;
      Result.RG_IE        := FieldByName('RG_IE').AsString;
      Result.DataCadastro := FieldByName('DATA_INCLUSAO').AsDateTime;
      Result.Ativo        := FieldByName('ATIVO').AsBoolean;
      Result.Lagradouro   := FieldByName('LAGRADOURO').AsString;
      Result.Complemento  := FieldByName('COMPLEMENTO').AsString;
      Result.Numero       := FieldByName('NUMERO').AsInteger;
      Result.Bairro       := FieldByName('BAIRRO').AsString;
      Result.CEP          := FieldByName('CEP').AsInteger;
      Result.Cidade       := FieldByName('CIDADE').AsString;
      Result.UF           := FieldByName('UF').AsString;
      Result.Pais         := FieldByName('PAIS').AsString;
    end;
  end;
end;

function TClienteRepository.fBuscaIDCliente(ACliente:TClienteModel): Integer;
begin
  Result := 0;
  with FQuery do
  begin
    Close;

    SQL.Clear;
    SQL.Add('SELECT CLIENTE_ID ');
    SQL.Add('  FROM tbcliente  ');

    if ACliente.CPF_CNPJ <> EmptyStr then
    begin
      SQL.Add(' WHERE CPF_CNPJ = ' + QuotedStr(ACliente.CPF_CNPJ));
    end
    else if ACliente.Nome <> EmptyStr then
    begin
      SQL.Add(' WHERE NOME = ' + QuotedStr(ACliente.Nome));
    end else
    begin
      Result := 0;
      Exit;
    end;

    Open;

    if RecordCount > 0 then
    begin
      Result := FieldByName('CLIENTE_ID').AsInteger;
    end;
    Close;
  end;
end;

procedure TClienteRepository.pAlterarCliente(ACliente:TClienteModel);
begin
  with FQuery do
  begin
    Close;

    SQL.Clear;
    SQL.Add('UPDATE tbcliente                   ');
    SQL.Add('   SET NOME = :NOME,               ');
    SQL.Add('       TIPO_PESSOA = :TIPO_PESSOA, ');
    SQL.Add('       CPF_CNPJ = :CPF_CNPJ,       ');
    SQL.Add('       RG_IE = :RG_IE,             ');
    SQL.Add('       LAGRADOURO = :LAGRADOURO,   ');
    SQL.Add('       BAIRRO = :BAIRRO,           ');
    SQL.Add('       NUMERO = :NUMERO,           ');
    SQL.Add('       COMPLEMENTO = :COMPLEMENTO, ');
    SQL.Add('       CIDADE = :CIDADE,           ');
    SQL.Add('       CEP = :CEP,                 ');
    SQL.Add('       UF = :UF,                   ');
    SQL.Add('       PAIS = :PAIS,               ');
    SQL.Add('       ATIVO = :ATIVO,             ');
    SQL.Add(' WHERE CLIENTE_ID = :CLIENTE_ID    ');

    ParamByName('NOME').Value        := ACliente.Nome;
    ParamByName('TIPO_PESSOA').Value := Ord(ACliente.TipoPessoa);
    ParamByName('CPF_CNPJ').Value    := ACliente.CPF_CNPJ;
    ParamByName('RG_IE').Value       := ACliente.RG_IE;
    ParamByName('LAGRADOURO').Value  := ACliente.Lagradouro;
    ParamByName('BAIRRO').Value      := ACliente.Bairro;
    ParamByName('NUMERO').Value      := ACliente.Numero;
    ParamByName('COMPLEMENTO').Value := ACliente.Complemento;
    ParamByName('CIDADE').Value      := ACliente.Cidade;
    ParamByName('CEP').Value         := ACliente.CEP;
    ParamByName('UF').Value          := ACliente.UF;
    ParamByName('PAIS').Value        := ACliente.Pais;
    ParamByName('ATIVO').Value       := ACliente.Ativo;
    ParamByName('CLIENTE_ID').Value  := ACliente.IDCliente;
    Prepare;
    ExecSQL;
  end;
end;

procedure TClienteRepository.pAlterarTelefone(ATelefone: TTelefone);
begin
  with FQuery do
  begin
    Close;

    SQL.Clear;
    SQL.Add('UPDATE tbcliente_fone           ');
    SQL.Add('   SET FONE = :FONE,            ');
    SQL.Add('       OBSE = :OBSE             ');
    SQL.Add(' WHERE CLIENTE_ID = :CLIENTE_ID ');
    SQL.Add('   AND FONE = :FONE_OLD         ');

    ParamByName('FONE').Value       := ATelefone.FTelefone;
    ParamByName('OBSE').Value       := ATelefone.FObservacao;
    ParamByName('CLIENTE_ID').Value := ATelefone.FIdCliente;
    ParamByName('FONE_OLD').Value   := ATelefone.FTelefoneOld;
    Prepare;
    ExecSQL;
  end;
end;

procedure TClienteRepository.pApagarCliente(ACliente:TClienteModel);
begin
  with FQuery do
  begin
    Close;

    SQL.Clear;
    SQL.Text := 'DELETE FROM tbcliente WHERE CLIENTE_ID = :CLIENTE_ID';

    ParamByName('CLIENTE_ID').AsInteger  := ACliente.IDCliente;
    Prepare;
    ExecSQL;
  end;
end;

procedure TClienteRepository.pApagarTelefone(ATelefone: TTelefone);
begin
  with FQuery do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE FROM tbcliente_fone      ');
    SQL.Add(' WHERE CLIENTE_ID = :CLIENTE_ID ');
    SQL.Add('   AND FONE = :FONE             ');

    ParamByName('CLIENTE_ID').Value := ATelefone.FIdCliente;
    ParamByName('FONE').Value       := ATelefone.FTelefone;
    Prepare;
    ExecSQL;
  end;
end;

procedure TClienteRepository.pNovoCliente(ACliente:TClienteModel);
begin
  with FQuery do
  begin
    Close;

    SQL.Clear;
    SQL.Add('INSERT INTO dbo.tbcliente                                       ');
    SQL.Add('  (NOME, TIPO_PESSOA, CPF_CNPJ, RG_IE, LAGRADOURO, BAIRRO,      ');
    SQL.Add('   NUMERO, COMPLEMENTO, CIDADE, CEP, UF, PAIS)                  ');
    SQL.Add('VALUES                                                          ');
    SQL.Add('  (:NOME, :TIPO_PESSOA, :CPF_CNPJ, :RG_IE, :LAGRADOURO, :BAIRRO,');
    SQL.Add('   :NUMERO, :COMPLEMENTO, :CIDADE, :CEP, :UF, :PAIS)            ');
    ParamByName('NOME').Value        := ACliente.Nome;
    ParamByName('TIPO_PESSOA').Value := Ord(ACliente.TipoPessoa);
    ParamByName('CPF_CNPJ').Value    := ACliente.CPF_CNPJ;
    ParamByName('RG_IE').Value       := ACliente.RG_IE;
    ParamByName('LAGRADOURO').Value  := ACliente.Lagradouro;
    ParamByName('BAIRRO').Value      := ACliente.Bairro;
    ParamByName('NUMERO').Value      := ACliente.Numero;
    ParamByName('COMPLEMENTO').Value := ACliente.Complemento;
    ParamByName('CIDADE').Value      := ACliente.Cidade;
    ParamByName('CEP').Value         := ACliente.CEP;
    ParamByName('UF').Value          := ACliente.UF;
    ParamByName('PAIS').Value        := ACliente.Pais;
    Prepare;
    ExecSQL;

    ACliente.IDCliente := fBuscaIDCliente(ACliente);
  end;
end;

procedure TClienteRepository.pNovoTelefone(ATelefone: TTelefone);
begin
  with FQuery do
  begin
    Close;

    SQL.Clear;
    SQL.Add('INSERT INTO dbo.tbcliente_fone ');
    SQL.Add('  (CLIENTE_ID, FONE, OBSE)     ');
    SQL.Add('VALUES                         ');
    SQL.Add('  (:CLIENTE_ID, :FONE, :OBSE)  ');
    ParamByName('CLIENTE_ID').Value := ATelefone.FIdCliente;
    ParamByName('FONE').Value       := ATelefone.FTelefone;
    ParamByName('OBSE').Value       := ATelefone.FObservacao;
    Prepare;
    ExecSQL;
  end;
end;

procedure TClienteRepository.pSelecionarLista(AFiltro: string);
begin
  with FQuery do
  begin
    Close;

    SQL.Clear;
    SQL.Add('SELECT *           ');
    SQL.Add('  FROM tbcliente   ');

    if AFiltro <> EmptyStr then
    begin
      AFiltro := '%' + AFiltro + '%';
      SQL.Add(' WHERE NOME LIKE ' + QuotedStr(AFiltro));
    end;
    SQL.Add(' ORDER BY NOME ASC ');

    Open;
  end;
end;

end.
