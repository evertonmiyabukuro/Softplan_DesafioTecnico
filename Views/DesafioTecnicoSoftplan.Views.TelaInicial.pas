unit DesafioTecnicoSoftplan.Views.TelaInicial;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
   Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
   DesafioTecnicoSoftplan.Controllers.IBuscaCEPController,
   DesafioTecnicoSoftplan.Data.IConexaoBD,
   DesafioTecnicoSoftplan.Data.IDAOCep,
   DesafioTecnicoSoftplan.Controllers.IBuscaViaCEP,
   Vcl.Buttons,
   DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP,
   DesafioTecnicoSoftplan.Controllers.IEventosMensagens,
   DesafioTecnicoSoftplan.Controllers.IValidacoesTelaBuscaCEP;

type
   TfrPrincipal = class(TForm)
      pcBuscaEVisualizacaoCeps: TPageControl;
      tsBuscarCEP: TTabSheet;
      tsConsultarCepsCadastrados: TTabSheet;
      grResultadosCEP: TDBGrid;
      pnTop: TPanel;
      btConsultarCeps: TBitBtn;
      dsDadosCepsCadastrados: TDataSource;
      btExcluirRegistroSelecionado: TButton;
      pnBuscarCep: TPanel;
      Label1: TLabel;
      rgBuscaPor: TRadioGroup;
      edCep: TMaskEdit;
      edCidade: TEdit;
      edEndereco: TEdit;
      lbCep: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      cbUF: TComboBox;
      rgConsultaVia: TRadioGroup;
      btBuscar: TButton;
      procedure rgBuscaPorClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure btBuscarClick(Sender: TObject);
      procedure rgConsultaViaClick(Sender: TObject);
      procedure btConsultarCepsClick(Sender: TObject);
      procedure btExcluirRegistroSelecionadoClick(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
   private
      FConexaoBD: IConexaoBD;
      FDaoCep: IDAOCep;
      FBuscaCepController: IBuscaCEPController;
      FComponenteBuscaViaCEPAtual: IBuscaViaCEP;
      FBuscadorViaCEP: IBuscadorViaCEP;
      FTratadorEventosMensagens: IEventosMensagens;
      FValidacoesTelaBuscaCEP: IValidacoesTelaBuscaCEP;

      function getBuscadorViaCEPSelecionado: IBuscaViaCEP;
      procedure efetuarBuscaPorCep;
      procedure efetuarBuscaPorEndereco;
      procedure liberarDatasetCeps();
   end;

var
   frPrincipal: TfrPrincipal;

implementation

uses
   DesafioTecnicoSoftplan.Controllers.BuscaCEPController,
   DesafioTecnicoSoftplan.Data.ConexaoBD,
   DesafioTecnicoSoftplan.Data.DAOCep,
   DesafioTecnicoSoftplan.Controllers.BuscaVIACEPXML,
   DesafioTecnicoSoftplan.Controllers.BuscaViaCEPJSON,
   DesafioTecnicoSoftplan.Controllers.BuscadorViaCEP,
   DesafioTecnicoSoftplan.Controllers.EventosMensagensUI,
   DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEP;

{$R *.dfm}

procedure TfrPrincipal.btBuscarClick(Sender: TObject);
begin
   if rgBuscaPor.ItemIndex = 0 then
      efetuarBuscaPorCep
   else
   if rgBuscaPor.ItemIndex = 1 then
      efetuarBuscaPorEndereco;
end;

procedure TfrPrincipal.btConsultarCepsClick(Sender: TObject);
begin
   liberarDatasetCeps();

   dsDadosCepsCadastrados.DataSet := FDaoCep.retornaConsultaCepsCadastrados;
end;

procedure TfrPrincipal.btExcluirRegistroSelecionadoClick(Sender: TObject);
begin
   if dsDadosCepsCadastrados.DataSet = nil then
      begin
         ShowMessage('Para poder excluir um registro, primeiro efetue a consulta e escolha qual registro deseja excluir.');

         exit;
      end;

   if FDaoCep.excluirCepPorCodigo(dsDadosCepsCadastrados.DataSet.FieldByName('CODIGO').AsInteger) > 0 then
      begin
         ShowMessage('Registro excluído com sucesso!');
         btConsultarCepsClick(btConsultarCeps);
      end
   else
      ShowMessage('Nenhum registro excluído.');
end;

procedure TfrPrincipal.efetuarBuscaPorCep;
var
   wCep: Integer;
begin
   if not FValidacoesTelaBuscaCEP.validarCep(edCep.Text, wCep) then
      exit;

   FBuscaCepController := TBuscaCepController.Create(FDaoCep, getBuscadorViaCEPSelecionado(), FTratadorEventosMensagens);
   try
      FBuscaCepController.EfetuarBuscaCEP(wCep);
   finally
      FBuscaCepController := nil;
   end;
end;

procedure TfrPrincipal.efetuarBuscaPorEndereco;
begin
   if not FValidacoesTelaBuscaCEP.validarEntradasParaEndereco(cbUF.Text, edCidade.Text, edEndereco.Text) then
      exit;

   FBuscaCepController := TBuscaCepController.Create(FDaoCep, getBuscadorViaCEPSelecionado(), FTratadorEventosMensagens);
   try

      FBuscaCepController.EfetuarBuscaCEP(cbUF.Text, edCidade.Text, edEndereco.Text);
   finally
      FBuscaCepController := nil;
   end;
end;

procedure TfrPrincipal.FormCreate(Sender: TObject);
begin
   FConexaoBD := TConexaoBDSQLite.Create;
   FDaoCep := TDAOCep.Create(FConexaoBD);
   FTratadorEventosMensagens := TEventosMensagensUI.Create;
   FValidacoesTelaBuscaCEP := TValidacoesTelaBuscaCEP.Create(FTratadorEventosMensagens);
   FBuscaCepController := nil;
   FComponenteBuscaViaCEPAtual := nil;
   FBuscadorViaCEP := TBuscadorViaCEP.Create;
end;

procedure TfrPrincipal.FormDestroy(Sender: TObject);
begin
   FBuscadorViaCEP := nil;
   FComponenteBuscaViaCEPAtual := nil;
   FBuscaCepController := nil;
   FValidacoesTelaBuscaCEP:= nil;
   FTratadorEventosMensagens := nil;
   FDaoCep := nil;
   FConexaoBD := nil;
   liberarDatasetCeps()
end;

procedure TfrPrincipal.FormShow(Sender: TObject);
begin
   rgBuscaPorClick(rgBuscaPor);
end;

function TfrPrincipal.getBuscadorViaCEPSelecionado: IBuscaViaCEP;
begin
   if FComponenteBuscaViaCEPAtual = nil then
      begin
         if rgConsultaVia.ItemIndex = 0 then
            FComponenteBuscaViaCEPAtual := TBuscaViaCEPJSON.Create(FBuscadorViaCEP)
         else
            FComponenteBuscaViaCEPAtual := TBuscaViaCEPXML.Create(FBuscadorViaCEP);
      end;

   result := FComponenteBuscaViaCEPAtual;
end;

procedure TfrPrincipal.liberarDatasetCeps;
var
   wTmpDataSet: TDataSet;
begin
   if dsDadosCepsCadastrados.DataSet <> nil then
      begin
         wTmpDataSet := dsDadosCepsCadastrados.DataSet;
         dsDadosCepsCadastrados.DataSet.Close;
         dsDadosCepsCadastrados.DataSet := nil;
         FreeAndNil(wTmpDataSet);
      end;
end;

procedure TfrPrincipal.rgConsultaViaClick(Sender: TObject);
begin
   FComponenteBuscaViaCEPAtual := nil;
end;

procedure TfrPrincipal.rgBuscaPorClick(Sender: TObject);
begin
   edCep.Enabled := rgBuscaPor.ItemIndex = 0;

   cbUF.Enabled := rgBuscaPor.ItemIndex = 1;
   edCidade.Enabled := rgBuscaPor.ItemIndex = 1;
   edEndereco.Enabled := rgBuscaPor.ItemIndex = 1;
end;

end.
