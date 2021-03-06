import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

ImagePicker _imagePicker = ImagePicker();

Future<void> tomarFotoDialog(BuildContext context, Size size, Map<String, File> imagenMap)async{
  File imagen;
  await showDialog(
    context: context,
     builder: (BuildContext buildContext){
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width * 0.035)
        ),
        child: Container(
          color: Colors.grey.withOpacity(0.45),
          padding: EdgeInsets.symmetric(vertical:0.0),
          height: size.height * 0.24,
          width: size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.35),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black.withOpacity(0.65)
                    )
                  ),
                  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.redAccent.withOpacity(0.9),
                        ),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
              CupertinoButton(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                //color: Colors.blueGrey.withOpacity(0.35),
                child: Text(
                  'Subir imagen',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.45),
                    fontSize: size.width * 0.049
                  ),
                ),
                onPressed: ()async{
                  imagen = await _procesarImagen(context, ImageSource.gallery);
                  imagenMap['imagen'] = imagen;
                  Navigator.of(context).pop(imagen);
                }
              ),
              Container(
                color: Colors.black.withOpacity(0.3),
                height: size.height * 0.001,
              ),
              CupertinoButton(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                //color: Colors.blueGrey.withOpacity(0.35),
                child: Text(
                  'Tomar foto',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.45),
                    fontSize: size.width * 0.049
                  ),
                ),
                onPressed: ()async{
                  imagen = await _procesarImagen(context, ImageSource.camera );
                  imagenMap['imagen'] = imagen;
                  Navigator.of(context).pop(imagen);
                }
              ),
            ],
          ),
        ),
      );
    }
  );
}



Future<File> _procesarImagen(BuildContext context, ImageSource imageSource)async{
  PickedFile pickedFile = await _imagePicker.getImage(
      source: imageSource
    );
    File imagen = File(pickedFile.path);
    return imagen;
    
}