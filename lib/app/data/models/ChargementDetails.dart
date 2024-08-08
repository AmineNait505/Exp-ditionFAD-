// ignore: file_names

import 'dart:convert';

class ChargementDetails{
  final String circuitName;
  final String vehicle;
  final String nomChauffeur;
  ChargementDetails({
    required this.circuitName, required this.vehicle, required this.nomChauffeur
  });
  factory ChargementDetails.fromJson(Map <String ,dynamic> json){
    return ChargementDetails(
      circuitName:utf8.decode(json['circuitName'].runes.toList()),
      vehicle: json['vehicle'],
      nomChauffeur: json['nomChauffeur'],);
  }
}