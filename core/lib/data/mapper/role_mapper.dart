import 'package:core/domain/entities/role.dart';
import 'package:core/utils/app_logger.dart';

class RoleMapper {
  static Role fromJson(Map<String, dynamic> json) {
    logger.logInfo(json.toString());
    return Role(
      id: json['\$id'] as String,
      name: json['name'] as String,
    );
  }

  static Map<String, dynamic> toJson(Role role) {
    return {
      'name': role.name,
    };
  }
}
