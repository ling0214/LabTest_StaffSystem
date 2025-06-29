import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'staff_list_page.dart';
import 'app_colors.dart';

class StaffCreationPage extends StatefulWidget {
  final bool isEdit;
  final String? docId;
  final String? name;
  final String? staffId;
  final int? age;

  const StaffCreationPage({
    this.isEdit = false,
    this.docId,
    this.name,
    this.staffId,
    this.age,
    Key? key,
  }) : super(key: key);

  @override
  _StaffCreationPageState createState() => _StaffCreationPageState();
}

class _StaffCreationPageState extends State<StaffCreationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _nameController.text = widget.name ?? '';
      _idController.text = widget.staffId ?? '';
      _ageController.text = widget.age?.toString() ?? '';
    }
  }

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final name = _nameController.text.trim();
      final staffId = _idController.text.trim();
      final age = int.parse(_ageController.text.trim());

      try {
        final staffCollection = FirebaseFirestore.instance.collection('staff');

        if (widget.isEdit && widget.docId != null) {
          await staffCollection.doc(widget.docId).update({
            'name': name,
            'staffId': staffId,
            'age': age,
          });
        } else {
          await staffCollection.add({
            'name': name,
            'staffId': staffId,
            'age': age,
          });
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const StaffListPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to ${widget.isEdit ? 'update' : 'add'} staff: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: AppColors.primary) : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
        title: Text(widget.isEdit ? "Edit Staff" : "Add Staff"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                widget.isEdit ? "Update Staff Information" : "Staff Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Full Name',
                controller: _nameController,
                validator: (value) =>
                    value == null || value.trim().isEmpty ? "Please enter name" : null,
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Staff ID',
                controller: _idController,
                validator: (value) =>
                    value == null || value.trim().isEmpty ? "Please enter staff ID" : null,
                icon: Icons.badge,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Age',
                controller: _ageController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter age";
                  }
                  final age = int.tryParse(value);
                  if (age == null || age < 0) {
                    return "Enter a valid number";
                  }
                  return null;
                },
                icon: Icons.cake,
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _submitData,
                        icon: Icon(widget.isEdit ? Icons.update : Icons.check),
                        label: Text(
                          widget.isEdit ? "Update" : "Submit",
                          style: const TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.buttonText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
