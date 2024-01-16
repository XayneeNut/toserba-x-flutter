import 'package:json_annotation/json_annotation.dart';

part 'generated/admin_account_model.g.dart';

@JsonSerializable()
class AdminAccountModel {
  const AdminAccountModel(
      {required this.accountId,
      required this.email,
      required this.username,
      required this.password});
  final int accountId;
  final String? email;
  final String? username;
  final String? password;

  const AdminAccountModel.second({
    required this.accountId,
  })  : email = null,
        username = null,
        password = null;

  factory AdminAccountModel.fromJson(Map<String, dynamic> json) =>
      _$AdminAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAccountModelToJson(this);
}
