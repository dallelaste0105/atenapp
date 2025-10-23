import 'package:flutter/material.dart';
import '../../connections/credentialConnection.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meu Perfil")),
      body: Center(
        child: FutureBuilder<String>(
          // Chama a sua função 'teste'
          future: teste(), 
          
          builder: (context, snapshot) {
            
            // 1. Carregando
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            // 2. Erro
            if (snapshot.hasError) {
              return Text(
                'Erro ao carregar e-mail: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            }

            // 3. Sucesso
            if (snapshot.hasData) {
              final userEmail = snapshot.data!;
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "E-mail do Usuário:",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userEmail, // O e-mail retornado pela API
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }

            return const Text('Nenhum dado encontrado.');
          },
        ),
      ),
    );
  }
}