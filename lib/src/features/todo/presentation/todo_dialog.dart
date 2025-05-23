import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/features/todo/domain/todo_model.dart';
import 'package:todo_app/src/extensions/snack_bar.dart';
import 'package:todo_app/src/constants/todo_theme.dart';
import 'package:todo_app/src/features/todo/presentation/todo_controller.dart';

class TodoDialog extends ConsumerStatefulWidget {
  const TodoDialog({super.key, required this.buttonTitle, this.todoModel});

  final String buttonTitle;
  final TodoModel? todoModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoDialogState();
}

class _TodoDialogState extends ConsumerState<TodoDialog> {
  late TextEditingController _controllerTodoTitle;
  late TextEditingController _controllerDate;
  late DateTime _dueDate;
  late bool _isImportant;

  @override
  void initState() {
    super.initState();
    _controllerTodoTitle = TextEditingController(
      text: widget.todoModel?.todoTitle ?? '',
    );
    _dueDate = widget.todoModel?.dueDate ?? DateTime.now();
    _controllerDate = TextEditingController(
      text: DateFormat('yyyy年MM月dd日').format(_dueDate),
    );
    _isImportant = widget.todoModel?.important ?? false;
  }

  @override
  void dispose() {
    _controllerTodoTitle.dispose();
    _controllerDate.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: const Locale('ja'),
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2099),
    );

    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
        _controllerDate.text = DateFormat('yyyy年MM月dd日').format(_dueDate);
      });
    }
  }

  Future<void> _createTodo() async {
    final title = _controllerTodoTitle.text.trim();
    if (_controllerTodoTitle.text.isEmpty) {
      context.showErrorSnackBar('タスク名が入力されていません');
      return;
    }

    await ref
        .read(todoControllerProvider.notifier)
        .addTodo(title, _dueDate, _isImportant);
  }

  Future<void> _updateTodo() async {
    final title = _controllerTodoTitle.text.trim();
    if (_controllerTodoTitle.text.isEmpty) {
      context.showErrorSnackBar('タスク名が入力されていません');
      return;
    }

    await ref
        .read(todoControllerProvider.notifier)
        .updateTodo(title, _dueDate, _isImportant, widget.todoModel!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 70,
                decoration: const BoxDecoration(
                  color: todoMainColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.todoModel == null ? '新しいTODO' : 'TODOを編集',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('タスク名'),
                        const SizedBox(width: 10),
                        if (_controllerTodoTitle.text.isEmpty)
                          const Text(
                            '※必須',
                            style: TextStyle(
                              color: todoMainColor,
                            ),
                          ),
                      ],
                    ),
                    TextField(
                      controller: _controllerTodoTitle,
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(_controllerDate.text),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          value: _isImportant,
                          onChanged: (newValue) {
                            setState(() {
                              _isImportant = newValue!;
                            });
                          },
                        ),
                        const Text('重要なタスク'),
                      ],
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (widget.todoModel == null) {
                            _createTodo();
                          } else {
                            _updateTodo();
                          }
                          // ダイアログを閉じる
                          if (mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(widget.buttonTitle),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
