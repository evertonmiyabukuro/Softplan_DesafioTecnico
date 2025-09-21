unit DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONErrado;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Classes;

type
   TMockBuscadorViaCEPRetornoJSONErrado = class(TInterfacedObject, IBuscadorViaCEP)
      function fazerRequisicaoBusca(const prUrl : String) : String;
      function fazerRequisicaoBuscaRetornandoStream(const prUrl : String) : TStringStream;
   end;

implementation

uses
   System.SysUtils,
   System.JSON;

{ TMockBuscadorViaCEPRetornoJSONErrado }

function TMockBuscadorViaCEPRetornoJSONErrado.fazerRequisicaoBusca(const prUrl: String): String;
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

function TMockBuscadorViaCEPRetornoJSONErrado.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
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
