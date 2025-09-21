unit DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSONTest;

interface

uses
   DUnitX.TestFramework,
   DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSON,
   DesafioTecnicoSoftplan.Controllers.BuscaCEPController,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONCorreto,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONErrado,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONVazio,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoStringVazia,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONVarios;

type
   [TestFixture]
   TBuscaViaCEPJSONTest = class
   strict private
      FBuscaViaCep : TBuscaViaCEPJSON;
   public
      [Setup]
      procedure Setup;
      [TearDown]
      procedure TearDown;

      [Test]
      procedure testeBuscaCepComRetornoViaCepVazio;
      [Test]
      procedure testeBuscaCepComJSONVazio;
      [Test]
      procedure testeBuscaCepComJSONCorreto;
      [Test]
      procedure testeBuscaCepComJSONErrado;

      [Test]
      procedure testeBuscaEnderecoComRetornoViaCepVazio;
      [Test]
      procedure testeBuscaEnderecoComJSONVazio;
      [Test]
      procedure testeBuscaEnderecoComJSONErrado;
      [Test]
      procedure testeBuscaEnderecoComJSONCorreto;
      [Test]
      procedure testeBuscaEnderecoComJSONRetornoVariosEnderecos;
   end;

implementation

uses
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   System.SysUtils,
   DesafioTecnicoSoftplan.Models.ICEP,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONErrado,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONCorreto,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONVazio,
   DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoStringVazia,
   System.Generics.Collections;

procedure TBuscaViaCEPJSONTest.Setup;
begin
   FBuscaViaCep := nil;
end;

procedure TBuscaViaCEPJSONTest.TearDown;
begin
end;

procedure TBuscaViaCEPJSONTest.testeBuscaCepComJSONCorreto;
var
   wCep : ICEP;
begin
   FBuscaViaCep := TBuscaViaCEPJSON.Create(TMockBuscadorViaCEPRetornoJSONCorreto.Create());
   try
      wCep := FBuscaViaCep.buscaPorCEP(89010600);
      Assert.IsNotNull(wCep, 'A busca retornou um objeto de CEP nil para um JSON do ViaCEP correto.');

      Assert.AreEqual(89010600,wCep.CEP, 'A busca retornou um CEP diferente do que foi informado para a busca.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPJSONTest.testeBuscaCepComJSONErrado;
var
   wCep : ICEP;
begin
   FBuscaViaCep := TBuscaViaCEPJSON.Create(TMockBuscadorViaCEPRetornoJSONErrado.Create());
   try
      wCep := FBuscaViaCep.buscaPorCEP(89010600);
      Assert.IsNull(wCep, 'A busca retornou um objeto de CEP diferente de nil para um JSON do ViaCEP errado.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPJSONTest.testeBuscaCepComJSONVazio;
var
   wCep : ICEP;
begin
   FBuscaViaCep := TBuscaViaCEPJSON.Create(TMockBuscadorViaCEPRetornoJSONVazio.Create());
   try
      wCep := FBuscaViaCep.buscaPorCEP(89010600);
      Assert.IsNull(wCep, 'A busca retornou um objeto de CEP diferente de nil para um JSON do ViaCEP vazio.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPJSONTest.testeBuscaCepComRetornoViaCepVazio;
var
   wCep : ICEP;
begin
   FBuscaViaCep := TBuscaViaCEPJSON.Create(TMockBuscadorViaCEPRetornoStringVazia.Create());
   try
      wCep := FBuscaViaCep.buscaPorCEP(89010600);
      Assert.IsNull(wCep, 'A busca retornou um objeto de CEP diferente de nil para um retorno do ViaCEP vazio.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPJSONTest.testeBuscaEnderecoComJSONCorreto;
var
   wCeps : TList<ICEP>;
begin
   FBuscaViaCep := TBuscaViaCEPJSON.Create(TMockBuscadorViaCEPEnderecoRetornoJSONCorreto.Create);
   try
      wCeps := FBuscaViaCep.buscaPorEndereco('SC','Blumenau','Rua Hermann Hering');

      Assert.AreEqual(wCeps.Count,1, 'A busca retornou mais de um cep para esse endereço.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPJSONTest.testeBuscaEnderecoComJSONErrado;
var
   wCeps : TList<ICEP>;
begin
   FBuscaViaCep := TBuscaViaCEPJSON.Create(TMockBuscadorViaCEPEnderecoRetornoJSONErrado.Create);
   try
      wCeps := FBuscaViaCep.buscaPorEndereco('SC','Blumenau','Rua Hermann Hering');
      Assert.AreEqual(wCeps.count, 0, 'A busca retornou objetos de CEP para um JSON retornado pelo ViaCEP errado.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

procedure TBuscaViaCEPJSONTest.testeBuscaEnderecoComJSONRetornoVariosEnderecos;
var
   wCeps : TList<ICEP>;
   wCep : ICEP;
begin
   FBuscaViaCep := TBuscaViaCEPJSON.Create(TMockBuscadorViaCEPEnderecoRetornoJSONVarios.Create);
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

procedure TBuscaViaCEPJSONTest.testeBuscaEnderecoComJSONVazio;
var
   wCeps : TList<ICEP>;
begin
   FBuscaViaCep := TBuscaViaCEPJSON.Create(TMockBuscadorViaCEPEnderecoRetornoJSONVazio.Create);
   try
      wCeps := FBuscaViaCep.buscaPorEndereco('SC','Blumenau','Rua Hermann Hering');
      Assert.AreEqual(wCeps.count, 0, 'A busca retornou objetos de CEP para um JSON retornado pelo ViaCEP Vazio.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;
procedure TBuscaViaCEPJSONTest.testeBuscaEnderecoComRetornoViaCepVazio;
var
   wCeps : TList<ICEP>;
begin
   FBuscaViaCep := TBuscaViaCEPJSON.Create(TMockBuscadorViaCEPEnderecoRetornoStringVazia.Create);
   try
      wCeps := FBuscaViaCep.buscaPorEndereco('SC','Blumenau','Rua Hermann Hering');
      Assert.AreEqual(wCeps.count, 0, 'A busca retornou objetos de CEP para um retorno do ViaCEP Vazio.');
   finally
      FreeAndNil(FBuscaViaCep);
   end;
end;

initialization
   TDUnitX.RegisterTestFixture(TBuscaViaCEPJSONTest);

end.
