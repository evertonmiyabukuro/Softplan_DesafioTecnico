# Desafio Técnico Softplan - Desenvolvedor Delphi

Este repositório contém o código-fonte do projeto desenvolvido para o desafio técnico de criar um **MVP para consultas de CEP** utilizando o **WebService público da ViaCEP**.

O projeto foi desenvolvido utilizando **Delphi 12.3**, sendo uma aplicação **Windows (desktop)**. Para persistência de dados, foi utilizado **SQLite**, e para comunicação com a Internet, a biblioteca **Indy**.

---

## Arquitetura

O projeto segue a arquitetura **MVC** (Model-View-Controller), estruturada da seguinte forma:

### Model
- Modelagem do **CEP**, correspondente à tabela `CEP` no banco de dados.

### View
- Tela principal do sistema, com opções para:
  - Consulta de CEPs
  - Visualização dos CEPs já buscados

### Controller
- Interfaces e classes responsáveis por:
  - Busca de CEP na API da ViaCEP (`BuscadorViaCEP`)
  - Tratamento do retorno da busca (JSON ou XML) (`BuscaViaCEPJSON` e `BuscaViaCEPXML`)
  - Controle da tela (`BuscaCepController`)
  - Validações da tela (`ValidacoesTelaBuscaCep`)
  - Eventos de mensagens para o usuário (`EventosMensagensUI`)

### Data
- Classe de conexão com o banco de dados
- DAO para consulta e manipulação de CEPs no banco

O projeto também inclui **testes unitários e de integração**, localizados na pasta `Tests`.

---

## Padrões de projeto utilizados

Alguns dos padrões aplicados no projeto incluem:

- **Dependency Injection**: Para injetar dependências entre as classes.
- **DAO (Data Access Object)**: acessar e trabalhar na tabela `CEP` do banco.
- **Strategy**: Utilizado com a interface `IEventosMensagem` para permitir diferentes comportamentos de mensagens.
- **Facade**: Na classe `TEventosMensagensUI`, encapsulando chamadas diretas à VCL.
- **Template Method**: `TBuscaViaCEP` e suas heranças `TBuscaViaCEPJSON` e `TBuscaViaCEPXML`, com suas implementações específicas.
- **Bridge**: Separando a lógica de busca do ViaCEP entre a classe principal (`TBuscaViaCEP`) e a interface de comunicação com a API (`IBuscadorViaCEP`).

---

## Instruções para compilação

1. Abra o **projeto no Delphi**.
2. Compile a aplicação.
3. Certifique-se de que a **DLL do SQLite (32 bits)** esteja presente na raiz da aplicação:
   - Para a aplicação: `.\bin\app`
   - Para os testes: `.\bin\Tests`
4. A DLL do SQLite pode ser obtida na pasta do Delphi ou na **release** deste repositório.

---

## Uso da aplicação

A aplicação possui duas abas principais (na parte inferior da interface):

### 1. Buscar CEP
- Permite pesquisar CEPs conforme os requisitos.
- Possibilita buscar por **CEP** ou **Endereço** (retornando um ou mais registros).
- Permite selecionar o formato da consulta: **JSON** ou **XML**.

### 2. Consultar CEPs cadastrados
- Exibe os CEPs já importados para consulta.
- Permite **excluir registros** do banco.

---

### Observações finais

Há algumas melhorias que são importantes para um produto final:
- Melhor controle com relação às conexões ao banco de dados.
- Observabilidade (logs e registros dos resultados das requisições feitas à API).
- Requisições à APIs web ser feitas por TTasks/Threads, de forma a não travar a intterface da aplicação.