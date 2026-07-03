import 'package:flutter/material.dart';

void main() {
  runApp(const GroupTopicApp());
}

class GroupTopicApp extends StatelessWidget {
  const GroupTopicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CXSY Group Topic Site',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
        useMaterial3: true,
        fontFamily: 'Microsoft YaHei',
      ),
      home: const GroupTopicHomePage(),
    );
  }
}

class GroupTopicHomePage extends StatefulWidget {
  const GroupTopicHomePage({super.key});

  @override
  State<GroupTopicHomePage> createState() => _GroupTopicHomePageState();
}

class _GroupTopicHomePageState extends State<GroupTopicHomePage> {
  int evidenceCount = 3;

  void addEvidenceCheck() {
    setState(() {
      evidenceCount = (evidenceCount + 1).clamp(0, 8);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('创新实验三 · 小组专题网站'),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: Icon(Icons.public_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _HeroSection(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 110),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SectionTitle(
                        eyebrow: '01 / 实验目标',
                        title: '围绕小组专题完成本地运行与网页展示',
                        trailing: Text(
                          '$evidenceCount / 8',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const _GoalGrid(),
                      const SizedBox(height: 28),
                      const _SectionTitle(
                        eyebrow: '02 / 小组分工',
                        title: '成员贡献与协作记录',
                      ),
                      const SizedBox(height: 14),
                      const _MemberTable(),
                      const SizedBox(height: 28),
                      const _SectionTitle(
                        eyebrow: '03 / 本地运行',
                        title: 'Flutter Web 运行命令',
                      ),
                      const SizedBox(height: 14),
                      const _RunCommandCard(),
                      const SizedBox(height: 28),
                      _SectionTitle(
                        eyebrow: '04 / 证据清单',
                        title: '报告截图与仓库材料',
                        trailing: FilledButton.icon(
                          onPressed: addEvidenceCheck,
                          icon: const Icon(Icons.add_task_rounded, size: 18),
                          label: const Text('确认一项'),
                        ),
                      ),
                      const SizedBox(height: 14),
                      _EvidencePanel(count: evidenceCount),
                      const SizedBox(height: 28),
                      const _SectionTitle(
                        eyebrow: '05 / 思考题',
                        title: 'Jekyll 与静态网站边界',
                      ),
                      const SizedBox(height: 14),
                      const _ReflectionCard(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addEvidenceCheck,
        icon: const Icon(Icons.check_rounded),
        label: const Text('补充证据'),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 56),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1D4ED8), Color(0xFF0F766E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Wrap(
            spacing: 36,
            runSpacing: 24,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 620,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Badge(text: 'CXSY Group · Flutter Web'),
                    const SizedBox(height: 18),
                    const Text(
                      '小组专题网站运行展示',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        height: 1.12,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '本页面用于创新实验三报告中的“小组专题网站”部分，集中展示项目分工、运行方式、截图证据和静态网站技术思考。',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.86),
                        fontSize: 17,
                        height: 1.65,
                      ),
                    ),
                  ],
                ),
              ),
              const _HeroStats(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroStats extends StatelessWidget {
  const _HeroStats();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatLine(label: '仓库', value: 'WeatheRe1/CXSY-group-'),
          _StatLine(label: '技术', value: 'Flutter Web'),
          _StatLine(label: '运行', value: 'localhost:8080'),
          _StatLine(label: '任务', value: '专题网站展示'),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final Widget? trailing;

  const _SectionTitle({
    required this.eyebrow,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow,
                style: const TextStyle(
                  color: Color(0xFF2563EB),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF172033),
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _GoalGrid extends StatelessWidget {
  const _GoalGrid();

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.article_rounded, '过程记录', '记录小组仓库、运行命令和页面修改依据。'),
      (Icons.web_rounded, '网页展示', '完成专题页本地运行，形成可截图网页证据。'),
      (Icons.groups_rounded, '协作分工', '说明成员贡献，体现真实协作和版本管理。'),
      (Icons.verified_rounded, '规范提交', '保留代码截图、命令行截图和 GitHub 提交记录。'),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 760;
        return GridView.count(
          crossAxisCount: isWide ? 4 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: isWide ? 1.18 : 1.08,
          children: [
            for (final item in items)
              _InfoCard(icon: item.$1, title: item.$2, body: item.$3),
          ],
        );
      },
    );
  }
}

class _MemberTable extends StatelessWidget {
  const _MemberTable();

  @override
  Widget build(BuildContext context) {
    return _Surface(
      child: Column(
        children: const [
          _TableRowLine(
              name: 'mingxi',
              github: '@youmaguijiang112',
              work: 'Flutter 界面个性化设计与开发'),
          Divider(height: 24),
          _TableRowLine(
              name: '刘锦耀',
              github: '@usedare',
              work: '专题网站运行验证、报告证据整理与 GitHub Pages 博客部分'),
        ],
      ),
    );
  }
}

class _RunCommandCard extends StatelessWidget {
  const _RunCommandCard();

  @override
  Widget build(BuildContext context) {
    return const _Surface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CodeLine('flutter pub get'),
          _CodeLine('flutter run -d chrome --web-port 8080'),
          SizedBox(height: 14),
          Text(
            '运行后在浏览器访问 http://localhost:8080。报告中需要截取命令行启动成功画面、页面首页和 GitHub 仓库提交记录。',
            style: TextStyle(color: Color(0xFF526070), height: 1.7),
          ),
        ],
      ),
    );
  }
}

