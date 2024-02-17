import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:toserba/models/admin_account_model.dart';
import 'package:toserba/models/image_barang_model.dart';
import 'package:toserba/models/json%20converter/file_converter.dart';

part 'barang_models.g.dart';

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
    required this.deskripsi,
  });

  int? idBarang;
  String? namaBarang;
  String? kodeBarang;
  int? hargaBarang;
  int? stokBarang;
  List<ImageBarangModel>? imageBarang;
  AdminAccountModel? adminAccountEntity;
  int? hargaJual;
  String? unit;
  String? deskripsi;

  BarangModels.fromJson(Map<String, dynamic> json) {
    idBarang = json['idBarang'];
    namaBarang = json['namaBarang'];
    hargaBarang = json['hargaBarang'];
    stokBarang = json['stokBarang'];
    kodeBarang = json['kodeBarang'];
    deskripsi = json['deskripsi'];
    adminAccountEntity = json['adminAccountEntity'] != null
        ? AdminAccountModel.fromJson(json['adminAccountEntity'])
        : null;
    hargaJual = json['hargaJual'];
    unit = json['unit'];
    if (json['imageBarang'] != null) {
      imageBarang =
          List<ImageBarangModel>.from(json["imageBarang"].map((x) => x));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'idBarang': idBarang,
      'namaBarang': namaBarang,
      'hargaBarang': hargaBarang,
      'stokBarang': stokBarang,
      'kodeBarang': kodeBarang,
      'adminAccountEntity': adminAccountEntity?.toJson(),
      'hargaJual': hargaJual,
      'unit': unit,
      'imageBarang': imageBarang?.map((item) => item.toJson()).toList(),
    };
  }
}
