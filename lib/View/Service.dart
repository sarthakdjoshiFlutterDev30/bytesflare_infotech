import 'package:bytesflare_infotech/widgets/footer.dart';
import 'package:bytesflare_infotech/widgets/header.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Header()),
      backgroundColor: const Color(0xFF1E2A32), // Dark blue background
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Our Services",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "We provide innovative technology solutions to help businesses grow and succeed.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    const SizedBox(height: 30),

                    // Service cards
                    _serviceCard(
                      title: "Mobile App Development",
                      description:
                          "High-quality iOS and Android applications tailored to your business needs.",
                      icon: Icons.phone_android,
                    ),
                    _serviceCard(
                      title: "Web Development",
                      description:
                          "Modern, responsive websites and web applications for all industries.",
                      icon: Icons.web,
                    ),
                    _serviceCard(
                      title: "UI/UX Design",
                      description:
                          "User-focused designs that enhance engagement and satisfaction.",
                      icon: Icons.design_services,
                    ),
                    _serviceCard(
                      title: "Cloud Solutions",
                      description:
                          "Secure and scalable cloud services to power your applications.",
                      icon: Icons.cloud,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Footer(),
        ],
      ),
    );
  }

  // Service card widget
  Widget _serviceCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      color: const Color(0xFF26343E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange, size: 40),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
