unit DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONVarios;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Classes;

type
   TMockBuscadorViaCEPEnderecoRetornoJSONVarios = class(TInterfacedObject, IBuscadorViaCEP)
      function fazerRequisicaoBusca(const prUrl : String) : String;
      function fazerRequisicaoBuscaRetornandoStream(const prUrl : String) : TStringStream;
   end;

implementation

uses
   System.SysUtils,
   System.JSON;

{ TMockBuscadorViaCEPEnderecoRetornoJSONVarios }

function TMockBuscadorViaCEPEnderecoRetornoJSONVarios.fazerRequisicaoBusca(const prUrl: String): String;
var
  wTempStream : TStringStream;
begin
   wTempStream := nil;
   try
      wTempStream := fazerRequisicaoBuscaRetornandoStream(prURL);
      result := wTempStream.DataString;
   finally
      freeAndNil(wTempStream);
   end;
end;

function TMockBuscadorViaCEPEnderecoRetornoJSONVarios.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
var
   wTmpJSON : TJSONArray;
begin
   wTmpJSON := TJSONArray.Create;
   try
      result := TStringStream.Create('', TEncoding.UTF8);

      wTmpJSON.AddElement(TJSONObject.Create
                                     .AddPair('cep', '91790-072')
                                     .AddPair('logradouro', 'Rua Domingos José Poli')
                                     .AddPair('complemento', '')
                                     .AddPair('unidade', '')
                                     .AddPair('bairro', 'Restinga')
                                     .AddPair('localidade', 'Porto Alegre')
                                     .AddPair('uf', 'RS')
                                     .AddPair('estado', 'Rio Grande do Sul')
                                     .AddPair('regiao', 'Sul')
                                     .AddPair('ibge', '4314902')
                                     .AddPair('gia', '')
                                     .AddPair('ddd', '51')
                                     .AddPair('siafi', '8801'));

      wTmpJSON.AddElement(TJSONObject.Create
                                     .AddPair('cep', '90420-200')
                                     .AddPair('logradouro', 'Rua Domingos José de Almeida')
                                     .AddPair('complemento', '')
                                     .AddPair('unidade', '')
                                     .AddPair('bairro', 'Rio Branco')
                                     .AddPair('localidade', 'Porto Alegre')
                                     .AddPair('uf', 'RS')
                                     .AddPair('estado', 'Rio Grande do Sul')
                                     .AddPair('regiao', 'Sul')
                                     .AddPair('ibge', '4314902')
                                     .AddPair('gia', '')
                                     .AddPair('ddd', '51')
                                     .AddPair('siafi', '8801'));

      result.WriteString(wTmpJSON.ToJSON);
   finally
      FreeAndNil(wTmpJSON);
   end;
end;

end.
