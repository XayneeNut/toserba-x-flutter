import 'package:json_annotation/json_annotation.dart';
import 'package:toserba/models/user_profile_model.dart';

part 'generated/user_account_model.g.dart';

@JsonSerializable()
class UserAccountModel {
  final int userAccountId;
  final String email;
  final String password;
  final String username;
  final DateTime createdAt;
  final DateTime updateAt;
  @JsonKey(name: "userProfileEntity")
  final UserProfileModel? userProfileModel;

  const UserAccountModel({
    required this.userAccountId,
    required this.email,
    required this.password,
    required this.username,
    required this.createdAt,
    required this.updateAt,
    required this.userProfileModel,
  });

  const UserAccountModel.next({
    required this.userAccountId,
    required this.email,
    required this.password,
    required this.username,
    required this.createdAt,
    required this.updateAt,
  }) : userProfileModel = null;

  factory UserAccountModel.fromJson(Map<String, dynamic> json) =>
      _$UserAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountModelToJson(this);

}
