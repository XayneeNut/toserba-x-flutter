import 'package:json_annotation/json_annotation.dart';
import 'package:toserba/models/detail_pembelian_model.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/models/barang_models.dart';

part 'pembelian_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PembelianModel {
  final int pembelianId;
  final UserAccountModel userAccountEntity;
  final BarangModels barangEntity;
  final DetailPembelianModel detailPembelianEntity;

  const PembelianModel(
      {required this.pembelianId,
      required this.userAccountEntity,
      required this.detailPembelianEntity,
      required this.barangEntity});

  factory PembelianModel.fromJson(Map<String, dynamic> json) =>
      _$PembelianModelFromJson(json);

  Map<String, dynamic> toJson() => _$PembelianModelToJson(this);
}
