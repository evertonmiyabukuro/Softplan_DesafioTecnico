unit DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONCorreto;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Classes;

type
    TMockBuscadorViaCEPEnderecoRetornoJSONCorreto = class(TInterfacedObject, IBuscadorViaCEP)
       function fazerRequisicaoBusca(const prUrl : String) : String;
       function fazerRequisicaoBuscaRetornandoStream(const prUrl : String) : TStringStream;
    end;

implementation

uses
   System.SysUtils,
   System.JSON;



{ TMockBuscadorViaCEPEnderecoRetornoJSONCorreto }

function TMockBuscadorViaCEPEnderecoRetornoJSONCorreto.fazerRequisicaoBusca(const prUrl: String): String;
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

function TMockBuscadorViaCEPEnderecoRetornoJSONCorreto.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
var
   wTmpJSON : TJSONArray;
begin
   wTmpJSON := TJSONArray.Create;
   try
      result := TStringStream.Create('', TEncoding.UTF8);

      wTmpJSON.AddElement(TJSONObject.Create()
                                     .AddPair('cep', '89010-600')
                                     .AddPair('logradouro', 'Rua Hermann Hering')
                                     .AddPair('complemento', 'até 889/890')
                                     .AddPair('unidade', '')
                                     .AddPair('bairro', 'Bom Retiro')
                                     .AddPair('localidade', 'Blumenau')
                                     .AddPair('uf', 'SC')
                                     .AddPair('estado', 'Santa Catarina')
                                     .AddPair('regiao', 'Sul')
                                     .AddPair('ibge', '4202404')
                                     .AddPair('gia', '')
                                     .AddPair('ddd', '47')
                                     .AddPair('siafi', '8047'));

      result.WriteString(wTmpJSON.ToJSON);
   finally
      FreeAndNil(wTmpJSON);
   end;
end;

end.
