unit ClienteController;

interface

uses
  ClienteModel, ClienteRepository, System.SysUtils, Data.DB, Datasnap.DBClient;

type

  TClienteController = class
  private
    FCliente    : TClienteModel;
    FRepository : TClienteRepository;
  public
    constructor Create;
    destructor Destroy; override;
    procedure pNovoCliente;
    procedure pAlterarCliente;
    procedure pApagarCliente;
    procedure pNovoTelefone(ATelefone: TTelefone);
    procedure pAlterarTelefone(ATelefone: TTelefone);
    procedure pApagarTelefone(ATelefone: TTelefone);
    procedure pSelecionarCliente(Filtro: String = '');
    procedure pBsucarClienteID(AID: Integer);
    property Cliente     : TClienteModel      Read FCliente     Write FCliente;
  end;

implementation

{ TClienteController }

procedure TClienteController.pAlterarCliente;
begin
  FRepository.pAlterarCliente(FCliente);
end;

procedure TClienteController.pAlterarTelefone(ATelefone: TTelefone);
begin
  FRepository.pAlterarTelefone(ATelefone);
end;

procedure TClienteController.pApagarCliente;
begin
  FRepository.pApagarCliente(FCliente);
end;

procedure TClienteController.pApagarTelefone(ATelefone: TTelefone);
begin
  FRepository.pApagarTelefone(ATelefone);
end;

procedure TClienteController.pBsucarClienteID(AID: Integer);
begin
  Cliente := FRepository.fBuscaCliente(AID);
end;

procedure TClienteController.pSelecionarCliente(Filtro: String);
begin
  FRepository.pSelecionarLista(Filtro);
end;

constructor TClienteController.Create;
begin
  FCliente   := TClienteModel.Create;
  FRepository  := TClienteRepository.Create;
end;

destructor TClienteController.Destroy;
begin
  FreeAndNil(FCliente);
  FreeAndNil(FRepository);

  inherited;
end;

procedure TClienteController.pNovoCliente;
begin
  FRepository.pNovoCliente(FCliente);
end;

procedure TClienteController.pNovoTelefone(ATelefone: TTelefone);
begin
  FRepository.pNovoTelefone(ATelefone);
end;

end.
