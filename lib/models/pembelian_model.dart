import 'package:toserba/models/detail_pembelian_model.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/models/barang_models.dart';
class PembelianModel {
  int? pembelianId;
  UserAccountModel? userAccountEntity;
  BarangModels? barangEntity;
  DetailPembelianModel? detailPembelianEntity;

  PembelianModel(
      {required this.pembelianId,
      required this.userAccountEntity,
      required this.detailPembelianEntity,
      required this.barangEntity});

  PembelianModel.fromJson(Map<String, dynamic> json) {
    pembelianId = json['pembelianId'];
    userAccountEntity = json['userAccountEntity'] != null
        ? UserAccountModel.fromJson(json['userAccountEntity'])
        : null;
    barangEntity = json['barangEntity'] != null
        ? BarangModels.fromJson2(json['barangEntity'])
        : null;
    detailPembelianEntity = json['detailPembelianEntity'] != null
        ? DetailPembelianModel.fromJson(json['detailPembelianEntity'])
        : null;
  }

}
