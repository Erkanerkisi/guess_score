enum MatchStatus {IN_PLAY, FINISHED, SCHEDULED }

extension EnumValue on MatchStatus {
  String getEnumValue() {
    return this.toString().split('.').last;
  }
}

extension EnumValueAsStringDescription on MatchStatus {
  String getEnumValueAsStringDesc() {
    if(this == MatchStatus.FINISHED) return "Finished";
    else if(this == MatchStatus.IN_PLAY) return "In Play";
    else if(this == MatchStatus.SCHEDULED) return "Scheduled";
    else return this.getEnumValue();
  }
}

MatchStatus matchStatusFromString(String value){
  return MatchStatus.values.firstWhere((e)=>
  e.toString().split('.')[1].toUpperCase()==value.toUpperCase());
}
