import 'package:bytesflare_infotech/widgets/footer.dart';
import 'package:bytesflare_infotech/widgets/header.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Header()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About Us",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Bytes Flare Infotech is a specialized IT agency dedicated to helping businesses succeed in the digital world. Since our inception, we have focused on delivering high-quality mobile apps, websites, and custom software solutions tailored to our clients' unique needs.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  "Our Mission",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Our mission is to empower businesses by providing innovative digital solutions that enhance customer engagement, streamline operations, and drive growth. We combine creativity with technology to deliver products that stand out in the market.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  "What We Do",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "We specialize in:\n- Mobile App Development (Android & iOS)\n- Web Development & Design\n- Custom Software Solutions\n- E-Commerce Platforms\n- UI/UX Design & Animation\n- Cloud & Backend Integration",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  "Why Choose Us?",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "We don’t just build apps or websites; we create solutions that solve real business challenges. Our team is hands-on, involved in every step from planning to deployment, ensuring your project’s success. We care about your growth as much as you do.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                const Center(child: Footer()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
