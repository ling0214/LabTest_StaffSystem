import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_colors.dart';

class StaffFormPage extends StatefulWidget {
  const StaffFormPage({super.key});

  @override
  State<StaffFormPage> createState() => _StaffFormPageState();
}

class _StaffFormPageState extends State<StaffFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void submitData() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('staffs').add({
        'name': nameController.text.trim(),
        'id': idController.text.trim(),
        'age': int.tryParse(ageController.text.trim()) ?? 0,
      });

      nameController.clear();
      idController.clear();
      ageController.clear();

      Navigator.pushNamed(context, '/staffList');
    }
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonText,
        title: const Text("Add New Staff"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Text(
                "Staff Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Full Name',
                icon: Icons.person,
                controller: nameController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                label: 'Staff ID',
                icon: Icons.badge,
                controller: idController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter staff ID' : null,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                label: 'Age',
                icon: Icons.calendar_today,
                controller: ageController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter age';
                  if (int.tryParse(value) == null) return 'Age must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text("Submit", style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: submitData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
