program DesafioTecnicoSoftPlan_Testes;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  {$ENDIF }
  DUnitX.TestFramework,
  DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEPTest in 'Controllers\DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEPTest.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaCEPController in '..\Controllers\DesafioTecnicoSoftplan.Controllers.BuscaCEPController.pas',
  DesafioTecnicoSoftplan.Controllers.IBuscaCEPController in '..\Controllers\DesafioTecnicoSoftplan.Controllers.IBuscaCEPController.pas',
  DesafioTecnicoSoftplan.Models.ICEP in '..\Models\DesafioTecnicoSoftplan.Models.ICEP.pas',
  DesafioTecnicoSoftplan.Data.IDAOCep in '..\Data\DesafioTecnicoSoftplan.Data.IDAOCep.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSONTest in 'Controllers\DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSONTest.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaViaCEP in '..\Controllers\DesafioTecnicoSoftplan.Controllers.BuscaViaCEP.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoStringVazia in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoStringVazia.pas',
  DesafioTecnicoSoftplan.Models.CEP in '..\Models\DesafioTecnicoSoftplan.Models.CEP.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONVazio in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONVazio.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONCorreto in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONCorreto.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONErrado in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoJSONErrado.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONErrado in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONErrado.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONVazio in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONVazio.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoStringVazia in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoStringVazia.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONCorreto in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONCorreto.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONVarios in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoJSONVarios.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaViaCEPXMLTest in 'Controllers\DesafioTecnicoSoftplan.Controllers.BuscaViaCEPXMLTest.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLCorreto in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLCorreto.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLErrado in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLErrado.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLVarios in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLVarios.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLVazio in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPEnderecoRetornoXMLVazio.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLCorreto in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLCorreto.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLErrado in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLErrado.pas',
  DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLVazio in 'Mocks\DesafioTecnicoSoftplan.Mocks.MockBuscadorViaCEPRetornoXMLVazio.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaCEPController_JSON_Test in 'Controllers\DesafioTecnicoSoftplan.Controllers.BuscaCEPController_JSON_Test.pas',
  DesafioTecnicoSoftplan.Data.ConexaoBD in '..\Data\DesafioTecnicoSoftplan.Data.ConexaoBD.pas',
  DesafioTecnicoSoftplan.Data.IConexaoBD in '..\Data\DesafioTecnicoSoftplan.Data.IConexaoBD.pas',
  DesafioTecnicoSoftplan.Data.DAOCep in '..\Data\DesafioTecnicoSoftplan.Data.DAOCep.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSON in '..\Controllers\DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSON.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaVIACEPXML in '..\Controllers\DesafioTecnicoSoftplan.Controllers.BuscaVIACEPXML.pas',
  DesafioTecnicoSoftplan.Controllers.IBuscaViaCEP in '..\Controllers\DesafioTecnicoSoftplan.Controllers.IBuscaViaCEP.pas',
  DesafioTecnicoSoftplan.Controllers.BuscadorViaCEP in '..\Controllers\DesafioTecnicoSoftplan.Controllers.BuscadorViaCEP.pas',
  DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP in '..\Controllers\DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP.pas',
  DesafioTecnicoSoftplan.Controllers.IEventosMensagens in '..\Controllers\DesafioTecnicoSoftplan.Controllers.IEventosMensagens.pas',
  DesafioTecnicoSoftplan.Mocks.EventosTelaUI in 'Mocks\DesafioTecnicoSoftplan.Mocks.EventosTelaUI.pas',
  DesafioTecnicoSoftplan.Controllers.IValidacoesTelaBuscaCEP in '..\Controllers\DesafioTecnicoSoftplan.Controllers.IValidacoesTelaBuscaCEP.pas',
  DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEP in '..\Controllers\DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEP.pas',
  DesafioTecnicoSoftplan.Controllers.BuscaCEPController_XML_Test in 'Controllers\DesafioTecnicoSoftplan.Controllers.BuscaCEPController_XML_Test.pas';

{ keep comment here to protect the following conditional from being removed by the IDE when adding a unit }
{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
  TDUnitX.Options.ExitBehavior := TDUnitXExitBehavior.Pause;

  DeleteFile(IncludeTrailingPathDelimiter(ExtractFilePath(GetModuleName(0)))+'bd\BDCEP.db');

{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
