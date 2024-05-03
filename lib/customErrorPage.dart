import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:japan_store/webview1.dart';
import 'package:webview_flutter/webview_flutter.dart';


class CustomErrorPage extends StatefulWidget{
  WebViewController controller;
  CustomErrorPage(this.controller, {super.key});

  @override
  State<StatefulWidget> createState() => _customErrorPage(controller);

}
class _customErrorPage extends State<CustomErrorPage>{
  WebViewController control;
  _customErrorPage(this.control);
  bool isRefreshing = false;

  bool _canPop = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: PopScope(
          canPop: _canPop,
          onPopInvoked: (bool didPop) => _canGoBack(context),
          child: Stack(
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height,
                child: const Image(
                  image: AssetImage("images/maintainance_new.png"),
                  // width: screenWidth,
                  // height: screenHeight,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top:Get.height*0.1),
                  child: const SizedBox(
                    child: Center(
                      child: Text(
                        "Under Maintainance",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 70,
              ),

              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top: Get.height*0.2, right: 50, left: 50),
                  child: const Positioned(
                    child: Expanded(
                      child: Center(
                        child: Text(
                          "Please try again later.",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Try Again Icon

              Positioned(
                top: Get.height*0.7,
                right: Get.width*0.35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text(
                    "Try Again!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const webview1()))
                ),
              ),
            ],
          ),
        ));
  }

  Future<bool> _canGoBack(BuildContext context) async {
      final shouldpop = await showDialog(
          context: context,
          builder: (context) => GiffyDialog(
            giffyPadding: EdgeInsets.zero,
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actionsPadding: const EdgeInsets.all(15),
            titlePadding: const EdgeInsets.only(top: 2.0),
            contentPadding: const EdgeInsets.only(top: 10),
            title: const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "Hold on a sec! 🚦",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            content: const Text(
              'Exiting the application\nAre you certain you want to exit?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Close dialog and prevent app exit
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
            giffy: Image.asset(
              "images/Exit.gif",
              fit: BoxFit.cover,
              height: 100,
            ),
          ));
      if (shouldpop != null && shouldpop) {
        SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      } else {
        setState(() {
          _canPop = false;
        });
      }
      return Future.value(true);
    }
  }
