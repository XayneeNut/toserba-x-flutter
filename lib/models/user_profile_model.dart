import 'package:json_annotation/json_annotation.dart';

part 'generated/user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  final int userProfileId;
  final String patokanAlamat;
  @JsonKey(name: 'userBirthday')
  final DateTime userBirthday;
  final String userPhoto;
  final String kodePos;
  final String alamatLengkap;

  UserProfileModel({
    required this.userProfileId,
    required this.patokanAlamat,
    required this.userBirthday,
    required this.userPhoto,
    required this.kodePos,
    required this.alamatLengkap,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
  Map<String,dynamic> toJson() => _$UserProfileModelToJson(this);
  
}
