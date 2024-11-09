


# Aplicativo de Agenda em Flutter

Este é um aplicativo simples de agenda desenvolvido com Flutter, criado por **Marco Antonio**, projetado para facilitar a gestão de contatos. Com ele, é possível adicionar, editar e excluir contatos, armazenando informações essenciais como nome, número de telefone e e-mail.

## Principais Funcionalidades

- **Visualização de Contatos**: Apresenta todos os contatos cadastrados de forma organizada, com a possibilidade de pesquisa rápida.
- **Cadastro e Alteração**: Permite criar novos contatos ou modificar os existentes, com validação de dados.
- **Validação de Informações**: Garante que os campos de nome, telefone e e-mail sejam preenchidos corretamente antes de salvar.
- **Tema Escuro**: Suporte a um design moderno e adaptável, incluindo uma opção de tema escuro.
- **Armazenamento Local**: Os contatos são salvos diretamente no dispositivo, permitindo o acesso offline e sem dependência de conexão com a internet.

## Tecnologias Empregadas

- **Flutter**: Framework robusto e eficiente para a criação de aplicativos móveis, utilizado para o desenvolvimento deste projeto.
- **Dart**: Linguagem de programação que serve como base para o Flutter, proporcionando excelente desempenho e experiência do usuário.

## Como Iniciar

Para rodar este projeto em seu ambiente local, siga os seguintes passos:

1. **Clone o repositório**:
   Abra o terminal e execute o comando abaixo para clonar o repositório em seu computador:
   ```bash
   git clone https://github.com/marcoantonio84/AgendaMarco
   cd Agenda-Flutter
   ```

2. **Instale as dependências**:
   Após clonar o repositório, execute o comando a seguir para instalar as dependências necessárias:
   ```bash
   flutter pub get
   ```

3. **Execute o aplicativo**:
   Conecte um dispositivo ou inicie um emulador e execute o aplicativo com o comando:
   ```bash
   flutter run
   ```

## Estrutura do Projeto

A estrutura do projeto foi organizada para facilitar a navegação e a manutenção. Veja a divisão de pastas e arquivos principais:

- **lib/models**: Contém o modelo `Contact`, que representa a estrutura de dados de um contato.
- **lib/repositories**: Abriga o `ContactRepository`, responsável por gerenciar o banco de dados local.
- **lib/screens**: Contém as telas principais, como a listagem de contatos e as telas de cadastro/edição.
- **lib/widgets**: Inclui widgets reutilizáveis e componentes UI para facilitar a construção das telas.

Este projeto foi desenvolvido por **Marco Antonio** com foco em simplicidade, usabilidade e eficiência no armazenamento local.