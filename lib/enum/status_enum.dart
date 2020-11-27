enum Status { Waiting, Completed }

extension EnumValue on Status {
  String getEnumValue() {
    return this.toString().split('.').last;
  }
}
