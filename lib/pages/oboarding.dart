import 'package:dental_care_app/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildFullscreenImage(
    String assetName,
  ) {
    return Image.asset(
      'assets/$assetName',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/onboarding/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color.fromARGB(255, 236, 236, 236),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      bodyPadding: const EdgeInsets.only(top: 100),
      key: introKey,
      globalBackgroundColor: const Color.fromARGB(255, 236, 236, 236),
      allowImplicitScrolling: true,
      infiniteAutoScroll: false,

      pages: [
        PageViewModel(
          title: "Bine ai venit!",
          body:
              "Aplicatia DentoCare iti ofera acces la o multitudine de servicii si informatii relevante, mereu disponibile oriunde ai fi.",
          image: _buildImage('doctori.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Totul la un click distanta",
          body:
              "Access 24/7 la lista ta de programari, tratamente, statusul lor, module educative si multe alte caracteristici.",
          image: _buildImage('programaritratamente.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body: "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('informatiicont.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.all(12.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

void _onIntroEnd(context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => LoginPage()),
  );
}
