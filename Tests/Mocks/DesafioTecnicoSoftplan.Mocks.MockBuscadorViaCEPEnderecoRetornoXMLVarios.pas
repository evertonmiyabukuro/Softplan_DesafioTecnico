unit DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLVarios;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Classes;

type
   TMockBuscadorViaCEPEnderecoRetornoXMLVarios = class(TInterfacedObject, IBuscadorViaCEP)
      function fazerRequisicaoBusca(const prUrl : String) : String;
      function fazerRequisicaoBuscaRetornandoStream(const prUrl : String) : TStringStream;
   end;

implementation

uses
   System.SysUtils;

const
   C_XML = '<?xml version="1.0" encoding="utf-8"?>'+
           '<xmlcep>'+
           '  <enderecos>'+
           '    <endereco>'+
           '      <cep>91790-072</cep>'+
           '      <logradouro>Rua Domingos José Poli</logradouro>'+
           '      <complemento></complemento>'+
           '      <unidade></unidade>'+
           '      <bairro>Restinga</bairro>'+
           '      <localidade>Porto Alegre</localidade>'+
           '      <uf>RS</uf>'+
           '      <estado>Rio Grande do Sul</estado>'+
           '      <regiao>Sul</regiao>'+
           '      <ibge>4314902</ibge>'+
           '      <gia></gia>'+
           '      <ddd>51</ddd>'+
           '      <siafi>8801</siafi>'+
           '    </endereco>'+
           '    <endereco>'+
           '      <cep>90420-200</cep>'+
           '      <logradouro>Rua Domingos José de Almeida</logradouro>'+
           '      <complemento></complemento>'+
           '      <unidade></unidade>'+
           '      <bairro>Rio Branco</bairro>'+
           '      <localidade>Porto Alegre</localidade>'+
           '      <uf>RS</uf>'+
           '      <estado>Rio Grande do Sul</estado>'+
           '      <regiao>Sul</regiao>'+
           '      <ibge>4314902</ibge>'+
           '      <gia></gia>'+
           '      <ddd>51</ddd>'+
           '      <siafi>8801</siafi>'+
           '    </endereco>'+
           '  </enderecos>'+
           '</xmlcep>';

{ TMockBuscadorViaCEPEnderecoRetornoXMLVarios }

function TMockBuscadorViaCEPEnderecoRetornoXMLVarios.fazerRequisicaoBusca(const prUrl: String): String;
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

function TMockBuscadorViaCEPEnderecoRetornoXMLVarios.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
begin
   result := TStringStream.Create('', TEncoding.UTF8);
   result.WriteString(C_XML);
end;

end.
