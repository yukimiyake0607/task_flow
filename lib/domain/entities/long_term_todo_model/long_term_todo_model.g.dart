// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'long_term_todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LongTermTodoModelImpl _$$LongTermTodoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LongTermTodoModelImpl(
      id: json['id'] as String,
      todoTitle: json['todoTitle'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      successBorder: json['successBorder'] as String,
      purpose: json['purpose'] as String,
      step: (json['step'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$LongTermTodoModelImplToJson(
        _$LongTermTodoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'todoTitle': instance.todoTitle,
      'createdDate': instance.createdDate.toIso8601String(),
      'dueDate': instance.dueDate.toIso8601String(),
      'successBorder': instance.successBorder,
      'purpose': instance.purpose,
      'step': instance.step,
    };
