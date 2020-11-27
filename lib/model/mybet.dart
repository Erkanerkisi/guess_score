class MyBet {
  String betId;
  String status;
  String uid;
  int estAmount;
  int cost;
  List<Content> content;

  MyBet({this.status, this.uid, this.estAmount, this.cost, this.content});

  factory MyBet.fromJson(Map<String, dynamic> json) {
    return MyBet(
      status: json['status'],
      uid: json['uid'],
      estAmount: json['estAmount'],
      cost: json['cost'],
      content:
          List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    );
  }
}

class Content {
  int guess;
  int matchid;

  Content({this.guess, this.matchid});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(guess: json['guess'], matchid: json['matchid']);
  }
}
