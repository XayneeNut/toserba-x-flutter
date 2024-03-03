import 'package:json_annotation/json_annotation.dart';
import 'package:toserba/models/user_address_model.dart';

class UserProfileModelConverter
    implements JsonConverter<UserAddressModel?, Map<String, dynamic>?> {
  const UserProfileModelConverter();

  @override
  UserAddressModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return UserAddressModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserAddressModel? object) {
    if (object == null) {
      return null;
    }

    return object.toJson();
  }
}
