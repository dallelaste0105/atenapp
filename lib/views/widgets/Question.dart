import 'package:flutter/material.dart';
import 'package:muto_system/models/QuestionModel.dart';

class QuestaoCard extends StatefulWidget {
  final QuestionModel question;
  final Function(String opcaoSelecionada)? onConfirmar;

  const QuestaoCard({super.key, required this.question, this.onConfirmar});

  @override
  State<QuestaoCard> createState() => _QuestaoCardState();
}

class _QuestaoCardState extends State<QuestaoCard> {
  String? _respostaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222631),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.question.subject),
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            widget.question.imageUrl ?? 'assets/img/PurpleExample.png',
          ),
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
      ),
      child: Center(
        child: Text(
          widget.question.subject,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Questão:",
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.question.text,
          textAlign: TextAlign.justify,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 20),
        ...widget.question.options.map(
          (opcao) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: InkWell(
              onTap: () => setState(() => _respostaSelecionada = opcao),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _respostaSelecionada == opcao
                      ? Colors.blue.withOpacity(0.3)
                      : Colors.transparent,
                  border: Border.all(
                    color: _respostaSelecionada == opcao
                        ? Colors.blueAccent
                        : Colors.white38,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  opcao,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _respostaSelecionada != null
                ? () => widget.onConfirmar?.call(_respostaSelecionada!)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Confirmar Resposta",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
