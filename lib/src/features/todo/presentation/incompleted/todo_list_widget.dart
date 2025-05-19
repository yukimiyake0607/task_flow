import 'package:flutter/material.dart';
import 'package:todo_app/src/features/todo/domain/todo_model.dart';
import 'package:todo_app/src/features/todo/presentation/incompleted/todo_section.dart';

class TodoListWidget extends StatelessWidget {
  final List<TodoModel> todos;

  const TodoListWidget({super.key, required this.todos});

  // 同じ日付かどうかを判定
  bool _isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // 日付を正規化（時間部分を除去）
  DateTime? _normalizeDate(DateTime? date) {
    if (date == null) return null;
    return DateTime(date.year, date.month, date.day);
  }

  // 順次フィルタリングでTodoをカテゴリ分け
  Map<String, List<TodoModel>> _categorizeTodos(
      List<TodoModel> allTodos,
      DateTime today,
      DateTime tomorrow,
      DateTime thisWeekSaturday,
      DateTime nextWeekSunday,
      DateTime nextWeekSaturday) {
    // 残りのTodo（未分類）
    List<TodoModel> remainingTodos = List.from(allTodos);

    // 1. 期限なしをフィルタリング
    final noDateTodos =
        remainingTodos.where((todo) => todo.dueDate == null).toList();

    // 期限なしを除外
    remainingTodos =
        remainingTodos.where((todo) => todo.dueDate != null).toList();

    // 2. 期限切れのTodoをフィルタリング
    final overdueTodos = remainingTodos.where((todo) {
      final dueDate = _normalizeDate(todo.dueDate);
      return dueDate != null && dueDate.isBefore(today);
    }).toList()
      ..sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

    // 期限切れを除外
    remainingTodos = remainingTodos.where((todo) {
      final dueDate = _normalizeDate(todo.dueDate);
      return dueDate == null || !dueDate.isBefore(today);
    }).toList();

    // 3. 今日のTodoをフィルタリング
    final todayTodos = remainingTodos
        .where((todo) => _isSameDay(_normalizeDate(todo.dueDate), today))
        .toList()
      ..sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

    // 今日を除外
    remainingTodos = remainingTodos
        .where((todo) => !_isSameDay(_normalizeDate(todo.dueDate), today))
        .toList();

    // 4. 明日のTodoをフィルタリング
    final tomorrowTodos = remainingTodos
        .where((todo) => _isSameDay(_normalizeDate(todo.dueDate), tomorrow))
        .toList()
      ..sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

    // 明日を除外
    remainingTodos = remainingTodos
        .where((todo) => !_isSameDay(_normalizeDate(todo.dueDate), tomorrow))
        .toList();

    // 5. 今週のTodoをフィルタリング (今日と明日以外の今週)
    final thisWeekTodos = remainingTodos.where((todo) {
      final dueDate = _normalizeDate(todo.dueDate);
      return dueDate != null &&
          dueDate.isAfter(tomorrow) &&
          (dueDate.isBefore(thisWeekSaturday.add(const Duration(days: 1))) ||
              _isSameDay(dueDate, thisWeekSaturday));
    }).toList()
      ..sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

    // 今週を除外
    remainingTodos = remainingTodos.where((todo) {
      final dueDate = _normalizeDate(todo.dueDate);
      return dueDate == null ||
          !dueDate.isAfter(tomorrow) ||
          !(dueDate.isBefore(thisWeekSaturday.add(const Duration(days: 1))) ||
              _isSameDay(dueDate, thisWeekSaturday));
    }).toList();

    // 6. 来週のTodoをフィルタリング (日曜〜土曜)
    final nextWeekTodos = remainingTodos.where((todo) {
      final dueDate = _normalizeDate(todo.dueDate);
      return dueDate != null &&
          (dueDate.isAfter(thisWeekSaturday) ||
              _isSameDay(dueDate, nextWeekSunday)) &&
          (dueDate.isBefore(nextWeekSaturday.add(const Duration(days: 1))) ||
              _isSameDay(dueDate, nextWeekSaturday));
    }).toList()
      ..sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

    // 来週を除外
    remainingTodos = remainingTodos.where((todo) {
      final dueDate = _normalizeDate(todo.dueDate);
      return dueDate == null ||
          !((dueDate.isAfter(thisWeekSaturday) ||
                  _isSameDay(dueDate, nextWeekSunday)) &&
              (dueDate.isBefore(
                      nextWeekSaturday.add(const Duration(days: 1))) ||
                  _isSameDay(dueDate, nextWeekSaturday)));
    }).toList();

    // 7. 残りは全て「それ以降」
    final futureTodos = remainingTodos
        .where((todo) => todo.dueDate != null)
        .toList()
      ..sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

    // 結果を格納
    return {
      'no_date': noDateTodos,
      'overdue': overdueTodos,
      'today': todayTodos,
      'tomorrow': tomorrowTodos,
      'this_week': thisWeekTodos,
      'next_week': nextWeekTodos,
      'future': futureTodos,
    };
  }

  @override
  Widget build(BuildContext context) {
    // 現在日付を取得（時間部分を除去）
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    // 日曜日始まりの週の計算（日曜=0, 月曜=1, ..., 土曜=6）
    final currentWeekday = today.weekday % 7; // 日曜日を0とする
    final daysUntilSaturday = 6 - currentWeekday; // 土曜日までの日数
    final thisWeekSaturday = today.add(Duration(days: daysUntilSaturday));
    final nextWeekSunday = thisWeekSaturday.add(const Duration(days: 1));
    final nextWeekSaturday = nextWeekSunday.add(const Duration(days: 6));

    // 順次フィルタリングを適用して各カテゴリに分類
    final categorizedTodos = _categorizeTodos(todos, today, tomorrow,
        thisWeekSaturday, nextWeekSunday, nextWeekSaturday);

    // カテゴリとその表示名
    final categories = [
      {'key': 'no_date', 'title': '期限なし'},
      {'key': 'overdue', 'title': '期限切れ'},
      {'key': 'today', 'title': '今日'},
      {'key': 'tomorrow', 'title': '明日'},
      {'key': 'this_week', 'title': '今週'},
      {'key': 'next_week', 'title': '来週'},
      {'key': 'future', 'title': 'それ以降'},
    ];

    // 各カテゴリのセクションを生成（空のカテゴリは非表示）
    final sections = categories
        .where(
            (category) => (categorizedTodos[category['key']] ?? []).isNotEmpty)
        .map((category) => TodoSection(
              title: category['title']!,
              todos: categorizedTodos[category['key']]!,
            ))
        .toList();

    return ListView(children: sections);
  }
}
