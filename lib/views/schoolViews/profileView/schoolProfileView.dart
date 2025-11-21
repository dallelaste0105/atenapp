import 'package:Atena/classes/generalBasicDataClass.dart';
import 'package:Atena/views/userViews/configView/configView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Atena/views/userViews/configView/themeNotifier.dart';

final generalBasicDataInstance = GeneralBasicData();
bool _firstExecution = true;

class SchoolProfileView extends StatefulWidget {
  @override
  State<SchoolProfileView> createState() => _SchoolProfileViewState();
}

class _SchoolProfileViewState extends State<SchoolProfileView> {
  @override
  void initState() {
    super.initState();
    _loadGeneralData();
  }

  Future<void> _loadGeneralData() async {
    if (_firstExecution) {
      await generalBasicDataInstance.takeAndSaveGeneralBasicData();
      _firstExecution = false;
    }
    setState(() {}); // Atualiza UI após carregar
  }

  Widget _buildStatColumn(BuildContext context, String label, String value) {
    final theme = Provider.of<ThemeNotifier>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.themeData.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: theme.themeData.colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.themeData.brightness == Brightness.dark;

    return FutureBuilder(
  future: generalBasicDataInstance.showGeneralBasicData(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final data = snapshot.data as Map<String, dynamic>;

    final String userName = data["name"];


        return Scaffold(
          backgroundColor: theme.themeData.scaffoldBackgroundColor,
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 380,
                  child: Stack(
                    children: [
                      // ------------ FUNDO ----------------
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const NetworkImage(
                              'https://tecnico-informatica.concordia.ifc.edu.br/wp-content/uploads/sites/20/2017/12/IMG-20171128-WA0003.jpg',
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              isDark ? Colors.black87 : Colors.black54,
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      ),

                      // ------------ BOTÃO CONFIG ----------------
                      Positioned(
                        top: 35,
                        right: 16,
                        child: IconButton(
                          icon: Icon(Icons.settings,
                              color: Colors.white, size: 30),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfigView(),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                      ),

                      // ------------ CONTEÚDO CENTRAL ----------------
                      Positioned(
                        top: 40,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/129172387?v=4",
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              userName, // ← AQUI
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Estudante do IFC',
                              style: TextStyle(
                                fontSize: 16,
                                color: theme.themeData.colorScheme.secondary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.local_fire_department,
                                      color: Colors.orange, size: 18),
                                  SizedBox(width: 6),
                                  Text(
                                    '224 dias',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ------------ CARD INFERIOR ----------------
                      Positioned(
                        bottom: 0,
                        left: 16,
                        right: 16,
                        child: Card(
                          color: theme.themeData.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildStatColumn(
                                    context, 'Avançado', 'Mat. 32/78'),
                                _buildStatColumn(context, 'Nível', '54'),
                                _buildStatColumn(
                                    context, 'Liga', "leagueType"), // ← AQUI
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
