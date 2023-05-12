import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/model.dart';
import '../sign in/sign in.dart';

class OnBordingEntry extends StatefulWidget {
   OnBordingEntry({Key? key}) : super(key: key);

  @override
  State<OnBordingEntry> createState() => _OnBordingEntryState();
}

class _OnBordingEntryState extends State<OnBordingEntry> {
  var EntryPagesController= PageController();

  List<EntryDeitals> bording =[
    EntryDeitals(
      image: "images/firstentry.png",
      body: 'The process of shopping through the APP,and knowing the productsi in the nearby machines'
    ),
    EntryDeitals(
        image: "images/secondentry.png",
        body: 'Scan to confirm that the payment process has been completed through the APP'
    ),
    EntryDeitals(
        image: "images/thirdentry.png",
        body: 'Locate the machine and select the most appropriate route'
    ),
  ];

  bool isLast=false;

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
                TextButton(onPressed: (){
                  Navigator.pushAndRemoveUntil(
                      context,MaterialPageRoute(
                      builder: (context)=> const Sign_in()
                  ),
                          (Route<dynamic>  route) => false
                  );

                }, child: const Text('Skip',
                  style: TextStyle(fontSize: 20,color: Colors.red,),),),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: EntryPagesController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>EntryPages(bording[index]),
                itemCount: bording.length,
                onPageChanged: (int index){
                  if(index==bording.length-1){
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmoothPageIndicator(
                    controller: EntryPagesController,
                    count: bording.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.red,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                TextButton( onPressed: (){
                  if(isLast){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context)=> Sign_in(),
                   ),
                            (Route<dynamic>  route) => false
                    );
                  }else{
                    EntryPagesController.nextPage(
                      duration: Duration(
                          milliseconds: 750
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }

                },
                  child: const Text('Next',
                    style: TextStyle(fontSize: 20,color: Colors.red,),),)
              ],
            )
          ],
        ),
      ),
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
