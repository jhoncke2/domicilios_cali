import 'package:domicilios_cali/src/providers/push_notifications_provider.dart';
import 'package:flutter/cupertino.dart';

class PushNotificationsBloc{
  bool notificationsStarted = false;
  final PushNotificationsProvider _pushNotificatoinsProvider = new PushNotificationsProvider();

  void onPushNotification(BuildContext context){
    if(!notificationsStarted){
      _pushNotificatoinsProvider.initNotificationsReceiver();
        _pushNotificatoinsProvider.pushMessagesStream.listen((Map<String, dynamic> data){
        print('===== llegó data a stream ====');
        print(data);
        
      });
      notificationsStarted = true;
    }
    
  }

  void dispose(){
    _pushNotificatoinsProvider.dispose();
  }
}