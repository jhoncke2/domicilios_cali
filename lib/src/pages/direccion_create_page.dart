import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:flutter/material.dart';

import 'package:domicilios_cali/src/utils/google_services.dart' as googleServices;
import 'package:domicilios_cali/src/utils/data_prueba/componentes_lugares.dart' as componentesLugares;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DireccionCreatePage extends StatefulWidget {
  static final route = 'direccion_create';

  @override
  _DireccionCreatePageState createState() => _DireccionCreatePageState();
}

class _DireccionCreatePageState extends State<DireccionCreatePage> {
  LugarModel lugar = LugarModel();

  String _dropdownDepartamentoValue;
  String _ciudadValue;
  String _viaPrincipalValue;
  String _numeroViaPrincipalValue;
  String _numeroViaSecundariaValue;
  String _numeroCasaValue;
  String _observacionesValue;
  
  List<DropdownMenuItem> _itemsCiudades = [];

  @override
  void initState() {
    /*
    _valorDireccion = 'Av. calle 40 # 13 - 73';
    _dropdownDepartamentoValue = 'Bogotá';
    _dropdownCiudadValue = 'Bogotá';
    _dropdownTipoDeViaValue = 'Avenida calle';
    _valorViaPrincipal = '40';
    _valorViaSecundaria = '13';
    _valorNumeroDomiciliario = '73';
    */
    // TODO: implement initState
    super.initState();  
  }

