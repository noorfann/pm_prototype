import 'package:core/common/enums.dart';
import 'package:core/core.dart';
import 'package:core/utils/app_logger.dart';

class EmployeeMapper {
  static Employee fromJson(Map<String, dynamic> json) {
    logger.logInfo(json.toString());
    return Employee(
      id: json['\$id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      gender: (json['gender'] == 'male') ? Gender.male : Gender.female,
      role: RoleMapper.fromJson(json['role'] as Map<String, dynamic>),
    );
  }

  static Map<String, dynamic> toJson(Employee employee) {
    return {
      'name': employee.name,
      'email': employee.email,
      'gender': (employee.gender == Gender.male) ? 'male' : 'female',
      'role': employee.role.id,
    };
  }
}
