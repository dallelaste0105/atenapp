import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/config.dart';

class Config extends StatelessWidget {
  const Config({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ConfigClass>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        backgroundColor: config.primaryColor,
      ),
      backgroundColor: config.secundaryColor,
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Escolha o Tema",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: config.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                config.changeTheme(); 
              },
              icon: Icon(config.isDark ? Icons.light_mode : Icons.dark_mode),
              label: Text(config.isDark ? "Mudar para Claro" : "Mudar para Escuro"),
            ),
          ],
        ),
      ),
    );
  }
}