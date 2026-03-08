import 'package:flutter/material.dart';
import 'package:myapp/screens/faq_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/settings_screen.dart';
import 'package:myapp/text.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTexts = AppTexts.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 8.0,
        shadowColor: Colors.black.withAlpha(128),
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: Center(
          child: Text(
            appTexts.appInfo,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, appTexts),
            const SizedBox(height: 30),
            _buildSectionTitle(context, "What's New"),
            _buildInfoCard(
              context,
              icon: Icons.new_releases,
              title: 'Version 1.0.0',
              subtitle:
                  'Initial release with exciting new features to help you on your journey.',
              isJustified: true,
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(context, "About AuraCare"),
            _buildInfoCard(
              context,
              icon: Icons.info_outline,
              title: 'Our Mission',
              subtitle:
                  'AuraCare is your personal companion for a healthier and happier life. We provide tools and resources to support your well-being, from medication reminders to mental wellness exercises.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(context, "Privacy Policy"),
            _buildExpansionTile(context, 
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                children: [
                  const Text(
                    'Your privacy is our priority. All data you enter is stored locally on your device and is never collected or shared by us. Your information remains entirely under your control.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ]),
            const SizedBox(height: 20),
            _buildSectionTitle(context, "Terms of Service"),
            _buildExpansionTile(
              context,
              icon: Icons.gavel,
              title: 'Terms of Service',
              children: [
                const Text(
                  'By using AuraCare, you agree to these terms.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                const Text(
                  '1. No User Accounts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This app works without a user account. All data is stored on your device.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                const Text(
                  '2. Medical Disclaimer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This app is for informational purposes only and is not a substitute for professional medical advice. Always consult a healthcare provider for medical concerns.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                const Text(
                  '3. Limitation of Liability',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You are responsible for your use of this app. We are not liable for any issues that may arise from its use.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60.0,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.help_outline),
              label: 'FAQ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: 1, // Home icon is selected
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FAQScreen()),
              );
            } else if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppTexts appTexts) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/images/AuraCare_logo_HomeScreen.png',
            height: 100,
          ),
          const SizedBox(height: 10),
          Text(
            appTexts.auraCare,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24,
                ),
          ),
          Text(
            'Version 1.0.0',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    bool isJustified = false,
  }) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15.0),
        leading: Icon(
          icon,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 16),
          textAlign: isJustified ? TextAlign.justify : TextAlign.start,
        ),
        onTap: onTap,
        trailing: onTap != null ? const Icon(Icons.arrow_forward_ios) : null,
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context, {
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ExpansionTile(
        leading: Icon(
          icon,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
