import 'package:flutter/material.dart';
import 'staff_list_page.dart';
import 'company_info.dart';
import 'app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Staff Management System'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonText,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.business, size: 80, color: AppColors.primary),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Ling Tech Staff System',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.buttonText,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StaffListPage()),
                );
              },
              icon: const Icon(Icons.people),
              label: const Text("Manage Staff", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.textPrimary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CompanyInfoPage()),
                );
              },
              icon: const Icon(Icons.info_outline),
              label: const Text("Company Info", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
