import 'package:flutter/material.dart';

class Lacuna {
  final int id;
  String marca;
  Color cor;
  bool habilitar;


  Lacuna(this.id,
      {this.marca = '', this.cor = Colors.black26, this.habilitar = true});

}