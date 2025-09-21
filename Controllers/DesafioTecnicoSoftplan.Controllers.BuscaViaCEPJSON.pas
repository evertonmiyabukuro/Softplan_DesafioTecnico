unit DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSON;

interface

uses
   DesafioTecnicoSoftplan.Controllers.BuscaViaCEP,
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   DesafioTecnicoSoftplan.Models.ICEP,
   System.Generics.Collections,
   System.JSON;

type
   TBuscaViaCEPJSON = class(TBuscaViaCep)
      function retornaCEPComDadosDoViaCEP(prObjViaCep: TJSONObject): ICEP;
   public
      function buscaPorCEP(prCEP: Integer): ICEP; override;
      function buscaPorEndereco(const prUF, prCidade, prEndereco: String): TList<ICEP>; override;
   end;

implementation

uses
   System.SysUtils,
   IdSSLOpenSSLHeaders_static,
   IdSSLOpenSSL,
   DesafioTecnicoSoftplan.Models.CEP,
   IdURI;

{ TBuscaViaCEPJSON }

function TBuscaViaCEPJSON.buscaPorCEP(prCEP: Integer): ICEP;
var
   wRetorno: String;
   wJSVal: TJSONValue;
   wJSObj: TJSONObject;
begin
   result := nil;

   wRetorno := self.BuscadorViaCEP.fazerRequisicaoBusca(Format(C_URL_BUSCACEP_JSON, [prCEP]));
   if wRetorno.IsEmpty() then
      exit;

   wJSVal := TJSONObject.ParseJSONValue(wRetorno);
   try
      if not(wJSVal is TJSONObject) then
         exit;

      wJSObj := (wJSVal as TJSONObject);

      if wJSObj = nil then
         exit;

      if wJSObj.Get('erro') <> nil then
         exit;

      if wJSObj.Count = 0 then
         exit;

      result := retornaCEPComDadosDoViaCEP(wJSObj);
   finally
      freeAndNil(wJSObj);
   end;
end;

function TBuscaViaCEPJSON.buscaPorEndereco(const prUF, prCidade, prEndereco: String): TList<ICEP>;
var
   wRetorno: String;
   wJSVal: TJSONValue;
   wI: Integer;
begin
   result := TList<ICEP>.Create;

   wRetorno := BuscadorViaCEP.fazerRequisicaoBusca(Format(C_URL_BUSCAENDERECO_JSON, [prUF, prCidade, prEndereco]));
   if wRetorno.IsEmpty() then
     exit;

   wJSVal := TJSONObject.ParseJSONValue(wRetorno);
   try
      if not(wJSVal is TJSONArray) then
         exit;

      if (wJSVal as TJSONArray) = nil then
         exit;

      if (wJSVal as TJSONArray).IsEmpty then
         exit;

      for wI := 0 to (wJSVal as TJSONArray).Count - 1 do
         result.Add(retornaCEPComDadosDoViaCEP((wJSVal as TJSONArray).Items[wI] as TJSONObject));
   finally
      freeAndNil(wJSVal);
   end;
end;

function TBuscaViaCEPJSON.retornaCEPComDadosDoViaCEP(prObjViaCep: TJSONObject): ICEP;
begin
   result := nil;

   if prObjViaCep.Get('cep') = nil then
      exit;
   if prObjViaCep.Get('logradouro') = nil then
      exit;
   if prObjViaCep.Get('complemento') = nil then
      exit;
   if prObjViaCep.Get('bairro') = nil then
      exit;
   if prObjViaCep.Get('localidade') = nil then
      exit;
   if prObjViaCep.Get('uf') = nil then
      exit;

   result             := TCEP.Create;
   result.CEP         := StrToIntDef(TJSONString(prObjViaCep.Get('cep').JsonValue).Value.Replace('-', ''), 0);
   result.Logradouro  := (prObjViaCep.Get('logradouro').JsonValue as TJSONString).Value;
   result.Complemento := (prObjViaCep.Get('complemento').JsonValue as TJSONString).Value;
   result.Bairro      := (prObjViaCep.Get('bairro').JsonValue as TJSONString).Value;
   result.Localidade  := (prObjViaCep.Get('localidade').JsonValue as TJSONString).Value;
   result.UF          := (prObjViaCep.Get('uf').JsonValue as TJSONString).Value;;
end;

end.
