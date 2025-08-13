import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                          'Carriers',
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
                          break;
                        case 'Carriers':
                          Navigator.pushNamed(context, "/carriers");
                          break;
                      }
                    },
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.pink),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    Center(child: Image.asset("assets/image/logo.png")),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    Text(
                      "All IT Solutions You Need",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              Container(
                color: Colors.blueAccent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Transforming Ideas into Innovative Digital Solutions',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'At ByteFlare Infotech, we specialize in creating powerful, user-friendly mobile and web applications tailored to meet the unique needs of businesses and startups. With a passion for technology and a commitment to excellence, we bring your ideas to life through innovative solutions.',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.blueAccent,
                width: MediaQuery.of(context).size.width,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'What We Offer:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      "• Mobile App Development\n• Website Development\n• Custom Software Solutions\n• E-commerce Solutions\n• API Development & Integration\n• UI/UX Design",
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.blueAccent,
                width: MediaQuery.of(context).size.width,

                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Our Work:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Explore our portfolio to see the diverse range of projects we\'ve successfully delivered, including:',
                      ),
                      SizedBox(height: 5),
                      Text(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),

                        "We have worked on projects like:\n"
                        "1. College Management System\n"
                        "2. E-commerce Platforms\n"
                        "3. Real-time Chat Applications\n"
                        "4. Business Websites\n"
                        "5. Data Analysis Tools",
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              Container(
                color: Colors.blueAccent,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Ready to Bring Your Idea to Life?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Let’s connect and discuss how we can help you achieve your business goals with our custom solutions.',
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/contactus');
                        },
                        child: Text('Contact Us'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
