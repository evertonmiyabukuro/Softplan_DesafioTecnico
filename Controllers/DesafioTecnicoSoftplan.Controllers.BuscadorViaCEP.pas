unit DesafioTecnicoSoftplan.Controllers.BuscadorViaCEP;

interface

uses
   IdHTTP,
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   DesafioTecnicoSoftplan.Models.ICEP,
   System.Classes;

type
   TBuscadorViaCEP = class(TInterfacedObject, IBuscadorViaCEP)
   strict private
      const C_BASE_URL = 'https://viacep.com.br/ws/';
   strict private
      const C_BASE_URL_BUSCA_CEP = TBuscadorViaCEP.C_BASE_URL + '%d/';
   strict private
      const C_BASE_URL_BUSCA_ENDERECO = TBuscadorViaCEP.C_BASE_URL + '%s/%s/%s/';
   strict private
      FComponenteHTTP: TIdHTTP;
   protected
      function fazerRequisicaoBusca(const prUrl: String): String;
      function fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
   public
      const C_URL_BUSCACEP_JSON = TBuscadorViaCEP.C_BASE_URL_BUSCA_CEP + 'json/';
      const C_URL_BUSCAENDERECO_JSON = TBuscadorViaCEP.C_BASE_URL_BUSCA_ENDERECO + 'json/';
      const C_URL_BUSCACEP_XML = TBuscadorViaCEP.C_BASE_URL_BUSCA_CEP + 'xml/';
      const C_URL_BUSCAENDERECO_XML = TBuscadorViaCEP.C_BASE_URL_BUSCA_ENDERECO + 'xml/';

      constructor Create;
      destructor Destroy; override;
   end;

implementation

uses
   System.SysUtils,
   IdSSLOpenSSLHeaders_static,
   IdSSLOpenSSL,
   IdURI,
   IdStack;

{ TBuscadorViaCEP }

constructor TBuscadorViaCEP.Create;
begin
   FComponenteHTTP := TIdHTTP.Create(nil);
   FComponenteHTTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(FComponenteHTTP);
   (FComponenteHTTP.IOHandler as TIdSSLIOHandlerSocketOpenSSL).SSLOptions.SSLVersions := [sslvTLSv1_2];
end;

destructor TBuscadorViaCEP.Destroy;
begin
   FreeAndNil(FComponenteHTTP);
end;

function TBuscadorViaCEP.fazerRequisicaoBuscaRetornandoStream(const prUrl: String): TStringStream;
begin
   result := TStringStream.Create('', TEncoding.UTF8, false);
   try
      FComponenteHTTP.Get(TIdURI.UrlEncode(prUrl), result);
      result.Seek(0, soFromBeginning);
   except
      on e: EIdHTTPProtocolException do
         begin
            if (e as EIdHTTPProtocolException).ErrorCode = 400 then
               exit;
         end;
      on e: EIdSocketError do
         begin
           exit;
         end;
   end;
end;

function TBuscadorViaCEP.fazerRequisicaoBusca(const prUrl: String): String;
var
   wTmpStringStream: TStringStream;
begin
   result := '';
   wTmpStringStream := fazerRequisicaoBuscaRetornandoStream(prUrl);
   try
      result := wTmpStringStream.DataString;
   finally
      FreeAndNil(wTmpStringStream);
   end;
end;

end.
