import 'package:flutter/material.dart';
import 'package:muto_system/views/credentialViews/signupView.dart';

class HomeView extends StatefulWidget {
  final String token;
  const HomeView({super.key, required this.token});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: [
          const ColoredPage(color: Colors.blue, title: 'Página 1'),
          const ColoredPage(color: Colors.green, title: 'Página 2'),
  // sem const
          const ColoredPage(color: Colors.orange, title: 'Página 4'),
          const ColoredPage(color: Colors.purple, title: 'Página 5'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Matérias'),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Campeonatos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Amizades'),
        ],
      ),
    );
  }
}

class ColoredPage extends StatelessWidget {
  final Color color;
  final String title;

  const ColoredPage({super.key, required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
