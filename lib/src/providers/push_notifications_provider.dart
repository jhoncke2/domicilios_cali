import 'package:domicilios_cali/src/pages/login_page.dart';
import 'package:domicilios_cali/src/pages/ventas_page.dart';
import 'package:flutter/material.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider{
  static bool onPushNotification = false;
  static final _firebaseServerUrl = 'https://fcm.googleapis.com/fcm/send';
  static final _firebaseServerToken = 'AAAA3uYRq0k:APA91bHim1CA93N6ph0tu-y0ZGV04DGVyJS2FYhyj8PYvzUV3xIkSVFRuDJUt-XpX7UsJNoI2n3vQQZYlgTzxOgE3a74Ld1XTPOkZkhW8BPBZaCHgLrzI8Se1J9UkkNO15GGhkchVTbC';

  static final notificationTypes = [
    'cliente_enviar_pedido', 
    'tienda_confirmar_pedido', 
    'tienda_denegar_pedido',
    'tienda_delegar_pedido_a_domiciliario',
    'tienda_crear_domiciliario'
  ];

  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _pushReceiverController = new StreamController<Map<String,dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get pushReceiverStream => _pushReceiverController.stream;
  static String mobileToken;
  bool yaInicio = false;
  BuildContext _context;

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
    print(yaInicio);
    //para obtener permisos del usuario
    yaInicio = true;
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
    if(!onPushNotification){
      print('======on message =======');
      print(message);
      try{
        _pushReceiverController.sink.add({
          'receiver_channel':'on_message',
          'data':message['data']
        });
        _reaccionarAPushNotification({
          'receiver_channel':'on_message',
          'data':message['data']
        });
      }catch(err){
        print('error en on Message: $err');
      }
    }
    onPushNotification = !onPushNotification;
    
    
  }

  Future<dynamic> onResume(Map<String, dynamic> message)async{
    print('======on message =======');
    print(message);
    try{
      _pushReceiverController.sink.add({
        'receiver_channel':'on_resume',
        'data':message['data']
      });
      _reaccionarAPushNotification({
        'receiver_channel':'on_resume',
        'data':message['data'],
      });
    }catch(err){
      print('error en on Resume: $err');
    }
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message)async{
    print('======on message =======');
    print(message);
    try{
      _pushReceiverController.sink.add({
        'receiver_channel':'on_launch',
        'data':message['data']
      });
      _reaccionarAPushNotification({
        'receiver_channel':'on_launch',
        'data':message['data'],
      });
    }catch(err){
      print('error en on Launch: $err');
    }
  }

  Future<Map<String, dynamic>> sendPushNotification(String receiverMobileToken, String notificationType, Map<String, dynamic> data)async{
    try{
      Map<String, dynamic> body = {
        'priority':'high',
        'to':receiverMobileToken
      };
      
      data['click_action'] = 'FLUTTER_NOTIFICATION_CLICK';
      data['notification_type'] = notificationType;
      body['data'] = data;
      String notificationTitle;
      String notificationBody;
      switch(notificationType){
        case 'cliente_enviar_pedido':
          notificationTitle = 'nuevo pedido';
          notificationBody = 'Has recibido un nuevo pedido';
          break;
        case 'tienda_confirmar_pedido':
          notificationTitle = 'pedido aceptado';
          notificationBody = '${data["tienda_name"]} ha aceptado tu pedido';
          break;
        case 'tienda_denegar_pedido':
          notificationTitle = 'pedido denegado';
          notificationBody = 'La tienda ha denegado tu pedido. Clickea aquí para saber porqué';
          break;
        case 'tienda_delegar_pedido_a_domiciliario':
          notificationTitle = 'Nueva entrega';
          notificationBody = 'Tienes un nuevo pedido para entregar';
          break;
        case 'tienda_crear_domiciliario':
          notificationTitle = 'Solicitud de domiciliario';
          notificationBody = '${data["tienda_name"]} quiere que seas uno de sus domiciliarios';
          break;
      }

      body['notification'] = {
        'title':notificationTitle,
        'body':notificationBody
      };
      final response = http.post(
      _firebaseServerUrl,
      headers: {
        'Authorization':'key=$_firebaseServerToken'
      },
      body: body
    );

    }catch(err){
      return {
        'status':'err',
        'message':err
      };
    }
    
  }

  void _reaccionarAPushNotification(Map<String, dynamic> notification){
    Map<String, dynamic> data = (notification['data'] as Map).cast<String, dynamic>();
    String receiverChannel = notification['receiver_channel'];
    switch(data['notification_type']){
      case 'cliente_enviar_pedido':
        if(Provider.usuarioBloc(_context).usuario != null){
          if(Provider.usuarioBloc(_context).usuario.hasStore){
            if(receiverChannel == 'on_message')
              _crearDialog(
                _context,
                'te ha llegado un nuevo pedido',
                //en realidad debe ser PedidosActualesPage.route
                VentasPage.route
              );
            else if(receiverChannel == 'on_resume')
              Navigator.of(_context).pushNamed(PerfilPage.route);
            
          }
        }else{
          Navigator.of(_context).pushNamed(LoginPage.route);
        }
        break; 
      case 'tienda_confirmar_pedido':
        break;
      case 'tienda_denegar_pedido':
        break;
      case 'tienda_delegar_pedido_a_domiciliario':
        break;
      case 'tienda_crear_domiciliario':
        break; 
    }
    print('Recibiendo data de push notification en el main:');
    print(data);
  }

  void _crearDialog(BuildContext context, String mensaje, String pageRoute){
    Size  size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.all(0.0),
            height: size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  mensaje,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.045
                  ),
                )
              ],
            ),
          ),
          onTap: (){
            Navigator.of(context).pushNamed(pageRoute);
          },
        );
      },

    );
  }

  set context(BuildContext newContext){
    this._context = newContext;
  }

  void dispose(){
    _pushReceiverController.close();
  }
}