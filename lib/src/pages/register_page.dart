import 'dart:ui';
import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static final String route = 'register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _nombreValue = '';
  String _emailVaue = '';
  String _numeroCelularValue = '';
  String _passwordValue = '';
  String _confirmatedPasswordValue = '';

  @override
  Widget build(BuildContext context) {
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    LugaresBloc lugaresBloc = Provider.lugaresBloc(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearLoginForm(context, usuarioBloc, lugaresBloc),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size;
    final fondoAzul = Container(
      height: size.height * 0.55,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Theme.of(context).primaryColor,
            Theme.of(context).secondaryHeaderColor,
          ]
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        fondoAzul,
        _crearCirculoLogo(context, size),
      ],
    );
  }

  Widget _crearCirculoLogo(BuildContext context, Size size){
    return Positioned(
      top: size.height * 0.05,
      left: size.width * 0.31,
      child: Container(
        width: size.width * 0.4,
        height: size.height * 0.23,
        decoration: BoxDecoration(
          color: Colors.white70,
          //color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(180.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              blurRadius: 2.0,
              spreadRadius: 1.5,
              offset: Offset(
                2.0,
                2.0
              )
            )
          ],
        ),
        child: Center(
          child: Text(
            'Logo',
            style: TextStyle(
              fontSize: 30.0,
              color: Color.fromRGBO(80, 80, 80, 1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearLoginForm(BuildContext context, UsuarioBloc usuarioBloc, LugaresBloc lugaresBloc){

    final size = MediaQuery.of(context).size;
    //para poder hacer scroll a todo lo que haya dentro.
    return SingleChildScrollView(
      
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height * 0.18,
            ),
          ),
          /**
           * El SingleCHildScrollView: Para que cuando salga el teclado no salga un 
           * error de overflow verticalmente.
           */
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.10),
            child: Container(
              width: size.width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 65.0),
              padding: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    spreadRadius: 3.0,
                    offset: Offset(
                      5.0, 
                      5.0
                    ),
                    
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height * 0.008,),
                  Text('Registrarse', style: TextStyle(fontSize: 21.0)),
                  SizedBox(height: 50.0,),
                  _crearInputNombres(),
                  SizedBox(height: 50.0,),
                  _crearInputEmail(),
                  SizedBox(height: 50.0,),
                  _crearInputNumeroCelular(),
                  SizedBox(height: 50.0,),
                  _crearInputPassword(),
                  SizedBox(height: 30.0,),
                  _crearInputConfirmarPassword(),
                  SizedBox(height: 30.0,),
                  _crearBotonSubmmit(context, usuarioBloc, lugaresBloc),
                  SizedBox(height: 45.0,),
                  _crearIngresoExterno(size),
                  SizedBox(height: 10.0,),
                  FlatButton(
                    child: Text(
                      '¿Ya tienes cuenta?',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color.fromRGBO(60, 120, 250, 1),
                      ),
                    ),
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, LoginPage.route);
                    },
                  ),
                  SizedBox(height: 10.0,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearInputNombres(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20.0),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.account_circle),
          labelText: 'Nombres y apellidos',
        ),
        onChanged: (String newValue){
          _nombreValue = newValue;
        },
      ),
    );
  }

  Widget _crearInputEmail(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email),
          labelText: 'Correo electrónico',
        ),
        onChanged: (String newValue){
          _emailVaue = newValue;
        },
      ),
    );
  }

  Widget _crearInputNumeroCelular(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.phone_android),
          labelText: 'Número de celular'
        ),
        onChanged: (String newValue){
          _numeroCelularValue = newValue;
        },
      ),
    );
  }

  Widget _crearInputPassword(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline),
          labelText: 'Contraseña',
        ),
        onChanged: (String newValue){
          _passwordValue = newValue;
        },
      ),
    );
  }

  Widget _crearInputConfirmarPassword(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline),
          labelText: 'Confirmar contraseña',
        ),
        onChanged: (String newValue){
          _confirmatedPasswordValue = newValue;
        },
      ),
    );
  }

  Widget _crearIngresoExterno(Size size){
    return Column(
      children: <Widget>[
        Text(
          'Ingresar con',
          style: TextStyle(
            fontSize: size.width * 0.04
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInImage(
              width: size.width * 0.08,
              height: size.height * 0.1,
              image: NetworkImage('https://cdn.clipart.email/ddbcf21543b89f8f4707d98c1056df7f_google-logo-google-adwords-google-panda-chrome-transparent-_800-813.jpeg'),
              placeholder: AssetImage('assets/placeholder_images/google_logo.jpeg'),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            FadeInImage(
              width: size.width * 0.08,
              height: size.height * 0.1,
              image: NetworkImage('https://www.stickpng.com/assets/images/58e91965eb97430e819064f5.png'),
              placeholder: AssetImage('assets/placeholder_images/facebook_logo.png'),
            ),
          ]
        )
      ],
    );
  }

  Widget _crearBotonSubmmit(BuildContext context, UsuarioBloc usuarioBloc, LugaresBloc lugaresBloc){
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
        child: Text('Registrarse', style: TextStyle(fontSize: 16.0),),
      ),
      onPressed: (){
        if(_passwordValue == _confirmatedPasswordValue){
          //impolementar el create de lugar tu posición
          _registrar(context, usuarioBloc);
        }
      },
    );
  }

  void _registrar(BuildContext context, UsuarioBloc usuarioBloc)async{
    await usuarioBloc.register(_nombreValue, _emailVaue, _passwordValue);
    Navigator.pushReplacementNamed(context, HomePage.route);
  }
}