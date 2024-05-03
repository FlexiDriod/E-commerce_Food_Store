import 'package:flutter/material.dart';
import 'package:japan_store/webview1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
                                                          /*_Onboarding Screen_*/
class WelcomeCarsouel extends StatefulWidget {
  const WelcomeCarsouel({super.key});

  @override
  State<WelcomeCarsouel> createState() => _WelcomeCarsouelState();
}

class _WelcomeCarsouelState extends State<WelcomeCarsouel> {
  final controller = PageController();
  bool isLastPage = false;

  List<Widget> pages = [
    Container(
      child: const Image(
        image: AssetImage("images/binary-code-abstract-lu-.jpg"),
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    ),
    Container(
      child: const Image(
        image: AssetImage("images/vue-js-kk.jpg"),
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    ),
    Container(
      child: const Image(
        image: AssetImage("images/linux-penguin.jpg"),
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    ),
  ];

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 80),
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                // Check whether it's a last page or not
                setState(() {
                  isLastPage = index == pages.length - 1;
                });
              },
              children: pages,
            ),
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lime,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: isLastPage
                    ? TextButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const webview1(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          // foregroundColor: Colors.white,
                          // backgroundColor: const Color(0xff4db9ac),
                        ),
                        child: const Text(
                          "Let's Get Started",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const webview1(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.lightGreenAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Skip",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          SmoothPageIndicator(
                            controller: controller,
                            count: pages.length,
                            effect: const WormEffect(
                              spacing: 10,
                              type: WormType.underground,
                              dotColor: Colors.grey,
                              activeDotColor: Colors.blueAccent,
                            ),
                            onDotClicked: (index) => controller.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
