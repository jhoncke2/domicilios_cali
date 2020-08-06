import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/pages/confirmar_codigo_domiciliario_page.dart';
import 'package:domicilios_cali/src/pages/cuenta_page.dart';
import 'package:domicilios_cali/src/pages/direccion_create_mapa_page.dart';
import 'package:domicilios_cali/src/pages/direccion_create_page.dart';
import 'package:domicilios_cali/src/pages/domiciliario_create_page.dart';
import 'package:domicilios_cali/src/pages/domiciliarios_elegir_page.dart';
import 'package:domicilios_cali/src/pages/domiciliarios_page.dart';
import 'package:domicilios_cali/src/pages/favoritos_page.dart';
import 'package:domicilios_cali/src/pages/pedidos_page.dart';
import 'package:domicilios_cali/src/pages/mapa_page.dart';
import 'package:domicilios_cali/src/pages/pasos_confirmacion_celular_page.dart';
import 'package:domicilios_cali/src/pages/pasos_crear_tienda_page.dart';
import 'package:domicilios_cali/src/pages/pasos_recuperar_password_page.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';
import 'package:domicilios_cali/src/pages/producto_create_page.dart';
import 'package:domicilios_cali/src/pages/solicitud_de_pedidos_page.dart';
import 'package:domicilios_cali/src/pages/splash_screen_page.dart';
import 'package:domicilios_cali/src/pages/ventas_page.dart';
import 'package:domicilios_cali/src/providers/push_notifications_provider.dart';
import 'package:flutter/material.dart';
//importaciones locales
import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/pages/login_page.dart';
import 'package:domicilios_cali/src/pages/producto_detail_page.dart';
import 'package:domicilios_cali/src/pages/productos_catalogo_page.dart';
import 'package:domicilios_cali/src/pages/productos_tienda_page.dart';
import 'package:domicilios_cali/src/pages/carrito_page.dart';
import 'package:domicilios_cali/src/pages/register_page.dart';

void main()async{
   runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext appContext){
    /**
     * Esta es la forma como Flutter recomienda que manipulemos la información
     * y/o el estado de la misma.
     * 
     * Como estoy implementando el InheritedWidget en la parte más alta(la cabeza) del
     * árbol de Widgets, va a ser distribuido alrededor de toda mi aplicación.
     */
    return Provider(
      child: MaterialApp(
        title: 'Domicilios',
        initialRoute: HomePage.route,
        routes:{
          HomePage.route:(BuildContext context)=>HomePage(),
          SplashScreenPage.route:(BuildContext context)=>SplashScreenPage(),
          LoginPage.route:(BuildContext context)=>LoginPage(),
          RegisterPage.route:(BuildContext context)=>RegisterPage(),
          PasosRecuperarPasswordPage.route:(BuildContext context)=>PasosRecuperarPasswordPage(),
          PasosConfirmacionCelularPage.route:(BuildContext context)=>PasosConfirmacionCelularPage(),
          PedidosPage.route:(BuildContext context)=>PedidosPage(),
          CuentaPage.route:(BuildContext context)=>CuentaPage(),
          PerfilPage.route:(BuildContext context)=>PerfilPage(),
          PasosCrearTiendaPage.route:(BuildContext context)=>PasosCrearTiendaPage(),
          DireccionCreatePage.route:(BuildContext context)=>DireccionCreatePage(),
          ProductosCatalogoPage.route:(BuildContext context)=>ProductosCatalogoPage(),
          ProductoDetailPage.route:(BuildContext context)=>ProductoDetailPage(),
          ProductosTiendaPage.route:(BuildContext context)=>ProductosTiendaPage(),
          SolicitudDePedidosPage.route:(BuildContext context)=>SolicitudDePedidosPage(),
          VentasPage.route:(BuildContext context)=>VentasPage(),
          DomiciliariosPage.route:(BuildContext context)=>DomiciliariosPage(),
          DomiciliarioCreatePage.route:(BuildContext context)=>DomiciliarioCreatePage(),
          ConfirmarCodigoDomiciliarioPage.route:(BuildContext context)=>ConfirmarCodigoDomiciliarioPage(),
          DomiciliariosElegirPage.route:(BuildContext context)=>DomiciliariosElegirPage(),
          FavoritosPage.route:(BuildContext context)=>FavoritosPage(),
          CarritoPage.route:(BuildContext context)=>CarritoPage(),
          MapaPage.route:(BuildContext context)=>MapaPage(),
          ProductoCreatePage.route:(BuildContext context)=>ProductoCreatePage(),
          DireccionCreateMapaPage.route:(BuildContext context)=>DireccionCreateMapaPage(),
        },
        theme: ThemeData(
          fontFamily: 'OpenSans',
          //backgroundColor: Color.fromRGBO(50, 196, 171, 1),//verde azulado
          //backgroundColor: Color.fromRGBO(240, 200, 102, 1),
          primaryColor: Color.fromRGBO(103, 58, 183, 1),
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),   
          secondaryHeaderColor: Color.fromRGBO(192, 214, 81, 1),
          //primaryColor: Colors.white,
          //secondaryHeaderColor: Color.fromRGBO(134, 174, 188, 1),//azul grisaseo
          //secondaryHeaderColor: Color.fromRGBO(240, 190, 92, 1),//orange
          hoverColor: Colors.white,
          iconTheme: IconThemeData(
            //color: Color.fromRGBO(240, 200, 102, 1),
            color: Colors.blueAccent
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.blue,
            focusColor: Colors.grey,
            hoverColor: Colors.redAccent
          ),
          buttonColor: Color.fromRGBO(240, 200, 102, 1),
          buttonTheme: ButtonThemeData(
            buttonColor: Color.fromRGBO(240, 200, 102, 1),
          )
        ),
        debugShowCheckedModeBanner: false,
      ),
    );

  }
}

