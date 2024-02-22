import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:toserba/models/json%20converter/file_converter.dart';
part 'image_barang_model.g.dart';

const FileConverter fileConverter = FileConverter();
Uint8List fromJsonToImageBarang(String? json) {
  File? file = fileConverter.fromJson(json);
  Uint8List bytes = file!.readAsBytesSync();
  return bytes;
}

Uint8List fromJsonToImageBarang2(String json) {
  List<int> bytes = base64Decode(json);
  return Uint8List.fromList(bytes);
}

String fromImageBarangToJson(Uint8List bytes) {
  String base64String = base64Encode(bytes);
  return base64String;
}

@JsonSerializable()
class ImageBarangModel {
  final int gambarId;
  @JsonKey(fromJson: fromJsonToImageBarang, toJson: fromImageBarangToJson)
  final Uint8List gambar;

  const ImageBarangModel({
    required this.gambarId,
    required this.gambar,
  });

  factory ImageBarangModel.fromJson(Map<String, dynamic> json) {
    return ImageBarangModel(
      gambarId: json['gambarId'],
      gambar: fromJsonToImageBarang2(json['gambar']),
    );
  }

  Map<String, dynamic> toJson() => _$ImageBarangModelToJson(this);
}
