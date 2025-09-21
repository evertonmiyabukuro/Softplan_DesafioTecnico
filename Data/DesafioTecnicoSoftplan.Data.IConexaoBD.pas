unit DesafioTecnicoSoftplan.Data.IConexaoBD;

interface

uses
   Data.DB;

type
   IConexaoBD = interface
      function executarSQL(const prSQL: String; const Params: Array of Variant): LongInt;
      function executarSelect(const prSQL: String; const Params: Array of Variant): TDataSet;
   end;

implementation

end.
