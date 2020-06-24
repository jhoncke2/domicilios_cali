import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/tienda_bloc.dart';
import 'package:domicilios_cali/src/pages/cuenta_page.dart';
import 'package:domicilios_cali/src/pages/perfil_page.dart';
import 'package:domicilios_cali/src/widgets/pasos_crear_tienda/confirmar_mapa_tienda_widget.dart';
import 'package:domicilios_cali/src/widgets/pasos_crear_tienda/crear_direccion_tienda_widget.dart';
import 'package:domicilios_cali/src/widgets/pasos_crear_tienda/crear_domiciliarios_tienda_widget.dart';
import 'package:domicilios_cali/src/widgets/pasos_crear_tienda/crear_horarios_tienda_page.dart';
import 'package:domicilios_cali/src/widgets/pasos_crear_tienda/subir_cedula_tienda_widget.dart';
import 'package:flutter/material.dart';
class PasosCrearTiendaPage extends StatefulWidget {
  static final route = 'pasos_crear_tienda';
  @override
  _PasosCrearTiendaPageState createState() => _PasosCrearTiendaPageState();

}

class _PasosCrearTiendaPageState extends State<PasosCrearTiendaPage> {
  int _indexPaso = 1;
  @override
  Widget build(BuildContext context) {
    TiendaBloc tiendaBloc = Provider.tiendaBloc(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            _crearPasoWidget(),
            _crearBotonIzquierdoNavegacion(context, size),
            _crearBotonDerechoNavegacion(context, size, tiendaBloc),
          ],
        ),
      ),
    );
  }

  Widget _crearPasoWidget(){
    switch(_indexPaso){
      case 1:
        return SubirCedulaTiendaWidget();
      case 2:
        return CrearDireccionTiendaWidget();
      case 3:
        return ConfirmarMapaTiendaWidget();
      case 4:
        return CrearHorariosTiendaPage();
      case 5:
        return CrearDomiciliariosTiendaWidget();
      default:
        return Container();
    }
  }

  Widget _crearIndexPaso(Size size){
    return Positioned(
      child: Container(
        height: size.height * 0.11,
        width: size.width * 0.185,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.45),
          borderRadius: BorderRadius.circular(size.width * 0.1)
        ),
        child: Center(
          child: Text(
            '$_indexPaso paso',
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: size.width * 0.045
            ),
          )
        )
      ),
      left: size.width * 0.05,
      top: size.height * 0.04,
    );
  }

  Widget _crearBotonIzquierdoNavegacion(BuildContext context, Size size){
    return Positioned(
        bottom: size.height * 0.01,
        left: size.width * 0.04,
        child: FlatButton(
          color: (_indexPaso!=3)?Colors.white.withOpacity(0.4):null,
          child: Row(
            children: [     
                 
              Icon(
                ((_indexPaso > 1)?
                Icons.navigate_before
                :Icons.close),
                size: size.width * 0.065,
              ),
              SizedBox(width: size.width * 0.025),
              Text(
                (_indexPaso > 1)?'Anterior':'Cancelar',
                style: TextStyle(
                  fontSize: size.width * 0.045,
                ),
              ),
              
            ],
          ),
          onPressed: (){
            if(_indexPaso == 1){
              Navigator.pushReplacementNamed(context, CuentaPage.route);
            }
            else{
              _indexPaso--;
              setState(() {
              
            });
            }
            
          },
        ),
      );
  }

  Widget _crearBotonDerechoNavegacion(BuildContext context, Size size, TiendaBloc tiendaBloc){
    return Positioned(
      bottom: size.height * 0.01,
      right: size.width * 0.04,
      child: FlatButton(
        color: (_indexPaso!=3)?Colors.white.withOpacity(0.4):null,
        child: Row(
          children: [
            Text(
              (_indexPaso<5)?'Siguiente':'Finalizar',
              style: TextStyle(
                fontSize: size.width * 0.045,
              ),
            ),
            SizedBox(width: size.width * 0.025),
            Icon(
              Icons.navigate_next,
              size: size.width * 0.065,
            ),
          ],
        ),
        onPressed: (){
          if(_indexPaso==5)
            Navigator.pushReplacementNamed(context, PerfilPage.route);
          else
            _siguientePaso(tiendaBloc);
        },
      ),
    );
  }

  void _siguientePaso(TiendaBloc tiendaBloc){
    tiendaBloc.siguientePaso(_indexPaso);
    setState((){
      _indexPaso++; 
    });
    
  }
}