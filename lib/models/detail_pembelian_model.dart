import 'package:json_annotation/json_annotation.dart';
part 'generated/detail_pembelian_model.g.dart';

@JsonSerializable()
class DetailPembelianModel {
  final int detailPembelianId;
  final int jumlahBarang;
  final int subtotal;
  final int hargaSatuan;
  @JsonKey(name: "pembelianDate")
  final DateTime pembelianDate;
  final String catatan;
  final String alamatPengiriman;

  const DetailPembelianModel(
      {required this.detailPembelianId,
      required this.jumlahBarang,
      required this.subtotal,
      required this.hargaSatuan,
      required this.pembelianDate,
      required this.catatan,
      required this.alamatPengiriman});

  factory DetailPembelianModel.fromJson(Map<String, dynamic> json) =>
      _$DetailPembelianModelFromJson(json);
  Map<String, dynamic> toJson() => _$DetailPembelianModelToJson(this);
}
