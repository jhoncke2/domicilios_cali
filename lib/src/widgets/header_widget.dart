import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/pages/direccion_create_page.dart';
import 'package:flutter/material.dart';
class HeaderWidget extends StatefulWidget {
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LugaresBloc lugaresBloc = Provider.lugaresBloc(context);
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    String token = usuarioBloc.token;
    if(usuarioBloc.usuario != null)
      lugaresBloc.cargarLugares(token);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ((usuarioBloc.usuario != null)?
          _crearPopUpDirecciones(size, lugaresBloc, token)
          :Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                      width: size.width * 0.025,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width  * 0.45),
                      child: Text(
                        lugar.direccion,
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
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
                      Navigator.pushNamed(context, DireccionCreatePage.route, arguments: 'cliente');
                    },
                  ),
                ),
              ),
            )
          );
          return PopupMenuButton<int>(
            onSelected: (int index){
              LugarModel elegido = snapshot.data[index];
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
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width  * 0.45),
                  child: Text(
                    lugarElegido.direccion,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.005,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey.withOpacity(0.65),
                  size: size.width * 0.085,
                ),
              ],
            ),
            itemBuilder: (BuildContext context){
              return popupItems;
            },
          ); 
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}