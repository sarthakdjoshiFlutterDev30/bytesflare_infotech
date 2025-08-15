import 'package:bytesflare_infotech/widgets/footer.dart';
import 'package:bytesflare_infotech/widgets/header.dart';
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
      appBar: AppBar(title: Header()),
      backgroundColor: const Color(0xFF1E2A32),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Available Opening",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              _jobCard(
                "Business Development Executive",
                "Remote",
                "Identify and convert leads into clients for IT services.",
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,

                decoration: const InputDecoration(
                  labelText: "Full Name",
                  labelStyle: TextStyle(color: Colors.white),
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
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                items: _jobOptions.map((job) {
                  return DropdownMenuItem(
                    value: job,
                    child: Text(job, style: TextStyle(color: Colors.white)),
                  );
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
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,

                decoration: const InputDecoration(
                  labelText: "Enter Portfolio/Resume Link",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _portfolioLink = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
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
                    _formKey.currentState!.reset();
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _jobCard(String title, String location, String description) {
    return Card(
      color: const Color(0xFF1E2A32),

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
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              location,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
