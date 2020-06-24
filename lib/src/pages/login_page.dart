import 'dart:ui';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/pages/home_page.dart';
import 'package:domicilios_cali/src/pages/pasos_recuperar_password_page.dart';
import 'package:domicilios_cali/src/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//clases locales

class LoginPage extends StatefulWidget {
  static final String route = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _emailValue = 'email4@gmail.com';
  String _passwordValue = '123456';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);

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
              'Ingreso',
              style: TextStyle(
                fontSize: size.width * 0.07,
                color: Colors.black.withOpacity(0.75),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          _crearLoginForm(context, size, usuarioBloc),
          SizedBox(
            height: size.height * 0.05,
          ),
           _crearBotonSubmmit(context, size, usuarioBloc),
          SizedBox(height: size.height * 0.03),
          _crearIngresoExterno(size),
          SizedBox(height: size.height*0.001),
          FlatButton(
            child: Text(
              '¿Olvidó contraseña?',
              style: TextStyle(
                fontSize: size.width * 0.049,
                //color: Color.fromRGBO(60, 120, 250, 1),
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            onPressed: (){
              Navigator.pushNamed(context, PasosRecuperarPasswordPage.route);
            },
          ),
          SizedBox(height: size.height * 0.01),
          FlatButton(
            child: Text(
              'Registrate',
              style: TextStyle(
                fontSize: size.width * 0.06,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            onPressed: (){
              Navigator.pushReplacementNamed(context, RegisterPage.route);
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
    //para poder hacer scroll a todo lo que haya dentro.
    return Center(
      child: Container(
        width: size.width * 0.72,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          //color: Colors.blueAccent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(size.width * 0.025),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.85),
              blurRadius: size.width * 0.06,
              offset: Offset(
                1.0,
                1.0
              )
            )
          ]
        ),
        child: Column(
          children: <Widget>[
            /**
             * El SingleCHildScrollView: Para que cuando salga el teclado no salga un 
             * error de overflow verticalmente.
             */
            //SizedBox(height: size.height * 0.01),
            _crearInputEmail(),
            //SizedBox(height: size.height * 0.01),
            SizedBox(
              height: size.height * 0.001,
              child: Container(
                height: size.height * 0.001,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            _crearInputPassword(),
            
          ],
        ),
      ),
    );
  }

  Widget _crearInputEmail(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20.0),
      child: TextFormField(
        initialValue: _emailValue,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.0,
              style: BorderStyle.none
              
            )
          ),
          icon: Icon(Icons.account_circle),
          //labelText: 'email',

        ),
        onChanged: (String newValue){
          _emailValue = newValue;
        },
      ),
    );
  }

  Widget _crearInputPassword(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: _passwordValue,
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
          //labelText: 'Contraseña',
        ),
        onChanged: (String newValue){
          _passwordValue = newValue;
        },
      ),
    );
  }

  Widget _crearIngresoExterno(Size size){
    return Column(
      children: <Widget>[
        Text(
          'O ingresa con',
          style: TextStyle(
            fontSize: size.width * 0.05,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.normal,
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

  Widget _crearBotonSubmmit(BuildContext context, Size size, UsuarioBloc usuarioBloc){
    return Center(

      child: Container(
        width: size.width * 0.25,
        child: FlatButton(   
          padding: EdgeInsets.symmetric(vertical:size.height * 0.013),
          color: Colors.grey.withOpacity(0.55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width * 0.075)
          ),
          child: Text(
            'Ingresa', 
            style: TextStyle(
              fontSize: size.width * 0.045,
              color: Colors.black.withOpacity(0.65)
            )
          ),
          onPressed: (){
            _clickSubmmit(usuarioBloc);
          },
        ),
      ),
    );
  }

  void _clickSubmmit(UsuarioBloc usuarioBloc)async{
    Map<String, dynamic> respuesta = await usuarioBloc.login(_emailValue, _passwordValue);
    Navigator.pushReplacementNamed(context, HomePage.route, arguments: respuesta['user']);
  }
}