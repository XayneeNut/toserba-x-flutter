import 'package:json_annotation/json_annotation.dart';
import 'package:toserba/models/admin_account_model.dart';
import 'package:toserba/models/detail_pembelian_model.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/models/user_profile_model.dart';

part 'generated/pembelian_model.g.dart';

@JsonSerializable()
class PembelianModel {
  final int pembelianId;
  final AdminAccountModel adminAccountEntity;
  @JsonKey(name: "userAccountEntity")
  final UserAccountModel userAccountEntity;
  @JsonKey(name: "detailPembelianEntity")
  final DetailPembelianModel detailPembelianEntity;
  @JsonKey(name: "userProfileEntity")
  final UserProfileModel userProfileEntity;

  const PembelianModel(
      {required this.pembelianId,
      required this.adminAccountEntity,
      required this.userAccountEntity,
      required this.detailPembelianEntity,
      required this.userProfileEntity});

  factory PembelianModel.fromJson(Map<String, dynamic> json) =>
      _$PembelianModelFromJson(json);

  Map<String, dynamic> toJson() => _$PembelianModelToJson(this);
}
