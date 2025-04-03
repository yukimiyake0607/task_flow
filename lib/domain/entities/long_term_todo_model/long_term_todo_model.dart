import 'package:freezed_annotation/freezed_annotation.dart';

part 'long_term_todo_model.freezed.dart';
part 'long_term_todo_model.g.dart';

@freezed
class LongTermTodoModel with _$LongTermTodoModel {
  const factory LongTermTodoModel({
    required String id,
    required String todoTitle,
    required DateTime createdDate,
    required DateTime dueDate,
    required String successBorder,
    required String purpose,
    required List<String>? step,
  }) = _LongTermTodoModel;

  factory LongTermTodoModel.fromJson(Map<String, dynamic> json) =>
      _$LongTermTodoModelFromJson(json);
}
