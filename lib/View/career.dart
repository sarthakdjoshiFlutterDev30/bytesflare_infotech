import 'dart:io';

import 'package:bytesflare_infotech/widgets/footer.dart';
import 'package:bytesflare_infotech/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CareerFormPage extends StatefulWidget {
  const CareerFormPage({super.key});

  @override
  State<CareerFormPage> createState() => _CareerFormPageState();
}

class _CareerFormPageState extends State<CareerFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _contactNo;
  String? _jobDesignation;
  String? _portfolioLink;

  final List<String> _jobOptions = [
    "Business Development Executive",
    "Digital Marketing Specialist",
  ];

  PlatformFile? _pickedFile;
  bool _isUploading = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = result.files.first;

      final ext = file.extension?.toLowerCase();
      if (ext != 'pdf') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Only PDF files are allowed")),
        );
        return;
      }

      if (file.size > 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("File size must be under 1 MB")),
        );
        return;
      }

      setState(() {
        _pickedFile = file;
      });
    }
  }

  Future<String?> _uploadFile() async {
    if (_pickedFile == null || _name == null || _jobDesignation == null)
      return null;

    setState(() => _isUploading = true);

    try {
      final safeName = _name!.replaceAll(' ', '_').toUpperCase();
      final safeJob = _jobDesignation!.replaceAll(' ', '_');
      final fileName = "$safeName-$safeJob.pdf";

      final storageRef = FirebaseStorage.instance.ref().child(
        "resumes/$fileName",
      );

      if (kIsWeb) {
        // Web upload
        await storageRef.putData(
          _pickedFile!.bytes!,
          SettableMetadata(contentType: 'application/pdf'),
        );
      } else {
        final file = File(_pickedFile!.path!);
        await storageRef.putFile(
          file,
          SettableMetadata(contentType: 'application/pdf'),
        );
      }

      return await storageRef.getDownloadURL();
    } catch (e) {
      if (kDebugMode) {
        print("Upload error: $e");
      }
      return null;
    } finally {
      setState(() => _isUploading = false);
    }
  }

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
                "Digital Marketing Specialist",
                "Remote",
                "Run SEO, Google & Social Media campaigns to boost visibility and bring inbound leads.",
              ),
              _jobCard(
                "Business Development Executive",
                "Remote",
                "Generate leads, pitch clients, prepare proposals, and close deals for IT services.",
              ),
              TextFormField(
                style: const TextStyle(fontSize: 18, color: Colors.white),
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
              TextFormField(
                style: const TextStyle(fontSize: 18, color: Colors.white),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  prefix: Text(
                    "+91-",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.red, fontSize: 14),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (value) => _contactNo = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Mobile No.";
                  }
                  if (value.length != 10) {
                    return "Mobile Number must be exactly 10 digits";
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
                dropdownColor: const Color(0xFF0D1B2A),
                items: _jobOptions.map((job) {
                  return DropdownMenuItem(
                    value: job,
                    child: Text(
                      job,
                      style: const TextStyle(color: Colors.white),
                    ),
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
                style: const TextStyle(fontSize: 18, color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Enter Portfolio/Github Link (Optional)",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _portfolioLink = value,
              ),
              const SizedBox(height: 20),

              // Resume Upload Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: _pickFile,
                icon: const Icon(Icons.upload_file, color: Colors.white),
                label: Text(
                  _pickedFile == null
                      ? "Upload Resume (Max 1MB)"
                      : "File Selected: ${_pickedFile!.name}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 30),
              _isUploading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_pickedFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please upload your resume"),
                              ),
                            );
                            return;
                          }

                          _formKey.currentState!.save();

                          final resumeUrl = await _uploadFile();
                          if (resumeUrl == null) return;
                          final formattedDate = DateFormat(
                            'dd-MM-yyyy',
                          ).format(DateTime.now());
                          await FirebaseFirestore.instance
                              .collection('Carriers')
                              .add({
                                "name": _name?.toUpperCase().toString(),
                                "jobDesignation": _jobDesignation,
                                "portfolioLink": _portfolioLink,
                                "mobileNo": _contactNo,
                                "resumeUrl": resumeUrl,
                                "appliedDate": formattedDate,
                              });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Application submitted for $_jobDesignation",
                              ),
                            ),
                          );

                          _formKey.currentState!.reset();
                          setState(() => _pickedFile = null);
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
