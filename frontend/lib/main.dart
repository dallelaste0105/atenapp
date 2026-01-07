import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'config.dart'; 
import 'package:teste/views/pages/pageTerminal.dart';
import 'package:teste/views/pages/allPages/signup.dart';
import 'connections/connectionFunctions.dart'; 
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ConfigClass(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigClass>(
      builder: (context, config, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Projeto Teste',
          debugShowCheckedModeBanner: false,
          theme: config.getThemeData(),
          home: FutureBuilder<String?>(
            future: getJWT(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator())
                );
              }
              if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                return UserPageView();
              }
              return const Signup();
            },
          ),
        );
      },
    );
  }
}