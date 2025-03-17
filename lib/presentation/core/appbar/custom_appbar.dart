import 'package:flutter/material.dart';
import 'package:todo_app/presentation/core/theme/todo_card_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.isPositionCenter,
    this.subTitle,
    this.actions,
  });

  final String title;
  final bool isPositionCenter;
  final String? subTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            todoMainColor,
            todoSubColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: isPositionCenter == true
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: isPositionCenter == true
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...?actions,
                ],
              ),
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    subTitle!,
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(subTitle != null ? 110 : 90);
}
