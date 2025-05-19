import 'package:flutter/material.dart';
import 'package:todo_app/src/constants/todo_theme.dart';
import 'package:todo_app/src/features/todo/domain/todo_model.dart';
import 'package:todo_app/src/features/todo/presentation/todo_card.dart';

class TodoSection extends StatelessWidget {
  final String title;
  final List<TodoModel> todos;

  const TodoSection({
    super.key,
    required this.title,
    required this.todos,
  });

  Color _getTitleColor() {
    switch (title) {
      case '期限切れ':
        return alertColor;
      default:
        return todoDayColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _getTitleColor(),
            ),
          ),
        ),
        ...todos.map((todo) => TodoCard(
              key: ValueKey(todo.id),
              todoModel: todo,
            )),
      ],
    );
  }
}
