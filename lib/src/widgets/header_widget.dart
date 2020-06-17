import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/navigation_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/pages/pasos_crear_tienda_page.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';
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
          //Container(
          //  child: _crearDropdownDirecciones(size, lugaresBloc, token)
          //),
          _crearPopUpDirecciones(size, lugaresBloc, token),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ((navigationBloc.index==3)?
                _crearPopUpNavigator(context, size)
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
  Widget _crearPopUpDirecciones(Size size, LugaresBloc lugaresBloc, String token){
    return StreamBuilder(
      stream: lugaresBloc.lugaresStream,
      builder: (BuildContext context, AsyncSnapshot<List<LugarModel>> snapshot){
        if(snapshot.hasData){
          List<LugarModel> lugares = snapshot.data;
          LugarModel lugarElegido;
          List<PopupMenuEntry<int>> popupItems = [];
          for(int i = 0; i < snapshot.data.length; i++){
            LugarModel lugar = lugares[i];
            if(lugar.elegido)
              lugarElegido = lugar;
            popupItems.add(
              PopupMenuItem(
                value: i,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.095,
                      height: size.height * 0.03,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: ((!lugar.elegido)? 
                          Border.all(
                            width: 1,
                            color: Colors.black.withOpacity(0.9)
                          )
                          :null
                          ),
                        color: (lugar.elegido)? Color.fromRGBO(192, 214, 81, 1) : Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Center(
                      child: Text(
                        (lugar.nombre == 'Tu ubicación')? lugar.nombre : lugar.direccion, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: size.width * 0.045
                        ),
                      )
                    ),
                  ],
                ),
              )
            );
          }
          popupItems.add(
            PopupMenuItem(
              enabled: false,
              value: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:size.height * 0.015),
                child: Center(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size.width * 0.04)),
                    child: Text('otra dirección'),
                    color: Colors.grey.withOpacity(0.8),
                    onPressed: (){

                    },
                  ),
                ),
              ),
            )
          );
          return PopupMenuButton<int>(
            onSelected: (int index){
              LugarModel elegido = snapshot.data[index];
              print('elegido');
              lugaresBloc.elegirLugar(elegido.id, token);
              setState(() {
                
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.width * 0.048)
            ),
            offset: Offset(
              -size.width * 0.04,
              size.height * 0.155,
            ),
            padding: EdgeInsets.all(0.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.place,
                  color: Colors.grey.withOpacity(0.8),
                  size: size.width * 0.06,
                ),
                SizedBox(
                  width: size.width * 0.02
                ),
                Text(
                  lugarElegido.direccion,
                  style: TextStyle(
                    fontSize: size.width * 0.047,
                    color: Colors.black.withOpacity(0.7)

                  ),
                )
              ],
            ),
            itemBuilder: (BuildContext context){
              return popupItems;
            },
          );
          
        }
      },
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
                  Container(
                    width: size.width * 0.095,
                    height: size.height * 0.03,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (lugar.elegido)? Colors.greenAccent : Colors.white,
                      
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
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
            itemHeight: size.height * 0.08,
            //isExpanded: true, 
            value: _dropdownValue,
            items: items,
            selectedItemBuilder: (BuildContext context){
              List<Widget> elementos = snapshot.data.map((lugar){
                return Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: Colors.grey.withOpacity(0.85),
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Text(
                      (lugar.nombre == 'Tu ubicación')? lugar.nombre : lugar.direccion, 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.045
                      ),
                    )
                    
                  ],
                );
              }).toList();
              return elementos;
            },
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

  Widget _crearPopUpNavigator(BuildContext context, Size size){
    return PopupMenuButton<int>(
      onSelected: (int index){
        switch(index){
          case 1:
            Navigator.pushNamed(context, PerfilPage.route);
            break;
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
      
      tooltip: 'tooltip',
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