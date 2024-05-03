import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:upgrader/upgrader.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'NetworkController.dart';
import 'customErrorPage.dart';

class webview1 extends StatefulWidget {
  const webview1({super.key});

  @override
  State<webview1> createState() => _webview1State();
}

class _webview1State extends State<webview1> {

  bool _canPop = false;

  late bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final GlobalKey webViewKey = GlobalKey();
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url){
                print('New Website: $url');
            },
            onNavigationRequest: (NavigationRequest request){
              return NavigationDecision.navigate;
            },
              onWebResourceError: (WebResourceError error) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CustomErrorPage(controller)));
              },

          )
      )
      ..loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvoked: (bool didPop) => _goBack(context),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Colors.white60,
            title: _isSearching
                ? _buildSearchfield()
                : const Text(
                    "Company Name",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
            centerTitle: true,
            actions: _searchAction(),
            bottom: const PreferredSize(preferredSize: Size.fromHeight(10.0), child: WarningWidgetValueNotifier(),
            ),
          ),
        ),

        drawer: Drawer(
          elevation: 3,
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: [
              Container(
                height: 100,
                child: const DrawerHeader(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      //color: Colors.black,
                      ),
                  child: Text(
                    "Category",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text("Beverages"),
                leading: const Icon(Icons.emoji_food_beverage_rounded),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=64"));
                }
              ),
              ListTile(
                title: const Text("Cleaning & Household"),
                leading: const Icon(Icons.cleaning_services_rounded),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=60"));
                }
              ),
              ListTile(
                title: const Text("Daily Needs"),
                leading: const Icon(Icons.clean_hands_outlined),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=60"));
                }
              ),
              ListTile(
                title: const Text("Dairy & Bakery"),
                leading: const Icon(Icons.bakery_dining),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=62"));
                }
              ),
              ListTile(
                title: const Text("Fruit Juice"),
                leading: const Icon(Icons.local_drink),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=70"));
                }
              ),
              ListTile(
                title: const Text("Fruits"),
                leading: Icon(MdiIcons.fruitWatermelon),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=63"));
                }
              ),
              ListTile(
                title: const Text("Oil and Spices"),
                leading: Icon(MdiIcons.chiliHot),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=65"));
                }
              ),
              ListTile(
                title: const Text("Personal Care"),
                leading: Icon(MdiIcons.starFace),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=66"));
                }
              ),
              ListTile(
                title: const Text("Rice Grains"),
                leading: Icon(MdiIcons.grain),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=67"));
                }
              ),
              ListTile(
                title: const Text("Snacks & Food"),
                leading: Icon(MdiIcons.food),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=67"));
                }
              ),
              ListTile(
                title: const Text("Staple Food"),
                leading: Icon(MdiIcons.food),
                onTap: () async{
                  final url = await controller.currentUrl();
                  print('Previous Website: $url');
                  controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=product/category&path=69"));
                }
              )
            ],
          ),
        ),
        body: UpgradeAlert(
          showIgnore: true,
          showLater: true,
          shouldPopScope: () => true,
          dialogStyle: UpgradeDialogStyle.cupertino,
          upgrader: Upgrader(
            // debugLogging: true,
            debugDisplayAlways: true,
            // remember to remove or comment out this line before releasing
            languageCode: "en",
            countryCode: "IN",
            minAppVersion: "2.0.0",
            durationUntilAlertAgain: const Duration(minutes: 59),
          ),
          child: SafeArea(
            child: WebViewWidget(controller: controller),
          ),
        ),
        floatingActionButton: SpeedDial(
          elevation: 10,
          backgroundColor: Colors.green,
          animatedIcon: AnimatedIcons.menu_close,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          children: [
            SpeedDialChild(
              child: Icon(MdiIcons.cartVariant),
              label: 'Cart',
              onTap: () async{
                final url = await controller.currentUrl();
                print('Previous Website: $url');
                controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=checkout/cart"));
              }
            ),

            SpeedDialChild(
              child: Icon(MdiIcons.accountCreditCardOutline),
              label: 'Checkout',
              onTap: () async{
                final url = await controller.currentUrl();
                print('Previous Website: $url');
                controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=checkout/checkout"));
              }
            ),

            SpeedDialChild(
              child: Icon(MdiIcons.accountDetailsOutline),
              label: 'Profile',
              onTap: () async{
                final url = await controller.currentUrl();
                print('Previous Website: $url');
                controller.loadRequest(Uri.parse("https://japanstore.thebizsolutions.com/index.php?route=account/login"));
              }
            ),
          ],
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildSearchfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextField(
        autocorrect: true,
        keyboardType: TextInputType.text,
        controller: _searchController,
        decoration: const InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          hintText: 'Search...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black),
        ),
        // autofocus: true,
        onChanged: (value) {
          // search logic
          // changing logic
        },
      ),
    );
  }

  List<Widget> _searchAction() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              setState(() {
                _isSearching = false;
                _searchController.text = "";
              });
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.green,
            ))
      ];
    }
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return Future.value(false);
    } else {
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
                    fontWeight: FontWeight.w500,
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


}

class MenuItem {
  final IconData icon;
  final String text;
  final String page;

  const MenuItem({required this.icon, required this.text, required this.page});
}
