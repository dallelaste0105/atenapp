import 'package:flutter/material.dart';
import 'package:teste/connections/sendNotificationsConnection.dart';

final TextEditingController studentCode = TextEditingController();
final TextEditingController teacherCode = TextEditingController();

class CreateCodes extends StatefulWidget {
  @override
  State<CreateCodes> createState() => _CreateCodesState();
}

class _CreateCodesState extends State<CreateCodes> {
  
  void showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Painel da Escola")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Text("Definir Códigos de Acesso", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            TextField(controller: studentCode, decoration: InputDecoration(labelText: "Novo código para Alunos")),
            ElevatedButton(
              onPressed: () async {
                if (studentCode.text.isEmpty) return showSnack("Digite um código!", isError: true);
                
                showSnack("Salvando...");
                var res = await LANCAR_CODIGO_ESTUDANTE({"cod": studentCode.text});
                
                if (res != null && res['ok'] == true) {
                  showSnack("Código de aluno atualizado com sucesso!");
                } else {
                  showSnack(res?['msg'] ?? "Erro ao atualizar", isError: true);
                }
              }, 
              child: Text("Salvar Cód. Aluno")
            ),
            
            SizedBox(height: 30),
            
            TextField(controller: teacherCode, decoration: InputDecoration(labelText: "Novo código para Professores")),
            ElevatedButton(
              onPressed: () async {
                if (teacherCode.text.isEmpty) return showSnack("Digite um código!", isError: true);

                showSnack("Salvando...");
                var res = await LANCAR_CODIGO_PROFESSOR({"cod": teacherCode.text});
                
                if (res != null && res['ok'] == true) {
                  showSnack("Código de professor atualizado com sucesso!");
                } else {
                  showSnack(res?['msg'] ?? "Erro ao atualizar", isError: true);
                }
              }, 
              child: Text("Salvar Cód. Professor")
            ),
            
            SizedBox(height: 40),
            Divider(),
            
            ElevatedButton.icon(
              icon: Icon(Icons.notifications_active),
              label: Text("Enviar Notificação para Alunos"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () async {
                showSnack("Enviando...");
                final res = await MANDAR_NOTIFICACAO({});
                if(res != null && res['ok'] == true) {
                   showSnack(res['msg']);
                } else {
                   showSnack("Erro ao enviar.", isError: true);
                }
              }, 
            )
          ]),
        )
      )
    );
  }
}