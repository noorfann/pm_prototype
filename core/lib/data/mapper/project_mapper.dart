import 'package:core/domain/entities/project.dart';
import 'package:core/utils/app_logger.dart';

class ProjectMapper {
  static Project fromJson(Map<String, dynamic> json) {
    logger.logInfo(json.toString());
    return Project(
      id: json['\$id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  static Map<String, dynamic> toJson(Project project) {
    return {'name': project.name, 'description': project.description};
  }
}
