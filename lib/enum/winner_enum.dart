enum WinnerEnum { HOME_TEAM, AWAY_TEAM, DRAW }

extension EnumValue on WinnerEnum {
  String getEnumValue() {
    return this.toString().split('.').last;
  }
}