  @override
  Widget build(BuildContext context) {
    final usuarioBloc = Provider.usuarioBloc(context);
    final lugaresBloc = Provider.lugaresBloc(context);
    String token = usuarioBloc.token;
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
          height: size.height,
          width: size.width,
          child: ListView(        
            children: [
              SizedBox(
                height: size.height * 0.045,
              ),
              _crearTitulo(size),
              SizedBox(
                height: size.height * 0.08,
              ),
              _crearInputCiudad(size),
              SizedBox(
                height: size.height * 0.01,
              ),
              _crearInputsViaPrincipal(size),
              SizedBox(
                height: size.height * 0.01,
              ),
              _crearInputsViaSecundariaYCasa(size),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'Observaciones:',
                style: TextStyle(
                  fontSize: size.width * 0.047,
                  color: Colors.black.withOpacity(0.8)
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ), 
              _crearInputComponenteDireccion(size, 'observaciones'),
            ]
          ),
        ),
      ),
      floatingActionButton: _crearBotonCrear(size, lugaresBloc, token),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _crearTitulo(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: size.width * 0.05,
            color: Colors.black.withOpacity(0.6),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        Text(
          'Crear dirección',
          style: TextStyle(
            fontSize: size.width * 0.067,
            color: Colors.black.withOpacity(0.65)
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        )
      ],
    );
  }

  Widget _crearInputCiudad(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Ciudad',
          style: TextStyle(
            fontSize: size.width * 0.047,
            color: Colors.black.withOpacity(0.8)
          ),
        ),
        SizedBox(
          width: size.width * 0.01,
        ),
        _crearPopupMenuItem(size, 'ciudad', componentesLugares.ciudades),
      ],
    );
  }

  Widget _crearInputsViaPrincipal(Size size){
    return Row(
      children: <Widget>[
        _crearPopupMenuItem(size, 'via_principal', componentesLugares.tipos_vias),
        SizedBox(
          width: size.width * 0.05,
        ),
        _crearInputComponenteDireccion(size, 'via_principal'),
      ],
    );
  }

  Widget _crearInputsViaSecundariaYCasa(Size size){
    return Row(
      children: <Widget>[
        SizedBox(
          width: size.width * 0.05,
        ),
        Text(
          '#',
          style: TextStyle(
            fontSize: size.width * 0.055,
            color: Colors.black.withOpacity(0.8)
          ),
        ),
        SizedBox(
          width: size.width * 0.025,
        ),
        _crearInputComponenteDireccion(size, 'via_secundaria'),
        SizedBox(
          width: size.width * 0.02,
        ),
        Text(
          '-',
          style: TextStyle(
            fontSize: size.width * 0.06,
            color: Colors.black.withOpacity(0.8)
          ),
        ),
        SizedBox(
          width: size.width * 0.02,
        ),
        _crearInputComponenteDireccion(size, 'casa'),
      ],
    );
  }

  /**
   * params:
   *  * tipoPopUp:
   *    * ciudad
   *    * via_principal 
   */
  Widget _crearPopupMenuItem(Size size, String tipoPopUp, List<String> elementos){
    String value = (tipoPopUp == 'ciudad')? _ciudadValue : _viaPrincipalValue;
    List<PopupMenuItem<String>> popupItems = elementos.map((String elementoActual){
      return PopupMenuItem(
          value: elementoActual,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width * 0.095,
                height: size.height * 0.03,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: ((value != elementoActual)? 
                    Border.all(
                      width: 1,
                      color: Colors.black.withOpacity(0.9)
                    )
                    :null
                    ),
                  color: (value == elementoActual)? Color.fromRGBO(192, 214, 81, 1) : Colors.white,
                ),
              ),
              SizedBox(
                width: size.width * 0.025,
              ),
              Text(
                elementoActual, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.9),
                  fontSize: size.width * 0.045
                ),
              ),
              
            ],
          ),
        );
    }).toList();
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.05)
      ),
      offset: Offset(
        size.width * 0.1,
        size.height * 0.1,
      ),
      //initialValue: 'Bogotá',
      onSelected: (String newValue){
        if(tipoPopUp=='ciudad')
          _ciudadValue = newValue;
        else
          _viaPrincipalValue = newValue;
        setState(() {
          
        });
      },
      child: Container(
        width: (tipoPopUp == 'ciudad')? size.width * 0.58 : size.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.04),
          color: Colors.grey.withOpacity(0.2)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.02
            ),
            ((value != null)?
            Text(
              value,
              style: TextStyle(
                fontSize: size.width * 0.045,
                color: Colors.black.withOpacity(0.8)
              ),
            )
            :(tipoPopUp == 'via_principal')?
              Text('via principal')
            :Container()
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey.withOpacity(0.65),
              size: size.width * 0.085,
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context){
        return popupItems;
      },
    );
  }

  Widget _crearInputComponenteDireccion(Size size, String tipoComponente){
    return Container(
      padding: EdgeInsets.only(
        top:size.height * 0.002
      ),
      width: size.width * ((tipoComponente == 'observaciones')? 0.7: 0.25),
      height: size.height * 0.05,

      child: TextField(       
        style: TextStyle(
          color: Colors.black
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: size.height * 0.0025,
            horizontal: size.width * 0.025
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.25),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.001,
              color: Colors.green.withOpacity(0.9),
            ),
             borderRadius: BorderRadius.circular(
              size.width * 0.1
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.withOpacity(0.85),
              width: size.width * 0.0001
            ),
            borderRadius: BorderRadius.circular(
              size.width * 0.1
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.withOpacity(0.85),
              width: size.width * 0.0001
            ),
            borderRadius: BorderRadius.circular(
              size.width * 0.1
            ),
          )
        ),
        onChanged: (String newValue){
          switch(tipoComponente){
            case 'via_principal':
              _numeroViaPrincipalValue = newValue;
            break;
            case 'via_secundaria':
              _numeroViaSecundariaValue = newValue;
            break;
            case 'casa':
              _numeroCasaValue = newValue;
            break;
            case 'observaciones':
              _observacionesValue = newValue;
            break;
          }
          setState(() {
            
          });
        },
      ),
    );
  }

  List<Map<String, dynamic>> _crearComponentes(){
    List<Map<String, dynamic>> componentes = [];
    //Lo quité. Estar pendiente.
    //widget.lugar.elegido = false;
    var componente;
    for(int i = 0; i < 6; i++){
      switch(i){
        case 0:
          componente = {
            'nombre':'pais',
            'valor':'Colombia'
          };
          break;
        case 1:
          componente = {
            'nombre':'ciudad',
            'valor':_ciudadValue
          };
          break;
        case 2:
          componente = {
            'nombre':'via_principal',
            'valor':  '$_viaPrincipalValue $_numeroViaPrincipalValue'
          };
          break;
        case 3:
          componente = {
            'nombre':'via_secundaria',
            'valor':_numeroViaSecundariaValue
          };
          break;
        case 4:
          componente = {
            'nombre':'numero_casa',
            'valor':_numeroCasaValue
          };
          break;
      }
      if(componente['valor'] == null)
        return null;
      componentes.add(componente);
    }
    return componentes;
  }

  Widget _crearBotonCrear(Size size, LugaresBloc lugaresBloc, String token){
    return FlatButton(
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.045,
        vertical: size.height * 0.002
      ),
      color: Colors.grey.withOpacity(0.62),
      child: Text(
        'Continuar',
        style: TextStyle(
          fontSize: size.width * 0.05,
          color: Colors.black.withOpacity(0.8)
        ),
      ),
      onPressed: (){
        _guardarDatos(lugaresBloc, token);
      },
    );
  }

  void _guardarDatos(LugaresBloc lugaresBloc, String token)async{
    //googleServices.getUbicacionConComponentesDireccion(componentes)
    List<Map<String, dynamic>> componentesLugar = _crearComponentes();
    if(componentesLugar == null)
      return;
    LatLng posicion = await googleServices.getUbicacionConComponentesDireccion(componentesLugar);
    String direccion = await googleServices.getDireccionByLatLng(posicion);
    lugar.latitud = posicion.latitude;
    lugar.longitud = posicion.longitude;
    lugar.direccion = direccion;
    lugar.ciudad = _ciudadValue;
    lugar.observaciones = _observacionesValue;
    lugar.tipo = 'cliente';
    Map<String, dynamic> response = await lugaresBloc.crearLugar(lugar, token);
    if(response['status'] == 'ok')
      Navigator.pop(context);
  }
}