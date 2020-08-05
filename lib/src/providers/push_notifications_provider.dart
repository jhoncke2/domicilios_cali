import 'package:domicilios_cali/src/pages/login_page.dart';
import 'package:domicilios_cali/src/pages/pedidos_page.dart';
import 'package:domicilios_cali/src/pages/solicitud_de_pedidos_page.dart';
import 'package:domicilios_cali/src/pages/ventas_page.dart';
import 'package:flutter/material.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

class PushNotificationsProvider{
  static bool onPushNotification = false;
  static final _firebaseServerUrl = 'https://fcm.googleapis.com/fcm/send';
  static final _firebaseServerToken = 'AAAA3uYRq0k:APA91bHim1CA93N6ph0tu-y0ZGV04DGVyJS2FYhyj8PYvzUV3xIkSVFRuDJUt-XpX7UsJNoI2n3vQQZYlgTzxOgE3a74Ld1XTPOkZkhW8BPBZaCHgLrzI8Se1J9UkkNO15GGhkchVTbC';

  static final notificationTypes = [
    'cliente_enviar_pedido', 
    'tienda_confirmar_pedido', 
    'tienda_denegar_pedido',
    'tienda_delegar_pedido_a_domiciliario',
    'tienda_crear_domiciliario',
    'domiciliario_aceptar_pedido',
    'domiciliario_denegar_pedido'
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
      data['id']='1';
      data['status']='done';
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
          notificationBody = '${data["nombre_tienda"]} ha aceptado tu pedido';
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
          notificationTitle = 'Solicitud de contrato';
          notificationBody = '${data["nombre_tienda"]} quiere que seas su domiciliario. Si deseas aceptar, comunicate con él y envíale el código que te llegará a la bandeja de mensajes.';
          break;
      }

      body['notification'] = {
        'title':notificationTitle,
        'body':notificationBody
      };
      final response = await http.post(
        _firebaseServerUrl,
        headers: {
          'Authorization':'key=$_firebaseServerToken',
          'Content-Type':'Application/json'
        },
        body: json.encode(body)
      );
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      return {
        'status':'ok',
        'response':decodedResponse
      };


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
        _reaccionarAClienteEnviarPedido(receiverChannel);
        break; 
      case 'tienda_confirmar_pedido':
        _reaccionarATiendaAceptarPedido(receiverChannel, data['nombre_tienda'], data['tiempo_maximo_entrega']);
        break;
      case 'tienda_denegar_pedido':
        _reaccionarATiendaDenegarPedido(receiverChannel, data['nombre_tienda'], data['razon_tienda']);
        break;
      case 'tienda_delegar_pedido_a_domiciliario':
        _reaccionarATiendaDelegarPedidoADomiciliario(receiverChannel, data['nombre_tienda']);
        break;
      case 'domiciliario_aceptar_pedido':
        break;
      case 'domiciliario_denegar_pedido':
        break; 
      case 'tienda_crear_domiciliario':
        _reaccionarATiendaCrearDomiciliario(receiverChannel, notification['nombre_tienda']);
        break;
      case 'domiciliario_unirse_a_tienda':
        break;
    }
    print('Recibiendo data de push notification en el main:');
    print(data);
  }

  void _reaccionarAClienteEnviarPedido(String receiverChannel){
    if(Provider.usuarioBloc(_context).usuario != null){
      if(Provider.usuarioBloc(_context).usuario.hasStore){
        if(receiverChannel == 'on_message')
          _crearDialog(
            _context,
            'te ha llegado un nuevo pedido',
            //en realidad debe ser PedidosActualesPage.route
            SolicitudDePedidosPage.route
          );
        else if(receiverChannel == 'on_resume')
          Navigator.of(_context).pushNamed(SolicitudDePedidosPage
          .route);
        
      }
    }else{
      Navigator.of(_context).pushNamed(LoginPage.route);
    }
  }

  void _reaccionarATiendaAceptarPedido(String receiverChannel, String nombreTienda, int tiempoMaximoEntrega){
    if(Provider.usuarioBloc(_context).usuario != null){
      if(receiverChannel == 'on_message'){
        _crearDialog(
          _context,
          '$nombreTienda ha aceptado tu pedido. Este llegará en máximo $tiempoMaximoEntrega minutos',
          PedidosPage.route
        );
      }else if(receiverChannel == 'on_resume'){
        print('on resume');
      }
    }
  }

  void _reaccionarATiendaDenegarPedido(String receiverChannel, String nombreTienda, String razon){
    if(Provider.usuarioBloc(_context).usuario != null){
      if(receiverChannel == 'on_message'){
        _crearDialog(
          _context,
          '$nombreTienda ha denegado tu pedido debido a lo siguiente: \n$razon',
          PedidosPage.route
        );
      }else if(receiverChannel == 'on_resume'){
        print('on resume');
      }
    }
  }

  void _reaccionarATiendaDelegarPedidoADomiciliario(String receiverChannel, String nombreTienda){
    if(Provider.usuarioBloc(_context).usuario != null){
      if(receiverChannel == 'on_message'){
        _crearDialog(
          _context,
          '$nombreTienda te ha designado un nuevo domicilio',
          PedidosPage.route
        );
      }else if(receiverChannel == 'on_resume'){
        _crearDialog(
          _context,
          '$nombreTienda te ha designado un nuevo domicilio',
          PedidosPage.route
        );
      }
    }
  }

  void _reaccionarATiendaCrearDomiciliario(String receiverChannel, String nombreTienda){
    if(Provider.usuarioBloc(_context).usuario != null){
      if(receiverChannel == 'on_message'){
        _crearDialog(
          _context,
         '$nombreTienda quiere hacerte su domiciliario. Si deseas aceptar, comunicate con él y envíale el código que te llegará a la bandeja de mensajes.',
          null
        );
      }else if(receiverChannel == 'on_resume'){
        _crearDialog(
          _context,
         '$nombreTienda quiere hacerte su domiciliario. Si deseas aceptar, comunicate con él y envíale el código que te llegará a la bandeja de mensajes.',
          null
        );
      }
    }
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
            if(pageRoute != null)
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