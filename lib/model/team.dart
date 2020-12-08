import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Team{
  int id;
  String name;
  String shortName;
  String crestUrl;
  Widget logo;

  Team({this.id, this.name, this.crestUrl, this.shortName, this.logo});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
    );
  }
  factory Team.fromTeamJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
      crestUrl: json['crestUrl'],
      logo: SvgPicture.network(json['crestUrl'])
    );
  }
  Map toJson() => {
    'id': id,
    'name': name,
    'shortName': shortName,
    'crestUrl': crestUrl
  };
}