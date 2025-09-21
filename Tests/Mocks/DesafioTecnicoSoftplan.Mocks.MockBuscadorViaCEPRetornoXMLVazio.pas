unit DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLVazio;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Classes;

type
   TMockBuscadorViaCEPRetornoXMLVazio = class(TInterfacedObject, IBuscadorViaCEP)
      function fazerRequisicaoBusca(const prUrl : String) : String;
      function fazerRequisicaoBuscaRetornandoStream(const prUrl : String) : TStringStream;
   end;

implementation

uses
   System.SysUtils;

{ TMockBuscadorViaCEPRetornoXMLVazio }

function TMockBuscadorViaCEPRetornoXMLVazio.fazerRequisicaoBusca(const prUrl: String): String;
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

function TMockBuscadorViaCEPRetornoXMLVazio.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
begin
   result := TStringStream.Create('', TEncoding.UTF8);
   result.WriteString('<?xml version="1.0" encoding="utf-8"?>'+
                      '<xmlcep>'+
                      '  <enderecos/>'+
                      '</xmlcep>');
end;

end.
