import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:flutter/material.dart';
class IntroducirCelularRecuperacionWidget extends StatefulWidget {

  @override
  _IntroducirCelularRecuperacionWidgetState createState() => _IntroducirCelularRecuperacionWidgetState();
}

class _IntroducirCelularRecuperacionWidgetState extends State<IntroducirCelularRecuperacionWidget> {

  String _emailValue = '';
  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[ 
          Text(
            'Introduce el correo de tu cuenta para recuperar la contraseña',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * 0.054,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          _crearInputEmail(size),
          SizedBox(
            height: size.height * 0.065,
          ),
          _crearBotonEnviar(size, usuarioBloc),
        ],
      ),
    );
  }

  Widget _crearInputEmail(Size size){
    return Container(
      width: size.width * 0.65,
      child: TextFormField(
        initialValue: _emailValue,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email),
          labelText: 'Correo'
        ),
        onChanged: (String newValue){
          _emailValue = newValue;
        },
      ),
    );
  }

  Widget _crearBotonEnviar(Size size, UsuarioBloc usuarioBloc){
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.085, vertical: size.height * 0.0075),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      color: Colors.grey.withOpacity(0.75),
      child: Text(
        'Enviar',
        style: TextStyle(
          fontSize: size.width * 0.065,
          color: Colors.black.withOpacity(0.65)
        ),
      ),
      onPressed: (){
        usuarioBloc.enviarCorreoRecuperarPassword(_emailValue);
      },
    );
  }
}