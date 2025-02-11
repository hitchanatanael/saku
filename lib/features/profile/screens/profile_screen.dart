import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saku/core/widget/app_bar_widget.dart';
import 'package:saku/core/widget/index.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        icon: Icons.chevron_left,
        title: 'Profil',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF373466),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      'assets/images/kades.png',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Name
                  const Text(
                    'Uzumaki Naruto',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Email
                  const Text(
                    'naruto@email.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInfoCard(
                    icon: Icons.phone,
                    title: 'Nomor Telepon',
                    subtitle: '+62-812-3456-7890',
                  ),
                  _buildInfoCard(
                    icon: Icons.location_on,
                    title: 'Alamat',
                    subtitle: 'Jakarta, Indonesia',
                  ),
                  _buildInfoCard(
                    icon: Icons.work,
                    title: 'Pekerjaan',
                    subtitle: 'Kepala Desa',
                  ),
                  Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    color: Colors.red,
                    child: ListTile(
                      onTap: () {
                        Get.offAllNamed('/login');
                      },
                      leading: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Logout',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? backgroundColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: backgroundColor,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                ),
              )
            : null,
      ),
    );
  }
}
