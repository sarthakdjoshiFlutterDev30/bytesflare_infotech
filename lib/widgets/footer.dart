import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "© ${DateTime.now().year} BytesFlare Infotech. All Rights Reserved.",
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: [
              _footerLink(context, 'Privacy Policy', '/privacy-policy'),
              _footerLink(context, 'Contact Us', '/contactus'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerLink(BuildContext context, String label, String route) {
    return InkWell(
      onTap: () => Navigator.popAndPushNamed(context, route),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }
}
