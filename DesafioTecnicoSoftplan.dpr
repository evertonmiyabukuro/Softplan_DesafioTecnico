program DesafioTecnicoSoftplan;

uses
  Vcl.Forms,
  DesafioTecnicoSoftplan.Views.TelaInicial in 'Views\DesafioTecnicoSoftplan.Views.TelaInicial.pas' {frPrincipal},
  DesafioTecnicoSoftplan.Data.ConexaoBD in 'Data\DesafioTecnicoSoftplan.Data.ConexaoBD.pas',
  DesafioTecnicoSoftplan.Models.CEP in 'Models\DesafioTecnicoSoftplan.Models.CEP.pas',
  DesafioTecnicoSoftplan.Controllers.IBuscaViaCEP in 'Controllers\DesafioTecnicoSoftplan.Controllers.IBuscaViaCEP.pas',
  DesafioTecnicoSoftplan.Data.DAOCep in 'Data\DesafioTecnicoSoftplan.Data.DAOCep.pas',
  DesafioTecnicoSoftplan.Data.IConexaoBD in 'Data\DesafioTecnicoSoftplan.Data.IConexaoBD.pas',
  DesafioTecnicoSoftplan.Models.ICEP in 'Models\DesafioTecnicoSoftplan.Models.ICEP.pas',
  DesafioTecnicoSoftplan.Data.IDAOCep in 'Data\DesafioTecnicoSoftplan.Data.IDAOCep.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSON in 'Controllers\DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSON.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaVIACEPXML in 'Controllers\DesafioTecnicoSoftplan.Controllers.BuscaVIACEPXML.pas',
  DesafioTecnicoSoftplan.Controllers.IBuscaCEPController in 'Controllers\DesafioTecnicoSoftplan.Controllers.IBuscaCEPController.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaCEPController in 'Controllers\DesafioTecnicoSoftplan.Controllers.BuscaCEPController.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaViaCEP in 'Controllers\DesafioTecnicoSoftplan.Controllers.BuscaViaCEP.pas',
  DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP in 'Controllers\DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP.pas',
  DesafioTecnicoSoftplan.Controllers.BuscadorViaCEP in 'Controllers\DesafioTecnicoSoftplan.Controllers.BuscadorViaCEP.pas',
  DesafioTecnicoSoftplan.Controllers.EventosMensagensUI in 'Controllers\DesafioTecnicoSoftplan.Controllers.EventosMensagensUI.pas',
  DesafioTecnicoSoftplan.Controllers.IEventosMensagens in 'Controllers\DesafioTecnicoSoftplan.Controllers.IEventosMensagens.pas',
  DesafioTecnicoSoftplan.Controllers.IValidacoesTelaBuscaCEP in 'Controllers\DesafioTecnicoSoftplan.Controllers.IValidacoesTelaBuscaCEP.pas',
  DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEP in 'Controllers\DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrPrincipal, frPrincipal);
  Application.Run;
end.
