unit DesafioTecnicoSoftplan.Controllers.IBuscaCEPController;

interface

uses
   DesafioTecnicoSoftplan.Models.ICEP,
   System.Generics.Collections;

type
   IBuscaCEPController = interface
      procedure EfetuarBuscaCEP(prCEP: Integer); overload;
      procedure EfetuarBuscaCEP(const prUF, prCidade, prEndereco: String); overload;

      procedure BuscaDoWS_E_Grava(prCEP: Integer); overload;
      procedure BuscaDoWS_E_Grava(const prUF, prCidade, prEndereco: String); overload;
   end;

implementation

end.
