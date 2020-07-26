import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/pages/login_page.dart';
import 'package:domicilios_cali/src/pages/pedidos_page.dart';

class NavigationBloc{
  int index = 0;

  String get routeByIndex{
    switch(index){
      case 0:
        return HomePage.route;
      case 2:
        return PedidosPage.route;
      case 3:
        return LoginPage.route;
      default:
        return LoginPage.route;
    }
  }

  void reiniciarIndex(){
    index = 0;
  }
}