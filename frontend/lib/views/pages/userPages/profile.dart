import 'package:flutter/material.dart';
import 'package:teste/connections/profileConnection.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getBasicDataConnection({}),  builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
            child: CircularProgressIndicator(),
          );
          }

          if (snapshot.hasData) {
            return(Scaffold(body: Center(child: Text("snapshot.data as String"))));
          }

          return(Image.network("https://static.vecteezy.com/system/resources/thumbnails/024/405/934/small/icon-tech-error-404-icon-isolated-png.png"));
      }
    );
  }
}