unit uCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uCadastroBase, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, ClienteController, uCadastroTelefone, uDM,
  FireDAC.Stan.Param, System.UITypes, ClienteModel, CEPController;

type
  TfrmCadastroCliente = class(TfrmCadastroBase)
    pnlTop: TPanel;
    Label1: TLabel;
    lblCPF: TLabel;
    edtNome: TEdit;
    edtCPF: TEdit;
    rgTipoPessoa: TRadioGroup;
    edtRG: TEdit;
    lblRG: TLabel;
    Label3: TLabel;
    edtEndereco: TEdit;
    ckbAtivo: TCheckBox;
    edtCEP: TEdit;
    Label4: TLabel;
    btnBuscarCEP: TSpeedButton;
    edtBairro: TEdit;
    Label5: TLabel;
    edtCidade: TEdit;
    Label6: TLabel;
    edtPais: TEdit;
    Label7: TLabel;
    cbUF: TComboBox;
    Label8: TLabel;
    pnlBot: TPanel;
    grdTelefone: TDBGrid;
    pnlTelefoneTop: TPanel;
    btnFoneNovo: TSpeedButton;
    btnFoneAlterar: TSpeedButton;
    btnFoneApagar: TSpeedButton;
    cbFiltro: TComboBox;
    Label2: TLabel;
    Label9: TLabel;
    edtComplemento: TEdit;
    edtNumero: TEdit;
    procedure rgTipoPessoaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCEPChange(Sender: TObject);
    procedure btnFoneNovoClick(Sender: TObject);
    procedure dbGridEnter(Sender: TObject);
    procedure dbGridCellClick(Column: TColumn);
    procedure AtivaClientes(Sender: TObject);
    procedure btnBuscarCEPClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnFoneAlterarClick(Sender: TObject);
    procedure btnFoneApagarClick(Sender: TObject);
  private
    { Private declarations }
    FCliente : TClienteController;
    FCadastroFone: TfrmCadastroFone;
    FCliente_ID: Integer;
    FTelefone: TTelefone;
    procedure pAtivarCampos(AAtivar: Boolean);
    procedure pLimparCampos;
    procedure pMappToClass;
    procedure pMappToComponents;
    procedure pAtivarBotoes(AAtivar: Boolean);
    procedure pAtivarBotoesFone(AAtivar: Boolean);
    procedure pAtivaFones;
  public
    { Public declarations }
    procedure pSalvar; override;
    procedure pApagar; override;
    procedure pNovo; override;
    procedure pCancelar; override;
    procedure pAlterar; override;
    procedure pPesquisar; override;
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}

procedure TfrmCadastroCliente.pAtivarBotoes(AAtivar: Boolean);
begin
  btnApagar.Enabled := AAtivar;
  btnAlterar.Enabled := AAtivar;
end;

procedure TfrmCadastroCliente.pAtivarBotoesFone(AAtivar: Boolean);
begin
  btnFoneNovo.Enabled    := AAtivar;
  btnFoneAlterar.Enabled := AAtivar;
  btnFoneApagar.Enabled  := AAtivar;
end;

procedure TfrmCadastroCliente.pAtivarCampos(AAtivar: Boolean);
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[i] is TEdit then
      TEdit(Self.Components[i]).Enabled := AAtivar;
  end;

  rgTipoPessoa.Enabled := AAtivar;
  cbUF.Enabled := AAtivar;
  ckbAtivo.Enabled := AAtivar;
  edtFiltro.Enabled := True;
  cbFiltro.Enabled := True;

  btnBuscarCEP.Enabled := (Length(edtCEP.Text) = 8);
end;

procedure TfrmCadastroCliente.pCancelar;
begin
  if FAcao = taNovo then
  begin
    pLimparCampos;
  end
  else
  begin
    pMappToComponents;
  end;
  pAtivarCampos(False);
end;

procedure TfrmCadastroCliente.pLimparCampos;
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount -1 do
  begin
    if (Self.Components[i] is TEdit) then
      TEdit(Self.Components[i]).Text := EmptyStr;
  end;

  rgTipoPessoa.ItemIndex := 0;
  cbUF.ItemIndex := -1;
end;

