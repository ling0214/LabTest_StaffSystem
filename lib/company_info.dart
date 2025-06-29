import 'package:flutter/material.dart';
import 'app_colors.dart'; // ✅ your centralized color file

class CompanyInfoPage extends StatelessWidget {
  const CompanyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Company Profile'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonText,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Ling Tech Solutions Sdn. Bhd.',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ling Tech Solutions is a leading provider of human resource management systems, '
                      'dedicated to delivering digital solutions that streamline staff administration, '
                      'data tracking, and performance monitoring. Established in 2010, we have served '
                      'over 500 clients across Southeast Asia.',
                      style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.text),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Our Mission',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'To empower businesses through innovative staff management tools that enhance efficiency '
                      'and promote organizational growth.',
                      style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.text),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '📍 HQ: 25, Jalan Teknologi, Cyberjaya, Malaysia\n'
                      '📞 Phone: +60 3-1234 5678\n'
                      '📧 Email: contact@lingtech.com',
                      style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.text),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
