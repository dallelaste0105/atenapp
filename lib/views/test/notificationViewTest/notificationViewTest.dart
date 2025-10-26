import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

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
    _initializeTimeZones();
    _initializeNotifications();
  }

  void _initializeTimeZones() {
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
    debugPrint('Fusos horários inicializados (America/Sao_Paulo).');
  }

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

    debugPrint('Sistema de notificações inicializado com sucesso.');
    _showSnackBar('Sistema de notificações pronto!');
  }

  Future<void> _sendInstantNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'instant_channel',
          'Notificações Instantâneas',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Notificação Enviada!',
      'Essa é uma notificação enviada instantaneamente!',
      notificationDetails,
    );

    debugPrint('Notificação instantânea enviada.');
    _showSnackBar('Notificação enviada instantaneamente!');
  }

  Future<void> _sendDelayedNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'delayed_channel',
          'Notificações Agendadas',
          importance: Importance.high,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final scheduledTime = tz.TZDateTime.now(
      tz.local,
    ).add(const Duration(seconds: 5));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'Lembrete Rápido!',
      'Sua notificação agendada para 5 segundos chegou.',
      scheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    debugPrint('Notificação agendada para ${scheduledTime.toLocal()}.');
    _showSnackBar('Notificação agendada para daqui a 5 segundos.');
  }

  Future<void> _scheduleDailyNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'daily_channel',
          'Lembretes Diários de Estudo',
          importance: Importance.max,
          priority: Priority.max,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final nextTime = _nextInstanceOfTime(hour: 8, minute: 0);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'Hora do Muto Estudo!',
      'Lembre-se de revisar seus tópicos de hoje.',
      nextTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    debugPrint('Lembrete diário agendado para ${nextTime.toLocal()}.');
    _showSnackBar('Lembrete diário agendado para 8:00 AM.');
  }

  tz.TZDateTime _nextInstanceOfTime({required int hour, required int minute}) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    debugPrint('Todas as notificações agendadas foram canceladas.');
    _showSnackBar('Todas as notificações foram canceladas.');
  }

  Future<void> _sendConditionalNotification(bool condition) async {
    if (condition) {
      await _sendInstantNotification();
      debugPrint('Condição atendida. Notificação enviada.');
      _showSnackBar('Condição atendida! Notificação enviada.');
    } else {
      debugPrint('Condição não satisfeita. Nenhuma notificação enviada.');
      _showSnackBar('Condição não atendida. Nenhuma notificação enviada.');
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey[900],
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1B1B1D),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7C4DFF),
          secondary: Color(0xFF00BCD4),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2A2A2E),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
          centerTitle: true,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Testes de Notificação Local')),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C4DFF),
                  ),
                  onPressed: _sendInstantNotification,
                  child: const Text('1. Enviar Notificação Agora'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                  ),
                  onPressed: _sendDelayedNotification,
                  child: const Text('2. Agendar Notificação Depois de 5s'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7),
                  ),
                  onPressed: _scheduleDailyNotification,
                  child: const Text('3. Agendar Lembrete Diário (8:00 AM)'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009688),
                  ),
                  onPressed: () {
                    bool condition = DateTime.now().second % 2 == 0;
                    _sendConditionalNotification(condition);
                  },
                  child: const Text('4. Enviar Se Segundo For Par'),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: _cancelAllNotifications,
                  child: const Text('5. Cancelar Todas as Agendadas'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
