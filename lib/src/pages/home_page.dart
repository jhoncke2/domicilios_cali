import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:domicilios_cali/src/widgets/header_widget.dart';
import 'package:flutter/material.dart';
//importaciones locales
import 'package:domicilios_cali/src/utils/menu_categorias.dart';
import 'package:domicilios_cali/src/widgets/productos/productos_widget.dart';

class HomePage extends StatefulWidget with MenuCategorias{
  static final String route = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MenuCategorias{
  String _dropdownValue;
  List<LugarModel> _lugares = [];
  List<Widget> _itemsLugares = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String token = Provider.usuarioBloc(context).token;
    LugaresBloc lugaresBloc = Provider.lugaresBloc(context);
    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:size.width * 0.05),
        child: _crearElementos(context, lugaresBloc, token),
      ),
    );
  }

  Widget _crearElementos(BuildContext context, LugaresBloc lugaresBloc, String token){
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        //_crearMenuCategorias(size),
        SizedBox(height: size.height * 0.04),
        //_crearHeader(size, lugaresBloc),
        HeaderWidget(),
        ProductosWidget(),
      ],
    );
  }

  Widget _crearHeader(Size size, LugaresBloc lugaresBloc){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(right: size.width * 0.25),
            child: _crearDropdownDirecciones(size, lugaresBloc)
          ),
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
    );
  }

  Widget _crearDropdownDirecciones(Size size, LugaresBloc lugaresBloc){
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
}

/*
selectedItemBuilder: (BuildContext context){
    return _lugares.map<Widget>((lugar){
      return Row(
        children: <Widget>[
          Icon(
            Icons.add_circle,
            color: Colors.grey.withOpacity(0.8),
            size: size.width * 0.065,
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
      );
    }).toList();
  },
*/