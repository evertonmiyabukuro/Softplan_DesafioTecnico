unit DesafioTecnicoSoftplan.Controllers.BuscaViaCEP;

interface

uses
   IdHTTP,
   DesafioTecnicoSoftplan.Controllers.IBuscaViaCEP,
   DesafioTecnicoSoftplan.Models.ICEP,
   System.Classes, DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.Generics.Collections;

type
   TBuscaViaCEP = class(TInterfacedObject, IBuscaViaCEP)
   strict private
      FBuscadorViaCEP: IBuscadorViaCEP;
   protected
      property BuscadorViaCEP: IBuscadorViaCEP read FBuscadorViaCEP;
   public
      function buscaPorCEP(prCEP: Integer): ICEP; virtual; abstract;
      function buscaPorEndereco(const prUF, prCidade, prEndereco: String): TList<ICEP>; virtual; abstract;

      constructor Create(prBuscadorViaCEP: IBuscadorViaCEP);
   end;

const
   C_BASE_URL = 'https://viacep.com.br/ws/';
   C_BASE_URL_BUSCA_CEP = C_BASE_URL + '%d/';
   C_BASE_URL_BUSCA_ENDERECO = C_BASE_URL + '%s/%s/%s/';
   C_URL_BUSCACEP_JSON = C_BASE_URL_BUSCA_CEP + 'json/';
   C_URL_BUSCAENDERECO_JSON = C_BASE_URL_BUSCA_ENDERECO + 'json/';
   C_URL_BUSCACEP_XML = C_BASE_URL_BUSCA_CEP + 'xml/';
   C_URL_BUSCAENDERECO_XML = C_BASE_URL_BUSCA_ENDERECO + 'xml/';

implementation

{ TBuscaViaCEP }

constructor TBuscaViaCEP.Create(prBuscadorViaCEP: IBuscadorViaCEP);
begin
   FBuscadorViaCEP := prBuscadorViaCEP;
end;

end.
