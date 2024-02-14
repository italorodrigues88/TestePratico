unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.StrUtils,  Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmMain = class(TForm)
    sbPrinc: TStatusBar;
    pnlPrinc: TPanel;
    mmPrincipal: TMainMenu;
    Funcionario: TMenuItem;
    Sair: TMenuItem;
    CadCliente: TMenuItem;
    procedure SairClick(Sender: TObject);
    procedure CadClienteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pAtualizaConexao(Conectado: Boolean);
  end;

var
  frmMain: TfrmMain;
  FormAtivo: Boolean;

implementation

uses
  uCadastroCliente;

{$R *.dfm}

{ TfrmMain }

procedure TfrmMain.CadClienteClick(Sender: TObject);
begin
  if not FormAtivo then
  begin
    Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
    frmCadastroCliente.Parent := pnlPrinc;
    frmCadastroCliente.Align  := alClient;
    frmCadastroCliente.Show;
    FormAtivo := True;
  end;
end;

procedure TfrmMain.pAtualizaConexao(Conectado: Boolean);
begin
  sbprinc.Panels[0].Text := 'Status do Banco: ' + IfThen(Conectado, 'Conectado', 'Desconectado');
end;

procedure TfrmMain.SairClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
