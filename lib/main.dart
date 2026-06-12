import 'package:flutter/material.dart';

void main() {
  runApp(const BookTrackerApp());
}

// ============================================================
// App Root
// ============================================================

class BookTrackerApp extends StatelessWidget {
  const BookTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '阅读追踪 - 刘锦耀',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8D6E63),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFDF6EC),
        fontFamily: 'Roboto',
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: const ReadingHomePage(),
    );
  }
}

// ============================================================
// Color Palette
// ============================================================

class AppColors {
  static const warmBrown = Color(0xFF8D6E63);
  static const deepBrown = Color(0xFF3E2723);
  static const lightBrown = Color(0xFF6D4C41);
  static const gold = Color(0xFFFFB300);
  static const cream = Color(0xFFFDF6EC);
  static const parchment = Color(0xFFF5ECD7);
  static const amber100 = Color(0xFFFFECB3);
  static const amber700 = Color(0xFFFF8F00);

  static const bookColors = [
    Color(0xFFC62828), // 红
    Color(0xFF1565C0), // 蓝
    Color(0xFF2E7D32), // 绿
    Color(0xFF6A1B9A), // 紫
    Color(0xFFE65100), // 橙
    Color(0xFF00838F), // 青
    Color(0xFFAD1457), // 玫红
    Color(0xFF4E342E), // 深棕
    Color(0xFF283593), // 靛蓝
    Color(0xFF558B2F), // 草绿
  ];
}

// ============================================================
// Main Home Page
// ============================================================

class ReadingHomePage extends StatefulWidget {
  const ReadingHomePage({super.key});

  @override
  State<ReadingHomePage> createState() => _ReadingHomePageState();
}

