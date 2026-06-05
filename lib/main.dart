import 'package:flutter/material.dart';

void main() {
  runApp(const DarkTechApp());
}

// ══════════════════════════════════════════
//  暗黑科技配色 · Dark Tech Color Palette
// ══════════════════════════════════════════
class DTColor {
  // 黑色阶
  static const void_   = Color(0xFF0A0A0A); // 纯黑底色
  static const abyss   = Color(0xFF111111); // 深渊黑
  static const surface  = Color(0xFF1A1A1A); // 卡片表面
  static const surface2 = Color(0xFF222222); // 卡片表面2
  static const border  = Color(0xFF333333); // 边框

  // 白色阶
  static const textPrimary   = Color(0xFFEEEEEE); // 主文字
  static const textSecondary = Color(0xFFAAAAAA); // 次要文字
  static const textMuted    = Color(0xFF666666); // 静默文字

  // 金色阶
  static const gold    = Color(0xFFD4AF37); // 主金
  static const goldB   = Color(0xFFF5D76E); // 亮金
  static const goldDim = Color(0xFF8B7612); // 暗金

  // 功能色
  static const green  = Color(0xFF2ECC71); // 完成绿
  static const orange = Color(0xFFE67E22); // 进行中橙
  static const blue   = Color(0xFF3498DB); // 信息蓝
}

// ══════════════════════════════════════════
//  主应用
// ══════════════════════════════════════════
class DarkTechApp extends StatelessWidget {
  const DarkTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 创新实验 · 暗黑主题',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary:   DTColor.gold,
          secondary: DTColor.blue,
          surface:   DTColor.surface,
          onSurface: DTColor.textPrimary,
        ),
        scaffoldBackgroundColor: DTColor.void_,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: DTColor.gold),
          titleTextStyle: const TextStyle(
            color: DTColor.gold,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            fontSize: 17,
            shadows: [
              Shadow(color: DTColor.goldDim, blurRadius: 10),
            ],
          ),
        ),
        cardTheme: CardThemeData(
          color: DTColor.surface.withValues(alpha: 0.92),
          elevation: 16,
          shadowColor: Colors.black.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: DTColor.gold.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          margin: EdgeInsets.zero,
        ),
        dividerTheme: DividerThemeData(
          color: DTColor.border.withValues(alpha: 0.5),
          thickness: 0.5,
          space: 20,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: DTColor.abyss,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: DTColor.gold, width: 0.4),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

