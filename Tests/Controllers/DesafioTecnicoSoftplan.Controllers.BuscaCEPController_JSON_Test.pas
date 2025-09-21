unit DesafioTecnicoSoftplan.Controllers.BuscaCEPController_JSON_Test;

interface

uses
   DUnitX.TestFramework,
   DesafioTecnicoSoftplan.Controllers.IBuscaCEPController,
   DesafioTecnicoSoftplan.Data.IDAOCep,
   DesafioTecnicoSoftplan.Data.IConexaoBD,
   DesafioTecnicoSoftplan.Controllers.IBuscaViaCEP,
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   DesafioTecnicoSoftplan.Controllers.IEventosMensagens,
   DesafioTecnicoSoftplan.Controllers.IValidacoesTelaBuscaCEP;

type
   [TestFixture]
   TBuscaCEPController_JSON_Test = class
   strict private
      FBuscaCepController: IBuscaCEPController;
      FDAOCep: IDAOCep;
      FConexaoBD : IConexaoBD;
      FComponenteBuscaViaCEP: IBuscaViaCEP;
      FBuscadorViaCEP : IBuscadorViaCEP;
      FEventosUI : IEventosMensagens;
      FValidacoesBuscaCEP : IValidacoesTelaBuscaCEP;
   public
      [Setup]
      procedure Setup;
      [TearDown]
      procedure TearDown;

      [Test]
      [TestCase('(CA 1.2.1)Pesquisa por CEP: Ainda não buscado', '89010-600, true')]
      [TestCase('(CA 1.2.2)Pesquisa por CEP: Já buscado (atualizar)', '89010-600,true')]
      procedure pesquisaPorCep(const prCepDigitado : String; prAtualizar: Boolean);

      [Test]
      [TestCase('(CA 1.2.2)Pesquisa por CEP: Já buscado (mostrar mensagem)', '89010-600,true')]
      procedure pesquisaPorCepExistente_MostrarMensagem(const prCepDigitado : String);


      [Test]
      [TestCase('(CA 1.2.3)Pesquisa por CEP Inexistente: ', '99999-942')]
      procedure pesquisaPorCepInexistente(const prCepDigitado : String);

      [Test]
      [TestCase('(CA 1.3.1)Pesquisa por Endereço ainda não buscado: ', 'SC,Blumenau,Rua Tereza Fischer')]
      [TestCase('(CA 1.3.2)Pesquisa por Endereço já buscado (atualizar): ', 'SC,Blumenau,Rua Tereza Fischer')]
      [TestCase('(CA 1.3.1)Pesquisa por Endereço ainda não buscado - retorna vários: ', 'SC,Blumenau,Rua Hermann Hering')]
      [TestCase('(CA 1.3.2)Pesquisa por Endereço já buscado - (atualizar): ', 'SC,Blumenau,Rua Hermann Hering')]
      procedure pesquisarPorEndereco(const prUF, prCidade, prLogradouro : String; prAtualizar : Boolean);

      [Test]
      [TestCase('(CA 1.3.2)Pesquisa por Endereço já buscado (mostrar mensagem): ', 'SC,Blumenau,Rua Tereza Fischer')]
      procedure pesquisarPorEnderecoExistente_MostrarMensagem(const prUF, prCidade, prLogradouro : String);

      [Test]
      [TestCase('(CA 1.3.3)Pesquisa por Endereço inexistente: ', 'SC,Blumeksnau,Rua Tereza Fischer')]
      procedure pesquisarPorEnderecoInexistente(const prUF, prCidade, prLogradouro : String);
   end;

implementation

uses
   System.Math,
   DesafioTecnicoSoftplan.Controllers.BuscaCEPController,
   DesafioTecnicoSoftplan.Data.DAOCep,
   DesafioTecnicoSoftplan.Data.ConexaoBD,
   DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSON,
   DesafioTecnicoSoftplan.Controllers.BuscadorViaCEP,
   DesafioTecnicoSoftplan.Mocks.EventosTelaUI,
   DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEP;

{ TBuscaCEPController_JSON_Test }

procedure TBuscaCEPController_JSON_Test.pesquisaPorCep(const prCepDigitado: String; prAtualizar: Boolean);
var
   wCepUsarNaBusca : Integer;
begin
   FValidacoesBuscaCEP.validarCep(prCepDigitado, wCepUsarNaBusca);

   TMockEventosTelaUI(FEventosUI).OpcaoSelecionarPerguntaUsuario := ifThen(prAtualizar, 7, 6);
   FBuscaCepController.EfetuarBuscaCEP(wCepUsarNaBusca);

   Assert.IsNotNull(FDAOCep.procurarPorCep(wCepUsarNaBusca),'CEP não foi buscado com sucesso.');
end;

procedure TBuscaCEPController_JSON_Test.pesquisaPorCepExistente_MostrarMensagem(const prCepDigitado: String);
var
   wCepUsarNaBusca : Integer;
   wMensagemEsperada : String;
