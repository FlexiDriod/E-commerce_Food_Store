import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rxdart/rxdart.dart';

import 'main.dart';

enum ConnectionStatus {
  online,
  offline,
}

class CheckInternetConnection {
  final Connectivity _connectivity = Connectivity();

  // Default will be online. This controller will help to emit new states when the connection changes.
  final _controller = BehaviorSubject.seeded(ConnectionStatus.online);
  StreamSubscription? _connectionSubscription;

  CheckInternetConnection() {
    _checkInternetConnection();
  }

  // The [ConnectionStatusValueNotifier] will subscribe to this
  // stream and every time the connection status changes it
  // will update its value
  Stream<ConnectionStatus> internetStatus() {
    _connectionSubscription ??= _connectivity.onConnectivityChanged
        .listen((_) => _checkInternetConnection());
    return _controller.stream;
  }

  // Code from StackOverflow
  Future<void> _checkInternetConnection() async {
    try {
      // Sometimes, after we connect to a network, this function will
      // be called but the device still does not have an internet connection.
      // This 3 seconds delay will give some time to the device to
      // connect to the internet in order to avoid false-positives
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _controller.sink.add(ConnectionStatus.online);
      } else {
        _controller.sink.add(ConnectionStatus.offline);
      }
    } on SocketException catch (_) {
      _controller.sink.add(ConnectionStatus.offline);
    }
  }

  Future<void> close() async {
    // Cancel subscription and close controller
    await _connectionSubscription?.cancel();
    await _controller.close();
  }
}

class ConnectionStatusValueNotifier extends ValueNotifier<ConnectionStatus> {
  // Will keep a subscription to
  // the class [CheckInternetConnection]
  late StreamSubscription _connectionSubscription;

  ConnectionStatusValueNotifier() : super(ConnectionStatus.online) {
    // Everytime there a new connection status is emitted
    // we will update the [value]. This will make the widget
    // to rebuild
    _connectionSubscription = internetChecker
        .internetStatus()
        .listen((newStatus) => value = newStatus);
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}

class WarningWidgetValueNotifier extends StatelessWidget {
  const WarningWidgetValueNotifier({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectionStatusValueNotifier(),
      builder: (context, ConnectionStatus status, child) {
        return Visibility(
          visible: status != ConnectionStatus.online,
          child: Container(
            margin: const EdgeInsets.all(5.0),
            height: 25,
            color: Colors.black26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(
                    MdiIcons.wifiOff,
                  size: 25,
                  color: Colors.red,
                ),
                const SizedBox(width: 10),
                const Text(
                  'No internet connection',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 18
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
