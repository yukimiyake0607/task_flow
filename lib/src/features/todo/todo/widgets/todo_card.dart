import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/features/todo/domain/todo_model.dart';
import 'package:todo_app/src/constants/todo_theme.dart';
import 'package:todo_app/src/features/todo/todo/widgets/todo_dialog.dart';
import 'package:todo_app/src/features/todo/data/todo_provider.dart';

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
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: _isChecked == false
            ? Colors.white
            : completedCardColor.withAlpha(13),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _isChecked == false
                ? todoMainColor.withAlpha(26)
                : completedCardColor.withAlpha(26),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: todoCardBorderColor,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Container(
              width: 5,
              color: widget.todoModel.important == true ? todoMainColor : null,
            ),
          ),
          Checkbox(
            value: _isChecked,
            onChanged: (newValue) async {
              setState(() {
                // nullが返ってくることを考慮してデフォでfalseを指定
                _isChecked = newValue ?? false;
              });

              // 一時的に状態を更新せず、0.5秒後に更新する
              await Future.delayed(const Duration(milliseconds: 500));

              if (!mounted) return;

              // 反対のリストに移動する処理
              ref.read(todoActionsProvider).toggleTodo(widget.todoModel);
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.todoModel.todoTitle,
                style: TextStyle(
                  decoration: widget.todoModel.isCompleted == false
                      ? null
                      : TextDecoration.lineThrough,
                ),
              ),
              widget.todoModel.dueDate != null
                  ? Text(DateFormat('yyyy年MM月dd日')
                      .format(widget.todoModel.dueDate!))
                  : const SizedBox.shrink(),
            ],
          ),

          // Todoタイトルとボタン間に余白
          const Spacer(),

          // 編集機能はTodoPageのみ
          if (_isChecked == false)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return TodoDialog(
                      buttonTitle: '編集',
                      todoModel: widget.todoModel,
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit_note_outlined),
              visualDensity: VisualDensity.compact,
            ),

          // 削除ボタン：両方
          IconButton(
            onPressed: () async {
              await ref
                  .read(todoActionsProvider)
                  .deleteTodo(widget.todoModel.id);
            },
            icon: const Icon(Icons.delete_outlined),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
