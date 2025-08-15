import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  const Header({super.key, this.height = 70});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      toolbarHeight: height,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
          if (!isMobile)
            Row(
              children: _navItems(context).map((item) {
                return _buildHoverButton(
                  context,
                  item['label']!,
                  item['route']!,
                );
              }).toList(),
            ),
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _navItems(context).map((item) {
                          return ListTile(
                            title: Text(
                              item['label']!,
                              style: const TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              Navigator.pop(context); // close sheet
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
    );
  }

  // Updated to match your provided route names
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
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
