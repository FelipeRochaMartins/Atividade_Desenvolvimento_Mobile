import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CadastroApp());
}

class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: const CadastroScreen(),
    );
  }
}

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  bool _obscureSenha = true;
  bool _obscureConfirmaSenha = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    super.dispose();
  }

  void _submeterFormulario() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Cadastro realizado com sucesso!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 4),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Por favor, corrija os erros destacados no formulário.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Usuário',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_add_alt_1_rounded,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Criar Nova Conta',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Preencha todos os campos obrigatórios abaixo',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 24),

              // Campo: Nome completo
              TextFormField(
                key: const Key('campo_nome'),
                controller: _nomeController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nome completo *',
                  hintText: 'Digite seu nome completo',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'O nome completo é obrigatório.';
                  }
                  if (value.trim().length < 3) {
                    return 'O nome deve ter no mínimo 3 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: E-mail
              TextFormField(
                key: const Key('campo_email'),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail *',
                  hintText: 'exemplo@email.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'O e-mail é obrigatório.';
                  }
                  final trimmed = value.trim();
                  if (!trimmed.contains('@')) {
                    return 'O e-mail deve conter o caractere @.';
                  }
                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(trimmed)) {
                    return 'Informe um e-mail válido (ex: usuario@dominio.com).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: CPF
              TextFormField(
                key: const Key('campo_cpf'),
                controller: _cpfController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'CPF *',
                  hintText: 'Apenas números (11 dígitos)',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'O CPF é obrigatório.';
                  }
                  final trimmed = value.trim();
                  if (!RegExp(r'^[0-9]+$').hasMatch(trimmed)) {
                    return 'O CPF deve conter apenas números.';
                  }
                  if (trimmed.length != 11) {
                    return 'O CPF deve ter exatamente 11 dígitos.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Telefone
              TextFormField(
                key: const Key('campo_telefone'),
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'Telefone *',
                  hintText: 'Apenas números com DDD (ex: 11999999999)',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'O telefone é obrigatório.';
                  }
                  final trimmed = value.trim();
                  if (!RegExp(r'^[0-9]+$').hasMatch(trimmed)) {
                    return 'O telefone deve conter apenas números.';
                  }
                  if (trimmed.length < 10 || trimmed.length > 11) {
                    return 'O telefone deve conter 10 ou 11 dígitos.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Senha
              TextFormField(
                key: const Key('campo_senha'),
                controller: _senhaController,
                obscureText: _obscureSenha,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Senha *',
                  hintText: 'Mínimo de 6 caracteres',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    key: const Key('toggle_senha'),
                    icon: Icon(
                      _obscureSenha
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    tooltip: _obscureSenha ? 'Mostrar senha' : 'Ocultar senha',
                    onPressed: () {
                      setState(() {
                        _obscureSenha = !_obscureSenha;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A senha é obrigatória.';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter no mínimo 6 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Desafio: Campo de confirmação de senha
              TextFormField(
                key: const Key('campo_confirma_senha'),
                controller: _confirmaSenhaController,
                obscureText: _obscureConfirmaSenha,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha *',
                  hintText: 'Repita sua senha',
                  prefixIcon: const Icon(Icons.lock_reset_outlined),
                  suffixIcon: IconButton(
                    key: const Key('toggle_confirma_senha'),
                    icon: Icon(
                      _obscureConfirmaSenha
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    tooltip: _obscureConfirmaSenha
                        ? 'Mostrar confirmação de senha'
                        : 'Ocultar confirmação de senha',
                    onPressed: () {
                      setState(() {
                        _obscureConfirmaSenha = !_obscureConfirmaSenha;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A confirmação de senha é obrigatória.';
                  }
                  if (value != _senhaController.text) {
                    return 'As senhas não coincidem.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Botão CADASTRAR
              ElevatedButton(
                key: const Key('botao_cadastrar'),
                onPressed: _submeterFormulario,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'CADASTRAR',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
