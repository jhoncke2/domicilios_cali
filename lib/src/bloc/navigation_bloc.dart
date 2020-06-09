import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';

class NavigationBloc{
  int index = 0;

  String get routeByIndex{
    switch(index){
      case 0:
        return HomePage.route;
      default:
        return PerfilPage.route;
    }
  }
}