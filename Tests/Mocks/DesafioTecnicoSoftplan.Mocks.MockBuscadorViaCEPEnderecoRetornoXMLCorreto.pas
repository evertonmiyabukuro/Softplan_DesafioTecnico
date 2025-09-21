unit DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLCorreto;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Classes;

type
   TMockBuscadorViaCEPEnderecoRetornoXMLCorreto = class(TInterfacedObject, IBuscadorViaCEP)
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
           '      <cep>89062-080</cep>'+
           '      <logradouro>Rua Tereza Fischer</logradouro>'+
           '      <complemento></complemento>'+
           '      <unidade></unidade>'+
           '      <bairro>Itoupava Central</bairro>'+
           '      <localidade>Blumenau</localidade>'+
           '      <uf>SC</uf>'+
           '      <estado>Santa Catarina</estado>'+
           '      <regiao>Sul</regiao>'+
           '      <ibge>4202404</ibge>'+
           '      <gia></gia>'+
           '      <ddd>47</ddd>'+
           '      <siafi>8047</siafi>'+
           '    </endereco>'+
           '  </enderecos>'+
           '</xmlcep>';

{ TMockBuscadorViaCEPEnderecoRetornoXMLCorreto }

function TMockBuscadorViaCEPEnderecoRetornoXMLCorreto.fazerRequisicaoBusca(const prUrl: String): String;
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

function TMockBuscadorViaCEPEnderecoRetornoXMLCorreto.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
begin
   result := TStringStream.Create('', TEncoding.UTF8);
   result.WriteString(C_XML);
end;

end.
