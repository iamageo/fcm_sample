import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fcm_sample/sample_screen.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final notif = message.notification;
  debugPrint('📥 [FCM][Background]');
  debugPrint('   • Título: ${notif?.title ?? '—'}');
  debugPrint('   • Corpo:  ${notif?.body  ?? '—'}');
  debugPrint('   • Dados:  ${message.data}');
}

Future<void> configureFirebaseMessaging() async {
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  debugPrint('🛡️ [FCM] Permissões: ${settings.authorizationStatus}');

  final token = await messaging.getToken();
  if (token != null) {
    debugPrint('🔑 [FCM] Token obtido:\n$token');
  } else {
    debugPrint('⚠️ [FCM] Falha ao obter token');
  }

  FirebaseMessaging.onMessage.listen((msg) {
    final notif = msg.notification;
    debugPrint('📲 [FCM][Foreground]');
    debugPrint('   • Título: ${notif?.title ?? '—'}');
    debugPrint('   • Corpo:  ${notif?.body  ?? '—'}');
    debugPrint('   • Dados:  ${msg.data}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((msg) {
    final notif = msg.notification;
    debugPrint('👆 [FCM][OpenedApp]');
    debugPrint('   • Título: ${notif?.title ?? '—'}');
    debugPrint('   • Corpo:  ${notif?.body  ?? '—'}');
    debugPrint('   • Dados:  ${msg.data}');
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureFirebaseMessaging();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCM Sample',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SampleScreen(),
    );
  }
}
