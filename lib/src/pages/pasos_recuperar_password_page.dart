import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/widgets/pasos_recuperar_password/introducir_codigo_recuperacion_widget.dart';
import 'package:domicilios_cali/src/widgets/pasos_recuperar_password/introducir_celular_recuperacion_widget.dart';
import 'package:domicilios_cali/src/widgets/pasos_recuperar_password/nuevo_password_recuperacion_widget.dart';
import 'package:flutter/material.dart';
class PasosRecuperarPasswordPage extends StatefulWidget{
  static final route = 'pasos_recuperar_password';
  @override
  _PasosRecuperarPasswordPageState createState() => _PasosRecuperarPasswordPageState();
}

class _PasosRecuperarPasswordPageState extends State<PasosRecuperarPasswordPage> {
  int _indexPaso = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UsuarioBloc usuarioBloc = Provider.usuarioBloc(context);
    return Scaffold(
      body: 
      StreamBuilder(
        stream: usuarioBloc.recuperarPasswordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          print('**********************');
          print('en el steamBuilder');
          
          if(snapshot.hasData){
            print('tiene data');
            if(snapshot.data['paso']=='email')
              return IntroducirCodigoRecuperacionWidget();
            else if(snapshot.data['paso']=='code')
              return NuevoPasswordRecuperacionWidget();
              
            return IntroducirCelularRecuperacionWidget();
          }
          else{
            print('no tiene data');
            return IntroducirCelularRecuperacionWidget();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.withOpacity(0.8),
        child: Icon(
          Icons.arrow_back_ios,
          size: size.width * 0.065,
          color: Colors.black.withOpacity(0.5),
        ),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
    );
  }
}