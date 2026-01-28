import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_app/features/tasks/domain/models/task_model.dart';

part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

// Create Task DTO
@freezed
class CreateTaskDto with _$CreateTaskDto {
  const factory CreateTaskDto({
    required String title,
    required String description,
  }) = _CreateTaskDto;

  factory CreateTaskDto.fromJson(Map<String, dynamic> json) =>
      _$CreateTaskDtoFromJson(json);
}

// Update Task DTO
@freezed
class UpdateTaskDto with _$UpdateTaskDto {
  const factory UpdateTaskDto({
    String? title,
    String? description,
    bool? isCompleted,
  }) = _UpdateTaskDto;

  factory UpdateTaskDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateTaskDtoFromJson(json);
}

// Task Response DTO (same as TaskModel, but separated for clarity)
@freezed
class TaskResponseDto with _$TaskResponseDto {
  const factory TaskResponseDto({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _TaskResponseDto;

  factory TaskResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseDtoFromJson(json);

  // Convert to TaskModel
  static TaskModel toModel(TaskResponseDto dto) {
    return TaskModel(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      isCompleted: dto.isCompleted,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
}
