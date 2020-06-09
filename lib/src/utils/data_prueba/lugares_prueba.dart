class LugaresPrueba{
  final lugares = [
    {
      "id":1,
      "nombre": "casa 1",
      "direccion": "cll 28 sur # 6-22",
      "latitud": 4.582479, 
      "longitud": -74.10985730000002,
      'elegido':true,
      'tipo_via_principal':'Calle',
      'componentes':<Map<String,dynamic>>[
        {
          'nombre':'numero_domiciliario',
          'valor':'22'
        },
        {
          'nombre':'via_secundaria',
          'valor':'6'
        },
        {
          'nombre':'via_principal',
          'valor':'Calle 28 sur'
        },
        {
          'nombre':'ciudad',
          'valor':'Bogotá'
        }, 
        {
          'nombre':'departamento',
          'valor':'Bogotá'
        },
        {
          'nombre':'pais',
          'valor':'Colombia'
        },
        
      ]
    },
    {
      "id":2,
      "nombre":"sobrinos",
      "direccion":"cll 129 # 25-45",
      "latitud":4.715489,
      "longitud": -74.053068,
      'elegido':false,
      'tipo_via_principal':'Calle',
      'componentes':<Map<String,dynamic>>[
        {
          'nombre':'numero_domiciliario',
          'valor':'45'
        },
        {
          'nombre':'via_secundaria',
          'valor':'25'
        },
        {
          'nombre':'via_principal',
          'valor':'Calle 129'
        },
        {
          'nombre':'ciudad',
          'valor':'Bogotá',
        },
        {
          'nombre':'departamento',
          'valor':'Bogotá'
        },
        {
          'nombre':'pais',
          'valor':'Colombia'
        },
      ]
    },
    {
      "id":3,
      "nombre":"trabajo",
      "direccion":"cra 58 # 47-93",
      "latitud":4.6816213,
      "longitud": -74.06034319999999,
      'elegido':false,
      'tipo_via_principal':'Carrera',
      'componentes':<Map<String,dynamic>>[
        {
          'nombre':'numero_domiciliario',
          'valor':'93'
        },
        {
          'nombre':'via_secundaria',
          'valor':'47',
        },
        {
          'nombre':'via_principal',
          'valor':'Carrera 58',
        },
        {
          'nombre':'ciudad',
          'valor':'Bogotá',
        },
        {
          'nombre':'departamento',
          'valor':'Bogotá'
        },
        {
          'nombre':'pais',
          'valor':'Colombia'
        },
      ]
    },
    {
      "id":0,
      "nombre":"tu ubicación",
      "direccion":null,
      "latitud":null,
      "longitud": null,
      'elegido':false,
      'componentes':<Map<String,String>>[     
      ]
    }
  ];
}