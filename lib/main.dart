
import 'package:flutter/material.dart';
import 'package:notificaciones/screens/home_screen.dart';
import 'package:notificaciones/screens/message_screen.dart';
import 'package:notificaciones/services/push_notifications_service.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // context
    PushNotificationsService.messageStream.listen((message) { 
      print('My app: $message');

      navigatorKey.currentState?.pushNamed('message', arguments: message);
      final snackBar =  SnackBar(content: Text(message));
      scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey, // Navegar
      scaffoldMessengerKey: scaffoldMessengerKey, // Snacks
      routes: {
        'home' : ( _ ) => const HomeScreen(),
        'message' : ( _ ) => const MessageScreen(),
      },
    );
  }
}