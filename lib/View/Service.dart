import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(Icons.menu, color: Colors.black),
                    items:
                        <String>[
                          'Home',
                          'Services',
                          'Info',
                          'About',
                          'ContactUs',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? value) {
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
                          break; // Ensure the route name is consistent
                      }
                    },
                  ),
                ),
              ),
              Text(
                'What We Offer',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildServiceItem(
                title: 'Custom Mobile App Development',
                description:
                    'We create fast, scalable, and user-friendly mobile applications for both Android and iOS platforms, tailored to your business needs.',
              ),
              _buildServiceItem(
                title: 'Web Development',
                description:
                    'Our team builds responsive and engaging websites that enhance your online presence and drive business growth.',
              ),
              _buildServiceItem(
                title: 'UI/UX Design',
                description:
                    'We design beautiful and intuitive user interfaces that provide an exceptional user experience, ensuring your app is both functional and appealing.',
              ),
              _buildServiceItem(
                title: 'Integration Services',
                description:
                    'We seamlessly integrate various services such as payment gateways, chat functionalities, and backend services to enhance your applications.',
              ),
              _buildServiceItem(
                title: 'Cloud Solutions',
                description:
                    'Our cloud solutions provide scalable and secure infrastructure, enabling your applications to grow and adapt to changing demands.',
              ),
              _buildServiceItem(
                title: 'Consulting Services',
                description:
                    'We offer expert consulting to help you strategize and implement technology solutions that align with your business goals.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem({
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
