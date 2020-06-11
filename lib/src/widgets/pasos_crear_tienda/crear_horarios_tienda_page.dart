import 'package:domicilios_cali/src/models/horarios_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CrearHorariosTiendaPage extends StatefulWidget {

  @override
  _CrearHorariosTiendaPageState createState() => _CrearHorariosTiendaPageState();
}

class _CrearHorariosTiendaPageState extends State<CrearHorariosTiendaPage> {
  final _dias = ['lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábados', 'domingos', 'festivos'];
  List<String> _diasSeleccionados = [];
  List<HorarioModel> _horarios = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _agregarHorario();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> elementos = [];
    _crearElementosListView(context, size, elementos);
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
      child: Center(
        child: ListView(
          children: elementos
        ),
      ),
    );
  }

  void _agregarHorario(){
    HorarioModel horario = new HorarioModel(
      dias: [],
      horaInicial: TimeOfDay(
        hour: 0,
        minute: 0,
      ),
      horaFinal: TimeOfDay(
        hour: 23,
        minute: 59
      )
    );
    _horarios.add(horario);
    setState(() {
    });
  }

  void _crearElementosListView(BuildContext context, Size size, List<Widget> elementos){
    elementos.add(SizedBox(height: size.height * 0.03));
    elementos.add(
      Center(
        child: Text(
          'Horarios de domicilios',
          style: TextStyle(
            color: Colors.black.withOpacity(0.65),
            fontSize: size.width * 0.084
          ),
        ),
      ),
    );
    elementos.add(SizedBox(height: size.height * 0.03));

    _horarios.forEach((horario) {
      elementos.add(
        SizedBox(height: size.height * 0.04),
      );
      elementos.add(
        Container(
          width: double.infinity,
          
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(size.width * 0.04),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      blurRadius: size.width * 0.01,
                      spreadRadius: size.width * 0.01,
                      offset: Offset(
                        1.0,
                        1.0
                      ),
                    )
                  ]
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    _crearElementosTimePickers(size, horario),
                    _crearElementosDiasDeHorario(size, horario, elementos),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.12,
                child: ((_horarios.length > 0)?
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.redAccent.withOpacity(0.9),
                  ),
                  onPressed: (){
                    if(_horarios.length > 0)
                      _eliminarModuloHorario(horario);
                  },
                )
                :Container()),
              )
            ],
          ),
        ),
      );
    });
    elementos.add(SizedBox(height: size.height * 0.035,));
    elementos.add(_crearBotonNuevoHorario(size));
    elementos.add(SizedBox(height: size.height * 0.13,));
  }

  void _eliminarModuloHorario(HorarioModel horario){
    _horarios.remove(horario);
    _diasSeleccionados.removeWhere((dia)=>horario.dias.contains(dia));
    setState(() {
      
    });
  }

  Widget _crearElementosTimePickers(Size size, HorarioModel horario){
    return Column(
      children: <Widget>[
        Text(
          'Rango de horas',
          style: TextStyle(
            fontSize: size.width * 0.062,
            color: Colors.black.withOpacity(0.65)
          ),
        ),
        SizedBox(
          height: size.height * 0.012,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              color: Colors.white.withOpacity(0.75),
              child: Text(
                'desde las ${horario.horaInicial.hour}:${horario.horaInicial.minute}',
                style: TextStyle(
                  fontSize: size.width * 0.04
                ),
              ),
              onPressed: (){
                _mostrarTimePicker(context, horario, 1);
              },
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            RaisedButton(
              color: Colors.white.withOpacity(0.75),
              child: Text(
                'hasta las ${horario.horaFinal.hour}:${horario.horaFinal.minute}',
                style: TextStyle(
                  fontSize: size.width * 0.035
                ),
              ),
              onPressed: (){
                _mostrarTimePicker(context, horario, 2);
              },
            ),
            
          ],
        ),
      ],
    );
  }

  Widget _crearElementosDiasDeHorario(Size size, HorarioModel horario, List<Widget> elementos){    
    List<Widget> botonesDias = [];
    botonesDias.add(
      SizedBox(
        height: size.height * 0.025,
      )
    );
    botonesDias.add(
      Text(
        'Dias seleccionados',
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontSize: size.width * 0.06
        ),
      ),
    );
    botonesDias.add(
      SizedBox(
        height: size.height * 0.02,
      )
    );

    _dias.forEach((diaActual) {
      bool horarioTieneDia = horario.dias.contains(diaActual);
      if(!_diasSeleccionados.contains(diaActual) || horarioTieneDia){
        botonesDias.add(
          Row(
            children: [
              Checkbox(
                value: horarioTieneDia,
                onChanged: (bool selected){
                  horarioTieneDia = selected;
                  if(selected){
                    horario.dias.add(diaActual);
                    _diasSeleccionados.add(diaActual);
                  }               
                  else{
                    horario.dias.remove(diaActual);
                    _diasSeleccionados.remove(diaActual);
                  }                 
                  setState(() {
                    
                  });
                }
              ),
              Text(
                diaActual,
                style: TextStyle(
                  fontSize: size.width * 0.045
                ),
              )
            ],
          ),
        );
      }
    });
    botonesDias.add(SizedBox(height: size.height * 0.01));
    return Container(
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: botonesDias
      ),
    );
  }

  void _mostrarTimePicker(BuildContext context, HorarioModel horario, int nTimePicker)async{
    TimeOfDay initialTime = TimeOfDay(
      hour: ((nTimePicker==1)? 0 : 23),
      minute: ((nTimePicker ==1)? 0 : 59)
    );
    TimeOfDay selectedTime = await showTimePicker(context: context, initialTime: initialTime);
    if(selectedTime != null){
      if(nTimePicker == 1)
        horario.horaInicial = selectedTime;
      else
        horario.horaFinal = selectedTime;
      setState(() {
        
      });
    }
  }

  Widget _crearBotonNuevoHorario(Size size){
    return Center(
      //width: size.width * 0.25,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: size.height * 0.01),
        color: Colors.blueGrey.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width * 0.045)
        ),
        child: Text(
          'Nuevo horario',
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: size.width * 0.06,
          ),
        ),
        onPressed: (_diasSeleccionados.length < 8)? _agregarHorario : null,
      ),
    );
  }
}