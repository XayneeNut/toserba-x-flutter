import 'package:json_annotation/json_annotation.dart';
import 'package:toserba/models/user_profile_model.dart';

class UserProfileModelConverter
    implements JsonConverter<UserProfileModel?, Map<String, dynamic>?> {
  const UserProfileModelConverter();

  @override
  UserProfileModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return UserProfileModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserProfileModel? object) {
    if (object == null) {
      return null;
    }

    return object.toJson();
  }
}
