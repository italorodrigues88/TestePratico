unit ClienteModel;

interface

uses
  System.SysUtils;

type
  TTipoPessoa = (ttpFisica, ttpJuridica);

  TTelefone = record
    FIdCliente:   integer;
    FObservacao:  string;
    FTelefone:    string;
    FTelefoneOld: string;
  end;

  TClienteModel = class
  private
    FNome:         string;
    FTipoPessoa:   TTipoPessoa;
    FCPF_CNPJ:     string;
    FBairro:       string;
    FLagradouro:   string;
    FRG_IE:        string;
    FAtivo:        boolean;
    FUF:           String;
    FCEP:          integer;
    FDataCadastro: TDateTime;
    FIdCliente:    integer;
    FCidade:       string;
    FPais:         string;
    FComplemento:  string;
    FNumero:       integer;
  public
    property IDCliente    : integer            Read FIdCliente    Write FIdCliente;
    property Nome         : string             Read FNome         Write FNome;
    property TipoPessoa   : TTipoPessoa        Read FTipoPessoa   Write FTipoPessoa;
    property CPF_CNPJ     : string             Read FCPF_CNPJ     Write FCPF_CNPJ;
    property RG_IE        : string             Read FRG_IE        Write FRG_IE;
    property DataCadastro : TDateTime          Read FDataCadastro Write FDataCadastro;
    property Ativo        : boolean            Read FAtivo        Write FAtivo;
    property Lagradouro   : string             Read FLagradouro   Write FLagradouro;
    property Complemento  : string             Read FComplemento  Write FComplemento;
    property Numero       : integer            Read FNumero       write FNumero;
    property Bairro       : string             Read FBairro       Write FBairro;
    property CEP          : integer            Read FCEP          Write FCEP;
    property Cidade       : string             Read FCidade       Write FCidade;
    property UF           : string             Read FUF           Write FUF;
    property Pais         : string             Read FPais         Write FPais;
  end;

implementation


end.
