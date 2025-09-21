unit DesafioTecnicoSoftplan.Controllers.IValidacoesTelaBuscaCEP;

interface

uses
   DesafioTecnicoSoftplan.Models.ICEP,
   System.Generics.Collections;

type
   IValidacoesTelaBuscaCEP = interface
      function ValidarUF(const prUf: String): Boolean;
      function validarCep(prCepDigitado: String; out prCepParaUsarNaPesquisa: Integer): Boolean;
      function validarEntradasParaEndereco(const prUf, prCidade, prEndereco: String): Boolean;
   end;

implementation

end.
