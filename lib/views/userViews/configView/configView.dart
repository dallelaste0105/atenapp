import 'package:Atena/views/userViews/configView/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfigView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Configurações")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("TEMA", style: TextStyle(fontSize: theme.fontSize + 2)),

            ElevatedButton(
              onPressed: () => theme.setTheme("light"),
              child: Text("Modo claro", style: TextStyle(fontSize: theme.fontSize)),
            ),
            ElevatedButton(
              onPressed: () => theme.setTheme("dark"),
              child: Text("Modo escuro", style: TextStyle(fontSize: theme.fontSize)),
            ),

            const SizedBox(height: 40),

            Text("TAMANHO DA FONTE", style: TextStyle(fontSize: theme.fontSize + 2)),

            ElevatedButton(
              onPressed: () => theme.setFontSize("small"),
              child: Text("Pequena", style: TextStyle(fontSize: theme.fontSize)),
            ),
            ElevatedButton(
              onPressed: () => theme.setFontSize("medium"),
              child: Text("Média", style: TextStyle(fontSize: theme.fontSize)),
            ),
            ElevatedButton(
              onPressed: () => theme.setFontSize("large"),
              child: Text("Grande", style: TextStyle(fontSize: theme.fontSize)),
            ),
          ],
        ),
      ),
    );
  }
}
