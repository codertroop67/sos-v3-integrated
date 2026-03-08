import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/settings_screen.dart';
import 'package:myapp/text.dart';
import 'package:myapp/widgets/bottom_nav_bar.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTexts = AppTexts.of(context);
    final List<Map<String, String>> faqs = [
      {
        "question": appTexts.whoIsConsideredAnElderlyPerson,
        "answer": appTexts.whoIsConsideredAnElderlyPersonAnswer,
      },
      {
        "question": appTexts.whatAreCommonChallengesFacedByElderlyPeople,
        "answer": appTexts.whatAreCommonChallengesFacedByElderlyPeopleAnswer,
      },
      {
        "question": appTexts.whyIsCompanionshipImportantForElderlyPeople,
        "answer": appTexts.whyIsCompanionshipImportantForElderlyPeopleAnswer,
      },
      {
        "question": appTexts.doElderlyPeopleNeedConstantHelp,
        "answer": appTexts.doElderlyPeopleNeedConstantHelpAnswer,
      },
      {
        "question": appTexts.howCanElderlyPeopleStayMentallyActive,
        "answer": appTexts.howCanElderlyPeopleStayMentallyActiveAnswer,
      },
      {
        "question": appTexts.isForgetfulnessNormalInOldAge,
        "answer": appTexts.isForgetfulnessNormalInOldAgeAnswer,
      },
      {
        "question": appTexts.howCanElderlyPeopleStayEmotionallyHealthy,
        "answer": appTexts.howCanElderlyPeopleStayEmotionallyHealthyAnswer,
      },
      {
        "question":
            appTexts.whyIsPatienceImportantWhenInteractingWithElderlyPeople,
        "answer": appTexts
            .whyIsPatienceImportantWhenInteractingWithElderlyPeopleAnswer,
      },
      {
        "question": appTexts.canElderlyPeopleLearnNewThings,
        "answer": appTexts.canElderlyPeopleLearnNewThingsAnswer,
      },
      {
        "question": appTexts.howCanTechnologySupportElderlyPeople,
        "answer": appTexts.howCanTechnologySupportElderlyPeopleAnswer,
      },
    ];

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
            appTexts.frequentlyAskedQuestions,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isTablet = constraints.maxWidth > 600;
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: isTablet ? 40 : 10,
              ),
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return _buildFAQCard(
                  faqs[index]['question']!,
                  faqs[index]['answer']!,
                  isTablet,
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildFAQCard(String question, String answer, bool isTablet) {
    final double questionFontSize = isTablet ? 22 : 18;
    final double answerFontSize = isTablet ? 18 : 14;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      child: ExpansionTile(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
        iconColor: Theme.of(context).primaryColor,
        collapsedIconColor: Theme.of(context).primaryColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            question,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: questionFontSize,
              //color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Text(
              answer,
              textAlign: TextAlign.justify,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: answerFontSize),
            ),
          ),
        ],
      ),
    );
  }
}
