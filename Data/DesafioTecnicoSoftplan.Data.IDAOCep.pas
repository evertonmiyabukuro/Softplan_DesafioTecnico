unit DesafioTecnicoSoftplan.Data.IDAOCep;

interface

uses
   System.Generics.Collections,
   DesafioTecnicoSoftplan.Models.ICEP,
   FireDAC.Comp.Client;

type
   IDAOCep = Interface
      function procurarPorCep(prCep: Integer): ICEP;
      function procurarPorEndereco(const prUF, prCidade, prEndereco: String; out prPossuiMaisCeps: Boolean): ICEP;
      procedure armazenarCEP(prCep: ICEP);

      function cepJaExiste(prCep: Integer; out prCepEncontrado: ICEP): Boolean; overload;
      function cepJaExiste(const prUF, prCidade, prEndereco: String; out prCepEncontrado: ICEP; out prPossuiMaisCeps: Boolean): Boolean; overload;

      function retornaConsultaCepsCadastrados(): TFDMemTable;

      function excluirCepPorCodigo(prCodigo: Integer): LongInt;
   end;

implementation

end.
