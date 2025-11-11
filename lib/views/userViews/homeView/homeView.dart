import 'package:flutter/material.dart';
import 'package:muto_system/views/userViews/leagueView/leaguePositionsView.dart';
import 'package:muto_system/views/userViews/loadingDadosView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, String? savedToken}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _paginaAtual = 0;

  void _mudarPagina(int index) {
    setState(() => _paginaAtual = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _pagina(Color cor, String texto) {
    return Container(
      color: cor,
      alignment: Alignment.center,
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _paginaAtual = index),
        children: [LoadingdadosView(), LeagueScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaAtual,
        onTap: _mudarPagina,
        backgroundColor: const Color(0xFF2C5282),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person_2), label: "INICIAL"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "LIGA"),
        ],
      ),
    );
  }
}
