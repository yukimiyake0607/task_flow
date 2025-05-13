import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/common_widgets/appbar/custom_appbar.dart';
import 'package:todo_app/src/constants/setting_theme.dart';
import 'package:todo_app/src/features/profile/presentation/widgets/logout_button.dart';
import 'package:todo_app/src/features/profile/presentation/widgets/setting_item.dart';
import 'package:todo_app/src/features/authentication/data/auth_provider.dart';
import 'package:todo_app/src/routing/router.dart';

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
              Consumer(
                builder: (context, ref, _) {
                  final authState = ref.watch(authStateProvider);
                  return SettingItem(
                    icon: Icons.person,
                    title: authState.valueOrNull?.email ?? '未ログイン',
                    onTap: () {
                      context.pushNamed(AppRoute.emailSetting.name);
                    },
                  );
                },
              ),
              const SizedBox(height: 5),
              SettingItem(
                icon: Icons.password,
                title: 'パスワード変更',
                onTap: () {
                  context.pushNamed(AppRoute.passwordSetting.name);
                },
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
                onTap: () {
                  context.pushNamed(AppRoute.termsPolicies.name);
                },
              ),
              const SizedBox(height: 5),
              SettingItem(
                icon: Icons.question_mark,
                title: 'ヘルプとサポート',
                onTap: () {
                  context.pushNamed(AppRoute.helpSupport.name);
                },
              ),
              const SizedBox(height: 5),
              const Text(
                'TaskFlow バージョン 1.0.0',
                style: versionTextStyle,
              ),
              const SizedBox(height: 20),
              const LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
