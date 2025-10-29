import 'package:flutter/material.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;
import 'package:muto_system/views/studentViews/championshipViews/championshipdetailsView.dart';
import 'package:muto_system/views/widgets/CampCard.dart';

class ChampionshipPage extends StatefulWidget {
  @override
  State<ChampionshipPage> createState() => _ChampionshipPageState();
}

class _ChampionshipPageState extends State<ChampionshipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        title: Text(
          'Championship View',
          style: TextStyle(color: ThemeColors.Colors.background_white),
        ),
        backgroundColor: ThemeColors.Colors.background_black,
        centerTitle: true,
      ),
      backgroundColor: ThemeColors.Colors.background_black,
      body: ListView(
        children: [
          Column(
            children: [
              EventCard(
                onItemTap: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionshipDetailsView(index: index),
                    ),
                  );
                },
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                onItemTap: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionshipDetailsView(index: index),
                    ),
                  );
                },
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                onItemTap: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionshipDetailsView(index: index),
                    ),
                  );
                },
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                onItemTap: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionshipDetailsView(index: index),
                    ),
                  );
                },
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                onItemTap: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionshipDetailsView(index: index),
                    ),
                  );
                },
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                onItemTap: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionshipDetailsView(index: index),
                    ),
                  );
                },
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                onItemTap: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionshipDetailsView(index: index),
                    ),
                  );
                },
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                onItemTap: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionshipDetailsView(index: index),
                    ),
                  );
                },
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
              EventCard(
                onItemTap: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionshipDetailsView(index: index),
                    ),
                  );
                },
                title: "Campeonato Catarinense de Exatas",
                locationType: "Estadual",
                subjects: ["Mat.", "Fís."],
                daysLeft: 8,
                timeLeft: "46H",
                backgroundImage: "assets/img/ColorExample.png",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
