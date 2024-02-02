// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_barang_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageBarangModel _$ImageBarangModelFromJson(Map<String, dynamic> json) =>
    ImageBarangModel(
      gambarId: json['gambarId'] as int,
      gambar: fromJsonToImageBarang(json['gambar'] as String?),
    );

Map<String, dynamic> _$ImageBarangModelToJson(ImageBarangModel instance) =>
    <String, dynamic>{
      'gambarId': instance.gambarId,
      'gambar': fromImageBarangToJson(instance.gambar),
    };
