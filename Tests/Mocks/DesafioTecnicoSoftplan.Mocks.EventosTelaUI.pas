unit DesafioTecnicoSoftplan.Mocks.EventosTelaUI;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IEventosMensagens;

type
   TMockEventosTelaUI = class(TInterfacedObject, IEventosMensagens)
   private
      FUltimaMensagem : String;
      FOpcaoSelecionarPerguntaUsuario : Integer;
   public
     procedure exibirMensagem(const prMensagem: String);
     function exibirMensagem_Pergunta_Ao_Usuario(const prMensagem: String; const prCaptions: array of string): Integer;

     constructor Create;

     property UltimaMensagem : String read FUltimaMensagem;
     property OpcaoSelecionarPerguntaUsuario : Integer read FOpcaoSelecionarPerguntaUsuario write FOpcaoSelecionarPerguntaUsuario;
   end;

implementation

{ TMockEventosTelaUI }

constructor TMockEventosTelaUI.Create;
begin
   FUltimaMensagem := '';
   FOpcaoSelecionarPerguntaUsuario := 0;
end;

procedure TMockEventosTelaUI.exibirMensagem(const prMensagem: String);
begin
   FUltimaMensagem := prMensagem;
end;

function TMockEventosTelaUI.exibirMensagem_Pergunta_Ao_Usuario(const prMensagem: String; const prCaptions: array of string): Integer;
begin
  result := FOpcaoSelecionarPerguntaUsuario;
end;

end.
