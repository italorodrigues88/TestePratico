program TestePratico;

uses
  Vcl.Forms,
  uMain in '..\Views\uMain.pas' {frmMain},
  uDM in '..\DM\uDM.pas' {DM: TDataModule},
  ConexaoModel in '..\Models\ConexaoModel.pas',
  uCadastroBase in '..\Views\uCadastroBase.pas' {frmCadastroBase},
  uCadastroCliente in '..\Views\uCadastroCliente.pas' {frmCadastroCliente},
  ClienteModel in '..\Models\ClienteModel.pas',
  ClienteController in '..\Controllers\ClienteController.pas',
  ClienteRepository in '..\Repositories\ClienteRepository.pas',
  uCadastroTelefone in '..\Views\uCadastroTelefone.pas' {frmCadastroFone},
  CEPModel in '..\Models\CEPModel.pas',
  CEPController in '..\Controllers\CEPController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
