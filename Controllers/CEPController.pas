unit CEPController;

interface

uses
  CEPModel, System.SysUtils, System.Classes, IdHTTP, System.JSON,
  IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TCEPController = class
  private
    fcep: TCep;
  public
    constructor Create;
    destructor Destroy; override;
    function ConsultarCep(ACep: string): TCEP;
    property CEP  : TCep    read FCEP     write  FCEP;
  end;

implementation

{ TCEPController }

function TCEPController.ConsultarCep(ACep: string): TCEP;
var
  lIdHTTP: TIdHTTP;
  lJSONData: TJSONObject;
  lSSLIOHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  lIdHTTP := TIdHTTP.Create(nil);
  lSSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    lSSLIOHandler.SSLOptions.Method := sslvTLSv1_2;
    lIdHTTP.IOHandler := lSSLIOHandler;
    lJSONData := TJSONObject.ParseJSONValue(lIdHTTP.Get('https://viacep.com.br/ws/' + ACep + '/json/')) as TJSONObject;
    try
      FCEP := TCEP.Create;
      FCEP.Cep := lJSONData.GetValue('cep').Value;
      FCEP.Logradouro := lJSONData.GetValue('logradouro').Value;
      FCEP.Bairro := lJSONData.GetValue('bairro').Value;
      FCEP.Localidade := lJSONData.GetValue('localidade').Value;
      FCEP.UF := lJSONData.GetValue('uf').Value;
    finally
      FreeAndNil(lJSONData);
    end;
  finally
    FreeAndNil(lIdHTTP);
    FreeAndNil(lSSLIOHandler);
  end;
  Result := FCEP;
end;

constructor TCEPController.Create;
begin
  FCEP := TCep.Create;
end;

destructor TCEPController.destroy;
begin
  FreeAndNil(FCEP);
  inherited;
end;

end.

