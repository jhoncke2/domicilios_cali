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
          
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 0.3,
                    ),
                     bottom: BorderSide(
                      color: Colors.black,
                      width: 0.3,
                    )
                  )
                ),
                child: Column(
                  children: [
                    Row(
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
                    _crearElementosDiasDeHorario(size, horario, elementos),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CloseButton(
                    ),
                  ],
                ),
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
    return Container(
      width: size.width * 0.5,
      child: RaisedButton(
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

  /*
    for(int i = 0; i < _horarios.length; i++){
      HorarioModel horario = _horarios[i];
      elementos.add(
        Container(
          child: Row(
            children: [
              Column(
                children: [
                  Text('titulo'),
                  Row()
                ],
              ),
              Column(
                children: [
                  CloseButton(
                    color: Colors.redAccent,
                    onPressed: (){
                      
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
    */
}