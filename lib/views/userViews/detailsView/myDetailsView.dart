import 'package:flutter/material.dart';
import 'package:muto_system/classes/basicData.dart'; // Mantenha sua classe

final BasicDataClassInstance = BasicDataClass();

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  @override
  void initState() {
    super.initState();
    BasicDataClassInstance.getUserBasicDataClass();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meu Perfil")),
      body: Center(
        child: FutureBuilder<List>(
          
          // 7. PASSE A VARIÁVEL (e não a função)
          future: BasicDataClass().showUserBasicDataClass(), // <--- A GRANDE MUDANÇA
          
          builder: (context, snapshot) {
            
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text(
                'Erro ao carregar e-mail: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            }

            if (snapshot.hasData) {
              final userID = snapshot.data!;
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "ID do Usuário:",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userID[0],
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