import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/widgets/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
//importaciones locales
import 'package:domicilios_cali/src/utils/menu_categorias.dart';
import 'package:domicilios_cali/src/widgets/productos/lista_productos_widget.dart';


class HomePage extends StatefulWidget with MenuCategorias{
  static final String route = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MenuCategorias{
  String _dropdownValue;
  List<LugarModel> _lugares = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String token = Provider.usuarioBloc(context).token;
    LugaresBloc lugaresBloc = Provider.lugaresBloc(context);
    lugaresBloc.cargarLugares(token);
    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Container(
        //padding: EdgeInsets.symmetric(horizontal:size.width * 0.05),
        child: _crearElementos(context, lugaresBloc, token),
      ),
    );
  }

  Widget _crearElementos(BuildContext context, LugaresBloc lugaresBloc, String token){
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        //_crearMenuCategorias(size),
        SizedBox(height: size.height * 0.025),
        _crearHeader(size, lugaresBloc),
        ListaProductosWidget(),
      ],
    );
  }

  Widget _crearHeader(Size size, LugaresBloc lugaresBloc){
    return Container(
      child: Row(
        children: [
          _crearDropdownDirecciones(size, lugaresBloc),
          Text('logo'),
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
            return DropdownMenuItem(
              value: lugar.nombre,
              child: Center(
                child: Text(
                  lugar.direccion, 
                  textAlign: TextAlign.center,
                )
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