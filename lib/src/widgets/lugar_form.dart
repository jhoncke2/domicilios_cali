import 'package:domicilios_cali/src/bloc/lugares_bloc.dart';
import 'package:domicilios_cali/src/bloc/provider.dart';
import 'package:domicilios_cali/src/bloc/usuario_bloc.dart';
import 'package:domicilios_cali/src/models/lugares_model.dart';
import 'package:flutter/material.dart';
import 'package:domicilios_cali/src/utils/data_prueba/componentes_lugares.dart' as componentesLugares;

class LugarForm extends StatefulWidget {
  LugarModel lugar;
  final tiposForms = ['edit', 'create'];
  String tipoForm;
  LugarForm(
    this.lugar,
    {
      this.tipoForm='edit',
    }
  ){
    if(this.lugar == null)
      this.lugar = LugarModel();
  }
  @override
  _LugarFormState createState() => _LugarFormState();
}

class _LugarFormState extends State<LugarForm> {
  String _valorNombre;
  String _valorDireccion;
  String _dropdownDepartamentoValue;
  String _dropdownCiudadValue;
  String _dropdownTipoDeViaValue;
  String _valorViaPrincipal;
  String _valorViaSecundaria;
  String _valorNumeroDomiciliario;
  
  List<DropdownMenuItem> _itemsCiudades = [];

  @override
  void initState() {
    // TODO: implement initState
    if(widget.lugar == null)
      widget.lugar = LugarModel();
    super.initState();  
    if(widget.tipoForm == widget.tiposForms[0]){
      
      _itemsCiudades = _generarNombresCiudadesPorDepartamento(_dropdownDepartamentoValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioBloc = Provider.usuarioBloc(context);
    final lugaresBloc = Provider.lugaresBloc(context);
    Size size = MediaQuery.of(context).size;
    return  SingleChildScrollView(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text(
          '${widget.tipoForm == 'edit'? "Editar":"Crear"} lugar',
          style: TextStyle(
            fontSize: size.width * 0.058,
          ),
        ),
        content: Container(
          height: size.height * 0.5,
          width: size.width * 0.4,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre de lugar',
                ),
                initialValue: widget.lugar.direccion,
                onChanged: (value){
                  if(value != 'Tu ubicación')
                    _valorNombre = value;
                  
                },
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                'dirección',
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              _crearFormDirecciones(context, size, lugaresBloc),

            ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text('Cancelar'),
            onPressed: (){
              Navigator.of(context).pop();
              setState((){
              });
            }
            
          ),
          FlatButton(
            child: Text('Ok'),
            onPressed: (){
              _guardarDatos(usuarioBloc, lugaresBloc);
              Navigator.of(context).pop();
              
              setState((){

              });
            },
          )
        ],
      ),
    );
  }

  Widget _crearFormDirecciones(BuildContext contextParam, Size size, LugaresBloc lugaresBloc){
    String viaPrincipal;
    String viaSecundaria;
    String numeroDomiciliario;
    
    return Form(
      child: Column(
        children: [ 
          TextFormField(
            initialValue: widget.lugar.direccion,
            decoration: InputDecoration(
              labelText: 'La dirección como te la sabes',
            ),
            onChanged: (newValue){
              _valorDireccion = newValue;
            },
          ),
          SizedBox(
            height: size.height * 0.045,
          ),
          (_dropdownDepartamentoValue != null)?Text(
            'departamento',
            style: TextStyle(
              fontSize: size.width * 0.038,
              color: Colors.black45,
            ),
          )
          :SizedBox(),
          DropdownButton(
            hint: Text('departamento'),
            value: _dropdownDepartamentoValue,
            items: componentesLugares.departamentos.map((departamento){
              return DropdownMenuItem<String>(
                value: departamento['nombre'],
                child: Text(departamento['nombre']),
              );
            }).toList(),
            onChanged: (String value){
              _dropdownDepartamentoValue = value;
              _dropdownCiudadValue = null;
              _itemsCiudades = _generarNombresCiudadesPorDepartamento(value);
              setState(() {
              });
            },
          ),
          SizedBox(
            height: size.height * 0.045,
          ),
          (_dropdownCiudadValue != null)?Text(
            'ciudad',
            style: TextStyle(
              fontSize: size.width * 0.038,
              color: Colors.black45,
            ),
          )
          :SizedBox(),
          DropdownButton(
            hint: Text('ciudad'),
            value: _dropdownCiudadValue,
            items: _itemsCiudades,
            onChanged: (value){
              _dropdownCiudadValue = value;
              setState(() {
                
              });
            },
          ),
          SizedBox(
            height: size.height * 0.045,
          ),
          (_dropdownTipoDeViaValue != null)?Text(
            'tipo de vía',
            style: TextStyle(
              fontSize: size.width * 0.038,
              color: Colors.black45,
            ),
          )
          :SizedBox(),
          DropdownButton(
            hint: Text('tipo de vía'),
            value: _dropdownTipoDeViaValue,
            items: componentesLugares.tipos_vias.map((tipoVia){
              return DropdownMenuItem(
                value: tipoVia,
                child: Text(tipoVia),
              );
            }).toList(),
            onChanged: (value){
              _dropdownTipoDeViaValue = value;
              setState(() {
                
              });
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Column(
            children: [
              TextFormField(
                initialValue: viaPrincipal,
                decoration: InputDecoration(
                  labelText: 'Via principal',
                ),
                onChanged: (newValue){
                  _valorViaPrincipal = newValue;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                '#',
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  color: Colors.black45
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              TextFormField(
                initialValue: viaSecundaria,
                decoration: InputDecoration(
                  labelText: 'Via secundaria',
                ),
                onChanged: (newValue){
                  _valorViaSecundaria = newValue;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                '-',
                style: TextStyle(
                  fontSize: size.width * 0.062,
                  color: Colors.black45
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFormField(
                initialValue: numeroDomiciliario,
                decoration: InputDecoration(
                  labelText: 'Num',
                ),
                onChanged: (newValue){
                  _valorNumeroDomiciliario = newValue;
                },
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _generarNombresCiudadesPorDepartamento(String nombreDepartamento){
    dynamic departamento = componentesLugares.departamentos.singleWhere(
      (element) => element['nombre'] == nombreDepartamento
    );
    List<DropdownMenuItem<String>> ciudadesItems = [];

    departamento['ciudades'].forEach((ciudad){
      ciudadesItems.add(
        DropdownMenuItem(
          value: ciudad,
          child: Text(
            ciudad,
          ),
        )
      );
    });

    return ciudadesItems;
  }

  void _guardarDatos(UsuarioBloc usuarioBloc, LugaresBloc lugaresBloc)async{
    widget.lugar.direccion = _valorDireccion?? widget.lugar.direccion;
      
  }
}