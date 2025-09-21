unit DesafioTecnicoSoftplan.Models.ICEP;

interface

type
   ICEP = interface
      function GetCodigo: Integer;
      procedure SetCodigo(const Value: Integer);

      function GetCEP: Integer;
      procedure SetCEP(const Value: Integer);

      function GetLogradouro: string;
      procedure SetLogradouro(const Value: string);

      function GetComplemento: string;
      procedure SetComplemento(const Value: string);

      function GetBairro: string;
      procedure SetBairro(const Value: string);

      function GetLocalidade: string;
      procedure SetLocalidade(const Value: string);

      function GetUF: string;
      procedure SetUF(const Value: string);

      property Codigo: Integer read GetCodigo write SetCodigo;
      property CEP: Integer read GetCEP write SetCEP;
      property Logradouro: string read GetLogradouro write SetLogradouro;
      property Complemento: string read GetComplemento write SetComplemento;
      property Bairro: string read GetBairro write SetBairro;
      property Localidade: string read GetLocalidade write SetLocalidade;
      property UF: string read GetUF write SetUF;
   end;

implementation

end.
