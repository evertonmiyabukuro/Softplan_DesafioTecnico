unit DesafioTecnicoSoftplan.Controllers.IEventosMensagens;

interface

type
   IEventosMensagens = Interface
      procedure exibirMensagem(const prMensagem: String);
      function exibirMensagem_Pergunta_Ao_Usuario(const prMensagem: String; const prCaptions: array of string): Integer;
   End;

implementation

end.
