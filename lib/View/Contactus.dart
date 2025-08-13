import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Us')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We would love to hear from you!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                        r'^[^@]+@[^@]+\.[^@]+',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() ||
                          _nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _messageController.text.isEmpty) {
                        // Handle form submission
                        String name = _nameController.text;
                        String email = _emailController.text;
                        String message = _messageController.text;
                        FirebaseFirestore.instance
                            .collection('contacts')
                            .add({
                              "name": name,
                              "email": email,
                              "message": message,
                            })
                            .then((_) {
                              _nameController.clear();
                              _emailController.clear();
                              _messageController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Data store Successfully"),
                                ),
                              );
                            });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Enter Details Carefully")),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
