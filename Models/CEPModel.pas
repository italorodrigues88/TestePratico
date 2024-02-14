unit CEPModel;

interface

uses
  System.SysUtils, System.Classes;

type
  TCep = class
  private
    FCep        : string;
    FLogradouro : string;
    FBairro     : string;
    FLocalidade : string;
    FUF         : string;
  public
    property Cep        : string   read FCep        write FCep;
    property Logradouro : string   read FLogradouro write FLogradouro;
    property Bairro     : string   read FBairro     write FBairro;
    property Localidade : string   read FLocalidade write FLocalidade;
    property UF         : string   read FUF         write FUF;
  end;

implementation

end.

