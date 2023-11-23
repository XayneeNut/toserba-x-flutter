// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountModel _$UserAccountModelFromJson(Map<String, dynamic> json) =>
    UserAccountModel(
      userAccountId: json['userAccountId'] as int,
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
      userProfileModel: json['userProfileEntity'] == null
          ? null
          : UserProfileModel.fromJson(
              json['userProfileEntity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserAccountModelToJson(UserAccountModel instance) =>
    <String, dynamic>{
      'userAccountId': instance.userAccountId,
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'createdAt': instance.createdAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
      'userProfileEntity': instance.userProfileModel,
    };
