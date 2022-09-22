import 'package:flutter/material.dart';

import '../../domain/models/developer.dart';
import '../styles/app_colors.dart';
import '../widgets/contact_us_item.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: developers.length,
            itemBuilder: (context, index) {
              return ContactUsItem(developer: developers[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
        ),
      ),
    );
  }
}

List<Developer> developers = [
  Developer(
    name: 'Ammar Elgml',
    title: 'Flutter Developer',
    email: 'eng.amaarelgml@gmail.com',
    github: 'https://github.com/AmmarElgml',
    linkedin: 'https://www.linkedin.com/in/ammar-elgml-5a43381aa/',
    phone: '+201010256390',
    image: 'assets/images/ammar.jpeg',
  ),
  Developer(
    name: 'Abdelrahman \nJamal',
    title: 'Flutter Developer',
    email: 'abdelrahmanjamal5565@gmail.com',
    github: 'https://github.com/Hero2323',
    linkedin: 'https://linkedin.com/in/abdelrahmanjamal',
    phone: '+201000532723',
    image: 'assets/images/abdelrahman.jpeg',
  ),
];
