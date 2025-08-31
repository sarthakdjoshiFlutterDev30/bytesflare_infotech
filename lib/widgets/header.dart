import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ThemeProvider.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  const Header({super.key, this.height = 70});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      backgroundColor: const Color(0xFF1E2A32),
      elevation: 4,
      toolbarHeight: height,
      title: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// ✅ Left logo + title
            InkWell(
              onTap: () => Navigator.pushReplacementNamed(context, '/welcome'),
              child: Row(
                children: [
                  Image.asset('assets/image/logo.png', width: 40, height: 40),
                  const SizedBox(width: 8),
                  Text(
                    "BytesFlare Infotech",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
            ),

            /// ✅ Desktop Nav + Theme button
            if (!isMobile)
              Row(
                children: [
                  ..._navItems(context).map((item) {
                    return _buildHoverButton(
                      context,
                      item['label']!,
                      item['route']!,
                    );
                  }).toList(),

                  /// 🔘 Theme toggle button
                  IconButton(
                    icon: Icon(
                      themeProvider.themeMode == ThemeMode.light
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                  ),
                ],
              ),

            /// ✅ Mobile: Theme toggle + menu
            if (isMobile)
              Row(
                children: [
                  /// 🔘 Theme button for mobile
                  IconButton(
                    icon: Icon(
                      themeProvider.themeMode == ThemeMode.light
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                  ),

                  /// 📱 Mobile menu button
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            color: Colors.black87,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: _navItems(context).map((item) {
                                return ListTile(
                                  title: Text(
                                    item['label']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                      context,
                                      item['route']!,
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // ✅ Nav items
  List<Map<String, String>> _navItems(BuildContext context) {
    return [
      {'label': 'Home', 'route': '/welcome'},
      {'label': 'About', 'route': '/About'},
      {'label': 'Services', 'route': '/service'},
      {'label': 'Career', 'route': '/carriers'},
      {'label': 'Contact', 'route': '/contactus'},
      {'label': 'Info', 'route': '/info'},
    ];
  }

  Widget _buildHoverButton(BuildContext context, String text, String route) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, route),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
