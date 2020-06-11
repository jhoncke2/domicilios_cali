import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/widgets/DrawerWidget.dart';
import 'package:domicilios_cali/src/widgets/productos/productos_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductosTiendaPage extends StatelessWidget {
  static final route = 'productos_tienda';
  @override
  Widget build(BuildContext context) {
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    LugaresBloc lugaresBloc = Provider.lugaresBloc(context);
    //por el momento
    lugaresBloc.cargarLugares(usuarioBloc.token);
    //por el momento
    
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Mis productos',
            style: TextStyle(
              fontSize: size.width * 0.055,
              color: Colors.white.withOpacity(0.8),
            ),
          )
        ),
      ),
      drawer: DrawerWidget(),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearElementos(context, size, lugaresBloc),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
    );
  }

  Widget _crearElementos(BuildContext context, Size size, LugaresBloc lugaresBloc){
    return SingleChildScrollView(
      padding: EdgeInsets.all(0.0),
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [  
          SizedBox(height: size.height * 0.01,),
          _crearFiltros(context, size),
          SizedBox(height: size.height * 0.01,),
          ProductosWidget(
            widthPercent: 1,
            heightPercent: 0.72,
          ),
          _crearBotonAgregar(context, size)
        ],
      ),
    );
  }
  
  Widget _crearFiltros(BuildContext context, Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: size.height * 0.0, bottom: 0.0),
          margin: EdgeInsets.only(right: size.height * 0.035),
          height: size.height * 0.055,
          width: size.width * 0.5,
          decoration: BoxDecoration(
           // borderRadius: BorderRadius.circular(10.0),
           borderRadius:BorderRadius.only(
             topLeft: Radius.circular(8.0),
             topRight: Radius.circular(8.0),

           ),
            color: Colors.white
            //color: Theme.of(context).backgroundColor,
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              suffixIcon: Icon(
                Icons.search, 
              ),
              hintText: 'Buscar',
            ),
            onChanged: (String value){
              
            },
          ),
        ),
      ],
    );
  }

  Widget _crearBotonAgregar(BuildContext context, Size size){
    return Container(
      width: size.width,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.1),
        color: Theme.of(context).secondaryHeaderColor,
        child: Text(
          'Agregar producto',
          style: TextStyle(
            fontSize: size.width * 0.071,
            color: Colors.white54,
          ),
        ),
        onPressed: (){
          print('Agregar producto');
        },
      ),
    );
  }

}