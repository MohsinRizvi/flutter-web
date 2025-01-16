import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets');
}
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  loadAsset();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
        ),
      ),
      home: ResumePage(),
    );
  }
}

class ResumePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            HeaderSection(),
            AboutMeSection(),
            WorkExperienceSection(),
            EducationSection(),
            SkillsSection(),
            LanguagesSection(),
            ProjectLinksSection(),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Syed Mohsin Hussain Rizvi', style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 10),
            Text('Email: mohsinh496@gmail.com'),
            SizedBox(height: 10),
            GestureDetector(
                onTap: (){
                  _launchPhoneDialer('+92 337 037 5209');
                },
                child: Text('WhatsApp: +92 337 037 5209')),
            SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: () => _launchURL('https://www.linkedin.com/in/syed-mohsin-hussain-rizvi-194a04164/'),
                  child: Image(image: AssetImage('assets/linkedin_icon.png'),width: 30,height: 30,)
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () => _launchURL('https://github.com/MohsinRizvi'),
                  child:  Image(image: AssetImage('assets/github.png'),width: 30,height: 30,)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
void _launchPhoneDialer(String phoneNumber) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunch(launchUri.toString())) {
    await launch(launchUri.toString());
  } else {
    throw 'Could not dial $phoneNumber';
  }
}

class AboutMeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ABOUT ME', style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 10),
            Text(
              'Highly skilled Senior Flutter Developer with 4+ years of experience in mobile app development. Proficient in building cross-platform applications using Flutter and Dart. Expertise in UI/UX design, architecture design, and state management. Adept at leading teams, integrating APIs, and delivering high-quality applications within tight deadlines.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class WorkExperienceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('WORK EXPERIENCE', style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 10),
            ExperienceItem(
              jobTitle: 'Senior Flutter Developer',
              company: 'NEXT GEN',
              duration: 'Aug 2023 – Present | Karachi, Pakistan',
              description: '''
• Mawsim: E-commerce app featuring 30-second product reels, powered by Shopify GraphQL API and Algolia for search and facets.
• Kinto Car Rental App: Platform for B2B and B2C users for booking and managing car rental services.
• Kinto Car Inspection App: Vehicle inspection and fleet management application.
• Yaa Food: Grocery and meat delivery app for Yazid AlRajhi Brothers (YAB Group).
''',
              responsibilities: '''
• Led architecture design and development of core features for Toyota Kinto apps.
• Built and maintained high-quality cross-platform applications for diverse audiences.
• Designed intuitive UI/UX interfaces ensuring exceptional user experiences.
• Optimized app performance, wrote scalable code, and resolved bugs efficiently.
• Collaborated with cross-functional teams for seamless API integration.
• Integrated modern technologies to enhance functionality.
''',
              achievements: '''
• Successfully integrated Algolia and Shopify GraphQL API for advanced search and data management.
• Delivered scalable solutions for high-demand applications within deadlines.
• Mentored junior developers and ensured project deliverables met client expectations.
''',
            ),
            ExperienceItem(
              jobTitle: 'Senior Flutter Developer',
              company: 'Digital Dividend',
              duration: 'Dec 2022 – Jul 2023 | Karachi, Pakistan',
              description: '''
• CashCash243: Fintech app showcasing transactions via QR code, Stripe payment gateway, and multi-platform authentication (Google, Facebook, Apple).
• GoTrukker: Tracking app for shippers, carriers, and drivers, featuring OAuth integration and real-time route tracking.
''',
              responsibilities: '''
• Designed app architecture and implemented core features for customer and merchant apps.
• Ensured seamless user tracking and delivery assignment for GoTrukker.
• Integrated Stripe for secure payment gateways.
''',
              achievements: '',
            ),
          ],
        ),
      ),
    );
  }
}

class ExperienceItem extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String duration;
  final String description;
  final String responsibilities;
  final String achievements;

  ExperienceItem({
    required this.jobTitle,
    required this.company,
    required this.duration,
    required this.description,
    required this.responsibilities,
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$jobTitle at $company', style: Theme.of(context).textTheme.bodyMedium),
        Text(duration, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 10),
        Text('Description: $description', style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 10),
        Text('Responsibilities: $responsibilities', style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 10),
        Text('Achievements: $achievements', style: Theme.of(context).textTheme.bodyMedium),
        Divider(),
      ],
    );
  }
}

class EducationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('EDUCATION', style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 10),
            Text('BSCS (Software Engineering)', style: Theme.of(context).textTheme.bodyMedium),
            Text('Sindh Madrassah Tul Islam University | Jan 2017 – Dec 2020 | Karachi, Pakistan'),
            SizedBox(height: 10),
            Text('Intermediate (Pre-Engineering)', style: Theme.of(context).textTheme.bodyMedium),
            Text('Govt. Forman College | Aug 2014 – Aug 2016 | Karachi, Pakistan'),
          ],
        ),
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SKILLS', style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 10),
            Text('• Flutter | Dart | State Management (Provider, Riverpod, BLoC)'),
            Text('• UI/UX Design | Architecture Design | Performance Optimization'),
            Text('• Firebase | GraphQL | REST APIs'),
            Text('• Stripe Payment Gateway Integration | OAuth | Algolia Integration'),
          ],
        ),
      ),
    );
  }
}

class LanguagesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LANGUAGES', style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 10),
            Text('• Urdu: Native', style: Theme.of(context).textTheme.bodyMedium),
            Text('• English: Proficient', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class ProjectLinksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PROJECT LINKS', style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 10),
            Text('• Mawsim: App Store', style: Theme.of(context).textTheme.bodyMedium),
            Text('• CashCash243: Google Play Store', style: Theme.of(context).textTheme.bodyMedium),
            Text('• GoTrukker Carrier: Google Play Store', style: Theme.of(context).textTheme.bodyMedium),
            Text('• GoTrukker Driver: Google Play Store', style: Theme.of(context).textTheme.bodyMedium),
            Text('• GoTrukker Shipper: Google Play Store', style: Theme.of(context).textTheme.bodyMedium),
            Text('• Pillway: Google Play Store', style: Theme.of(context).textTheme.bodyMedium),
            Text('• SIAT: Google Play Store', style: Theme.of(context).textTheme.bodyMedium),
            Text('• Prosfinity: Google Play Store', style: Theme.of(context).textTheme.bodyMedium),
            Text('• WinnerWinner: Official Website', style: Theme.of(context).textTheme.bodyMedium),
            Text('• Ready Hai: APK Combo', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
