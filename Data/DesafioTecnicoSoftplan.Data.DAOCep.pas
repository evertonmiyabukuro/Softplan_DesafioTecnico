unit DesafioTecnicoSoftplan.Data.DAOCep;

interface

uses
   System.Generics.Collections,
   DesafioTecnicoSoftplan.Models.ICEP,
   DesafioTecnicoSoftplan.Data.IConexaoBD,
   DesafioTecnicoSoftplan.Data.IDAOCep,
   Firedac.Comp.Client;

type
   TDAOCep = class(TInterfacedObject, IDAOCep)
   strict private
      FAcessoBD: IConexaoBD;
   public
      function procurarPorCep(prCep: Integer): ICEP;
      function procurarPorEndereco(const prUF, prCidade, prEndereco: String;out prPossuiMaisCeps: Boolean): ICEP;
      procedure armazenarCEP(prCep: ICEP);

      function cepJaExiste(prCep: Integer; out prCepEncontrado: ICEP) : Boolean; overload;
      function cepJaExiste(const prUF, prCidade, prEndereco: String; out prCepEncontrado: ICEP; out prPossuiMaisCeps: Boolean): Boolean; overload;

      function retornaConsultaCepsCadastrados(): TFDMemTable;

      function excluirCepPorCodigo(prCodigo: Integer): Integer;

      constructor Create(prConexaoBD: IConexaoBD);
   end;

implementation

uses
   Data.DB,
   System.SysUtils,
   DesafioTecnicoSoftplan.Models.CEP,
   Firedac.Comp.DataSet;

{ TDAOCep }

procedure TDAOCep.armazenarCEP(prCep: ICEP);
var
   wTmpCep: ICEP;
begin
   if cepJaExiste(prCep.CEP, wTmpCep) then
      FAcessoBD.executarSQL('UPDATE CEP SET LOGRADOURO = :PRLOGRADOURO, '   +
                            '               COMPLEMENTO = :PRCOMPLEMENTO, ' +
                            '               BAIRRO = :PRBAIRRO, '           +
                            '               LOCALIDADE = :PRLOCALIDADE, '   +
                            '               UF = :PRUF '                    +
                            'WHERE CEP = :PRCEP',
                            [prCep.CEP, prCep.Logradouro, prCep.Complemento, prCep.Bairro,
                             prCep.Localidade, prCep.UF])
   else
      FAcessoBD.executarSQL('INSERT INTO CEP (CEP, LOGRADOURO, COMPLEMENTO, BAIRRO, LOCALIDADE, UF) ' +
                            'VALUES (:PRCEP, :PRLOGRADOURO, :PRCOMPLEMENTO, :PRBAIRRO, :PRLOCALIDADE, :PRUF)',
                            [prCep.CEP, prCep.Logradouro, prCep.Complemento, prCep.Bairro,
                             prCep.Localidade, prCep.UF]);
end;

function TDAOCep.cepJaExiste(const prUF, prCidade, prEndereco: String;out prCepEncontrado: ICEP; out prPossuiMaisCeps: Boolean): Boolean;
begin
   prCepEncontrado := procurarPorEndereco(prUF, prCidade, prEndereco, prPossuiMaisCeps);
   result := prCepEncontrado <> nil;
end;

function TDAOCep.cepJaExiste(prCep: Integer; out prCepEncontrado: ICEP): Boolean;
begin
   prCepEncontrado := procurarPorCep(prCep);
   result := prCepEncontrado <> nil;
end;

constructor TDAOCep.Create(prConexaoBD: IConexaoBD);
begin
   FAcessoBD := prConexaoBD;
end;

function TDAOCep.excluirCepPorCodigo(prCodigo: Integer): LongInt;
begin
   result := FAcessoBD.executarSQL('delete from cep where codigo = :PRCODIGO', [prCodigo]);
end;

function TDAOCep.procurarPorCep(prCep: Integer): ICEP;
var
   wResultDataSet: TDataSet;
begin
   result := nil;

   wResultDataSet := FAcessoBD.executarSelect('select * from CEP where CEP = :PRCEP LIMIT 1', [prCep]);
   try
      wResultDataSet.First;

      while not wResultDataSet.Eof do
         begin
            result := TCEP.Create();

            result.Codigo      := wResultDataSet.FieldByName('CODIGO').AsInteger;
            result.CEP         := wResultDataSet.FieldByName('CEP').AsInteger;
            result.Logradouro  := wResultDataSet.FieldByName('LOGRADOURO').AsString;
            result.Complemento := wResultDataSet.FieldByName('COMPLEMENTO').AsString;
            result.Bairro      := wResultDataSet.FieldByName('BAIRRO').AsString;
            result.Localidade  := wResultDataSet.FieldByName('LOCALIDADE').AsString;
            result.UF          := wResultDataSet.FieldByName('UF').AsString;

            wResultDataSet.Next;
         end;
   finally
      freeAndNil(wResultDataSet);
   end;
end;

function TDAOCep.procurarPorEndereco(const prUF, prCidade, prEndereco: String; out prPossuiMaisCeps: Boolean): ICEP;
var
   wResultDataSet: TDataSet;
begin
   result := nil;

   wResultDataSet := FAcessoBD.executarSelect('select * from CEP where (UF = :PRUF) AND (LOCALIDADE like :PRLOCALIDADE) AND (LOGRADOURO like :PRLOGRADOURO)',
                                              [prUF, '%' + prCidade + '%', '%' + prEndereco + '%']);
   try
      wResultDataSet.First;

      while not wResultDataSet.Eof do
         begin
            result := TCEP.Create();

            result.Codigo := wResultDataSet.FieldByName('CODIGO').AsInteger;
            result.CEP := wResultDataSet.FieldByName('CEP').AsInteger;
            result.Logradouro := wResultDataSet.FieldByName('LOGRADOURO').AsString;
            result.Complemento := wResultDataSet.FieldByName('COMPLEMENTO').AsString;
            result.Bairro := wResultDataSet.FieldByName('BAIRRO').AsString;
            result.Localidade := wResultDataSet.FieldByName('LOCALIDADE').AsString;
            result.UF := wResultDataSet.FieldByName('UF').AsString;

            wResultDataSet.Next;

            prPossuiMaisCeps := wResultDataSet.Eof;
            break;
         end;
   finally
      freeAndNil(wResultDataSet);
   end;
end;

function TDAOCep.retornaConsultaCepsCadastrados: TFDMemTable;
var
   wDataSet: TDataSet;
begin
   result := TFDMemTable.Create(nil);

   wDataSet := FAcessoBD.executarSelect('SELECT * FROM CEP', []);
   try
      result.CopyDataSet(wDataSet, [coStructure, coRestart, coAppend]);
   finally
      freeAndNil(wDataSet);
   end;
end;

end.
