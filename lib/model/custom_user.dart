
import 'package:equatable/equatable.dart';

class CustomUser extends Equatable {
  String uid;
  String displayName;
  String email;
  int point;
  String profileImage;

  CustomUser(
      {this.uid, this.displayName, this.email, this.point, this.profileImage});
  CustomUser.withoutPoint({
    this.uid, this.displayName, this.email, this.profileImage});

  @override
  List<Object> get props => [uid];
}
