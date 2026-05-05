import 'package:flutter/material.dart';

void main() {
  runApp(const SettingsApp());
}

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings App',
      debugShowCheckedModeBanner: false,
  
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF007bff), // الأزرق الأساسي
          secondary: Color(0xFF74b9ff), // بيبي بلو
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF007bff)),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Color(0xFF007bff),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  int _selectedMenu = -1; // None selected by default except for ExpansionTileAnimation
  late AnimationController _controller;

  final settingsSections = [
    {
      "icon": Icons.person_outline,
      "title": "Profile",
      "route": const ProfilePage(),
    },
    {
      "icon": Icons.account_circle_outlined,
      "title": "Account",
      "route": const AccountPage(),
    },
    {
      "icon": Icons.notifications_none,
      "title": "Notifications",
      "route": const NotificationsPage(),
    },
    {
      "icon": Icons.color_lens_outlined,
      "title": "Appearance",
      "route": const AppearancePage(),
    },
    {
      "icon": Icons.headset_mic_outlined,
      "title": "Support",
      "route": const SupportPage(),
    },
    {
      "icon": Icons.security_outlined,
      "title": "Security",
      "route": const SecurityPage(),
    },
    {
      "icon": Icons.gavel_outlined,
      "title": "Legal",
      "route": const LegalPage(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedTile(int index, Map section) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _controller,
        curve: Interval(0.1 * index, 0.6 + 0.1 * index, curve: Curves.easeIn),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(0.1 * index, 0.7 + 0.1 * index, curve: Curves.easeOut),
        )),
        child: Card(
          color: _selectedMenu == index
              ? const Color(0xFF74b9ff).withOpacity(0.3)
              : Colors.white,
          elevation: 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF74b9ff).withOpacity(0.15),
              child: Icon(
                section['icon'],
                color: const Color(0xFF007bff),
              ),
            ),
            title: Text(
              section['title'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF222e50),
              ),
              textAlign: TextAlign.right,
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF007bff)),
            onTap: () async {
              setState(() {
                _selectedMenu = index;
              });
              await Future.delayed(const Duration(milliseconds: 150));
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => section['route'],
                ),
              );
              setState(() {
                _selectedMenu = -1;
              });
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 16),
                ...settingsSections
                    .asMap()
                    .entries
                    .map(
                      (e) => _buildAnimatedTile(e.key, e.value),
                    )
                    ,
                const SizedBox(height: 24),
                const LogoutSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// مثال لصفحات الإعدادات الفارغة (إضاءة فقط، عدل صفحاتك الخاصة)
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsDetailPage(
      title: "Profile",
      icon: Icons.person_outline,
      color: Color(0xFF007bff),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsDetailPage(
      title: "Account",
      icon: Icons.account_circle_outlined,
      color: Color(0xFF007bff),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsDetailPage(
      title: "الإشعارات",
      icon: Icons.notifications_none,
      color: Color(0xFF007bff),
    );
  }
}

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsDetailPage(
      title: "Appearance",
      icon: Icons.color_lens_outlined,
      color: Color(0xFF007bff),
    );
  }
}

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsDetailPage(
      title: "Support",
      icon: Icons.headset_mic_outlined,
      color: Color(0xFF007bff),
    );
  }
}

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsDetailPage(
      title: "Security",
      icon: Icons.security_outlined,
      color: Color(0xFF007bff),
    );
  }
}

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsDetailPage(
      title: "Legal",
      icon: Icons.gavel_outlined,
      color: Color(0xFF007bff),
    );
  }
}

class SettingsDetailPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  const SettingsDetailPage({super.key, 
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Hero(
          tag: title,
          child: Icon(
            icon,
            size: 120,
            color: color.withOpacity(0.35),
          ),
        ),
      ),
    );
  }
}

class LogoutSection extends StatefulWidget {
  const LogoutSection({super.key});

  @override
  State<LogoutSection> createState() => _LogoutSectionState();
}

class _LogoutSectionState extends State<LogoutSection>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  bool _isPressedLogout = false;
  bool _isPressedPrivacy = false;
  bool _isPressedContact = false;
  bool _isPressedRate = false;
  bool _isPressedShare = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildActionButton({
    required bool isPressed,
    required void Function(bool) onPressedChanged,
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    Color color = const Color(0xFF007bff),
  }) {
    return GestureDetector(
      onTapDown: (_) {
        onPressedChanged(true);
      },
      onTapUp: (_) async {
        onPressedChanged(false);
        await Future.delayed(const Duration(milliseconds: 180));
        onTap();
      },
      onTapCancel: () {
        onPressedChanged(false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        decoration: BoxDecoration(
          color: isPressed ? color : Colors.white,
          border: Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isPressed)
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 2),
                color: const Color(0xFF74b9ff).withOpacity(0.15),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isPressed ? Colors.white : color,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isPressed ? Colors.white : color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildActionButton(
              isPressed: _isPressedLogout,
              onPressedChanged: (pressed) {
                setState(() => _isPressedLogout = pressed);
              },
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: Icons.exit_to_app,
              label: "Logout",
            ),
            const SizedBox(height: 18),
            _buildActionButton(
              isPressed: _isPressedPrivacy,
              onPressedChanged: (pressed) {
                setState(() => _isPressedPrivacy = pressed);
              },
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Privacy Policy")),
                );
              },
              icon: Icons.privacy_tip_outlined,
              label: "Privacy Policy",
              color: const Color(0xFF28a745),
            ),
            const SizedBox(height: 18),
            _buildActionButton(
              isPressed: _isPressedContact,
              onPressedChanged: (pressed) {
                setState(() => _isPressedContact = pressed);
              },
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Contact Us")),
                );
              },
              icon: Icons.mail_outline,
              label: "Contact Us",
              color: const Color(0xFFfd7e14),
            ),
            const SizedBox(height: 18),
            _buildActionButton(
              isPressed: _isPressedRate,
              onPressedChanged: (pressed) {
                setState(() => _isPressedRate = pressed);
              },
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Rate the App")),
                );
              },
              icon: Icons.star_half,
              label: "Rate the App",
              color: const Color(0xFFf39c12),
            ),
            const SizedBox(height: 18),
            _buildActionButton(
              isPressed: _isPressedShare,
              onPressedChanged: (pressed) {
                setState(() => _isPressedShare = pressed);
              },
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Share the App")),
                );
              },
              icon: Icons.share,
              label: "Share the App",
              color: const Color(0xFF17a2b8),
            ),
          ],
        ),
      ),
    );
  }
}