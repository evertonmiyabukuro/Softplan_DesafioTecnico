unit DesafioTecnicoSoftplan.Controllers.BuscaViaCEPXMLTest;

interface

uses
   DUnitX.TestFramework,
   DesafioTecnicoSoftplan.Controllers.BuscaViaCEPXML,
   DesafioTecnicoSoftplan.Controllers.BuscaCEPController,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLCorreto,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLErrado,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLVazio,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoStringVazia,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLVarios;

type
   [TestFixture]
   TBuscaViaCEPXMLTest = class
   strict private
      FBuscaViaCep : TBuscaViaCEPXML;
   public
      [Setup]
      procedure Setup;
      [TearDown]
      procedure TearDown;

      [Test]
      procedure testeBuscaCepComRetornoViaCepVazio;
      [Test]
      procedure testeBuscaCepComXMLVazio;
      [Test]
      procedure testeBuscaCepComXMLCorreto;
      [Test]
      procedure testeBuscaCepComXMLErrado;

      [Test]
      procedure testeBuscaEnderecoComRetornoViaCepVazio;
      [Test]
      procedure testeBuscaEnderecoComXMLVazio;
      [Test]
      procedure testeBuscaEnderecoComXMLErrado;
      [Test]
      procedure testeBuscaEnderecoComXMLCorreto;
      [Test]
      procedure testeBuscaEnderecoComXMLRetornoVariosEnderecos;
   end;

implementation

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.SysUtils,
   DesafioTecnicoSoftplan.Models.ICEP,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLErrado,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLCorreto,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLVazio,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoStringVazia,
   System.Generics.Collections;

procedure TBuscaViaCEPXMLTest.Setup;
begin
   FBuscaViaCep := nil;
end;

procedure TBuscaViaCEPXMLTest.TearDown;
begin
end;

procedure TBuscaViaCEPXMLTest.testeBuscaCepComXMLCorreto;
var
   wCep : ICEP;
begin
   FBuscaViaCep := TBuscaViaCEPXML.Create(TMockBuscadorViaCEPRetornoXMLCorreto.Create());
   try
      wCep := FBuscaViaCep.buscaPorCEP(89010600);
      Assert.IsNotNull(wCep, 'A busca retornou um objeto de CEP nil para um XML do ViaCEP correto.');

      Assert.AreEqual(89010600,wCep.CEP, 'A busca retornou um CEP diferente do que foi informado para a busca.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPXMLTest.testeBuscaCepComXMLErrado;
var
   wCep : ICEP;
begin
   FBuscaViaCep := TBuscaViaCEPXML.Create(TMockBuscadorViaCEPRetornoXMLErrado.Create());
   try
      wCep := FBuscaViaCep.buscaPorCEP(89010600);
      Assert.IsNull(wCep, 'A busca retornou um objeto de CEP diferente de nil para um XML do ViaCEP errado.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPXMLTest.testeBuscaCepComXMLVazio;
var
   wCep : ICEP;
begin
   FBuscaViaCep := TBuscaViaCEPXML.Create(TMockBuscadorViaCEPRetornoXMLVazio.Create());
   try
      wCep := FBuscaViaCep.buscaPorCEP(89010600);
      Assert.IsNull(wCep, 'A busca retornou um objeto de CEP diferente de nil para um XML do ViaCEP vazio.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPXMLTest.testeBuscaCepComRetornoViaCepVazio;
var
   wCep : ICEP;
begin
   FBuscaViaCep := TBuscaViaCEPXML.Create(TMockBuscadorViaCEPRetornoStringVazia.Create());
   try
      wCep := FBuscaViaCep.buscaPorCEP(89010600);
      Assert.IsNull(wCep, 'A busca retornou um objeto de CEP diferente de nil para um retorno do ViaCEP vazio.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPXMLTest.testeBuscaEnderecoComXMLCorreto;
var
   wCeps : TList<ICEP>;
begin
   FBuscaViaCep := TBuscaViaCEPXML.Create(TMockBuscadorViaCEPEnderecoRetornoXMLCorreto.Create);
   try
      wCeps := FBuscaViaCep.buscaPorEndereco('SC','Blumenau','Rua Hermann Hering');

      Assert.AreEqual(wCeps.Count,1, 'A busca retornou mais de um cep para esse endereço.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPXMLTest.testeBuscaEnderecoComXMLErrado;
var
   wCeps : TList<ICEP>;
begin
   FBuscaViaCep := TBuscaViaCEPXML.Create(TMockBuscadorViaCEPEnderecoRetornoXMLErrado.Create);
   try
      wCeps := FBuscaViaCep.buscaPorEndereco('SC','Blumenau','Rua Hermann Hering');
      Assert.AreEqual(wCeps.count, 0, 'A busca retornou objetos de CEP para um XML retornado pelo ViaCEP errado.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPXMLTest.testeBuscaEnderecoComXMLRetornoVariosEnderecos;
var
   wCeps : TList<ICEP>;
   wCep : ICEP;
begin
   FBuscaViaCep := TBuscaViaCEPXML.Create(TMockBuscadorViaCEPEnderecoRetornoXMLVarios.Create);
   try
      wCeps := FBuscaViaCep.buscaPorEndereco('RS','Porto Alegre','Domingos José');

      Assert.AreNotEqual(wCeps.count, 0, 'A busca retornou objetos de CEP para uma consulta que deveria retornar mais CEPs');

      for wCep in wCeps do
         begin
            if (wCep.CEP <> 91790072) and
               (wCep.CEP <> 90420200) then
               Assert.Fail('Retornou algum CEP diferente dos esperados para os dados da busca');
         end;
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPXMLTest.testeBuscaEnderecoComXMLVazio;
var
   wCeps : TList<ICEP>;
begin
   FBuscaViaCep := TBuscaViaCEPXML.Create(TMockBuscadorViaCEPEnderecoRetornoXMLVazio.Create);
   try
      wCeps := FBuscaViaCep.buscaPorEndereco('SC','Blumenau','Rua Hermann Hering');
      Assert.AreEqual(wCeps.count, 0, 'A busca retornou objetos de CEP para um XML retornado pelo ViaCEP Vazio.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;
procedure TBuscaViaCEPXMLTest.testeBuscaEnderecoComRetornoViaCepVazio;
var
   wCeps : TList<ICEP>;
begin
   FBuscaViaCep := TBuscaViaCEPXML.Create(TMockBuscadorViaCEPEnderecoRetornoStringVazia.Create);
   try
      wCeps := FBuscaViaCep.buscaPorEndereco('SC','Blumenau','Rua Hermann Hering');
      Assert.AreEqual(wCeps.count, 0, 'A busca retornou objetos de CEP para um retorno do ViaCEP Vazio.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

initialization
   TDUnitX.RegisterTestFixture(TBuscaViaCEPXMLTest);

end.
