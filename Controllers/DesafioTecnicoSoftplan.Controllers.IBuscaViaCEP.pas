unit DesafioTecnicoSoftplan.Controllers.IBuscaViaCEP;

interface

uses
   DesafioTecnicoSoftplan.Models.ICEP,
   System.Classes,
   System.Generics.Collections;

type
   IBuscaViaCEP = Interface
      function buscaPorCEP(prCEP: Integer): ICEP;
      function buscaPorEndereco(const prUF, prCidade, prEndereco: String) : TList<ICEP>;
   End;

implementation

end.
