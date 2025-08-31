import 'package:bytesflare_infotech/widgets/footer.dart';
import 'package:bytesflare_infotech/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Header()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About BytesFlare Infotech",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _sectionText(
                        context,
                        "BytesFlare Infotech is a leading provider of innovative digital solutions, "
                        "specializing in mobile and web application development. Our mission is to empower "
                        "businesses by delivering high-quality, user-friendly applications that drive growth "
                        "and enhance user engagement.",
                      ),
                      _sectionTitle(context, "Our Mission"),
                      _sectionText(
                        context,
                        "To provide cutting-edge technology solutions that help businesses thrive in the digital age.",
                      ),
                      _sectionTitle(context, "Our Vision"),
                      _sectionText(
                        context,
                        "To be a global leader in digital solutions, recognized for our commitment to quality, "
                        "innovation, and customer satisfaction.",
                      ),
                      _sectionTitle(context, "Our Values"),
                      _sectionText(
                        context,
                        "• Integrity: We uphold the highest standards of integrity in all our actions.\n"
                        "• Innovation: We strive to innovate and improve our services continuously.\n"
                        "• Customer Focus: Our customers are at the heart of everything we do.\n"
                        "• Collaboration: We believe in teamwork and collaboration to achieve our goals.\n"
                        "• Excellence: We are committed to delivering excellence in every project.",
                      ),
                      _sectionTitle(context, "Contact Us"),
                      _sectionText(
                        context,
                        "For inquiries or to learn more about our services, please contact us:",
                      ),
                      const SizedBox(height: 10),
                      TextButton.icon(
                        onPressed: _launchEmail,
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: Text(
                          "bytesflare.info@gmail.com",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
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

  Widget _sectionTitle(BuildContext context, String title) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 10),
    child: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );

  Widget _sectionText(BuildContext context, String text) =>
      Text(text, style: Theme.of(context).textTheme.bodyMedium);
}
