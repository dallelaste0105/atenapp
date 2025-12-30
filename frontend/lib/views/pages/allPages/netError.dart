import 'package:flutter/material.dart';

class NetError extends StatefulWidget {
  @override
  State<NetError> createState() => _NetErrorState();
}

class _NetErrorState extends State<NetError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Erro de rede, tente se conectar novamente")));
  }
}