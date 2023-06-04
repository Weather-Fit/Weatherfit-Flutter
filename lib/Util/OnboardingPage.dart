import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:weatherfit/Util/BottomNavigationBarWidget.dart';

///온보딩
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            title: "기온에 적합한 코디 확인",
            body: "기온을 터치하면 기온에 적합한 코디를 빠르게 확인할 수 있습니다.",
            image: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: SizedBox(
                height: 800.0, // 원하는 크기로 조정해주세요
                child: Image.asset('asset/images/img_onboarding1.png'),
              ),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.blueAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          PageViewModel(
            title: "기온에 적합한 코디 확인",
            bodyWidget: Text("body2"),
          ),
          PageViewModel(
            title: "Title3",
            bodyWidget: Text("body3"),
          ),
        ],
        next: Text("Next", style: TextStyle(fontWeight: FontWeight.w600)),
        done: Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigationBarWidget()),
          );
        },
      ),
    );
  }
}
