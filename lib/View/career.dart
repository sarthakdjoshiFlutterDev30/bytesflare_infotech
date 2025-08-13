import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CareerFormPage extends StatefulWidget {
  const CareerFormPage({super.key});

  @override
  State<CareerFormPage> createState() => _CareerFormPageState();
}

class _CareerFormPageState extends State<CareerFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _jobDesignation;
  String? _portfolioLink;

  final List<String> _jobOptions = ["Business Development Executive"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Career Application"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _jobCard(
                "Business Development Executive",
                "Remote",
                "Identify and convert leads into clients for IT services.",
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Job Designation",
                  border: OutlineInputBorder(),
                ),
                items: _jobOptions.map((job) {
                  return DropdownMenuItem(value: job, child: Text(job));
                }).toList(),
                onChanged: (value) => setState(() => _jobDesignation = value),
                validator: (value) {
                  if (value == null) {
                    return "Please select a job designation";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Portfolio Or Resume Link",
                  hintText: "Portfolio or Resume",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _portfolioLink = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your portfolio link";
                  }
                  if (!Uri.parse(value).isAbsolute) {
                    return "Please enter a valid URL";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    FirebaseFirestore.instance.collection('Carriers').add({
                      "name": _name,
                      "jobDesignation": _jobDesignation,
                      "portfolioLink": _portfolioLink,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Application submitted for $_jobDesignation",
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _jobCard(String title, String location, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              location,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(description, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
