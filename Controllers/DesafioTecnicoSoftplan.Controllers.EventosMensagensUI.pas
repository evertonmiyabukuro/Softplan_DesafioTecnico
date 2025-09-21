unit DesafioTecnicoSoftplan.Controllers.EventosMensagensUI;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IEventosMensagens;

type
  TEventosMensagensUI = class(TInterfacedObject, IEventosMensagens)
     procedure exibirMensagem(const prMensagem: String);
     function exibirMensagem_Pergunta_Ao_Usuario(const prMensagem: String; const prCaptions: array of string): Integer;
  end;

implementation

uses
   Vcl.Dialogs,
   Vcl.Forms,
   System.SysUtils;

{ TEventosMensagensUI }

procedure TEventosMensagensUI.exibirMensagem(const prMensagem: String);
begin
   ShowMessage(prMensagem)
end;

function TEventosMensagensUI.exibirMensagem_Pergunta_Ao_Usuario(const prMensagem: String; const prCaptions: array of string): Integer;
begin
   if Length(prCaptions) <> 2 then
      raise Exception.Create('TEventosMensagensUI.exibirMensagem_Pergunta_Ao_Usuario: Esse método espera apenas duas opções para os botões');

   result := TaskMessageDlg(Application.MainForm.Caption, prMensagem, TMsgDlgType.mtCustom, mbYesNo, 0, mbYes, prCaptions);
end;

end.
