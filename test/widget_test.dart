import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:atividade_desenvolvimento_mobile/main.dart';

void main() {
  setUp(() {
    // Configura tamanho de tela padrão de smartphone para os testes
  });

  void configurePhoneScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  testWidgets('Verifica renderização dos componentes principais da tela', (
    WidgetTester tester,
  ) async {
    configurePhoneScreen(tester);
    await tester.pumpWidget(const CadastroApp());

    // Verifica título do app bar
    expect(find.text('Cadastro de Usuário'), findsOneWidget);

    // Verifica presença dos campos pelo label ou chave
    expect(find.byKey(const Key('campo_nome')), findsOneWidget);
    expect(find.byKey(const Key('campo_email')), findsOneWidget);
    expect(find.byKey(const Key('campo_cpf')), findsOneWidget);
    expect(find.byKey(const Key('campo_telefone')), findsOneWidget);
    expect(find.byKey(const Key('campo_senha')), findsOneWidget);
    expect(find.byKey(const Key('campo_confirma_senha')), findsOneWidget);

    // Verifica botão CADASTRAR
    expect(find.byKey(const Key('botao_cadastrar')), findsOneWidget);
    expect(find.text('CADASTRAR'), findsOneWidget);
  });

  testWidgets(
    'Valida campos obrigatórios e exibe SnackBar de erro quando vazio',
    (WidgetTester tester) async {
      configurePhoneScreen(tester);
      await tester.pumpWidget(const CadastroApp());

      // Clica em CADASTRAR com campos vazios
      final botaoCadastrar = find.byKey(const Key('botao_cadastrar'));
      await tester.ensureVisible(botaoCadastrar);
      await tester.tap(botaoCadastrar);
      await tester.pumpAndSettle();

      // Verifica mensagens de erro individuais
      expect(find.text('O nome completo é obrigatório.'), findsOneWidget);
      expect(find.text('O e-mail é obrigatório.'), findsOneWidget);
      expect(find.text('O CPF é obrigatório.'), findsOneWidget);
      expect(find.text('O telefone é obrigatório.'), findsOneWidget);
      expect(find.text('A senha é obrigatória.'), findsOneWidget);
      expect(find.text('A confirmação de senha é obrigatória.'), findsOneWidget);

      // Verifica SnackBar de erro
      expect(
        find.text('Por favor, corrija os erros destacados no formulário.'),
        findsOneWidget,
      );
    },
  );

  testWidgets('Valida regras específicas de e-mail', (
    WidgetTester tester,
  ) async {
    configurePhoneScreen(tester);
    await tester.pumpWidget(const CadastroApp());

    final campoEmail = find.byKey(const Key('campo_email'));
    final botaoCadastrar = find.byKey(const Key('botao_cadastrar'));

    // Sem @
    await tester.enterText(campoEmail, 'usuarioemail.com');
    await tester.ensureVisible(botaoCadastrar);
    await tester.tap(botaoCadastrar);
    await tester.pumpAndSettle();
    expect(find.text('O e-mail deve conter o caractere @.'), findsOneWidget);

    // Com @ mas formato inválido
    await tester.enterText(campoEmail, 'usuario@');
    await tester.ensureVisible(botaoCadastrar);
    await tester.tap(botaoCadastrar);
    await tester.pumpAndSettle();
    expect(
      find.text('Informe um e-mail válido (ex: usuario@dominio.com).'),
      findsOneWidget,
    );
  });

  testWidgets('Valida regras de tamanho mínimo da senha e confirmação', (
    WidgetTester tester,
  ) async {
    configurePhoneScreen(tester);
    await tester.pumpWidget(const CadastroApp());

    final campoSenha = find.byKey(const Key('campo_senha'));
    final campoConfirmaSenha = find.byKey(const Key('campo_confirma_senha'));
    final botaoCadastrar = find.byKey(const Key('botao_cadastrar'));

    // Senha com menos de 6 caracteres
    await tester.enterText(campoSenha, '12345');
    await tester.enterText(campoConfirmaSenha, '12345');
    await tester.ensureVisible(botaoCadastrar);
    await tester.tap(botaoCadastrar);
    await tester.pumpAndSettle();
    expect(find.text('A senha deve ter no mínimo 6 caracteres.'), findsOneWidget);

    // Senha diferente da confirmação
    await tester.enterText(campoSenha, '123456');
    await tester.enterText(campoConfirmaSenha, '654321');
    await tester.ensureVisible(botaoCadastrar);
    await tester.tap(botaoCadastrar);
    await tester.pumpAndSettle();
    expect(find.text('As senhas não coincidem.'), findsOneWidget);
  });

  testWidgets('Alterna visibilidade da senha e confirmação de senha', (
    WidgetTester tester,
  ) async {
    configurePhoneScreen(tester);
    await tester.pumpWidget(const CadastroApp());

    // Testa botão de alternar senha
    final toggleSenha = find.byKey(const Key('toggle_senha'));
    expect(find.byIcon(Icons.visibility_off_outlined), findsNWidgets(2));

    await tester.ensureVisible(toggleSenha);
    await tester.tap(toggleSenha);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

    // Testa botão de alternar confirmação de senha
    final toggleConfirmaSenha = find.byKey(const Key('toggle_confirma_senha'));
    await tester.ensureVisible(toggleConfirmaSenha);
    await tester.tap(toggleConfirmaSenha);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.visibility_outlined), findsNWidgets(2));
  });

  testWidgets('Cadastra com sucesso quando dados são válidos', (
    WidgetTester tester,
  ) async {
    configurePhoneScreen(tester);
    await tester.pumpWidget(const CadastroApp());

    await tester.enterText(
      find.byKey(const Key('campo_nome')),
      'Felipe Rocha Martins',
    );
    await tester.enterText(
      find.byKey(const Key('campo_email')),
      'felipe@email.com',
    );
    await tester.enterText(
      find.byKey(const Key('campo_cpf')),
      '12345678901',
    );
    await tester.enterText(
      find.byKey(const Key('campo_telefone')),
      '11987654321',
    );
    await tester.enterText(
      find.byKey(const Key('campo_senha')),
      'senha123',
    );
    await tester.enterText(
      find.byKey(const Key('campo_confirma_senha')),
      'senha123',
    );

    final botaoCadastrar = find.byKey(const Key('botao_cadastrar'));
    await tester.ensureVisible(botaoCadastrar);
    await tester.tap(botaoCadastrar);
    await tester.pumpAndSettle();

    // Verifica se SnackBar de sucesso foi exibido
    expect(find.text('Cadastro realizado com sucesso!'), findsOneWidget);
  });
}
