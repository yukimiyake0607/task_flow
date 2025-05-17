import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/features/todo/domain/todo_model.dart';
import 'package:todo_app/src/constants/todo_theme.dart';
import 'package:todo_app/src/features/todo/presentation/todo_controller.dart';
import 'package:todo_app/src/features/todo/presentation/todo_dialog.dart';

class TodoCard extends ConsumerStatefulWidget {
  const TodoCard({
    super.key,
    required this.todoModel,
  });

  final TodoModel todoModel;

  @override
  ConsumerState<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends ConsumerState<TodoCard> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.todoModel.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isChecked) {
          showDialog(
            context: context,
            builder: (context) {
              return TodoDialog(
                buttonTitle: '編集',
                todoModel: widget.todoModel,
              );
            },
          );
        }
        return;
      },
      child: Container(
        decoration: BoxDecoration(
          color: _isChecked == false
              ? Colors.white
              : completedCardColor.withAlpha(13),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade100,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (newValue) async {
                setState(() {
                  _isChecked = newValue ?? false;
                });

                await Future.delayed(const Duration(milliseconds: 500));

                if (!mounted) return;

                await ref
                    .read(todoControllerProvider.notifier)
                    .toggleTodo(widget.todoModel);
              },
              side: BorderSide(color: Colors.grey.shade500, width: 2),
            ),
            Text(
              widget.todoModel.todoTitle,
              style: TextStyle(
                decoration: widget.todoModel.isCompleted == false
                    ? null
                    : TextDecoration.lineThrough,
              ),
            ),

            const Spacer(),

            // 削除ボタン：両方
            IconButton(
              onPressed: () async {
                await ref
                    .read(todoControllerProvider.notifier)
                    .deleteTodo(widget.todoModel.id);
              },
              icon: const Icon(Icons.delete_outlined),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}
