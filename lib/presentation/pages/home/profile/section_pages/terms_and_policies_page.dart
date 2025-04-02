import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class TermsAndPoliciesPage extends StatefulWidget {
  const TermsAndPoliciesPage({super.key});

  @override
  TermsAndPoliciesPageState createState() => TermsAndPoliciesPageState();
}

class TermsAndPoliciesPageState extends State<TermsAndPoliciesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          '利用規約とポリシー',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                size: 16, color: Colors.black87),
          ),
          onPressed: () => context.pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4A6FFF),
          unselectedLabelColor: const Color(0xFF999999),
          indicatorColor: const Color(0xFF4A6FFF),
          tabs: const [
            Tab(text: '利用規約'),
            Tab(text: 'プライバシーポリシー'),
            Tab(text: 'データ利用'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTermsOfServiceTab(),
          _buildPrivacyPolicyTab(),
          _buildDataUsageTab(),
        ],
      ),
    );
  }

  Widget _buildTermsOfServiceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TaskFlow 利用規約',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '最終更新日: 2025年4月1日',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),
          _buildTermsSection(
            title: '1. サービスの利用について',
            content:
                'TaskFlowは、タスク管理および業務効率化のためのサービスを提供します。ユーザーは本規約に同意した上でサービスを利用するものとします。',
          ),
          _buildTermsSection(
            title: '2. アカウント登録',
            content:
                'サービス利用にはアカウント登録が必要です。登録情報は正確かつ最新の情報を提供してください。アカウント情報の管理はユーザーの責任で行ってください。',
          ),
          _buildTermsSection(
            title: '3. サービスの提供',
            content:
                'TaskFlowは、可能な限り継続的にサービスを提供するよう努めますが、システムメンテナンスやアップデート、予期せぬ障害等によりサービスを一時停止する場合があります。',
          ),
          _buildTermsSection(
            title: '4. 禁止事項',
            content:
                '以下の行為を禁止します：\n・違法行為\n・他のユーザーへの迷惑行為\n・サービスの不正利用\n・著作権侵害\n・システムへの不正アクセス',
          ),
          _buildTermsSection(
            title: '5. 知的財産権',
            content:
                'TaskFlowに関連する知的財産権はすべて当社または正当な権利者に帰属します。ユーザーは、当社の許可なく複製、改変、配布等を行うことはできません。',
          ),
          _buildTermsSection(
            title: '6. 免責事項',
            content:
                'TaskFlowは、サービスの利用により発生した損害について、当社の故意または重大な過失がある場合を除き、責任を負いません。',
          ),
          _buildTermsSection(
            title: '7. 規約の変更',
            content:
                '当社は、必要に応じて本規約を変更することがあります。変更後の規約は、当社ウェブサイトまたはアプリ内での告知により効力を生じるものとします。',
          ),
          _buildTermsSection(
            title: '8. 準拠法と管轄裁判所',
            content: '本規約の解釈および適用は日本法に準拠し、紛争が生じた場合は東京地方裁判所を第一審の専属的合意管轄裁判所とします。',
          ),
          const SizedBox(height: 30),
          _buildContactInfo(),
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'プライバシーポリシー',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '最終更新日: 2025年4月1日',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),
          _buildTermsSection(
            title: '1. 収集する情報',
            content:
                '当社は以下の情報を収集することがあります：\n・氏名、メールアドレス等の個人情報\n・デバイス情報\n・位置情報\n・利用状況に関するデータ',
          ),
          _buildTermsSection(
            title: '2. 情報の利用目的',
            content:
                '収集した情報は以下の目的で利用します：\n・サービスの提供・改善\n・ユーザーサポート\n・新機能の開発\n・マーケティング分析',
          ),
          _buildTermsSection(
            title: '3. 情報の共有',
            content:
                '当社は、法令に基づく場合や業務委託先との共有が必要な場合を除き、ユーザーの個人情報を第三者と共有することはありません。',
          ),
          _buildTermsSection(
            title: '4. セキュリティ',
            content: '当社は、ユーザー情報を保護するための適切なセキュリティ対策を講じています。',
          ),
          _buildTermsSection(
            title: '5. Cookieの使用',
            content:
                '当社は、サービス向上のためにCookieを使用しています。ブラウザの設定でCookieを無効にすることも可能ですが、一部機能が利用できなくなる場合があります。',
          ),
          _buildTermsSection(
            title: '6. ユーザーの権利',
            content:
                'ユーザーは自己の個人情報について、アクセス、訂正、削除を請求する権利を有しています。お問い合わせフォームからご連絡ください。',
          ),
          const SizedBox(height: 30),
          _buildContactInfo(),
        ],
      ),
    );
  }

  Widget _buildDataUsageTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'データ利用について',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '最終更新日: 2025年4月1日',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),
          _buildTermsSection(
            title: '1. データの保存',
            content:
                'TaskFlowでは、タスク情報、プロジェクトデータ、ユーザー設定などをクラウドサーバーに保存します。データは暗号化され、安全に管理されます。',
          ),
          _buildTermsSection(
            title: '2. データの利用',
            content:
                '収集したデータは、サービス提供、品質向上、統計分析などの目的で利用されます。個人を特定できない形に加工した統計データは、サービス改善のために利用されることがあります。',
          ),
          _buildTermsSection(
            title: '3. データのバックアップ',
            content: 'ユーザーデータは定期的にバックアップされます。バックアップデータは暗号化され、不正アクセスから保護されています。',
          ),
          _buildTermsSection(
            title: '4. データの削除',
            content:
                'アカウント削除をリクエストした場合、当社は関連するユーザーデータを削除します。ただし、法的義務の遵守や正当なビジネス目的のために一部のデータを保持する場合があります。',
          ),
          _buildTermsSection(
            title: '5. 第三者サービスとのデータ連携',
            content:
                'ユーザーの同意を得た場合、TaskFlowは外部サービス（カレンダー、メール、その他の生産性ツール）とデータを連携することがあります。連携を解除した場合、当該サービスへのデータ共有は停止されます。',
          ),
          _buildTermsSection(
            title: '6. オフライン使用時のデータ',
            content:
                'オフライン時に作成または変更されたデータは、デバイス内に一時的に保存され、インターネット接続が回復したときにサーバーと同期されます。',
          ),
          const SizedBox(height: 30),
          _buildContactInfo(),
        ],
      ),
    );
  }

  Widget _buildTermsSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'お問い合わせ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 8),
          Text(
            '本規約に関するご質問やお問い合わせは、以下の連絡先までお願いします：',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Yuki Miyake\nEメール: yukimiyake67@gmail.com',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}
