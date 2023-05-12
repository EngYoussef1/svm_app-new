import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/model.dart';
import '../sign in/sign in.dart';

class OnBordingEntry extends StatefulWidget {
  final VoidCallback onCompleted;

  OnBordingEntry({Key? key, required this.onCompleted}) : super(key: key);

  @override
  _OnBordingEntryState createState() => _OnBordingEntryState();
}

class _OnBordingEntryState extends State<OnBordingEntry> {
  PageController _pageController = PageController();
  bool _isLast = false;
  List<EntryDeitals> bording = [
    EntryDeitals(
        image: "images/firstentry.png",
        body: 'The process of shopping through the APP,and knowing the productsi in the nearby machines'),
    EntryDeitals(
        image: "images/secondentry.png",
        body: 'Scan to confirm that the payment process has been completed through the APP'),
    EntryDeitals(
        image: "images/thirdentry.png",
        body: 'Locate the machine and select the most appropriate route'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Sign_in()),
                          (Route<dynamic> route) => false,
                    );
                    widget.onCompleted();
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ),
              ],
            ),
            Expanded(
              child: OnboardingScreen(
                onCompleted: widget.onCompleted,
                pages: bording.map((entryDetails) => EntryPages(entryDetails)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class OnboardingScreen extends StatefulWidget {
  final List<Widget> pages;
  final VoidCallback onCompleted;

  OnboardingScreen({required this.pages, required this.onCompleted});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  bool _isLast = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            children: widget.pages,
            onPageChanged: (int index) {
              setState(() {
                _isLast = index == widget.pages.length - 1;
              });
              if (_isLast) {
                widget.onCompleted();
              }
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmoothPageIndicator(
              controller: _pageController,
              count: widget.pages.length,
              effect: ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: Colors.red,
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 4,
                spacing: 5,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                if (_isLast) {
                  widget.onCompleted();
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
              },
              child: Text(
                _isLast ? 'Finish' : 'Next',
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

 Widget EntryPages(EntryDeitals model)=>Column(
  children: [
    Expanded(
      child: Image.asset('${model.image}',
      ),
    ),
    SizedBox(
      height: 30,
    ),
    Text('${model.body}',
      // textAlign:TextAlign.justify,
      style: TextStyle(fontSize:24,fontWeight:FontWeight.normal,color: Colors.black,),
    ),
    SizedBox(
      height: 70,
    ),
  ],
);
