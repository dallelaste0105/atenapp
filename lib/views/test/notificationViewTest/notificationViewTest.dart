import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Instância global do plugin de notificações
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationTest extends StatefulWidget {
  const NotificationTest({super.key});

  @override
  State<NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  // Inicializa o plugin de notificações
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  // Envia uma notificação simples imediatamente
  Future<void> _sendInstantNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'instant_channel', // ID do canal
          'Notificações Instantâneas', // Nome do canal
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // ID da notificação
      'Notificação Enviada!',
      'Essa é uma notificação enviada instantaneamente 🎉',
      notificationDetails,
    );
  }

  // Envia uma notificação após um tempo (agendada)
  Future<void> _sendDelayedNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'delayed_channel',
          'Notificações Agendadas',
          importance: Importance.high,
          priority: Priority.high,
        );
  }

  // Envia uma notificação baseada em uma condição
  Future<void> _sendConditionalNotification(bool condition) async {
    if (condition) {
      await _sendInstantNotification();
    } else {
      debugPrint('Condição não satisfeita, sem notificação.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Notificação instantânea
            ElevatedButton(
              onPressed: () {
                _sendInstantNotification();
              },
              child: const Text('Enviar Notificação Agora'),
            ),

            const SizedBox(height: 20),

            // Notificação com atraso
            ElevatedButton(
              onPressed: () {
                _sendDelayedNotification();
              },
              child: const Text('Enviar Notificação Depois de 5s'),
            ),

            const SizedBox(height: 20),

            // Notificação condicional
            ElevatedButton(
              onPressed: () {
                bool condition = DateTime.now().second % 2 == 0;
                _sendConditionalNotification(condition);
              },
              child: const Text('Enviar Se Segundo For Par'),
            ),
          ],
        ),
      ),
    );
  }
}
