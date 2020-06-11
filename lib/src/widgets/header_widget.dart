import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/navigation_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/pages/pasos_crear_tienda_page.dart';
import 'package:flutter/material.dart';
class HeaderWidget extends StatefulWidget {

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String _dropdownValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    NavigationBloc navigationBloc = Provider.navigationBloc(context);
    LugaresBloc lugaresBloc = Provider.lugaresBloc(context);
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    String token = usuarioBloc.token;

    lugaresBloc.cargarLugares(token);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            //padding: EdgeInsets.only(right: size.width * 0.25),
            child: _crearDropdownDirecciones(size, lugaresBloc, token)
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ((navigationBloc.index==3)?
                _crearPopUpMenu(context, size)
              : Container()),
              Container(
                width: size.width * 0.0005,
                height: size.height * 0.045,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.grey.withOpacity(0.65),
                      width: 1
                    )
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.055),
                //height: size.height * 0.085,
                //width: size.width * 0.085,
                child: Image.asset(
                  'assets/iconos/logo_porta_02.png',
                  fit: BoxFit.fill,
                  width: size.width * 0.085,
                  height: size.height * 0.085,
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  Widget _crearDropdownDirecciones(Size size, LugaresBloc lugaresBloc, String token){
    //_dropdownValue = _lugaresPrueba[0].nombre;
    DropdownButton<String> dropDown = DropdownButton<String>( 
      value: _dropdownValue,
      items: [],
      onChanged: (newValue){
        
      },
    );
    return StreamBuilder(
      stream: lugaresBloc.lugaresStream,
      builder: (BuildContext context, AsyncSnapshot<List<LugarModel>> snapshot){
        if(snapshot.hasData){
          List<DropdownMenuItem> items = snapshot.data.map((LugarModel lugar){
            if(lugar.elegido)
              _dropdownValue = lugar.nombre;
            return DropdownMenuItem(
              value: lugar.nombre,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.place,
                    color: Colors.grey.withOpacity(0.8),
                    size: size.width * 0.065,
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Center(
                    child: Text(
                      (lugar.nombre == 'Tu ubicación')? lugar.nombre : lugar.direccion, 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.045
                      ),
                    )
                  ),
                ],
              ),
            );
          }).toList();
          dropDown = DropdownButton<String>( 
            value: _dropdownValue,
            items: items,
            onChanged: (newValue){
              LugarModel elegido = snapshot.data.firstWhere((lugar)=>lugar.nombre == newValue);
              lugaresBloc.elegirLugar(elegido.id, token);
              setState(() { 
                _dropdownValue = newValue;
              });
            },
            
          );
        }
        return dropDown;
      },
    );
  }

  Widget _crearPopUpMenu(BuildContext context, Size size){
    return PopupMenuButton<int>(
      onSelected: (int index){
        print('*******************');
        print('selected:');
        print('element: $index');
        switch(index){
          case 3:
            Navigator.pushReplacementNamed(context, PasosCrearTiendaPage.route);
            break;
          default:
            break;
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.048)
      ),
      offset: Offset(
        size.width * 0.28,
        -size.height * 0.005,
      ),
      padding: EdgeInsets.all(0.0),
      icon: Icon(Icons.arrow_drop_down),
      itemBuilder: (BuildContext context){
        return [
          PopupMenuItem(
            enabled: false,
            value: 0,
            child: Container(
              padding: EdgeInsets.only(bottom:size.height * 0.045),
              child: Center(
                child: Image.asset(
                  'assets/iconos/logo_porta_01.png',
                  fit: BoxFit.fill,
                  width: size.width * 0.37,
                  height: size.height * 0.074,
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: 1,
            height: size.height * 0.08,
            child: _crearChildPopUpMenuItem(size, 0, 'Perfil', Icons.person),
          ),
          PopupMenuItem(
            value: 2,
            child: _crearChildPopUpMenuItem(size, 1, 'Favoritos', Icons.favorite),
            height: size.height * 0.08,
          ),
          PopupMenuItem(
            value: 3,
            child: _crearChildPopUpMenuItem(size, 2, 'Ofrecer productos para venta', Icons.monetization_on),
            height: size.height * 0.08,
          ),
          PopupMenuItem(
            value: 4,
            child: _crearChildPopUpMenuItem(size, 3, 'Salir', Icons.open_in_new),
            height: size.height * 0.08,
            
          ),
        ];
      },
    );
  }

  Widget _crearChildPopUpMenuItem(Size size, int index, String nombre, IconData icono){
    return Container(
      height: size.height * 0.08,
      margin: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(((index < 3)? 0.45: 0.0)),
            width: 1.35
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            nombre,
            style: TextStyle(
              color: Colors.black.withOpacity(0.65),
              fontSize: size.width * 0.045,
              //fontFamily: 'FiraSansExtraCondensed',
              //fontFamily: 'BarlowCondensed',
              //fontFamily: 'UbuntuCondensed',
              fontFamily: 'FjallaOne',
              //fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.w100,

            ),
          ),
          Icon(
            icono,
            size: size.width * 0.058,
            color: Colors.grey.withOpacity(0.9),
          ),
        ],
      ),
    );
  }
}