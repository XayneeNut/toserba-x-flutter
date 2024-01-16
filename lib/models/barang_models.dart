import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:toserba/models/admin_account_model.dart';
import 'package:toserba/models/json%20converter/file_converter.dart';

part 'generated/barang_models.g.dart';

const FileConverter fileConverter = FileConverter();
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
    required this.imageBarang,
    required this.adminAccountEntity,
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
  final AdminAccountModel adminAccountEntity;
  final int hargaJual;
  final String unit;
  

  factory BarangModels.fromJson(Map<String, dynamic> json) =>
      _$BarangModelsFromJson(json);

  Map<String, dynamic> toJson() {
    return {
      'idBarang': idBarang,
      'namaBarang': namaBarang,
      'kodeBarang': kodeBarang,
      'hargaBarang': hargaBarang,
      'stokBarang': stokBarang,
      'imageBarang': fromImageBarangToJson(imageBarang),
      'adminAccountEntity': adminAccountEntity.accountId,
      'hargaJual': hargaJual,
      'unit': unit,
    };
  }
}
