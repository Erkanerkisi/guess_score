enum Status { Waiting, Won, Lost }

extension EnumValue on Status {
  String getEnumValue() {
    return this.toString().split('.').last;
  }
}
