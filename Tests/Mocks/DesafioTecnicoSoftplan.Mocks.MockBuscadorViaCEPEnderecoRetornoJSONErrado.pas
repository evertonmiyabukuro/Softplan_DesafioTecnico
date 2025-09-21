unit DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONErrado;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Classes;

type
   TMockBuscadorViaCEPEnderecoRetornoJSONErrado = class(TInterfacedObject, IBuscadorViaCEP)
      function fazerRequisicaoBusca(const prUrl : String) : String;
      function fazerRequisicaoBuscaRetornandoStream(const prUrl : String) : TStringStream;
   end;

implementation

uses
   System.SysUtils,
   System.JSON;

{ TMockBuscadorViaCEPEnderecoRetornoJSONErrado }

function TMockBuscadorViaCEPEnderecoRetornoJSONErrado.fazerRequisicaoBusca(const prUrl: String): String;
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

function TMockBuscadorViaCEPEnderecoRetornoJSONErrado.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
var
   wTmpJSON: TJSONObject;
begin
   wTmpJSON := TJSONObject.Create;
   try
      wTmpJSON.AddPair('teste', True);

      result := TStringStream.Create('', TEncoding.UTF8);
      result.WriteString(wTmpJSON.ToJSON);
   finally
      FreeAndNil(wTmpJSON);
   end;
end;

end.
