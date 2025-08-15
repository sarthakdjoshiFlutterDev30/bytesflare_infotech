import 'package:bytesflare_infotech/widgets/footer.dart';
import 'package:bytesflare_infotech/widgets/header.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2A32),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2A32),
        elevation: 0,
        title: const Header(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you visit or use our services.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Information Collection:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "We may collect personal information such as your name, email address, and any other details you provide when using our services or contacting us.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Information Use:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "The information collected is used to respond to your inquiries, improve our services, and provide a better user experience. We do not share your personal data with third parties without your consent.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Cookies and Tracking:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "We may use cookies and similar technologies to analyze site usage and improve performance. You can manage your cookie preferences in your browser settings.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Data Security:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "We implement appropriate security measures to protect your personal information from unauthorized access, disclosure, or misuse.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Changes to this Policy:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "We may update this Privacy Policy from time to time. Any changes will be posted on this page with an updated revision date.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Contact Us:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "If you have any questions about this Privacy Policy or how we handle your data, please contact us via our Contact Us page.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Center(child: Footer()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
