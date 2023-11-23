import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:toserba/models/json%20converter/file_converter.dart';

part 'generated/barang_models.g.dart';

const fileConverter = FileConverter();

File? fromJsonToImageBarang(String? json) => fileConverter.fromJson(json);
String? fromImageBarangToJson(File? imageBarang) =>
    fileConverter.toJson(imageBarang);

@JsonSerializable()
class BarangModels {
  BarangModels({
    required this.idBarang,
    required this.namaBarang,
    required this.kodeBarang,
    required this.hargaBarang,
    required this.stokBarang,
    this.imageBarang,
    required this.accountId,
    required this.hargaJual,
    required this.unit,
  });

  final int idBarang;
  final String namaBarang;
  final String kodeBarang;
  final int hargaBarang;
  final int stokBarang;
  @JsonKey(fromJson: fromJsonToImageBarang, toJson: fromImageBarangToJson)
  File? imageBarang;
  final int accountId;
  final int hargaJual;
  final String unit;

  factory BarangModels.fromJson(Map<String, dynamic> json) =>
      _$BarangModelsFromJson(json);

  Map<String, dynamic> toJson() => _$BarangModelsToJson(this);
}
