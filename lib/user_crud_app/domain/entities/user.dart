import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String firstName,
    required String lastName,
    required int age,
     int? id,
  }) = _User;
}
