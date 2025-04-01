import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';
import 'package:todo_app/presentation/core/theme/setting_theme.dart';
import 'package:todo_app/presentation/pages/home/profile/widgets/logout_button.dart';
import 'package:todo_app/presentation/pages/home/profile/widgets/setting_item.dart';
import 'package:todo_app/presentation/providers/auth/auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'プロフィール',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'アカウント',
                style: profileTitleTextStyle,
              ),
              const SizedBox(height: 10),
              SettingItem(
                icon: Icons.person,
                title: 'アカウント設定',
                onTap: () {},
              ),
              const SizedBox(height: 5),
              SettingItem(
                icon: Icons.password,
                title: 'パスワード変更',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              const Text(
                'その他',
                style: profileTitleTextStyle,
              ),
              const SizedBox(height: 10),
              SettingItem(
                icon: Icons.book_outlined,
                title: '利用規約とポリシー',
                onTap: () {},
              ),
              const SizedBox(height: 5),
              SettingItem(
                icon: Icons.question_mark,
                title: 'ヘルプとサポート',
                onTap: () {},
              ),
              const SizedBox(height: 5),
              const Text(
                'TaskFlow バージョン 1.0.0',
                style: versionTextStyle,
              ),
              const SizedBox(height: 20),
              const LogoutButton(),
              Consumer(
                builder: (context, ref, _) {
                  final authState = ref.watch(authStateProvider);
                  return Text(
                    'ユーザー: ${authState.valueOrNull?.email ?? "未ログイン"}',
                    style: const TextStyle(fontSize: 16),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
