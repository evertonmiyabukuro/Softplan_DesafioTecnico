unit DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoStringVazia;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Classes;

type
   TMockBuscadorViaCEPEnderecoRetornoStringVazia = class(TInterfacedObject, IBuscadorViaCEP)
      function fazerRequisicaoBusca(const prUrl : String) : String;
      function fazerRequisicaoBuscaRetornandoStream(const prUrl : String) : TStringStream;
   end;

implementation

uses
   System.SysUtils;

{ TMockBuscadorViaCEPEnderecoRetornoStringVazia }

function TMockBuscadorViaCEPEnderecoRetornoStringVazia.fazerRequisicaoBusca(const prUrl: String): String;
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

function TMockBuscadorViaCEPEnderecoRetornoStringVazia.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
begin
   result := TStringStream.Create('', TEncoding.UTF8);
end;

end.
