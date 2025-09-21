unit DesafioTecnicoSoftplan.Controllers.BuscaCEPController;

interface

uses
   System.Generics.Collections,
   DesafioTecnicoSoftplan.Controllers.IBuscaCEPController,
   DesafioTecnicoSoftplan.Data.IDAOCep,
   DesafioTecnicoSoftplan.Models.ICEP,
   DesafioTecnicoSoftplan.Controllers.IBuscaViaCEP,
   DesafioTecnicoSoftplan.Controllers.IEventosMensagens;

type
   TBuscaCepController = class(TInterfacedObject, IBuscaCEPController)
   strict private
      FDAOCep : IDAOCep;
      FComponenteBuscaViaCEP : IBuscaViaCEP;
      FEventosMensagens: IEventosMensagens;

      procedure BuscaDoWS_E_Grava(prCEP : Integer); overload;
      procedure BuscaDoWS_E_Grava(const prUF, prCidade, prEndereco : String); overload;
   public
      procedure EfetuarBuscaCEP(prCEP : Integer); overload;
      procedure EfetuarBuscaCEP(const prUF, prCidade, prEndereco : String); overload;

      constructor Create(prDAOCep : IDAOCep; prComponenteBuscaViaCEP : IBuscaViaCEP; prEventosMensagens : IEventosMensagens);
   end;

implementation

uses
   System.SysUtils,
   System.RegularExpressions;

{ TBuscaCepController }

procedure TBuscaCepController.BuscaDoWS_E_Grava(const prUF, prCidade, prEndereco: String);
var
   wCeps : TList<ICep>;
   wCep : ICep;
begin
   wCeps := FComponenteBuscaViaCEP.buscaPorEndereco(prUF, prCidade, prEndereco);

   if wCeps.IsEmpty then
      begin
         FEventosMensagens.exibirMensagem('O endereço informado não foi encontrado na base de dados da ViaCEP!');
         exit;
      end;

   for wCep in wCeps do
      FDAOCep.armazenarCEP(wCep);

   FEventosMensagens.exibirMensagem('Endereço(s) buscado(s) e armazenado(s) com sucesso!');
end;

procedure TBuscaCepController.BuscaDoWS_E_Grava(prCEP: Integer);
var
   wCep : ICEP;
begin
   wCep := FComponenteBuscaViaCEP.buscaPorCEP(prCEP);

   if wCep = nil then
      begin
         FEventosMensagens.exibirMensagem('O CEP informado não foi encontrado na base de dados da ViaCEP!');
         exit;
      end;

   FDAOCep.armazenarCEP(wCep);

   FEventosMensagens.exibirMensagem('Cep buscado e armazenado com sucesso!');
end;

constructor TBuscaCepController.Create(prDAOCep : IDAOCep; prComponenteBuscaViaCEP : IBuscaViaCEP; prEventosMensagens : IEventosMensagens);
begin
   FDAOCep := prDAOCep;
   FComponenteBuscaViaCEP := prComponenteBuscaViaCEP;
   FEventosMensagens := prEventosMensagens;
end;

procedure TBuscaCepController.EfetuarBuscaCEP(const prUF, prCidade, prEndereco: String);
var
   wTmpCep : ICEP;
   wPossuiMaisCeps : Boolean;
begin
   wTmpCep := nil;
   try
     if not FDAOCep.cepJaExiste(prUF, prCidade, prEndereco, wTmpCep, wPossuiMaisCeps) then
        begin
           BuscaDoWS_E_Grava(prUF, prCidade, prEndereco);
           exit;
        end;


     if FEventosMensagens.exibirMensagem_Pergunta_Ao_Usuario('O CEP informado já encontra-se cadastrado.' + sLineBreak + 'Deseja ver suas informações ou atualizá-lo?',
                                                            ['Ver as informações', 'Atualizar CEP']) =  6 {mrYes} then
        begin
           FEventosMensagens.exibirMensagem('Como foi efetuada uma pesquisa por endereço, está sendo mostrado a primeira ocorrência abaixo. ' + sLineBreak +
                                            'Detalhe melhor a pesquisa ou visualize os CEPs da base na aba "Consultar CEPs cadastrados".' + sLineBreak + sLineBreak+
                                            'CEP: '         + wTmpCep.CEP.ToString() + sLineBreak +
                                            'Logradouro: '  + wTmpCep.Logradouro     + sLineBreak +
                                            'Complemento: ' + wTmpCep.Complemento    + sLineBreak +
                                            'Bairro: '      + wTmpCep.Bairro         + sLineBreak +
                                            'Cidade: '      + wTmpCep.Localidade     + sLineBreak +
                                            'UF: '          + wTmpCep.UF);
           exit;
        end
     else
        BuscaDoWS_E_Grava(prUF, prCidade, prEndereco);
   finally
      wTmpCep := nil;
   end;
end;

procedure TBuscaCepController.EfetuarBuscaCEP(prCEP: Integer);
var
   wTmpCep: ICEP;
begin
   wTmpCep := nil;
   try
     if not FDAOCep.cepJaExiste(prCep, wTmpCep) then
        begin
           BuscaDoWS_E_Grava(prCep);
           exit;
        end;

     if FEventosMensagens.exibirMensagem_Pergunta_Ao_Usuario('O CEP informado já encontra-se cadastrado.' + sLineBreak + 'Deseja ver suas informações ou atualizá-lo?',
                       ['Ver as informações', 'Atualizar CEP']) = 6 {mrYes} then
        begin
           FEventosMensagens.exibirMensagem('CEP: '         + wTmpCep.CEP.ToString() + sLineBreak +
                                            'Logradouro: '  + wTmpCep.Logradouro     + sLineBreak +
                                            'Complemento: ' + wTmpCep.Complemento    + sLineBreak +
                                            'Bairro: '      + wTmpCep.Bairro         + sLineBreak +
                                            'Cidade: '      + wTmpCep.Localidade     + sLineBreak +
                                            'UF: '          + wTmpCep.UF);
           exit;
        end
     else
        BuscaDoWS_E_Grava(prCep);
   finally
      wTmpCep := nil;
   end;
end;

end.
