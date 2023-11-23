// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      userProfileId: json['userProfileId'] as int,
      patokanAlamat: json['patokanAlamat'] as String,
      userBirthday: DateTime.parse(json['userBirthday'] as String),
      userPhoto: json['userPhoto'] as String,
      kodePos: json['kodePos'] as String,
      alamatLengkap: json['alamatLengkap'] as String,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'userProfileId': instance.userProfileId,
      'patokanAlamat': instance.patokanAlamat,
      'userBirthday': instance.userBirthday.toIso8601String(),
      'userPhoto': instance.userPhoto,
      'kodePos': instance.kodePos,
      'alamatLengkap': instance.alamatLengkap,
    };
