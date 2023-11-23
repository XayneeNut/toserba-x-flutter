// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../admin_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminAccountModel _$AdminAccountModelFromJson(Map<String, dynamic> json) =>
    AdminAccountModel(
      accountId: json['accountId'] as int,
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AdminAccountModelToJson(AdminAccountModel instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
    };
