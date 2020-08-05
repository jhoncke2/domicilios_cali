import 'package:flutter/material.dart';
class ConfirmarCodigoDomiciliarioPage extends StatefulWidget {
  static final route = 'confirmar_codigo_domiciliario';
  @override
  _ConfirmarCodigoDomiciliarioPageState createState() => _ConfirmarCodigoDomiciliarioPageState();
}

class _ConfirmarCodigoDomiciliarioPageState extends State<ConfirmarCodigoDomiciliarioPage> {
  BuildContext context;
  Size size;

  String _codigoValue;
  @override
  Widget build(BuildContext appContext) {
    context = appContext;
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: _crearElementos(),
    );
  }

  Widget _crearElementos(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Para completar la inscripción del domiciliario, ingresa el código que ha sido enviado al celular de él.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: size.height * 0.035,
            ),
            _crearInputIntroducirCodigo(),
            SizedBox(
              height: size.height * 0.075,
            ),
            _crearBotonSubmit(),
            SizedBox(
              height: size.height * 0.03,
            ),
            _crearBotonReenviarCodigo(),
          ],
        ),
      ),
    );
  }

  Widget _crearInputIntroducirCodigo(){
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

  Widget _crearBotonSubmit(){
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.075, vertical: size.height * 0.008),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.05)
      ),
      //color: Colors.grey.withOpacity(0.5),
      color: Theme.of(context).primaryColor,
      child: Text(
        'Enviar',
        style: TextStyle(
          fontSize: size.width * 0.048,
          color: Colors.white.withOpacity(0.95)
        ),
      ),
      onPressed: (){
        
      },
    );
  }

  Widget _crearBotonReenviarCodigo(){
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.067, vertical: size.height * 0.0085),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.05)
      ),
      //color: Colors.grey.withOpacity(0.5),
      color: Theme.of(context).primaryColor,
      child: Text(
        'Reenviar código',
        style: TextStyle(
          fontSize: size.width * 0.048,
          color: Colors.white.withOpacity(0.95)
        ),
      ),
      onPressed: (){
        //confirmationBloc.resetCode(usuarioBloc.token, 'phone', usuarioBloc.usuario.id.toString());
      },
    );
  }
}