unit uCadastroBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls;

type

  TAcao = (taNone, taNovo, taAlte);

  TfrmCadastroBase = class(TForm)
    pcDados: TPageControl;
    tbCampos: TTabSheet;
    pnlControle: TPanel;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnPesquisar: TSpeedButton;
    btnFechar: TSpeedButton;
    pnlCampos: TPanel;
    tbGrid: TTabSheet;
    pnlBotoes: TPanel;
    btnFiltro: TSpeedButton;
    lblDescricao: TLabel;
    btnAlterar: TSpeedButton;
    btnApagar: TSpeedButton;
    btnVoltar: TSpeedButton;
    edtFiltro: TEdit;
    pnlGrid: TPanel;
    dbGrid: TDBGrid;
    procedure btnFecharClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure pPageAtiva(Index: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
  private
    { Private declarations }
    procedure pControleBotoes;
  public
    { Public declarations }
    FAcao: TAcao;
    procedure pSalvar; virtual;
    procedure pApagar; virtual;
    procedure pNovo; virtual;
    procedure pCancelar; virtual;
    procedure pAlterar; virtual;
    procedure pPesquisar; virtual;
  end;

var
  frmCadastroBase: TfrmCadastroBase;

implementation

uses
  uDM, uMain;

{$R *.dfm}

{ TfrmCadastroBase }

procedure TfrmCadastroBase.btnAlterarClick(Sender: TObject);
begin
  pAlterar;
  FAcao := taAlte;
  pControleBotoes;
  pPageAtiva(0);
end;

procedure TfrmCadastroBase.btnApagarClick(Sender: TObject);
begin
  pApagar;
end;

procedure TfrmCadastroBase.btnCancelarClick(Sender: TObject);
begin
  pCancelar;
  FAcao := taNone;
  pControleBotoes;
end;

procedure TfrmCadastroBase.btnFecharClick(Sender: TObject);
begin
  FormAtivo := False;
  Close;
end;

procedure TfrmCadastroBase.btnNovoClick(Sender: TObject);
begin
  pNovo;
  FAcao := taNovo;
  pControleBotoes;
end;

procedure TfrmCadastroBase.btnPesquisarClick(Sender: TObject);
begin
  pPesquisar;
  pPageAtiva(1);
end;

procedure TfrmCadastroBase.btnSalvarClick(Sender: TObject);
begin
  pSalvar;
  FAcao := taNone;
  pControleBotoes;
end;

procedure TfrmCadastroBase.btnVoltarClick(Sender: TObject);
begin
  pPageAtiva(0);
end;

procedure TfrmCadastroBase.FormDestroy(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroBase.FormShow(Sender: TObject);
begin
  tbCampos.TabVisible := False;
  tbGrid.TabVisible := False;
  pPageAtiva(0);
end;

procedure TfrmCadastroBase.pControleBotoes;
begin
  btnSalvar.Enabled    := (FAcao in [taNovo, taAlte]);
  btnCancelar.Enabled  := btnSalvar.Enabled;

  btnPesquisar.Enabled := (FAcao = taNone);
  btnNovo.Enabled      := btnPesquisar.Enabled;
end;

procedure TfrmCadastroBase.pCancelar;
begin
  // Virtual
end;

procedure TfrmCadastroBase.pAlterar;
begin
  // Virtual
end;

procedure TfrmCadastroBase.pApagar;
begin
  // Virtual
end;

procedure TfrmCadastroBase.pSalvar;
begin
  // Virtual
end;

procedure TfrmCadastroBase.pNovo;
begin
  // Virtual
end;

procedure TfrmCadastroBase.pPageAtiva(Index: Integer);
begin
  pcDados.ActivePageIndex := Index;
end;

procedure TfrmCadastroBase.pPesquisar;
begin
  // Virtual
end;

end.