class _ReadingHomePageState extends State<ReadingHomePage>
    with SingleTickerProviderStateMixin {
  int _booksRead = 0;
  static const int _goal = 10;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onBookCompleted() {
    if (_booksRead >= _goal) return;
    setState(() => _booksRead++);
    _scaleController.forward(from: 0);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _booksRead >= _goal
              ? '恭喜！目标达成！你是最棒的阅读者！'
              : '又读完一本！继续加油！已读 $_booksRead 本',
        ),
        backgroundColor:
            _booksRead >= _goal ? AppColors.gold : AppColors.warmBrown,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _getMotivationText() {
    if (_booksRead >= 10) return '目标达成！你是阅读之星！';
    if (_booksRead >= 8) return '即将完成目标，冲刺！';
    if (_booksRead >= 5) return '半程达成！阅读是最好的习惯！';
    if (_booksRead >= 3) return '不错！你已经读了$_booksRead本，继续加油！';
    if (_booksRead >= 1) return '好的开始！坚持阅读，你会收获更多！';
    return '书海无涯，开始你的阅读之旅吧！';
  }

  Map<String, String> _getQuote() {
    final quotes = [
      {'text': '读书破万卷，下笔如有神。', 'author': '杜甫'},
      {'text': '书籍是人类进步的阶梯。', 'author': '高尔基'},
      {'text': '读万卷书，行万里路。', 'author': '董其昌'},
      {
        'text': 'The more that you read, the more things you will know.',
        'author': 'Dr. Seuss',
      },
    ];
    return quotes[_booksRead % quotes.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _booksRead < _goal
          ? FloatingActionButton.extended(
              onPressed: _onBookCompleted,
              backgroundColor: AppColors.warmBrown,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.auto_stories),
              label: const Text('读完一本', style: TextStyle(fontSize: 16)),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildProfileCard(),
            const SizedBox(height: 16),
            _buildBookStack(),
            const SizedBox(height: 16),
            _buildStatsCard(),
            const SizedBox(height: 16),
            _buildCategories(),
            const SizedBox(height: 16),
            _buildQuoteCard(),
            const SizedBox(height: 16),
            _buildFooter(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------
  // 1. Header Banner
  // --------------------------------------------------------
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFD84315), Color(0xFFFF8F00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
      child: Column(
        children: [
          const Icon(Icons.menu_book_rounded, size: 56, color: Colors.white),
          const SizedBox(height: 12),
          const Text(
            'Hello, Flutter!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '第14周 · 阅读追踪任务',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------
  // 2. Profile Card (书签风格)
  // --------------------------------------------------------
  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Bookmark ribbon
              Container(
                width: 8,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.warmBrown, AppColors.gold],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Profile content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.amber100,
                            child: const Icon(
                              Icons.person,
                              color: AppColors.warmBrown,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '刘锦耀',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.deepBrown,
                                  ),
                                ),
                                Text(
                                  '阅读爱好者',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.lightBrown,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildInfoChip(Icons.badge, '学号 0115'),
                          const SizedBox(width: 8),
                          _buildInfoChip(Icons.group, '第07组'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.parchment,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.warmBrown),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.lightBrown,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------
  // 3. Book Stack (书堆可视化 - 核心特色)
  // --------------------------------------------------------
  Widget _buildBookStack() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.local_library,
                      color: AppColors.warmBrown, size: 20),
                  SizedBox(width: 8),
                  Text(
                    '我的书架',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepBrown,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_booksRead == 0)
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.parchment,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.warmBrown.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '还没有读过的书，快开始吧！',
                      style: TextStyle(
                          color: AppColors.lightBrown, fontSize: 14),
                    ),
                  ),
                )
              else
                AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.warmBrown,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 6,
                        runSpacing: 0,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: List.generate(_booksRead, (index) {
                          return AnimatedBuilder(
                            animation: _scaleAnimation,
                            builder: (context, child) {
                              final bool isNew = index == _booksRead - 1;
                              return Transform.scale(
                                scale: isNew ? _scaleAnimation.value : 1.0,
                                child: child,
                              );
                            },
                            child: _buildSingleBook(index),
                          );
                        }),
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

  Widget _buildSingleBook(int index) {
    final color = AppColors.bookColors[index % AppColors.bookColors.length];
    final heights = [
      36.0, 42.0, 38.0, 44.0, 40.0, 35.0, 41.0, 37.0, 43.0, 39.0
    ];
    final bookHeight = heights[index % heights.length];
    final rotation = (index % 3 - 1) * 0.03;

    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: 28,
        height: bookHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(3),
            bottomLeft: Radius.circular(3),
            topRight: Radius.circular(1),
            bottomRight: Radius.circular(1),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 3),
          width: 3,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------
  // 4. Stats Card
  // --------------------------------------------------------
  Widget _buildStatsCard() {
    final progress = _booksRead / _goal;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      );
                    },
                    child: Text(
                      '$_booksRead',
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: AppColors.warmBrown,
                        height: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, left: 4),
                    child: Text(
                      '/ $_goal 本',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.lightBrown,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 12,
                  backgroundColor: AppColors.parchment,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress >= 1.0 ? AppColors.gold : AppColors.warmBrown,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.lightBrown,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  _getMotivationText(),
                  key: ValueKey(_booksRead),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.deepBrown,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------
  // 5. Categories
  // --------------------------------------------------------
  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '阅读分类',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepBrown,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryItem(
                      Icons.auto_stories, '文学', AppColors.bookColors[0]),
                  _buildCategoryItem(
                      Icons.science, '科技', AppColors.bookColors[1]),
                  _buildCategoryItem(
                      Icons.history_edu, '历史', AppColors.bookColors[2]),
                  _buildCategoryItem(
                      Icons.psychology, '哲学', AppColors.bookColors[3]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.lightBrown,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------
  // 6. Quote Card
  // --------------------------------------------------------
  Widget _buildQuoteCard() {
    final quote = _getQuote();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: AppColors.parchment,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(
                Icons.format_quote,
                size: 32,
                color: AppColors.warmBrown,
              ),
              const SizedBox(height: 8),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: Text(
                  '"${quote['text']}"',
                  key: ValueKey(_booksRead),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: AppColors.deepBrown,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.warmBrown.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '— ${quote['author']}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.lightBrown,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------
  // 7. Footer
  // --------------------------------------------------------
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Divider(color: AppColors.warmBrown.withValues(alpha: 0.2)),
          const SizedBox(height: 12),
          Text(
            '云南大学 · 创新实验 · 2025-2026学年',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.lightBrown.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '刘锦耀 · 学号0115 · 第07组',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.lightBrown.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
