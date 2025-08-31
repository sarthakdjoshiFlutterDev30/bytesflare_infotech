import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Add url_launcher to your pubspec.yaml

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "© ${DateTime.now().year} BytesFlare Infotech. All Rights Reserved.",
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: [
              _footerLink(context, 'Privacy Policy', '/privacy-policy'),
              _footerLink(context, 'Contact Us', '/contactus'),
              _footerLink(context, 'About', '/About'),
            ],
          ),
          const SizedBox(height: 16),
          _socialMediaLinks(),
        ],
      ),
    );
  }

  Widget _footerLink(BuildContext context, String label, String route) {
    return InkWell(
      onTap: () => Navigator.pushReplacementNamed(context, route),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }

  Widget _socialMediaLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.facebook, color: Colors.white70),
          onPressed: () async {
            await launchUrl(Uri.parse('https://www.facebook.com/'));
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white70),
          onPressed: () async {
            // Replace with your Twitter/X profile URL
            await launchUrl(Uri.parse('https://www.twitter.com/'));
          },
        ),
      ],
    );
  }
}
