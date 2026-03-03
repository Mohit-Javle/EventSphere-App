import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../providers/theme_provider.dart';
import '../../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme/es_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "Appearance",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SwitchListTile(
            title: const Text("Dark mode"),
            subtitle: const Text("Toggle between light and dark themes"),
            value: isDark,
            activeThumbColor: EsColors.primary,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "Notifications",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SwitchListTile(
            title: const Text("Push notifications"),
            value: true,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text("Email updates"),
            value: false,
            onChanged: (value) {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(LucideIcons.languages, color: EsColors.textMuted),
            title: const Text("Language"),
            trailing: const Text("English (US)", style: TextStyle(color: EsColors.primary)),
            onTap: () => _showLanguageDialog(context),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text("Account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
          ),
          ListTile(
            leading: const Icon(LucideIcons.logOut, color: EsColors.accent),
            title: const Text("Log Out", style: TextStyle(color: EsColors.accent)),
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: EsColors.bgSurface,
        title: const Text("Select Language"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ["English (US)", "Hindi", "Spanish", "French"].map((lang) => ListTile(
            title: Text(lang),
            trailing: lang == "English (US)" ? const Icon(LucideIcons.check, color: EsColors.primary) : null,
            onTap: () => Navigator.pop(context),
          )).toList(),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: EsColors.bgSurface,
        title: const Text("Log Out?"),
        content: const Text("Are you sure you want to log out of EventSphere?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.go('/login');
            },
            child: const Text("Log Out", style: TextStyle(color: EsColors.accent)),
          ),
        ],
      ),
    );
  }
}
