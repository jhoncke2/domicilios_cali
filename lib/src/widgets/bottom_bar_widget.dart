import 'package:domicilios_cali/src/bloc/navigation_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:flutter/material.dart';
class BottomBarWidget extends StatefulWidget {

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {

  Color _unselectedItemColor;
  Color _selectedItemColor;
  IconThemeData _unselectedIconTheme;
  IconThemeData _selectedIconTheme;

  @override
  Widget build(BuildContext context) {
    NavigationBloc navigationBloc = Provider.navigationBloc(context);
    Size size = MediaQuery.of(context).size;
    _generarStylesYThemes();
    return BottomNavigationBar(
      iconSize: size.width * 0.075,
      selectedItemColor: _selectedItemColor,
      unselectedItemColor: _unselectedItemColor,
      backgroundColor: Colors.blueAccent,
      selectedIconTheme: _selectedIconTheme,
      unselectedIconTheme: _unselectedIconTheme,
      onTap: (int newIndex){
        navigationBloc.index = newIndex;
        Navigator.of(context).pushNamed(navigationBloc.routeByIndex);
        setState(() {
          
        });
      },
      currentIndex: navigationBloc.index,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Inicio',
              style: TextStyle(
                fontSize: size.width * 0.042,
              ),  
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Buscar',
              style: TextStyle(
                fontSize: size.width * 0.042,
              ),  
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_style),
            title: Text(
              'Pedidos',
              style: TextStyle(
                fontSize: size.width * 0.042,
              ),  
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            title: Text(
              'Cuenta',
              style: TextStyle(
                fontSize: size.width * 0.042,
              ),
            )
          ),
      ],
      showUnselectedLabels: true,
    );
  }

  void _generarStylesYThemes(){
    _unselectedItemColor = Colors.black.withOpacity(0.6);
    _selectedItemColor = Colors.black.withOpacity(0.9);
    _selectedIconTheme = IconThemeData(
      color: Colors.black.withOpacity(0.8),
    );
    _unselectedIconTheme = IconThemeData(
      color: Colors.grey.withOpacity(0.8),
    );
  }
}