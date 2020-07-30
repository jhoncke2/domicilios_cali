import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _pushMessagesController = new StreamController<Map<String,dynamic>>();

  Stream<Map<String, dynamic>> get pushMessagesStream => _pushMessagesController.stream;

  static String mobileToken;

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message)async{
      if(message.containsKey('data')){
        final dynamic data = message['data'];
        print('from background: data: $data');
      }
      if(message.containsKey('notificatoin')){
        final dynamic notification = message['notification'];
        print('from background: notification: $notification');
      }
  }

  static Future<String> getMobileToken()async{
    //await _firebaseMessaging.requestNotificationPermissions();
    mobileToken = await _firebaseMessaging.getToken();
    print('=============mobile token==================');
    print(mobileToken);
    return mobileToken;
  }

  initNotificationsReceiver()async{
    //para obtener permisos del usuario
    _firebaseMessaging.requestNotificationPermissions();
    mobileToken = await _firebaseMessaging.getToken();
    print('mobile token:');
    print(mobileToken);
    _firebaseMessaging.configure(
      onBackgroundMessage: Platform.isIOS ? null: onBackgroundMessage,
      onMessage: onMessage,
      onResume: onResume,
      onLaunch: onLaunch
    );
  }

  

  Future<dynamic> onMessage(Map<String, dynamic> message)async{
    print('======on message =======');
    print(message);
    try{
      Map<String, dynamic> data = (message['data'] as Map).cast<String, dynamic>();
      _pushMessagesController.sink.add(data);
    }catch(err){
      print('error en on Message: $err');
    }
  }

  Future<dynamic> onResume(Map<String, dynamic> message)async{
    print('======on message =======');
    print(message);
    try{
      Map<String, dynamic> data = (message['data'] as Map).cast<String, dynamic>();
      _pushMessagesController.sink.add(data);
    }catch(err){
      print('error en on Message: $err');
    }
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message)async{
    print('======on message =======');
    print(message);
    try{
      Map<String, dynamic> data = (message['data'] as Map).cast<String, dynamic>();
      _pushMessagesController.sink.add(data);
    }catch(err){
      print('error en on Message: $err');
    }
  }

  void dispose(){
    _pushMessagesController.close();
  }
}