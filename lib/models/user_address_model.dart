import 'package:json_annotation/json_annotation.dart';

part 'user_address_model.g.dart';

@JsonSerializable()
class UserAddressModel {
  final int addressId;
  final String alamatLengkap;
  final String posCode;
  final String patokan;

  UserAddressModel({
    required this.addressId,
    required this.alamatLengkap,
    required this.posCode,
    required this.patokan,
  });

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      _$UserAddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserAddressModelToJson(this);
}