class _EvidencePanel extends StatelessWidget {
  final int count;

  const _EvidencePanel({required this.count});

  @override
  Widget build(BuildContext context) {
    final progress = count / 8;
    return _Surface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0), minHeight: 10),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _EvidenceBadge(text: '代码截图'),
              _EvidenceBadge(text: '命令行截图'),
              _EvidenceBadge(text: '网页截图'),
              _EvidenceBadge(text: '仓库截图'),
              _EvidenceBadge(text: '提交记录'),
              _EvidenceBadge(text: '分工说明'),
              _EvidenceBadge(text: '思考题'),
              _EvidenceBadge(text: '总结体会'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReflectionCard extends StatelessWidget {
  const _ReflectionCard();

  @override
  Widget build(BuildContext context) {
    return const _Surface(
      child: Text(
        'Jekyll 适合个人博客、项目文档和课程专题页等以内容展示为主的网站；不适合实时聊天、支付订单、权限复杂的后台系统和强事务业务。静态网站开发虽然部署简单，但仍要保证截图真实、素材合规、引用规范，并通过 Git 记录小组协作过程。',
        style: TextStyle(
          color: Color(0xFF334155),
          fontSize: 16,
          height: 1.8,
        ),
      ),
    );
  }
}

class _Surface extends StatelessWidget {
  final Widget child;

  const _Surface({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5EAF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return _Surface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF2563EB), size: 30),
          const SizedBox(height: 12),
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
          const SizedBox(height: 8),
          Text(body,
              style: const TextStyle(color: Color(0xFF64748B), height: 1.45)),
        ],
      ),
    );
  }
}

class _TableRowLine extends StatelessWidget {
  final String name;
  final String github;
  final String work;

  const _TableRowLine({
    required this.name,
    required this.github,
    required this.work,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 90,
            child: Text(name,
                style: const TextStyle(fontWeight: FontWeight.w900))),
        SizedBox(
            width: 170,
            child:
                Text(github, style: const TextStyle(color: Color(0xFF2563EB)))),
        Expanded(
            child:
                Text(work, style: const TextStyle(color: Color(0xFF526070)))),
      ],
    );
  }
}

class _CodeLine extends StatelessWidget {
  final String text;

  const _CodeLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFE2E8F0),
          fontFamily: 'Consolas',
          fontSize: 14,
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;

  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _EvidenceBadge extends StatelessWidget {
  final String text;

  const _EvidenceBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF1D4ED8),
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _StatLine extends StatelessWidget {
  final String label;
  final String value;

  const _StatLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 58,
            child: Text(label,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.68))),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
