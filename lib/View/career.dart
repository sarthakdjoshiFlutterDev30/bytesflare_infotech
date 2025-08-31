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
  PlatformFile? _pickedPhoto;
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
          const SnackBar(content: Text("Resume size must be under 1 MB")),
        );
        return;
      }

      setState(() {
        _pickedFile = file;
      });
    }
  }

  Future<void> _pickPhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      final file = result.files.first;

      if (file.size > 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Photo size must be under 1 MB")),
        );
        return;
      }

      setState(() {
        _pickedPhoto = file;
      });
    }
  }

  Future<String?> _uploadFile() async {
    if (_pickedFile == null || _name == null || _jobDesignation == null) {
      return null;
    }

    try {
      final safeName = _name!.replaceAll(' ', '_').toUpperCase();
      final safeJob = _jobDesignation!.replaceAll(' ', '_');
      final fileName = "$safeName-$safeJob.pdf";

      final storageRef = FirebaseStorage.instance.ref().child(
        "resumes/$fileName",
      );

      if (kIsWeb) {
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
        print("Upload error (resume): $e");
      }
      return null;
    }
  }

  Future<String?> _uploadPhoto() async {
    if (_pickedPhoto == null || _name == null) return null;
    try {
      final safeName = _name!.replaceAll(' ', '_').toUpperCase();
      final fileName = "PHOTO_$safeName.png";

      final storageRef = FirebaseStorage.instance.ref().child(
        "photos/$fileName",
      );

      if (kIsWeb) {
        await storageRef.putData(
          _pickedPhoto!.bytes!,
          SettableMetadata(contentType: 'image/png'),
        );
      } else {
        final file = File(_pickedPhoto!.path!);
        await storageRef.putFile(
          file,
          SettableMetadata(contentType: 'image/png'),
        );
      }

      return await storageRef.getDownloadURL();
    } catch (e) {
      if (kDebugMode) {
        print("Upload error (photo): $e");
      }
      return null;
    }
  }

  Future<void> _submitCareerForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload your resume")),
      );
      return;
    }

    setState(() => _isUploading = true);
    final resumeUrl = await _uploadFile();
    final photoUrl = await _uploadPhoto();

    if (resumeUrl == null) {
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to upload resume. Please try again."),
        ),
      );
      return;
    }

    try {
      final formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      await FirebaseFirestore.instance.collection('Carriers').add({
        "name": _name?.toUpperCase().toString(),
        "jobDesignation": _jobDesignation,
        "portfolioLink": _portfolioLink,
        "mobileNo": _contactNo,
        "resumeUrl": resumeUrl,
        "photoUrl": photoUrl,
        "appliedDate": formattedDate,
      });
      _formKey.currentState!.reset();
      setState(() {
        _pickedFile = null;
        _pickedPhoto = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Application submitted successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting application: $e")),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Header()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Career Opportunities",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildAvailableOpenings(context),
                  const SizedBox(height: 40),
                  Text(
                    "Apply Now",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildApplicationForm(),
                  const SizedBox(height: 50),
                  const Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvailableOpenings(BuildContext context) {
    return Column(
      children: [
        _jobCard(
          context,
          "Digital Marketing Specialist",
          "Remote",
          "Run engaging campaigns and analyze performance to drive business growth.",
        ),
        _jobCard(
          context,
          "Business Development Executive",
          "Remote",
          "Develop new business opportunities and build strong client relationships.",
        ),
      ],
    );
  }

  Widget _jobCard(
    BuildContext context,
    String title,
    String location,
    String description,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(location, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 10),
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Full Name",
              hintText: "Enter your full name",
            ),
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter your name'
                : null,
            onSaved: (value) => _name = value,
          ),
          const SizedBox(height: 20),
          TextFormField(
            maxLength: 10,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "Contact No",
              hintText: "Enter your contact number",
            ),
            keyboardType: TextInputType.phone,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter your contact number'
                : null,
            onSaved: (value) => _contactNo = value,
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            value: _jobDesignation,
            decoration: const InputDecoration(labelText: "Job Designation"),
            items: _jobOptions.map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _jobDesignation = newValue;
              });
            },
            validator: (value) =>
                value == null ? 'Please select a job designation' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Portfolio Link (Optional)",
              hintText: "Enter a link to your portfolio",
            ),
            keyboardType: TextInputType.url,
            onSaved: (value) => _portfolioLink = value,
          ),
          const SizedBox(height: 20),
          _buildFilePickerField(
            title: "Upload Resume (PDF only)",
            onTap: _pickFile,
            pickedFile: _pickedFile,
          ),
          const SizedBox(height: 20),
          _buildFilePickerField(
            title: "Upload Photo (JPG/PNG only)",
            onTap: _pickPhoto,
            pickedFile: _pickedPhoto,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isUploading ? null : _submitCareerForm,
              child: _isUploading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePickerField({
    required String title,
    required VoidCallback onTap,
    required PlatformFile? pickedFile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.file_upload),
          label: Text(pickedFile != null ? pickedFile.name : "Choose File"),
        ),
      ],
    );
  }
}
