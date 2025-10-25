import 'package:flutter/material.dart';
import 'package:muto_system/models/QuestionModel.dart';

class QuestaoCard extends StatefulWidget {
  final String tituloMateria;
  final String textoQuestao;
  final List<String> opcoes;
  final Function(String opcaoSelecionada)? onConfirmar;
  // A propriedade imagemFundoAsset não é mais usada no layout estilizado
  final String imagemFundoAsset;

  const QuestaoCard({
    super.key,
    required this.tituloMateria,
    required this.textoQuestao,
    required this.opcoes,
    this.onConfirmar,
    this.imagemFundoAsset = 'assets/image_d8ed45_background.png',
  });

  /// Cria o card a partir de um modelo genérico de questão
  factory QuestaoCard.fromModel({
    required QuestionModel question,
    required String tituloMateria,
    required String textoQuestao,
    required List<String> opcoes,
    Function(String opcaoSelecionada)? onConfirmar,
    String imagemFundoAsset = 'assets/image_d8ed45_background.png',
  }) {
    // Mantendo a factory para compatibilidade, mesmo que a imagem não seja usada
    return QuestaoCard(
      tituloMateria: tituloMateria,
      textoQuestao: textoQuestao,
      opcoes: opcoes,
      onConfirmar: onConfirmar,
      imagemFundoAsset: imagemFundoAsset,
    );
  }

  @override
  State<QuestaoCard> createState() => _QuestaoCardState();
}

class _QuestaoCardState extends State<QuestaoCard> {
  String? _opcaoSelecionada;

  // Cores fixas do tema (Aprimoradas para melhor contraste e modernidade)
  static const Color _corFundoPrincipal = Color(
    0xFF191D26,
  ); // Fundo mais escuro
  static const Color _corCardPrincipal = Color(
    0xFF22283A,
  ); // Cor principal do card
  static const Color _corTextoClaro = Colors.white;
  static const Color _corTextoSecundario = Color(
    0xFF90A4AE,
  ); // Cinza mais suave
  static const Color _corDestaque = Color(
    0xFF5E81AC,
  ); // Azul escuro moderno (Substitui _corBotaoConfirmar)
  static const Color _corTituloQuestao = Color(
    0xFF708090,
  ); // Cinza azulado para detalhes

  @override
  Widget build(BuildContext context) {
    // 1. Header (Topo) estilizado com gradiente
    final headerWidget = Container(
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1F222B), Color(0xFF191D26)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: _corTextoClaro),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.tituloMateria.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _corTextoSecundario,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Questão de Múltipla Escolha',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _corTextoClaro,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    // 2. Card Principal do Corpo
    final cardBody = Container(
      padding: const EdgeInsets.all(20.0),
      // Bordas arredondadas e cor principal
      decoration: const BoxDecoration(
        color: _corCardPrincipal,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enem PPL | M0516',
            style: TextStyle(
              color: _corTituloQuestao,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Texto da Questão com estilo
          Text(
            widget.textoQuestao,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: _corTextoClaro,
              fontSize: 18, // Aumentado para melhor leitura
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),

          // Opções de múltipla escolha estilizadas
          ...widget.opcoes.map((opcao) => _buildOptionTile(opcao)),
          const SizedBox(height: 30),

          // Botão Confirmar estilizado com gradiente
          SizedBox(
            width: double.infinity,
            height: 55,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Gradiente para o botão principal
                gradient: LinearGradient(
                  colors: [_corDestaque, _corDestaque.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _corDestaque.withOpacity(
                      _opcaoSelecionada != null ? 0.5 : 0.1,
                    ),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed:
                    _opcaoSelecionada != null && widget.onConfirmar != null
                    ? () => widget.onConfirmar!(_opcaoSelecionada!)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Transparente para mostrar o DecoratedBox
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Confirmar Resposta',
                  style: TextStyle(
                    color: _corTextoClaro,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: _corFundoPrincipal,
      body: SingleChildScrollView(
        child: Column(
          children: [
            headerWidget,
            // Adiciona um pequeno espaçamento negativo para o card se sobrepor um pouco ao header
            Transform.translate(offset: const Offset(0, -20), child: cardBody),
          ],
        ),
      ),
    );
  }

  /// Constrói o widget de opção individual (ListTile aprimorado)
  Widget _buildOptionTile(String opcao) {
    final isSelected = _opcaoSelecionada == opcao;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _opcaoSelecionada = opcao;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? _corDestaque.withOpacity(0.2)
                : _corCardPrincipal, // Fundo sutil ao selecionar
            border: Border.all(
              color: isSelected
                  ? _corDestaque
                  : _corTextoSecundario.withOpacity(0.3),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: _corDestaque.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Círculo de seleção
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? _corDestaque : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? _corDestaque
                        : _corTextoSecundario.withOpacity(0.6),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12), // Círculo
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: _corTextoClaro, size: 16)
                    : null,
              ),
              const SizedBox(width: 16),
              // Texto da Opção
              Expanded(
                child: Text(
                  opcao,
                  style: TextStyle(
                    color: isSelected ? _corTextoClaro : _corTextoSecundario,
                    fontSize: 16,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
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
