import 'package:bytesflare_infotech/widgets/footer.dart';
import 'package:bytesflare_infotech/widgets/header.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});

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
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    children: [
                      Text(
                        "Our Services",
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "We provide innovative technology solutions to help businesses grow and succeed.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 30),
                      _buildServicesGrid(context),
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

  Widget _buildServicesGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 2.5,
      ),
      itemCount: _services.length,
      itemBuilder: (context, index) {
        final service = _services[index];
        return _serviceCard(
          context: context,
          title: service['title']!,
          description: service['description']!,
          icon: service['icon'] as IconData,
        );
      },
    );
  }

  Widget _serviceCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return SingleChildScrollView(
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.secondary,
                size: 40,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _services = [
    {
      'title': "Mobile App Development",
      'description': "Cutting-edge mobile applications for iOS and Android.",
      'icon': Icons.phone_android,
    },
    {
      'title': "Web Development",
      'description': "Responsive and fast web platforms for every screen.",
      'icon': Icons.web,
    },
    {
      'title': "UI/UX Design",
      'description':
          "User-focused designs that enhance engagement and satisfaction.",
      'icon': Icons.design_services,
    },
    {
      'title': "Cloud Solutions",
      'description':
          "Secure and scalable cloud services to power your applications.",
      'icon': Icons.cloud,
    },
    {
      'title': "E-commerce Solutions",
      'description':
          "Build powerful online stores with seamless user experiences.",
      'icon': Icons.shopping_cart,
    },
    {
      'title': "Digital Marketing",
      'description':
          "Boost your online presence and reach with our marketing strategies.",
      'icon': Icons.campaign,
    },
  ];
}
