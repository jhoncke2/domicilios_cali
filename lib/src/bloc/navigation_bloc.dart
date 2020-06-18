import 'package:domicilios_cali/src/pages/cuenta_page.dart';
import 'package:domicilios_cali/src/pages/historial_page.dart';
import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';

class NavigationBloc{
  int index = 0;

  String get routeByIndex{
    print('index: $index');
    switch(index){
      case 0:
        return HomePage.route;
      case 2:
        return HistorialPage.route;
      case 3:
        return CuentaPage.route;
      default:
        return PerfilPage.route;
    }
  }
}