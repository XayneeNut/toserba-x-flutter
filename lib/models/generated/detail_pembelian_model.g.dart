// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../detail_pembelian_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailPembelianModel _$DetailPembelianModelFromJson(
        Map<String, dynamic> json) =>
    DetailPembelianModel(
      detailPembelianId: json['detailPembelianId'] as int,
      jumlahBarang: json['jumlahBarang'] as int,
      subtotal: json['subtotal'] as int,
      hargaSatuan: json['hargaSatuan'] as int,
      pembelianDate: DateTime.parse(json['pembelianDate'] as String),
      catatan: json['catatan'] as String,
      alamatPengiriman: json['alamatPengiriman'] as String,
    );

Map<String, dynamic> _$DetailPembelianModelToJson(
        DetailPembelianModel instance) =>
    <String, dynamic>{
      'detailPembelianId': instance.detailPembelianId,
      'jumlahBarang': instance.jumlahBarang,
      'subtotal': instance.subtotal,
      'hargaSatuan': instance.hargaSatuan,
      'pembelianDate': instance.pembelianDate.toIso8601String(),
      'catatan': instance.catatan,
      'alamatPengiriman': instance.alamatPengiriman,
    };
