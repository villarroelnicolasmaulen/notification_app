// sha1 : 1E:BA:AE:F8:50:35:44:A1:8D:DC:B2:E0:55:0D:B9:09:69:4F:E3:8B

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast(); 
  static Stream<String> get messageStream => _messageStream.stream;

  // cuando está terminada
  static Future<void> _backgroundHandler( RemoteMessage message) async{
    // print('onBackground Handler ${message.messageId}');
    print(message.data);

    _messageStream.add(message.notification?.body ?? 'No title');
  }

  // cuando está en funcionamiento
  static Future<void> _onMessageHandler( RemoteMessage message) async{
    // print('onMessage Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.body ?? 'No title');
  }

  // cuando está en la APP
  static Future<void> _onMessageOpenAppr( RemoteMessage message) async{
    // print('onMessageOpenAppr Handler ${message.messageId}');
    print(message.data);

    _messageStream.add(message.notification?.body ?? 'No title');
  }


  static Future initializeApp() async{
    // Push notifications
      await Firebase.initializeApp();
      token = await FirebaseMessaging.instance.getToken();
      print(token);

    
    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenAppr);


    // Local notifications
  }


  static closeStreams(){
    _messageStream.close();
  }

}