begin
   FValidacoesBuscaCEP.validarCep(prCepDigitado, wCepUsarNaBusca);

   TMockEventosTelaUI(FEventosUI).OpcaoSelecionarPerguntaUsuario := 6;
   FBuscaCepController.EfetuarBuscaCEP(wCepUsarNaBusca);

   Assert.IsNotNull(FDAOCep.procurarPorCep(wCepUsarNaBusca),'CEP não foi buscado com sucesso.');

   wMensagemEsperada := 'CEP: 89010600'+sLineBreak+
                        'Logradouro: Rua Hermann Hering'+sLineBreak+
                        'Complemento: até 889/890'+sLineBreak+
                        'Bairro: Bom Retiro'+sLineBreak+
                        'Cidade: Blumenau'+sLineBreak+
                        'UF: SC';

   Assert.AreEqual(TMockEventosTelaUI(FEventosUI).UltimaMensagem, wMensagemEsperada, 'Não mostrou a última mensagem corretamente.');

end;

procedure TBuscaCEPController_JSON_Test.pesquisaPorCepInexistente(const prCepDigitado: String);
var
   wCepUsarNaBusca : Integer;
begin
   FValidacoesBuscaCEP.validarCep(prCepDigitado, wCepUsarNaBusca);

   FBuscaCepController.EfetuarBuscaCEP(wCepUsarNaBusca);

   Assert.IsNull(FDAOCep.procurarPorCep(wCepUsarNaBusca),'Retornou um CEP quando não deveria.');

   Assert.AreEqual(TMockEventosTelaUI(FEventosUI).UltimaMensagem, 'O CEP informado não foi encontrado na base de dados da ViaCEP!', 'Não mostrou a mensagem que o CEP não foi encontrado na base de dados da ViaCEP.');
end;

procedure TBuscaCEPController_JSON_Test.pesquisarPorEndereco(const prUF, prCidade, prLogradouro: String; prAtualizar: Boolean);
var
   wPossuiMaisCeps : Boolean;
begin
   FValidacoesBuscaCEP.validarEntradasParaEndereco(prUF, prCidade, prLogradouro);

   TMockEventosTelaUI(FEventosUI).OpcaoSelecionarPerguntaUsuario := ifThen(prAtualizar, 7, 6);
   FBuscaCepController.EfetuarBuscaCEP(prUF, prCidade, prLogradouro);

   Assert.IsNotNull(FDAOCep.procurarPorEndereco(prUF, prCidade, prLogradouro, wPossuiMaisCeps),'Endereço não foi buscado com sucesso.');
end;
procedure TBuscaCEPController_JSON_Test.pesquisarPorEnderecoExistente_MostrarMensagem(const prUF, prCidade, prLogradouro: String);
var
   wPossuiMaisCeps : Boolean;
   wMensagemEsperada : String;
begin
   FValidacoesBuscaCEP.validarEntradasParaEndereco(prUF, prCidade, prLogradouro);

   TMockEventosTelaUI(FEventosUI).OpcaoSelecionarPerguntaUsuario := 6;
   FBuscaCepController.EfetuarBuscaCEP(prUF, prCidade, prLogradouro);

   Assert.IsNotNull(FDAOCep.procurarPorEndereco(prUF, prCidade, prLogradouro, wPossuiMaisCeps),'Endereço não foi buscado com sucesso.');

   wMensagemEsperada := 'Como foi efetuada uma pesquisa por endereço, está sendo mostrado a primeira ocorrência abaixo. '+sLineBreak+
                        'Detalhe melhor a pesquisa ou visualize os CEPs da base na aba "Consultar CEPs cadastrados".'+sLineBreak+sLineBreak+
                        'CEP: 89062080'+sLineBreak+
                        'Logradouro: Rua Tereza Fischer'+sLineBreak+
                        'Complemento: '+sLineBreak+
                        'Bairro: Itoupava Central'+sLineBreak+
                        'Cidade: Blumenau'+sLineBreak+
                        'UF: SC';

   Assert.AreEqual(TMockEventosTelaUI(FEventosUI).UltimaMensagem, wMensagemEsperada, 'Não mostrou a última mensagem corretamente.');
end;

procedure TBuscaCEPController_JSON_Test.pesquisarPorEnderecoInexistente(const prUF, prCidade, prLogradouro: String);
var
   wPossuiMaisCeps : Boolean;
begin
   FValidacoesBuscaCEP.validarEntradasParaEndereco(prUF, prCidade, prLogradouro);

   FBuscaCepController.EfetuarBuscaCEP(prUF, prCidade, prLogradouro);

   Assert.IsNull(FDAOCep.procurarPorEndereco(prUF, prCidade, prLogradouro, wPossuiMaisCeps),'Retornou um endereço quando não deveria.');

   Assert.AreEqual(TMockEventosTelaUI(FEventosUI).UltimaMensagem, 'O endereço informado não foi encontrado na base de dados da ViaCEP!', 'Não mostrou a mensagem que o CEP não foi encontrado na base de dados da ViaCEP.');
end;

procedure TBuscaCEPController_JSON_Test.Setup;
begin
   FConexaoBD := TConexaoBDSQLite.Create;
   FDAOCep := TDAOCep.Create(FConexaoBD);
   FBuscadorViaCEP := TBuscadorViaCEP.Create;
   FComponenteBuscaViaCEP := TBuscaViaCEPJSON.Create(FBuscadorViaCEP);
   FEventosUI := TMockEventosTelaUI.Create;
   FBuscaCepController := TBuscaCepController.Create(FDAOCep, FComponenteBuscaViaCEP, FEventosUI);
   FValidacoesBuscaCEP := TValidacoesTelaBuscaCEP.Create(FEventosUI);
end;

procedure TBuscaCEPController_JSON_Test.TearDown;
begin
end;

end.
