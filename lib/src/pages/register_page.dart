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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: _crearElementos(context, size, usuarioBloc),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
  Widget _crearElementos(BuildContext context, Size size, UsuarioBloc usuarioBloc){
    return Container(
      //padding: EdgeInsets.symmetric(horizontal:size.width * 0.15),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.1,
          ),
          _crearImgLogo(size),
          SizedBox(
            height: size.height * 0.075,
          ),
          Center(
            child: Text(
              'Registrate',
              style: TextStyle(
                fontSize: size.width * 0.067,
                color: Colors.black.withOpacity(0.75),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.015),
          _crearIngresoExterno(size),
          SizedBox(height: size.height * 0.005),
          Center(
            child: Text(
              'o',
              style: TextStyle(
                fontSize: size.width * 0.055,
                color: Colors.black.withOpacity(0.65),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          _crearLoginForm(context, size, usuarioBloc),
          SizedBox(
            height: size.height * 0.05,
          ),
           _crearBotonSubmmit(context, size, usuarioBloc),
          
          SizedBox(height: size.height*0.045),
          FlatButton(
            child: Text(
              '¿Ya tienes una cuenta? Ingresa',
              style: TextStyle(
                fontSize: size.width * 0.055,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            onPressed: (){
              Navigator.pushReplacementNamed(context, LoginPage.route);
            },
          ),
          
          SizedBox(
            height: size.height * 0.075,
          ),
        ],
      ),
    );
  }

  Widget _crearImgLogo(Size size){
    return Center(
      child: Image.asset(
        'assets/iconos/logo_porta_01.png',
        fit: BoxFit.fill,
        width: size.width * 0.65,
        height: size.height * 0.165,
        
      ),
    );
  }

  Widget _crearLoginForm(BuildContext context, Size size, UsuarioBloc usuarioBloc){

    final size = MediaQuery.of(context).size;
    //para poder hacer scroll a todo lo que haya dentro.
    return Center(
      child: Container(
        width: size.width * 0.65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.035),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.85),
              blurRadius: size.width * 0.062,
              spreadRadius: 2.0,
              offset: Offset(
                1.0, 
                1.0
              ),
              
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            _crearInputNombres(),
            SizedBox(
              height: size.height * 0.001,
              child: Container(
                height: size.height * 0.001,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            _crearInputEmail(),
            SizedBox(
              height: size.height * 0.001,
              child: Container(
                height: size.height * 0.001,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            _crearInputNumeroCelular(),
            SizedBox(
              height: size.height * 0.001,
              child: Container(
                height: size.height * 0.001,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            _crearInputPassword(),
            SizedBox(
              height: size.height * 0.001,
              child: Container(
                height: size.height * 0.001,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            _crearInputConfirmarPassword(),
            
          ],
        ),
      ),
    );
  }

  Widget _crearInputNombres(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20.0),
      child: TextField(
        
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.0,
              style: BorderStyle.none
              
            )
          ),
          icon: Icon(Icons.account_circle),
          hintText: 'Nombres'
          //labelText: 'Nombres y apellidos',
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
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.0,
              style: BorderStyle.none
              
            )
          ),
          icon: Icon(Icons.email),
          hintText: 'Email'
          //labelText: 'Correo electrónico',
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
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.0,
              style: BorderStyle.none
              
            )
          ),
          icon: Icon(Icons.phone_android),
          prefixText: '(+57) '
          //labelText: 'Número de celular'
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
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.0,
              style: BorderStyle.none
              
            )
          ),
          icon: Icon(Icons.lock_outline),
          hintText: 'Contraseña'
          //labelText: 'Contraseña',
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
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.0,
              style: BorderStyle.none
              
            )
          ),
          icon: Icon(Icons.lock),
          hintText: 'Confirmar contraseña'
          //labelText: 'Confirmar contraseña',
        ),
        onChanged: (String newValue){
          _confirmatedPasswordValue = newValue;
        },
      ),
    );
  }

  Widget _crearIngresoExterno(Size size){
    return Row(
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
    );
  }

  Widget _crearBotonSubmmit(BuildContext context, Size size, UsuarioBloc usuarioBloc){
    
    return Center(

      child: Container(
        width: size.width * 0.3,
        child: FlatButton(   
          padding: EdgeInsets.symmetric(vertical:size.height * 0.013),
          color: Colors.grey.withOpacity(0.55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width * 0.075)
          ),
          child: Text(
            'Registrarse', 
            style: TextStyle(
              fontSize: size.width * 0.045,
              color: Colors.black.withOpacity(0.65)
            )
          ),
          onPressed: (){
            _registrar(context, usuarioBloc);
          },
        ),
      ),
    );
  }

  void _registrar(BuildContext context, UsuarioBloc usuarioBloc)async{
    await usuarioBloc.register(_nombreValue, _emailVaue, _passwordValue);
    Navigator.pushReplacementNamed(context, HomePage.route);
  }
}