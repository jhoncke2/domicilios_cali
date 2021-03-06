import 'package:domicilios_cali/src/bloc/confirmation_bloc.dart';
import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:domicilios_cali/src/pages/direccion_create_page.dart';
import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:flutter/material.dart';
class PasosConfirmacionCelularPage extends StatefulWidget {
  static final route = 'pasosConfirmacionCelular';

  @override
  _PasosConfirmacionCelularPageState createState() => _PasosConfirmacionCelularPageState();
}

class _PasosConfirmacionCelularPageState extends State<PasosConfirmacionCelularPage> {
  String _codigoValue = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final confirmationBloc = Provider.confirmationBloc(context);
    final usuarioBloc = Provider.usuarioBloc(context);
    final lugaresBloc = Provider.lugaresBloc(context);
    if(confirmationBloc.newPhoneConfirmation == null)
      confirmationBloc.newPhoneConfirmation = usuarioBloc.usuario.phone;
    print('phone usuario: ${usuarioBloc.usuario.phone}');
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.08,
            ),
            _crearTitulo(size),
            _crearElementosContenido(size, confirmationBloc, usuarioBloc, lugaresBloc),
          ],
        ),
      ),
    );
  }

  Widget _crearTitulo(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.withOpacity(0.9),
          ),
          iconSize: size.width * 0.065,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        Text(
          'Confirmar celular',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
            fontSize: size.width * 0.062
          ),
        ),
        SizedBox(
          width: size.width * 0.1,
        )
      ],
    );
  }

  Widget _crearElementosContenido(Size size, ConfirmationBloc confirmationBloc, UsuarioBloc usuarioBloc, LugaresBloc lugaresBloc){
    return Expanded(   
      child: Container(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Introdue el código que te llegó al celular',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black.withOpacity(0.8),
                fontSize: size.width * 0.057
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            _crearInputIntroducirCodigo(size),
            SizedBox(
              height: size.height * 0.035,
            ),
            _crearBotonSubmit(size, confirmationBloc, usuarioBloc, lugaresBloc),
            SizedBox(
              height: size.height * 0.11,
            ),
            Text(
              'Si no te ha llegado el código escribe aquí',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black.withOpacity(0.8),
                fontSize: size.width * 0.057
              ),
            ),
            SizedBox(
              height: size.height * 0.042,
            ),
            _crearBotonReenviarCodigo(size, usuarioBloc, confirmationBloc),
            SizedBox(
              height: size.height * 0.05,
            )
          ],
        ),
      )
    );
  }

  Widget _crearInputIntroducirCodigo(Size size){
    return Container(
      width: size.width * 0.7,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Código',
          icon: Icon(
            Icons.confirmation_number,
          ),
        ),
        onChanged: (String newValue){
          _codigoValue = newValue;
        },
      ),
    );
  }

  Widget _crearBotonSubmit(Size size, ConfirmationBloc confirmationBloc, UsuarioBloc usuarioBloc, LugaresBloc lugaresBloc){
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.075, vertical: size.height * 0.008),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.05)
      ),
      //color: Colors.grey.withOpacity(0.5),
      color: Theme.of(context).primaryColor.withOpacity(0.75),
      child: Text(
        'Enviar',
        style: TextStyle(
          fontSize: size.width * 0.048,
          color: Colors.white.withOpacity(0.95)
        ),
      ),
      onPressed: ()=> _verificarCodigo(confirmationBloc, usuarioBloc, lugaresBloc),
    );
  }

  void _verificarCodigo(ConfirmationBloc confirmationBloc, UsuarioBloc usuarioBloc, LugaresBloc lugaresBloc)async{
    Map<String, dynamic> resultado = await confirmationBloc.enviarCodigoConfirmarPhone(usuarioBloc.token, usuarioBloc.usuario.id, _codigoValue);
    if(resultado['status'] == 'ok'){
      Navigator.of(context).pushReplacementNamed(DireccionCreatePage.route);     
    }
      
  }

  Widget _crearBotonReenviarCodigo(Size size, UsuarioBloc usuarioBloc, ConfirmationBloc confirmationBloc){
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.067, vertical: size.height * 0.0085),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.05)
      ),
      //color: Colors.grey.withOpacity(0.5),
      color: Theme.of(context).primaryColor.withOpacity(0.75),
      child: Text(
        'Reenviar código',
        style: TextStyle(
          fontSize: size.width * 0.048,
          color: Colors.white.withOpacity(0.95)
        ),
      ),
      onPressed: (){
        confirmationBloc.resetCode(usuarioBloc.token, 'phone', usuarioBloc.usuario.id.toString());
      },
    );
  }
}