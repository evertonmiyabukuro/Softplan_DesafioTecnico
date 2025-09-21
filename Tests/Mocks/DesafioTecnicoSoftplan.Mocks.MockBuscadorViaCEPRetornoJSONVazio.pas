unit DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONVazio;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Classes;

type
   TMockBuscadorViaCEPRetornoJSONVazio = class(TInterfacedObject, IBuscadorViaCEP)
      function fazerRequisicaoBusca(const prUrl : String) : String;
      function fazerRequisicaoBuscaRetornandoStream(const prUrl : String) : TStringStream;
   end;

implementation

uses
   System.SysUtils;

{ TMockBuscadorViaCEPRetornoJSONVazio }

function TMockBuscadorViaCEPRetornoJSONVazio.fazerRequisicaoBusca(const prUrl: String): String;
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

function TMockBuscadorViaCEPRetornoJSONVazio.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
begin
   result := TStringStream.Create('', TEncoding.UTF8);
   result.WriteString('{}');
end;

end.
