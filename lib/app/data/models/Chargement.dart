// ignore: file_names
import 'dart:convert';

class Chargement{
  final String code;
  final String nom;
  Chargement({
    required this.code, required this.nom
  });
  factory Chargement.fromJson(Map <String ,dynamic> json){
    return Chargement(
      code: json['code'], 
     nom: utf8.decode(json['nom'].runes.toList()),);
  }
}