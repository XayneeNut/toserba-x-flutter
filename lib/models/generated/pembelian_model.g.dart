// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../pembelian_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PembelianModel _$PembelianModelFromJson(Map<String, dynamic> json) =>
    PembelianModel(
      pembelianId: json['pembelianId'] as int,
      adminAccountEntity: AdminAccountModel.fromJson(
          json['adminAccountModel'] as Map<String, dynamic>),
      userAccountEntity: UserAccountModel.fromJson(
          json['userAccountModel'] as Map<String, dynamic>),
      detailPembelianEntity: DetailPembelianModel.fromJson(
          json['detailPembelianModel'] as Map<String, dynamic>),
      userProfileEntity: UserProfileModel.fromJson(
          json['userProfileModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PembelianModelToJson(PembelianModel instance) =>
    <String, dynamic>{
      'pembelianId': instance.pembelianId,
      'adminAccountModel': instance.adminAccountEntity,
      'userAccountModel': instance.userAccountEntity,
      'detailPembelianModel': instance.detailPembelianEntity,
      'userProfileModel': instance.userProfileEntity,
    };