procedure TfrmCadastroCliente.pMappToClass;
begin
  FCliente.Cliente.Nome        := edtNome.Text;
  FCliente.Cliente.CPF_CNPJ    := edtCPF.Text;
  FCliente.Cliente.RG_IE       := edtRG.Text;
  FCliente.Cliente.CEP         := StrToInt(edtCEP.Text);
  FCliente.Cliente.Bairro      := edtBairro.Text;
  FCliente.Cliente.Complemento := edtComplemento.Text;
  FCliente.Cliente.Numero      := StrToInt(edtNumero.Text);
  FCliente.Cliente.Lagradouro  := edtEndereco.Text;
  FCliente.Cliente.Cidade      := edtCidade.Text;
  FCliente.Cliente.UF          := cbUF.Text;
  FCliente.Cliente.Pais        := edtPais.Text;
  FCliente.Cliente.Ativo       := ckbAtivo.Checked;
  FCliente.Cliente.TipoPessoa  := TTipoPessoa(rgTipoPessoa.ItemIndex);
end;

procedure TfrmCadastroCliente.pMappToComponents;
begin
  edtNome.Text           := FCliente.Cliente.Nome;
  edtCPF.Text            := FCliente.Cliente.CPF_CNPJ;
  edtRG.Text             := FCliente.Cliente.RG_IE;
  edtCEP.Text            := FCliente.Cliente.CEP.ToString;
  edtBairro.Text         := FCliente.Cliente.Bairro;
  edtComplemento.Text    := FCliente.Cliente.Complemento;
  edtNumero.Text         := FCliente.Cliente.Numero.ToString;
  edtEndereco.Text       := FCliente.Cliente.Lagradouro;
  edtCidade.Text         := FCliente.Cliente.Cidade;
  cbUF.Text              := FCliente.Cliente.UF;
  edtPais.Text           := FCliente.Cliente.Pais;
  ckbAtivo.Checked       := FCliente.Cliente.Ativo;
  rgTipoPessoa.ItemIndex := Ord(FCliente.Cliente.TipoPessoa);
end;

procedure TfrmCadastroCliente.AtivaClientes(Sender: TObject);
begin
  DM.quCliente.Close;
  DM.quCliente.ParamByName('ATIVO').Value := (cbFiltro.ItemIndex - 1);
  DM.quCliente.ParamByName('NOME').Value := (edtFiltro.Text);
  DM.quCliente.Open;
end;

procedure TfrmCadastroCliente.pAtivaFones;
begin
  DM.quTelefones.Close;
  DM.quTelefones.ParamByName('CLIENTE_ID').Value := FCliente.Cliente.IDCliente;
  DM.quTelefones.Open;
end;

procedure TfrmCadastroCliente.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pAtivaFones;
end;

procedure TfrmCadastroCliente.btnBuscarCEPClick(Sender: TObject);
var
  lCEP : TCEPController;
begin
  lCEP := TCEPController.Create;
  try
    lCEP.ConsultarCep(edtCEP.Text);

    edtBairro.Text := lCEP.CEP.Bairro;
    edtEndereco.Text := lCEP.CEP.Logradouro;
    edtCidade.Text := lCEP.CEP.Localidade;
    cbUF.Text := lCEP.CEP.UF;
  finally
    FreeAndNil(lCEP);
  end;
end;

procedure TfrmCadastroCliente.btnFoneAlterarClick(Sender: TObject);
begin
  inherited;
  FCadastroFone := TfrmCadastroFone.Create(Self);
  try
    FTelefone.FTelefoneOld := DM.quTelefones.FieldByName('FONE').AsString;

    FCadastroFone.edtFone.Text := DM.quTelefones.FieldByName('FONE').AsString;
    FCadastroFone.edtObs.Text  := DM.quTelefones.FieldByName('OBSE').AsString;
    FCadastroFone.ShowModal;

    if FCadastroFone.ModalResult = mrOk then
    begin
      FTelefone.FIdCliente  := FCliente_ID;
      FTelefone.FTelefone   := FCadastroFone.lFone;
      FTelefone.FObservacao := FCadastroFone.lObservacao;

      FCliente.pAlterarTelefone(FTelefone);
    end;
  finally
    FCadastroFone.Free;
    pAtivaFones;
  end;
end;

