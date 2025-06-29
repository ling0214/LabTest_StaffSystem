import 'package:flutter/material.dart';

class CompanyInfoPage extends StatelessWidget {
  const CompanyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text('Company Profile'),
        backgroundColor: const Color.fromARGB(255, 57, 130, 167),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ling Tech Solutions Sdn. Bhd.',
                  style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ABC Tech Solutions is a leading provider of human resource management systems, '
                  'dedicated to delivering digital solutions that streamline staff administration, '
                  'data tracking, and performance monitoring. Established in 2010, we have served '
                  'over 500 clients across Southeast Asia.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Our Mission',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'To empower businesses through innovative staff management tools that enhance efficiency '
                  'and promote organizational growth.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '📍 HQ: 25, Jalan Teknologi, Cyberjaya, Malaysia\n'
                  '📞 Phone: +60 3-1234 5678\n'
                  '📧 Email: contact@abctech.com',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
