import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
    );
  }
}
