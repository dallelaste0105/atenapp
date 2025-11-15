import 'package:Atena/connections/credentialConnection.dart';
import 'package:flutter/material.dart';
import 'package:Atena/views/userViews/configView/colorConfigView.dart';
import 'package:Atena/views/pageViews.dart';
import 'package:Atena/views/generalViews/userSignupView.dart';
// Importa ambas as funções de conexão
import 'package:Atena/connections/basicData.dart'; 

void main() {
  // Garante que os bindings do Flutter sejam inicializados
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // A home agora é a nossa nova widget de verificação
      home: AuthCheckScreen(),
    );
  }
}

/// Esta é a nova widget que gerencia a verificação de login.
/// Ela é Stateful para que o Future possa ser armazenado no State.
class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  // 1. Declaramos o Future como uma variável de estado.
  late Future<String> _loadUserFuture;

  @override
  void initState() {
    super.initState();
    // 2. Iniciamos o Future *apenas uma vez* no initState.
    _loadUserFuture = _loadUserType();
  }

  /// A lógica de carregar o usuário foi movida para dentro do State.
  Future<String> _loadUserType() async {
    try {
      // Carrega tema salvo
      final colorConfig = ColorConfig();
      await colorConfig.getColorConfig();

      // Busca dados básicos do usuário
      final userBasicData = await getUserBasicDataConnection();

      // Verificação de SUCESSO
      if (userBasicData.isNotEmpty &&
          userBasicData.containsKey("userType") &&
          userBasicData["userType"] != null) {
        // Encontramos um usuário válido, retorna o tipo
        return userBasicData["userType"].toString();
      }

      // --- CORREÇÃO APLICADA ---
      // Falha 1: A API respondeu, mas não retornou 'userType'.
      // Isso significa que o token salvo é inválido ou expirado.
      debugPrint("Token inválido (sem userType). Limpando token local.");
      await deleteToken(); // Limpa o token "lixo"
      return "";
      // --- FIM DA CORREÇÃO ---

    } catch (e) {
      // --- CORREÇÃO APLICADA ---
      // Falha 2: A API falhou (erro de rede, 401, 500, etc.)
      // Assumimos que é por causa de um token expirado/inválido.
      debugPrint("Erro ao carregar usuário (provável token expirado): $e");
      await deleteToken(); // Limpa o token "lixo"
      return "";
      // --- FIM DA CORREÇÃO ---
    }
  }

  @override
  Widget build(BuildContext context) {
    // 3. O FutureBuilder agora usa a variável de estado _loadUserFuture
    return FutureBuilder<String>(
      future: _loadUserFuture,
      builder: (context, snapshot) {
        // Enquanto o future está rodando (apenas na primeira vez)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Se o future deu erro (agora já limpamos o token)
        if (snapshot.hasError) {
          debugPrint("Erro no FutureBuilder: ${snapshot.error}");
          return UserSignupView(); // Vai para o login
        }

        // Se o future completou com dados
        if (snapshot.hasData) {
          final userType = snapshot.data!;

          switch (userType) {
            case "user":
              return UserPageView();
            case "student":
              return StudentPageView();
            case "teacher":
              return TeacherPageView();
            case "school":
              return SchoolPageView();
            default:
              // Se 'userType' for "" (após limpar o token), vai pro login
              return UserSignupView();
          }
        }

        // Fallback: se não tiver dados (ex: future completou com null)
        return UserSignupView();
      },
    );
  }
}