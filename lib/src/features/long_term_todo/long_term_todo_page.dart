import 'package:flutter/material.dart';
import 'package:todo_app/src/features/long_term_todo/domain/long_term_todo_model.dart';
import 'package:todo_app/src/core/appbar/custom_appbar.dart';

class LongTermTodoPage extends StatelessWidget {
  LongTermTodoPage({super.key});

  final List<LongTermTodoModel> longTermTodoList = [
    LongTermTodoModel(
      id: '1',
      todoTitle: 'タイトル',
      createdDate: DateTime.now(),
      dueDate: DateTime(2025, 12, 31),
      successBorder: '成功の基準',
      purpose: '目的をここに書く',
      step: [],
    ),
    LongTermTodoModel(
      id: '2',
      todoTitle: 'タイトル',
      createdDate: DateTime.now(),
      dueDate: DateTime(2025, 10, 31),
      successBorder: '成功の基準',
      purpose: '目的をここに書く',
      step: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: '長期目標'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView.builder(
          itemCount: longTermTodoList.length,
          itemBuilder: (context, index) {
            final todo = longTermTodoList[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.todoTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE0E0),
                          borderRadius: BorderRadius.circular(12.5),
                        ),
                        child: const Text(
                          '残り日数',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0EFFE),
                          borderRadius: BorderRadius.circular(12.5),
                        ),
                        child: Text(
                          '残タスク：${todo.step?.length ?? 0}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('目的：${todo.purpose}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