// ══════════════════════════════════════════
//  主页
// ══════════════════════════════════════════
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulse;

  // 等级系统
  static const List<_Level> _levels = [
    _Level(0,   '入门',    DTColor.textMuted),
    _Level(5,   '进阶',    DTColor.blue),
    _Level(15,  '熟练',    DTColor.goldDim),
    _Level(30,  '精通',    DTColor.gold),
    _Level(50,  '专家',    DTColor.goldB),
    _Level(100, '大师',    DTColor.goldB),
  ];

  _Level get _currentLevel {
    for (int i = _levels.length - 1; i >= 0; i--) {
      if (_counter >= _levels[i].threshold) return _levels[i];
    }
    return _levels.first;
  }

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _increment() {
    setState(() => _counter++);
    if (!mounted) return;
    final level = _currentLevel;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: DTColor.gold, size: 20),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                '计数 +1  当前等级：$level',
                style: const TextStyle(color: DTColor.textPrimary, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ─── 背景装饰 ────────────────────────
  List<Widget> _bgDecorations() => [
    Positioned(
      top: 60,
      right: -30,
      child: Transform.rotate(
        angle: -0.25,
        child: Text('FL',
          style: TextStyle(
            fontSize: 130,
            fontWeight: FontWeight.w900,
            color: DTColor.gold.withValues(alpha: 0.03),
          ),
        ),
      ),
    ),
    Positioned(
      top: 220,
      left: -20,
      child: Transform.rotate(
        angle: 0.15,
        child: Text('UT',
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.w900,
            color: DTColor.border.withValues(alpha: 0.05),
          ),
        ),
      ),
    ),
    Positioned(
      bottom: 100,
      right: -10,
      child: Transform.rotate(
        angle: -0.1,
        child: Text('ER',
          style: TextStyle(
            fontSize: 90,
            fontWeight: FontWeight.w900,
            color: DTColor.border.withValues(alpha: 0.04),
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,

      // ─── 顶栏 ────────────────────────────
      appBar: AppBar(
        title: const Text('⚔ Flutter 创新实验'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, size: 22),
            tooltip: '关于',
            onPressed: _showAbout,
          ),
        ],
      ),

      // ─── 主体 ────────────────────────────
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.3, -0.45),
            radius: 1.8,
            colors: [DTColor.abyss, DTColor.void_],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              ..._bgDecorations(),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    _buildEmblem(),
                    const SizedBox(height: 28),
                    _buildIdentity(),
                    const SizedBox(height: 16),
                    _buildCounter(w),
                    const SizedBox(height: 16),
                    _buildSkills(),
                    const SizedBox(height: 16),
                    _buildTasks(),
                    const SizedBox(height: 16),
                    _buildQuote(),
                    const SizedBox(height: 24),
                    _buildFooter(),
                    const SizedBox(height: 96),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ─── 悬浮按钮 ────────────────────────
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // ─── 关于对话框 ─────────────────────────
  void _showAbout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: DTColor.abyss,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: DTColor.gold, width: 0.5),
        ),
        title: const Row(
          children: [
            Icon(Icons.code, color: DTColor.gold, size: 22),
            SizedBox(width: 10),
            Text('关于此应用', style: TextStyle(color: DTColor.gold, fontSize: 16)),
          ],
        ),
        content: const Text(
          'Flutter 第14周创新实验\n'
          '暗黑主题个性化版本\n\n'
          '开发者：马梓杭\n'
          '学号：0267  ·  第7组\n\n'
          '「用代码构建所见，用逻辑驱动世界。」',
          style: TextStyle(color: DTColor.textPrimary, height: 1.7, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('了解', style: TextStyle(color: DTColor.gold, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════
  //  Section: 徽章
  // ══════════════════════════════════════════
  Widget _buildEmblem() {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (_, _) => Column(
        children: [
          // 发光徽章
          Container(
            width: 108,
            height: 108,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  DTColor.gold.withValues(alpha: 0.15 * _pulse.value),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: DTColor.gold.withValues(alpha: 0.4 * _pulse.value),
                  blurRadius: 48 * _pulse.value,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.flutter_dash,
                size: 54,
                color: DTColor.gold,
                shadows: [Shadow(color: DTColor.gold, blurRadius: 16)],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 标题（金色渐变）
          ShaderMask(
            shaderCallback: (b) => const LinearGradient(
              colors: [DTColor.textSecondary, DTColor.gold, DTColor.goldB],
            ).createShader(b),
            child: const Text(
              'F L U T T E R',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 8,
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text('第14周 · 创新实验',
            style: TextStyle(fontSize: 13, color: DTColor.textMuted, letterSpacing: 2)),
          const SizedBox(height: 8),

          // Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: DTColor.gold.withValues(alpha: 0.3)),
              gradient: LinearGradient(
                colors: [
                  DTColor.border.withValues(alpha: 0.3),
                  DTColor.surface2.withValues(alpha: 0.15),
                ],
              ),
            ),
            child: const Text('暗黑主题版',
              style: TextStyle(
                color: DTColor.gold,
                fontSize: 12,
                letterSpacing: 3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════
  //  Section: 身份卡
  // ══════════════════════════════════════════
  Widget _buildIdentity() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(Icons.person, '个人信息', 'PROFILE'),
            const SizedBox(height: 16),
            _infoRow('姓名', '马梓杭'),
            _sep(),
            _infoRow('学号', '0267'),
            _sep(),
            _infoRow('分组', '第 7 组'),
            _sep(),
            _infoRow('方向', 'Flutter · Dart · Git'),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════
  //  Section: 计数器
  // ══════════════════════════════════════════
  Widget _buildCounter(double sw) {
    final progress = (_counter / 100).clamp(0.0, 1.0);
    final level = _currentLevel;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(Icons.bar_chart, '完成进度', 'PROGRESS'),
            const SizedBox(height: 16),

            // 计数 + 等级
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$_counter',
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w900,
                    color: DTColor.gold,
                    shadows: [Shadow(color: DTColor.goldDim, blurRadius: 12)],
                  ),
                ),
                const SizedBox(width: 8),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('次点击',
                    style: TextStyle(color: DTColor.textMuted, fontSize: 16)),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [
                        level.color.withValues(alpha: 0.2),
                        level.color.withValues(alpha: 0.06),
                      ]),
                      border: Border.all(color: level.color.withValues(alpha: 0.4)),
                    ),
                    child: Text(level.title,
                      style: TextStyle(
                        color: level.color, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // 进度条
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: DTColor.void_,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: DTColor.border.withValues(alpha: 0.5)),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    width: sw * 0.72 * progress,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [DTColor.goldDim, DTColor.gold]),
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: DTColor.gold.withValues(alpha: 0.3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  if (_counter >= 100)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [DTColor.gold, DTColor.goldB]),
                          borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0',   style: TextStyle(color: DTColor.textMuted, fontSize: 10)),
                Text('100',  style: TextStyle(color: DTColor.textMuted, fontSize: 10)),
              ],
            ),

            if (_counter > 0 && _counter < 100) ...[
              const SizedBox(height: 6),
              Text('距离下一等级还需 ${100 - _counter} 次',
                style: const TextStyle(
                  color: DTColor.textSecondary,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            if (_counter >= 100) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [DTColor.abyss, DTColor.surface2]),
                ),
                child: const Center(
                  child: Text('★ 已达最高等级 · 大师 ★',
                    style: TextStyle(
                      color: DTColor.gold,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════
  //  Section: 技能面板
  // ══════════════════════════════════════════
  Widget _buildSkills() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(Icons.code, '技能面板', 'SKILLS'),
            const SizedBox(height: 16),
            _statBar('Flutter', 0.72, '熟练',  DTColor.blue),
            const SizedBox(height: 14),
            _statBar('Dart',    0.65, '良好',  DTColor.blue),
            const SizedBox(height: 14),
            _statBar('Git',     0.80, '精通',  DTColor.gold),
            const SizedBox(height: 14),
            _statBar('UI 设计', 0.90, '专家',  DTColor.green),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════
  //  Section: 任务日志
  // ══════════════════════════════════════════
  Widget _buildTasks() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(Icons.menu_book, '任务日志', 'TASK LOG'),
            const SizedBox(height: 16),
            _taskItem('Flutter 环境搭建',    '已完成', '2026-06-06', DTColor.gold,  Icons.build),
            _sep(),
            _taskItem('个性化页面修改',        '已完成', '2026-06-06', DTColor.green, Icons.edit),
            _sep(),
            _taskItem('暗黑主题魔改',          '已完成', '2026-06-06', DTColor.blue,  Icons.dark_mode),
            _sep(),
            _taskItem('GitHub 提交检查',       '待执行', '2026-06-06', DTColor.textMuted, Icons.upload),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════
  //  Section: 箴言
  // ══════════════════════════════════════════
  Widget _buildQuote() {
    const quotes = [
      '「任何足够先进的技术，都与魔法无异。——阿瑟·克拉克」',
      '「代码写得好，是最好的文档。」',
      '「简单是可靠的先决条件。」',
      '「先让它能跑，再让它跑对，最后让它跑快。」',
    ];
    final q = quotes[_counter % quotes.length];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _rune('◆'),
                const SizedBox(width: 14),
                const Icon(Icons.format_quote, color: DTColor.gold, size: 18),
                const SizedBox(width: 14),
                _rune('◆'),
              ],
            ),
            const SizedBox(height: 10),
            Text(q,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: DTColor.textSecondary,
                fontSize: 13,
                fontStyle: FontStyle.italic,
                letterSpacing: 1,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(44, (_) => Container(
                width: 4, height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 1.3),
                color: DTColor.border.withValues(alpha: 0.35),
              )),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════
  //  Section: 页脚
  // ══════════════════════════════════════════
  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _rune('◆'),
            const SizedBox(width: 16),
            _rune('◆'),
            const SizedBox(width: 16),
            _rune('◆'),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          '「用代码构建所见，用逻辑驱动世界。」',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: DTColor.textSecondary,
            fontSize: 12,
            fontStyle: FontStyle.italic,
            letterSpacing: 1,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Flutter 3.44.1 · Dart 3.9 · 马梓杭 0267 · 第7组',
          style: TextStyle(color: DTColor.textMuted, fontSize: 10, letterSpacing: 1),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ══════════════════════════════════════════
  //  FAB
  // ══════════════════════════════════════════
  Widget _buildFAB() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: DTColor.gold.withValues(alpha: 0.4),
            blurRadius: 22,
            spreadRadius: 2,
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: _increment,
        icon: const Icon(Icons.add, color: DTColor.void_, size: 22),
        label: const Text('点击计数',
          style: TextStyle(
            color: DTColor.void_,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 15,
          ),
        ),
        backgroundColor: DTColor.gold,
        elevation: 0,
      ),
    );
  }

  // ══════════════════════════════════════════
  //  Helpers
  // ══════════════════════════════════════════
  Widget _sectionHeader(IconData icon, String zh, String en) {
    return Row(
      children: [
        Icon(icon, color: DTColor.gold, size: 18),
        const SizedBox(width: 8),
        Text(en,
          style: const TextStyle(
            color: DTColor.gold,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        const Spacer(),
        Container(width: 28, height: 1, color: DTColor.gold.withValues(alpha: 0.25)),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text(label,
          style: const TextStyle(
            color: DTColor.textMuted, fontSize: 14, letterSpacing: 1.5)),
        const Spacer(),
        Text(value,
          style: const TextStyle(
            color: DTColor.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _sep() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Divider(color: DTColor.border.withValues(alpha: 0.4), height: 1),
  );

  Widget _statBar(String label, double frac, String rank, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
              style: const TextStyle(
                color: DTColor.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
            Text(rank,
              style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: DTColor.void_,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: DTColor.border.withValues(alpha: 0.4)),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: frac,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withValues(alpha: 0.65), color]),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 4),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _taskItem(String title, String status, String date, Color color, IconData icon) {
    return Row(
      children: [
        Container(
          width: 38, height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.12),
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                style: const TextStyle(
                  color: DTColor.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
              Text(date,
                style: const TextStyle(color: DTColor.textMuted, fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color.withValues(alpha: 0.1),
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: Text(status,
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _rune(String s) => Text(
    s,
    style: TextStyle(color: DTColor.gold.withValues(alpha: 0.45), fontSize: 16),
  );
}

// ══════════════════════════════════════════
//  等级数据类
// ══════════════════════════════════════════
class _Level {
  final int threshold;
  final String title;
  final Color color;
  const _Level(this.threshold, this.title, this.color);
}
