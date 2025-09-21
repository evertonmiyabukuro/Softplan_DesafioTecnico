unit DesafioTecnicoSoftplan.Controllers.IBuscadorViaCEP;

interface

uses
   System.Classes;

type
   IBuscadorViaCEP = Interface
     function fazerRequisicaoBusca(const prUrl: String): String;
     function fazerRequisicaoBuscaRetornandoStream(const prUrl: String) : TStringStream;
   end;

implementation

end.
