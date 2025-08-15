import 'package:bytesflare_infotech/widgets/footer.dart';
import 'package:bytesflare_infotech/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  void _navigateTo(BuildContext context, String value) {
    switch (value) {
      case 'Home':
        Navigator.pushNamed(context, "/welcome");
        break;
      case 'Services':
        Navigator.pushNamed(context, "/service");
        break;
      case 'Info':
        Navigator.pushNamed(context, "/info");
        break;
      case 'About':
        Navigator.pushNamed(context, "/About");
        break;
      case 'ContactUs':
        Navigator.pushNamed(context, "/contactus");
        break;
    }
  }

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'bytesflare.info@gmail.com',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 10),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      ),
    ),
  );

  Widget _sectionText(String text) => Text(
    text,
    style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Header()),
      backgroundColor: const Color(0xFF1E2A32),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Navigation Menu
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                icon: const Icon(Icons.menu, color: Colors.white),
                items:
                    <String>[
                      'Home',
                      'Services',
                      'Info',
                      'About',
                      'ContactUs',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (String? value) {
                  if (value != null) _navigateTo(context, value);
                },
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "About BytesFlare Infotech",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _sectionText(
                    "BytesFlare Infotech is a leading provider of innovative digital solutions, "
                    "specializing in mobile and web application development. Our mission is to empower "
                    "businesses by delivering high-quality, user-friendly applications that drive growth "
                    "and enhance user engagement.",
                  ),
                  _sectionTitle("Our Mission"),
                  _sectionText(
                    "To provide cutting-edge technology solutions that help businesses thrive in the digital age.",
                  ),
                  _sectionTitle("Our Vision"),
                  _sectionText(
                    "To be a global leader in digital solutions, recognized for our commitment to quality, "
                    "innovation, and customer satisfaction.",
                  ),
                  _sectionTitle("Our Values"),
                  _sectionText(
                    "• Integrity: We uphold the highest standards of integrity in all our actions.\n"
                    "• Innovation: We strive to innovate and improve our services continuously.\n"
                    "• Customer Focus: Our customers are at the heart of everything we do.\n"
                    "• Collaboration: We believe in teamwork and collaboration to achieve our goals.\n"
                    "• Excellence: We are committed to delivering excellence in every project.",
                  ),
                  _sectionTitle("Contact Us"),
                  _sectionText(
                    "For inquiries or to learn more about our services, please contact us:",
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: _launchEmail,
                    icon: const Icon(Icons.email, color: Colors.orange),
                    label: const Text(
                      "bytesflare.info@gmail.com",
                      style: TextStyle(fontSize: 16, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Footer(),
        ],
      ),
    );
  }
}
