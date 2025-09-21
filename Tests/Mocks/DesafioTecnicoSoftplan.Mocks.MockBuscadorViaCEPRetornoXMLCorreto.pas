unit DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLCorreto;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Classes;

type
   TMockBuscadorViaCEPRetornoXMLCorreto = class(TInterfacedObject, IBuscadorViaCEP)
      function fazerRequisicaoBusca(const prUrl : String) : String;
      function fazerRequisicaoBuscaRetornandoStream(const prUrl : String) : TStringStream;
   end;

implementation

uses
   System.SysUtils;

const
   C_XML = '<?xml version="1.0" encoding="UTF-8"?>'+
           '<xmlcep>'+
           '  <cep>89010-600</cep>'+
           '  <logradouro>Rua Hermann Hering</logradouro>'+
           '  <complemento>até 889/890</complemento>'+
           '  <unidade></unidade>'+
           '  <bairro>Bom Retiro</bairro>'+
           '  <localidade>Blumenau</localidade>'+
           '  <uf>SC</uf>'+
           '  <estado>Santa Catarina</estado>'+
           '  <regiao>Sul</regiao>'+
           '  <ibge>4202404</ibge>'+
           '  <gia></gia>'+
           '  <ddd>47</ddd>'+
           '  <siafi>8047</siafi>'+
           '</xmlcep>';

{ TMockBuscadorViaCEPRetornoXMLCorreto }

function TMockBuscadorViaCEPRetornoXMLCorreto.fazerRequisicaoBusca(const prUrl: String): String;
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

function TMockBuscadorViaCEPRetornoXMLCorreto.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
begin
   result := TStringStream.Create('', TEncoding.UTF8);
   result.WriteString(C_XML);
end;

end.
