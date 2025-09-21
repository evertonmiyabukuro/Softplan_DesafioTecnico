unit DesafioTecnicoSoftplan.Models.CEP;

interface

uses
   DesafioTecnicoSoftplan.Models.ICEP;

type
   TCEP = class(TInterfacedObject, ICEP)
   private
      FCodigo: Integer;
      FCEP: Integer;
      FLogradouro: string;
      FComplemento: string;
      FBairro: string;
      FLocalidade: string;
      FUF: string;

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

   public
      property Codigo: Integer read GetCodigo write SetCodigo;
      property CEP: Integer read GetCEP write SetCEP;
      property Logradouro: string read GetLogradouro write SetLogradouro;
      property Complemento: string read GetComplemento write SetComplemento;
      property Bairro: string read GetBairro write SetBairro;
      property Localidade: string read GetLocalidade write SetLocalidade;
      property UF: string read GetUF write SetUF;

      constructor Create;
   end;

implementation

{ TCEP }

constructor TCEP.Create;
begin
   inherited;
   FCodigo := 0;
   FCEP := 0;
   FLogradouro := '';
   FComplemento := '';
   FBairro := '';
   FLocalidade := '';
   FUF := '';
end;

function TCEP.GetBairro: string;
begin
   Result := FBairro;
end;

function TCEP.GetCEP: Integer;
begin
   Result := FCEP;
end;

function TCEP.GetCodigo: Integer;
begin
   Result := FCodigo;
end;

function TCEP.GetComplemento: string;
begin
   Result := FComplemento;
end;

function TCEP.GetLocalidade: string;
begin
   Result := FLocalidade;
end;

function TCEP.GetLogradouro: string;
begin
   Result := FLogradouro;
end;

function TCEP.GetUF: string;
begin
   Result := FUF;
end;

procedure TCEP.SetBairro(const Value: string);
begin
   FBairro := Value;
end;

procedure TCEP.SetCEP(const Value: Integer);
begin
   FCEP := Value;
end;

procedure TCEP.SetCodigo(const Value: Integer);
begin
   FCodigo := Value;
end;

procedure TCEP.SetComplemento(const Value: string);
begin
   FComplemento := Value;
end;

procedure TCEP.SetLocalidade(const Value: string);
begin
   FLocalidade := Value;
end;

procedure TCEP.SetLogradouro(const Value: string);
begin
   FLogradouro := Value;
end;

procedure TCEP.SetUF(const Value: string);
begin
   FUF := Value;
end;

end.
