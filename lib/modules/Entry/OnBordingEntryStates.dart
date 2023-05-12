import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sign in/sign in.dart';
import 'entry.dart';

class OnboardingEntryMode extends StatefulWidget {
  @override
  _OnboardingEntryModeState createState() => _OnboardingEntryModeState();
}

class _OnboardingEntryModeState extends State<OnboardingEntryMode> {
  bool _showOnboarding = false;

  @override
  void initState() {
    super.initState();
    _checkIfOnboardingCompleted();
  }

  Future<void> _checkIfOnboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;
    setState(() {
      _showOnboarding = !hasCompletedOnboarding;
    });
  }

  void _setOnboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Sign_in()));
  }

  @override
  Widget build(BuildContext context) {
    if (_showOnboarding) {
      return OnBordingEntry(
        onCompleted: _setOnboardingCompleted,
      );
    } else {
      return Sign_in();
    }
  }
}