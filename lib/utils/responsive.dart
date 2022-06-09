import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

///Clase responsive hecha para obtener las medidas de MediaQuery
///de una manera mas sencilla
class Responsive {
  ///Constructor que recibe context para calcular el mediaQuery
  Responsive(BuildContext context) {
    final size = MediaQuery.of(context).size;

    width = size.width;
    height = size.height;
    ip = math.sqrt(math.pow(width, 2) + math.pow(height, 2));
  }

  ///Inicializar valores
  double width = 0, height = 0, ip = 0;

  ///Regresa el valor de alto y recibe como parametro el porcentaje que quieres
  double heightCustom(double value) {
    return height * value;
  }

  ///Regresa el valor de ancho y recibe como parametro el porcentaje que quieres
  double widthCustom(double value) {
    return width * value;
  }
}
