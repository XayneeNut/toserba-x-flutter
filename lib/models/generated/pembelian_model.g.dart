// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../pembelian_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PembelianModel _$PembelianModelFromJson(Map<String, dynamic> json) =>
    PembelianModel(
      pembelianId: json['pembelianId'] as int,
      adminAccountEntity: AdminAccountModel.fromJson(
          json['adminAccountEntity'] as Map<String, dynamic>),
      userAccountEntity: UserAccountModel.fromJson(
          json['userAccountEntity'] as Map<String, dynamic>),
      detailPembelianEntity: DetailPembelianModel.fromJson(
          json['detailPembelianEntity'] as Map<String, dynamic>),
      userProfileEntity: UserProfileModel.fromJson(
          json['userProfileEntity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PembelianModelToJson(PembelianModel instance) =>
    <String, dynamic>{
      'pembelianId': instance.pembelianId,
      'adminAccountEntity': instance.adminAccountEntity.toJson(),
      'userAccountEntity': instance.userAccountEntity.toJson(),
      'detailPembelianEntity': instance.detailPembelianEntity.toJson(),
      'userProfileEntity': instance.userProfileEntity.toJson(),
    };
