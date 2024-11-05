import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';

@freezed
class Project with _$Project {
  const factory Project(
      {required String id,
      required String name,
      required String description}) = _Project;
}
