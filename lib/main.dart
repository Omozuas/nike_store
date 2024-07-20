import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_store/apis/timbu_api.dart';
import 'package:nike_store/db/cartdb.dart';
import 'package:nike_store/db/orderdb.dart';
import 'package:nike_store/db/sharedPrefrence_db.dart';
import 'package:nike_store/db/wishlistdb.dart';
import 'package:nike_store/widgets/bottomNav/BottomNav.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? subscription;
  var isDeviceConnected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = InternetConnection().onStatusChange.listen((onData) {
      print(onData);
      switch (onData) {
        case InternetStatus.connected:
          setState(() {
            isDeviceConnected = true;
          });

          break;

        case InternetStatus.disconnected:
          setState(() {
            isDeviceConnected = false;
          });
          break;
        default:
          setState(() {
            isDeviceConnected = false;
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isDeviceConnected
        ? MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ApiProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => DataBase(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => WishlistdbProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrderdbProvider(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: BottomNavigation(),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Lottie.asset('assets/animation/noNetwork.json')
            ],
          );
  }
}
