import 'package:domicilios_cali/src/pages/cuenta_page.dart';
import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';

class NavigationBloc{
  int index = 0;

  String get routeByIndex{
    switch(index){
      case 0:
        return HomePage.route;
      case 3:
        return CuentaPage.route;
      default:
        return PerfilPage.route;
    }
  }
}