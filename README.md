# Atividade Prática: Formulário de Cadastro de Usuário em Flutter

**Disciplina:** Desenvolvimento Mobile (Flutter e Dart)  
**Tema:** Formulários e Validações no Flutter  

---

## 📱 Visão Geral

Aplicação desenvolvida em Flutter contendo uma tela completa de cadastro de usuário. A aplicação captura os dados digitados, aplica filtros de entrada e máscaras de validação, valida cada campo individualmente com mensagens descritivas de erro e fornece feedback visual ao usuário via `SnackBar`.

---

## 📋 Campos e Regras de Validação

| Campo | Entrada permitida | Regras de Validação |
|---|---|---|
| **Nome completo** | Texto livre | Obrigatório, mínimo de 3 caracteres |
| **E-mail** | Teclado de e-mail | Obrigatório, deve conter `@` e seguir padrão RFC válido via RegExp |
| **CPF** | Apenas dígitos (`FilteringTextInputFormatter.digitsOnly`) | Obrigatório, exatamente 11 dígitos numéricos |
| **Telefone** | Apenas dígitos (`FilteringTextInputFormatter.digitsOnly`) | Obrigatório, 10 ou 11 dígitos com DDD |
| **Senha** | Senha com visualização alternável | Obrigatório, mínimo de 6 caracteres |
| **Confirmar Senha** *(Desafio)* | Senha com visualização alternável | Obrigatório, deve ser idêntico ao campo Senha |

---

## 🌟 Recursos Implementados (Incluindo Desafios)

1. **Estrutura Obrigatória de Widgets:**
   ```
   Scaffold
   └── Form (key: _formKey)
       └── SingleChildScrollView
           └── Column
               ├── TextFormField (nome)
               ├── TextFormField (e-mail)
               ├── TextFormField (CPF)
               ├── TextFormField (telefone)
               ├── TextFormField (senha)
               ├── TextFormField (confirmar senha)
               └── ElevatedButton (CADASTRAR)
   ```

2. **Filtros e Teclados de Entrada:**
   - `keyboardType: TextInputType.name` com capitalização de palavras.
   - `keyboardType: TextInputType.emailAddress`.
   - `keyboardType: TextInputType.number` com `FilteringTextInputFormatter.digitsOnly` e `LengthLimitingTextInputFormatter(11)` para CPF.
   - `keyboardType: TextInputType.phone` com `FilteringTextInputFormatter.digitsOnly` e `LengthLimitingTextInputFormatter(11)` para Telefone.

3. **Desafios Concluídos:**
   - 🔒 **Campo de confirmação de senha:** validação de igualdade entre senha e confirmação.
   - 👁️ **Botão mostrar/ocultar senha:** ícone interativo nos campos de senha e confirmação de senha.
   - 📧 **Validação robusta de e-mail:** uso de expressão regular (RegExp) validando estrutura completa de domínio.
   - ⚠️ **SnackBar de erro estilizado em vermelho:** disparado ao submeter formulário com campos inválidos.
   - ✅ **SnackBar de sucesso estilizado em verde:** disparado ao submeter formulário válido.

---

## 🧪 Testes Automatizados

O projeto conta com suíte de testes de widgets cobrindo todos os fluxos:
- Renderização inicial da hierarquia de widgets.
- Validação de campos em branco e disparo de mensagens de erro + SnackBar de erro.
- Validação de regras específicas de e-mail (com e sem `@`, domínios inválidos).
- Validação de senha curta (< 6 caracteres) e discrepância de confirmação.
- Alternância de visibilidade das senhas.
- Submissão com dados válidos e exibição do SnackBar de sucesso.

Para executar os testes:
```bash
flutter test
```

---

## 🚀 Como Executar o Projeto

1. Certifique-se de que o Flutter SDK está instalado.
2. Na raiz deste diretório (`Atividade_Desenvolvimento_Mobile`), baixe as dependências:
   ```bash
   flutter pub get
   ```
3. Execute o aplicativo em seu dispositivo, emulador ou navegador:
   ```bash
   # Para executar no Chrome:
   flutter run -d chrome

   # Para executar no Windows Desktop:
   flutter run -d windows

   # Ou simplesmente:
   flutter run
   ```

---

## 📦 Entrega

- Repositório: [GitHub](https://github.com/FelipeRochaMartins/Atividade_Desenvolvimento_Mobile)
- Suba os commits e envie o link junto com o print do app em funcionamento no AVA.
