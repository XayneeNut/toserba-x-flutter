import 'package:json_annotation/json_annotation.dart';
import 'package:toserba/models/user_address_model.dart';
import 'package:toserba/models/pembelian_model.dart';

class UserAccountModel {
  final int userAccountId;
  final String email;
  final String password;
  final String username;
  final DateTime createdAt;
  final DateTime updateAt;
  @JsonKey(name: "userProfileEntity")
  final List<UserAddressModel>? userAddressEntity;
  final List<PembelianModel>? pembelianModel;

  const UserAccountModel({
    required this.userAccountId,
    required this.email,
    required this.password,
    required this.username,
    required this.createdAt,
    required this.updateAt,
    required this.userAddressEntity,
    required this.pembelianModel,
  });

  const UserAccountModel.next({
    required this.userAccountId,
    required this.email,
    required this.password,
    required this.username,
    required this.createdAt,
    required this.updateAt,
  })  : userAddressEntity = null,
        pembelianModel = null;

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      userAccountId: json['userAccountId'] as int,
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
      userAddressEntity: json['userAddressEntities'] == null
          ? null
          : List<UserAddressModel>.from(
              (json['userAddressEntities'] as List).map(
                  (x) => UserAddressModel.fromJson(x as Map<String, dynamic>)),
            ),
      pembelianModel: json['pembelianEntities'] != null
          ? List<PembelianModel>.from(
              (json['pembelianEntities'] as List).map(
                  (x) => PembelianModel.fromJson(x as Map<String, dynamic>)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userAccountId': userAccountId,
      'email': email,
      'password': password,
      'username': username,
      'createdAt': createdAt.toIso8601String(),
      'updateAt': updateAt.toIso8601String(),
      'userAddressEntities': userAddressEntity!.map((e) => e.toJson()).toList(),
      'pembelianEntities': pembelianModel!.map((e) => e.toJson()).toList()
    };
  }
}
