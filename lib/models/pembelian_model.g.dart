// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pembelian_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PembelianModel _$PembelianModelFromJson(Map<String, dynamic> json) =>
    PembelianModel(
      pembelianId: json['pembelianId'] as int,
      userAccountEntity: UserAccountModel.fromJson(
          json['userAccountEntity'] as Map<String, dynamic>),
      detailPembelianEntity: DetailPembelianModel.fromJson(
          json['detailPembelianEntity'] as Map<String, dynamic>),
      barangEntity:
          BarangModels.fromJson(json['barangEntity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PembelianModelToJson(PembelianModel instance) =>
    <String, dynamic>{
      'pembelianId': instance.pembelianId,
      'userAccountEntity': instance.userAccountEntity.toJson(),
      'barangEntity': instance.barangEntity.toJson(),
      'detailPembelianEntity': instance.detailPembelianEntity.toJson(),
    };
