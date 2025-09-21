unit DesafioTecnicoSoftplan.Controllers.BuscaVIACEPXML;

interface

uses
   DesafioTecnicoSoftplan.Controllers.BuscaViaCEP,
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   DesafioTecnicoSoftplan.Models.ICEP,
   System.Generics.Collections,
   Xml.XMLDoc,
   Xml.xmldom,
   Xml.XMLIntf,
   IdHTTP;

type
   TBuscaViaCEPXML = class(TBuscaViaCEP)
      function retornaCEPComDadosDoViaCEP(prObjViaCep: IDOMNode): ICEP;
   public
      function buscaPorCEP(prCEP: Integer): ICEP; override;
      function buscaPorEndereco(const prUF, prCidade, prEndereco: String): TList<ICEP>; override;
   end;

implementation

uses
   System.SysUtils,
   IdSSLOpenSSLHeaders_static,
   IdSSLOpenSSL,
   Xml.omnixmldom,
   DesafioTecnicoSoftplan.Models.CEP,
   System.Classes,
   IdException;

{ TBuscaViaCEPXML }

function TBuscaViaCEPXML.buscaPorCEP(prCEP: Integer): ICEP;
var
   wXMLDoc: TXMLDocument;
   wStringStream: TStringStream;
begin
   result := nil;

   wStringStream := BuscadorViaCEP.fazerRequisicaoBuscaRetornandoStream(Format(C_URL_BUSCACEP_XML, [prCEP]));
   try
      if wStringStream = nil then
         exit;

      if wStringStream.Size = 0 then
         exit;

      wStringStream.Seek(0, soFromBeginning);

      wXMLDoc := TXMLDocument.Create(nil);
      try
         wXMLDoc.DOMVendor := GetDOMVendor(sOmniXmlVendor);
         wXMLDoc.LoadFromStream(wStringStream, xetUTF_8);

         if wXMLDoc.DOMDocument.firstChild = nil then
            exit;

         if wXMLDoc.DOMDocument.firstChild.nodeName <> 'xml' then
            exit;

         if wXMLDoc.DOMDocument.firstChild.nextSibling = nil then
            exit;

         if wXMLDoc.DOMDocument.firstChild.nextSibling.nodeName <> 'xmlcep' then
            exit;

         result := retornaCEPComDadosDoViaCEP(wXMLDoc.DOMDocument.firstChild.nextSibling);
      finally
         freeAndNil(wXMLDoc);
      end;
   finally
      freeAndNil(wStringStream);
   end;
end;

function TBuscaViaCEPXML.buscaPorEndereco(const prUF, prCidade, prEndereco: String): TList<ICEP>;
var
   wXMLDoc: TXMLDocument;
   wStringStream: TStringStream;
   wNodeXMLCep: IDOMNode;
   wNodeListaEnderecos: IDOMNode;
   wI: Integer;
begin
  result := TList<ICEP>.Create;

  wStringStream := self.BuscadorViaCEP.fazerRequisicaoBuscaRetornandoStream(Format(C_URL_BUSCAENDERECO_XML, [prUF, prCidade, prEndereco]));
  try
     if wStringStream = nil then
        exit;

     if wStringStream.Size = 0 then
        exit;

     wStringStream.Seek(0, soFromBeginning);

     wXMLDoc := TXMLDocument.Create(nil);
     try
        wXMLDoc.DOMVendor := GetDOMVendor(sOmniXmlVendor);
        wXMLDoc.LoadFromStream(wStringStream, xetUTF_8);

        if wXMLDoc.DOMDocument.firstChild = nil then
           exit;

        if wXMLDoc.DOMDocument.firstChild.nodeName <> 'xml' then
           exit;

        wNodeXMLCep := wXMLDoc.DOMDocument.firstChild.nextSibling;

        if wNodeXMLCep = nil then
           exit;

        if wNodeXMLCep.nodeName <> 'xmlcep' then
           exit;

        wNodeListaEnderecos := wNodeXMLCep.firstChild;
        if wNodeListaEnderecos = nil then
           exit;
        if wNodeListaEnderecos.nodeName <> 'enderecos' then
          exit;

        for wI := 0 to wNodeListaEnderecos.childNodes.length - 1 do
          result.Add(retornaCEPComDadosDoViaCEP(wNodeListaEnderecos.childNodes.item[wI]));
     finally
        freeAndNil(wXMLDoc);
     end;
  finally
     freeAndNil(wStringStream);
  end;
end;

function TBuscaViaCEPXML.retornaCEPComDadosDoViaCEP(prObjViaCep: IDOMNode): ICEP;
var
  wI: Integer;
begin
   result := nil;

   if prObjViaCep.childNodes.length = 1 then
      begin
        if prObjViaCep.childNodes.item[0].nodeName.Equals('erro') then
           exit;

        if prObjViaCep.childNodes.item[0].firstChild = nil then
           exit;
      end;

   result := TCep.Create;

   for wI := 0 to prObjViaCep.childNodes.length - 1 do
      begin
        if prObjViaCep.childNodes.item[wI].firstChild = nil then
           continue;

        if prObjViaCep.childNodes.item[wI].nodeName.Equals('cep') then
           begin
              result.CEP := StrToIntDef(prObjViaCep.childNodes.item[wI].firstChild.nodeValue.Replace('-', ''), 0);
              continue;
           end;

        if prObjViaCep.childNodes.item[wI].nodeName.Equals('logradouro') then
           begin
              result.Logradouro := prObjViaCep.childNodes.item[wI].firstChild.nodeValue;
              continue;
           end;

        if prObjViaCep.childNodes.item[wI].nodeName.Equals('complemento') then
           begin
              result.Complemento := prObjViaCep.childNodes.item[wI].firstChild.nodeValue;
              continue;
           end;

        if prObjViaCep.childNodes.item[wI].nodeName.Equals('bairro') then
           begin
              result.Bairro := prObjViaCep.childNodes.item[wI].firstChild.nodeValue;
              continue;
           end;

        if prObjViaCep.childNodes.item[wI].nodeName.Equals('localidade') then
           begin
              result.Localidade := prObjViaCep.childNodes.item[wI].firstChild.nodeValue;
              continue;
           end;

        if prObjViaCep.childNodes.item[wI].nodeName.Equals('uf') then
           begin
              result.UF := prObjViaCep.childNodes.item[wI].firstChild.nodeValue;
              continue;
           end;
      end;
end;

end.
