// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAddressModel _$UserAddressModelFromJson(Map<String, dynamic> json) =>
    UserAddressModel(
      addressId: json['addressId'] as int,
      alamatLengkap: json['alamatLengkap'] as String,
      posCode: json['posCode'] as String,
      patokan: json['patokan'] as String,
    );

Map<String, dynamic> _$UserAddressModelToJson(UserAddressModel instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'alamatLengkap': instance.alamatLengkap,
      'posCode': instance.posCode,
      'patokan': instance.patokan,
    };
