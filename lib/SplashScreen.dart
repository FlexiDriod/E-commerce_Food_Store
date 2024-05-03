import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:japan_store/webview1.dart';

import 'WelcomeCarsouel.dart';

class SplashScreen extends StatefulWidget {
  final bool showHome;

  const SplashScreen({super.key, required this.showHome});

  @override
  State<StatefulWidget> createState() => _SplashScreen(showHome: showHome);
}

class _SplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final bool showHome;

  _SplashScreen({required this.showHome});

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => showHome ? const webview1() : const WelcomeCarsouel(),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        /*_system UI won't automatically change based on user interactions_*/
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                "images/js.png",
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
