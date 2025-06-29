import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'creation_page.dart';
import 'app_colors.dart'; // ✅ import centralized color file

class StaffListPage extends StatelessWidget {
  const StaffListPage({super.key});

  void _deleteStaff(BuildContext context, String docId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Staff"),
        content: const Text("Are you sure you want to delete this staff member?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await FirebaseFirestore.instance.collection('staff').doc(docId).delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Staff deleted successfully")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete staff: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Staff Directory",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.buttonText,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('staff').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('⚠️ Error loading data'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final staffList = snapshot.data!.docs;

            if (staffList.isEmpty) {
              return const Center(child: Text('No staff data found.'));
            }

            return ListView.separated(
              itemCount: staffList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final staff = staffList[index];
                final staffData = staff.data() as Map<String, dynamic>;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          staffData['name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text("Staff ID: ${staffData['staffId']}"),
                        Text("Age: ${staffData['age']}"),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => StaffCreationPage(
                                      isEdit: true,
                                      docId: staff.id,
                                      name: staffData['name'],
                                      staffId: staffData['staffId'],
                                      age: staffData['age'],
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit, color: AppColors.edit),
                              label: Text("Edit", style: TextStyle(color: AppColors.edit)),
                            ),
                            const SizedBox(width: 10),
                            TextButton.icon(
                              onPressed: () => _deleteStaff(context, staff.id),
                              icon: Icon(Icons.delete, color: AppColors.delete),
                              label: Text("Delete", style: TextStyle(color: AppColors.delete)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const StaffCreationPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Staff"),
      ),
    );
  }
}
