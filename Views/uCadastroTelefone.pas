unit uCadastroTelefone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCadastroFone = class(TForm)
    pnlTop: TPanel;
    Label1: TLabel;
    lblCPF: TLabel;
    edtObs: TEdit;
    edtFone: TEdit;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    lFone: string;
    lObservacao: string;
  end;

var
  frmCadastroFone: TfrmCadastroFone;

implementation

{$R *.dfm}

procedure TfrmCadastroFone.btnCancelarClick(Sender: TObject);
begin
  lFone := EmptyStr;
  lObservacao := EmptyStr;
  Close;
  ModalResult := mrCancel;
end;

procedure TfrmCadastroFone.btnSalvarClick(Sender: TObject);
begin
  lFone := edtFone.Text;
  lObservacao := edtObs.Text;
  Close;
  ModalResult := mrOk;
end;

procedure TfrmCadastroFone.FormCreate(Sender: TObject);
begin
  lFone := EmptyStr;
  lObservacao := EmptyStr;
end;

end.
