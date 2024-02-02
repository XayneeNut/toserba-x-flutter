  // GENERATED CODE - DO NOT MODIFY BY HAND

  part of 'barang_models.dart';

  // **************************************************************************
  // JsonSerializableGenerator
  // **************************************************************************

  BarangModels _$BarangModelsFromJson(Map<String, dynamic> json) => BarangModels(
        idBarang: json['idBarang'] as int,
        namaBarang: json['namaBarang'] as String,
        kodeBarang: json['kodeBarang'] as String,
        hargaBarang: json['hargaBarang'] as int,
        stokBarang: json['stokBarang'] as int,
        imageBarang: (json['imageBarang'] as List<dynamic>)
            .map((e) => ImageBarangModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        adminAccountEntity: AdminAccountModel.fromJson(
            json['adminAccountEntity'] as Map<String, dynamic>),
        hargaJual: json['hargaJual'] as int,
        unit: json['unit'] as String,
      );

  Map<String, dynamic> _$BarangModelsToJson(BarangModels instance) =>
      <String, dynamic>{
        'idBarang': instance.idBarang,
        'namaBarang': instance.namaBarang,
        'kodeBarang': instance.kodeBarang,
        'hargaBarang': instance.hargaBarang,
        'stokBarang': instance.stokBarang,
        'imageBarang': instance.imageBarang,
        'adminAccountEntity': instance.adminAccountEntity,
        'hargaJual': instance.hargaJual,
        'unit': instance.unit,
      };
