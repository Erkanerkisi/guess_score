class Team{
  int id;
  String name;
  String shortName;
  String crestUrl;

  Team({this.id, this.name, this.crestUrl, this.shortName});

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
    );
  }
}