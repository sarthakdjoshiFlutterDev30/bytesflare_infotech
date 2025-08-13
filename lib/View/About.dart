import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                'About BytesFlare Infotech',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'BytesFlare Infotech is a premier technology company dedicated to providing innovative digital solutions. Founded in [Year], we have been at the forefront of mobile and web application development, helping businesses transform their ideas into reality.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Our Mission',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'To empower businesses with cutting-edge technology solutions that enhance efficiency and drive growth.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Our Vision',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'To be a global leader in digital solutions, recognized for our commitment to quality, innovation, and customer satisfaction.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Our Values',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                      text: 'Integrity: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'We uphold the highest standards of integrity in all our actions.\n',
                    ),
                    TextSpan(
                      text: 'Innovation: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' We strive to innovate and improve our services continuously.\n',
                    ),
                    TextSpan(
                      text: 'Customer Focus: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' Our customers are at the heart of everything we do.\n',
                    ),
                    TextSpan(
                      text: 'Collaboration: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' We believe in teamwork and collaboration to achieve our goals.\n',
                    ),
                    TextSpan(
                      text: 'Excellence: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' We are committed to delivering excellence in every project.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'For inquiries or to learn more about our services, please contact us at:\n',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: _launchEmail,
                    child: Text(
                      'Email: bytesflare.info@gmail.com\n',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'bytesflare.info@gmail.com',
    );

    await launch(emailLaunchUri.toString());
  }
}
