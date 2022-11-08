import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  User(this.id, this.firstName, this.lastName, this.avatar, this.email);
  int id;
  String firstName;
  String lastName;
  String email;
  String avatar;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
