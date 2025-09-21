unit DesafioTecnicoSoftplan.Controllers.ValidacoesTelaBuscaCEP;

interface

uses
   DesafioTecnicoSoftplan.Controllers.IValidacoesTelaBuscaCEP,
   DesafioTecnicoSoftplan.Controllers.IEventosMensagens;

type
   TValidacoesTelaBuscaCEP = class(TInterfacedObject, IValidacoesTelaBuscaCEP)
   strict private
      FEventosMensagens: IEventosMensagens;

      function ValidarUF(const prUf: String): Boolean;
   public
      function validarCep(prCepDigitado: String; out prCepParaUsarNaPesquisa: Integer): Boolean;
      function validarEntradasParaEndereco(const prUf, prCidade, prEndereco: String): Boolean;

      constructor Create(prEventosMensagens: IEventosMensagens);
   end;

implementation

uses
   System.RegularExpressions,
   System.SysUtils;

{ TValidacoesTelaBuscaCEP }

constructor TValidacoesTelaBuscaCEP.Create(prEventosMensagens: IEventosMensagens);
begin
   FEventosMensagens := prEventosMensagens;
end;

function TValidacoesTelaBuscaCEP.validarCep(prCepDigitado: String; out prCepParaUsarNaPesquisa: Integer): Boolean;
begin
   prCepParaUsarNaPesquisa := 0;

   result := TRegEx.IsMatch(prCepDigitado, '^\d{5}-\d{3}$');
   if not result then
     begin
        FEventosMensagens.exibirMensagem('Cep inválido!');
        exit;
     end;

   result := TryStrToInt(prCepDigitado.Replace('-', ''), prCepParaUsarNaPesquisa);

   if not result then
      FEventosMensagens.exibirMensagem('Cep inválido!');
end;

function TValidacoesTelaBuscaCEP.validarEntradasParaEndereco(const prUf, prCidade, prEndereco: String): Boolean;
begin
   result := ValidarUF(prUf);
   if not result then
      exit;

   result := prCidade.Length >= 3;
   if not result then
      begin
         FEventosMensagens.exibirMensagem('O nome da cidade deve conter ao menos 3 caracteres!');
         exit;
      end;

   result := prEndereco.Length >= 3;
   if not result then
      begin
           FEventosMensagens.exibirMensagem('O endereço deve conter ao menos 3 caracteres!');
           exit;
      end;
end;

function TValidacoesTelaBuscaCEP.ValidarUF(const prUf: String): Boolean;
const
   C_UFS_ESPERADAS: Array [0 .. 26] of String = ('AC', 'AL', 'AP', 'AM', 'BA',
     'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE',
     'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO');
var
   wI: Integer;
begin
   result := not prUf.IsEmpty;

   if not result then
      begin
         FEventosMensagens.exibirMensagem('UF informada está vazia!');
         exit;
      end;

   for wI := Low(C_UFS_ESPERADAS) to High(C_UFS_ESPERADAS) do
      begin
        if prUf.Equals(C_UFS_ESPERADAS[wI]) then
           begin
              result := true;
              exit;
           end;
      end;

   result := false;
   FEventosMensagens.exibirMensagem('UF inválida!');
end;

end.
