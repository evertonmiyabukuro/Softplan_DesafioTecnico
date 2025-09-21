unit DesafioTecnicoSoftplan.Data.ConexaoBD;

interface

uses
   FireDAC.Comp.Client,
   System.SysUtils,
   System.Classes,
   DesafioTecnicoSoftplan.Data.IConexaoBD,
   Data.DB;

type
   TConexaoBDSQLite = class(TInterfacedObject, IConexaoBD)
   const
      C_NOME_BD = 'BDCEP.db';
   strict private
      FConexao: TFDConnection;

      function retornaNomeArquivoBD: String;
      function CriaConexao: TFDConnection;

      procedure InicializaTabelaCEPSeNaoExistir();
   private
      function Conexao: TFDConnection;
   public
      function executarSQL(const prSQL: String; const Params: Array of Variant): LongInt;
      function executarSelect(const prSQL: String; const Params: Array of Variant): TDataSet;

      constructor Create;
      destructor Destroy; override;
   end;

implementation

uses
   WinAPI.Windows,
   FireDAC.Phys.SQLite,
   FireDAC.Phys.SQLiteDef,
   FireDAC.DApt,
   FireDAC.Stan.Def,
   FireDAC.Comp.UI,
   FireDAC.Stan.Async;

{ TConexaoBDSQLite }

function TConexaoBDSQLite.Conexao: TFDConnection;
begin
   if FConexao = nil then
      begin
         FConexao := CriaConexao;
         InicializaTabelaCEPSeNaoExistir;
      end;

   result := FConexao;
end;

constructor TConexaoBDSQLite.Create;
begin
   FConexao := nil;
end;

function TConexaoBDSQLite.CriaConexao: TFDConnection;
begin
   result := TFDConnection.Create(nil);

   result.DriverName := 'SQLite';
   result.Params.Database := retornaNomeArquivoBD();

   ForceDirectories(ExtractFilePath(result.Params.Database));

   (result.Params as TFDPhysSQLiteConnectionDefParams).OpenMode := omCreateUTF16;
   result.ResourceOptions.SilentMode := true;

   result.Open();
end;

destructor TConexaoBDSQLite.Destroy;
begin
   FreeAndNil(FConexao);
end;

function TConexaoBDSQLite.executarSelect(const prSQL: String; const Params: array of Variant): TDataSet;
begin
   result := TFDQuery.Create(nil);
   (result as TFDQuery).Connection := Conexao;

   (result as TFDQuery).Open(prSQL, Params);
end;

function TConexaoBDSQLite.executarSQL(const prSQL: String; const Params: Array of Variant): LongInt;
begin
   result := Conexao.ExecSQL(prSQL, Params);
end;

procedure TConexaoBDSQLite.InicializaTabelaCEPSeNaoExistir;
var
   wQuery: TFDQuery;
begin
   wQuery := TFDQuery.Create(nil);
   try
      wQuery.Connection := FConexao;
      wQuery.ExecSQL('CREATE TABLE IF NOT EXISTS CEP ( '              +
                     '    CODIGO INTEGER PRIMARY KEY AUTOINCREMENT, ' +
                     '    CEP INTEGER UNIQUE, '                       +
                     '    LOGRADOURO VARCHAR(255), '                  +
                     '    COMPLEMENTO VARCHAR(255), '                 +
                     '    BAIRRO VARCHAR(100), '                      +
                     '    LOCALIDADE VARCHAR(100), ' +
                     '    UF VARCHAR(2));');
   finally
      FreeAndNil(wQuery);
   end;
end;

function TConexaoBDSQLite.retornaNomeArquivoBD: String;
var
   wDiretorioBD: String;
begin
   wDiretorioBD := IncludeTrailingPathDelimiter(ExtractFilePath(getModuleName(0))) + 'BD\';

   result := wDiretorioBD + TConexaoBDSQLite.C_NOME_BD;
end;

end.