procedure TfrmCadastroCliente.btnFoneApagarClick(Sender: TObject);
begin
  FCliente.pBsucarClienteID(FCliente_ID);
  If MessageDlg('Confirma a exclusão do telefone ' +
                 DM.quTelefones.FieldByName('FONE_FORMAT').AsString + '?',
              mtConfirmation, [mbyes, mbno],0) = mrNo then
    Exit;

  FTelefone.FIdCliente  := FCliente_ID;
  FTelefone.FTelefone   := DM.quTelefones.FieldByName('FONE').AsString;
  FTelefone.FObservacao := DM.quTelefones.FieldByName('OBSE').AsString;
  FCliente.pApagarTelefone(FTelefone);
  pAtivaFones;
end;

procedure TfrmCadastroCliente.btnFoneNovoClick(Sender: TObject);
begin
  inherited;
  FCadastroFone := TfrmCadastroFone.Create(Self);
  try
    FTelefone.FIdCliente  := 0;
    FTelefone.FTelefone   := EmptyStr;
    FTelefone.FObservacao := EmptyStr;
    FCadastroFone.ShowModal;

    if FCadastroFone.ModalResult = mrOk then
    begin
      FTelefone.FIdCliente  := FCliente_ID;
      FTelefone.FTelefone   := FCadastroFone.lFone;
      FTelefone.FObservacao := FCadastroFone.lObservacao;

      FCliente.pNovoTelefone(FTelefone);
    end;
  finally
    FCadastroFone.Free;
    pAtivaFones;
  end;
end;

procedure TfrmCadastroCliente.dbGridCellClick(Column: TColumn);
begin
  inherited;
  FCliente_ID := dbGrid.DataSource.DataSet.FieldByName('CLIENTE_ID').AsInteger;
end;

procedure TfrmCadastroCliente.dbGridEnter(Sender: TObject);
begin
  inherited;
  if not dbGrid.DataSource.DataSet.IsEmpty then
  begin
    pAtivarBotoes(True);
  end;
end;

procedure TfrmCadastroCliente.edtCEPChange(Sender: TObject);
begin
  inherited;
  btnBuscarCEP.Enabled := (Length(edtCEP.Text) = 8);
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  inherited;
  FCliente := TClienteController.Create;
  pAtivarBotoes(False);
end;

procedure TfrmCadastroCliente.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCliente);
  inherited;
end;

procedure TfrmCadastroCliente.pAlterar;
begin
  FCliente.pBsucarClienteID(FCliente_ID);
  pMappToComponents;
  pAtivarCampos(True);
  pAtivarBotoesFone(true);
end;

procedure TfrmCadastroCliente.pApagar;
begin
  FCliente.pBsucarClienteID(FCliente_ID);
  If MessageDlg('Confirma a exclusão do cliente?' + #13 +
              'Nome: ' + FCliente.Cliente.Nome + #13 +
              'CPF/CNPJ: ' + FCliente.Cliente.CPF_CNPJ,
              mtConfirmation, [mbyes, mbno],0) = mrNo then
  Exit;
  FCliente.pApagarCliente;
  AtivaClientes(nil);
end;

procedure TfrmCadastroCliente.pNovo;
begin
  pAtivarCampos(True);
  pLimparCampos;
  ckbAtivo.Checked := True;
  pAtivarBotoesFone(False);
end;

procedure TfrmCadastroCliente.pPesquisar;
begin
  FCliente.pSelecionarCliente(EmptyStr);
  AtivaClientes(nil);
end;

procedure TfrmCadastroCliente.pSalvar;
begin
  try
    pMappToClass;
    FCliente.pNovoCliente;
    pAtivarCampos(False);
    pAtivarBotoesFone(True);
  except
  on E: Exception do
    begin
      ShowMessage('Erro ao inserir cliente: ' + E.Message );
    end;
  end;
end;

procedure TfrmCadastroCliente.rgTipoPessoaClick(Sender: TObject);
begin
  inherited;
  if rgTipoPessoa.ItemIndex = 0 then
  begin
    lblCPF.Caption := 'CPF:';
    lblRG.Caption  := 'RG:';

    edtCPF.MaxLength := 11;
  end else
  begin
    lblCPF.Caption := 'CNPJ:';
    lblRG.Caption  := 'IE:';

    edtCPF.MaxLength := 14;
  end;
end;

end.
