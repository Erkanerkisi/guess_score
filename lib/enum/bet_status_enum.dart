enum BetStatus { Waiting, Won, Lost }

extension EnumValue on BetStatus {
  String getEnumValue() {
    return this.toString().split('.').last;
  }
}
