unit DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEPTest;

interface

uses
   DUnitX.TestFramework,
   DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEP;

type
   [TestFixture]
   TValidacoesTelaBuscaCEPTest = class
   strict private
      FValidacoesTelaBuscaCEP: TValidacoesTelaBuscaCEP;
   public
      [Setup]
      procedure Setup;
      [TearDown]
      procedure TearDown;
      [Test]
      [TestCase('CEP certo', '89010-600,true,89010600')]
      [TestCase('CEP errado, não obedendo a máscara', '898841984,false,0')]
      [TestCase('CEP errado, com caracteres alfanuméricos', 'a1bd1,false,0')]
      [TestCase('CEP errado, vazio', ',false,0')]
      procedure ValidarCEPDigitado(const prCepDigitado: String; prCorreto: Boolean; prCepConvertidoEsperado: Integer);

      [Test]
      [TestCase('Endereço certo', 'SC,Blumenau,Rua XV de Novembro,true')]
      [TestCase('Endereço errado', 'xx,Blumenau,Rua XV de Novembro,false')]
      [TestCase('Endereço errado', 'SC,Bl,Rua XV de Novembro,false')]
      [TestCase('Endereço errado', 'SC,Blumenau,ro,false')]
      procedure ValidarEnderecoInformado(const prUF, prCidade, prLogradouro: String; prCorreto: Boolean);
   end;

implementation

uses
   DesafioTecnicoSoftplan.Controllers.IEventosMensagens,
   DesafioTecnicoSoftplan.Mocks.EventosTelaUI;

procedure TValidacoesTelaBuscaCEPTest.Setup;
begin
   FValidacoesTelaBuscaCEP := TValidacoesTelaBuscaCEP.Create(TMockEventosTelaUI.Create);
end;

procedure TValidacoesTelaBuscaCEPTest.TearDown;
begin
end;

procedure TValidacoesTelaBuscaCEPTest.ValidarCEPDigitado(const prCepDigitado: String; prCorreto: Boolean; prCepConvertidoEsperado: Integer);
var
   wCepConvertido: Integer;
begin
   Assert.AreEqual(FValidacoesTelaBuscaCEP.validarCep(prCepDigitado, wCepConvertido), prCorreto, 'A validação não retornou o resultado (válido ou não) esperado!');

   Assert.AreEqual(wCepConvertido, prCepConvertidoEsperado, 'O Cep convertido não bate com o esperado!');
end;

procedure TValidacoesTelaBuscaCEPTest.ValidarEnderecoInformado(const prUF, prCidade, prLogradouro: String; prCorreto: Boolean);
begin
   Assert.AreEqual(FValidacoesTelaBuscaCEP.validarEntradasParaEndereco(prUF, prCidade, prLogradouro), prCorreto, 'A validação não retornou o resultado (válido ou não) esperado!');
end;

initialization
   TDUnitX.RegisterTestFixture(TValidacoesTelaBuscaCEPTest);

end.
