import 'package:core/core.dart';
import 'package:core/utils/app_logger.dart';

class AssessmentMapper {
  static Assessment fromJson(Map<String, dynamic> json) {
    logger.logInfo(json.toString());
    return Assessment(
      id: json['\$id'] as String,
      assessor: json['assessor'] as String,
      employee:
          EmployeeMapper.fromJson(json['employee'] as Map<String, dynamic>),
    );
  }

  static Map<String, dynamic> toJson(Assessment assessment) {
    return {
      'assessor': assessment.assessor,
      'employee': assessment.employee.id,
    };
  }
}
