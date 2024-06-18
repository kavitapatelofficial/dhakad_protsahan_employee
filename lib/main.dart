import 'package:dashboard_flutter/helper/get_storage_helper.dart';
import 'package:dashboard_flutter/providers/allocation_provider.dart';
import 'package:dashboard_flutter/providers/contractor_provider.dart';
import 'package:dashboard_flutter/providers/gifts_provider.dart';
import 'package:dashboard_flutter/providers/products_provider.dart';
import 'package:dashboard_flutter/providers/redemption_provider.dart';
import 'package:dashboard_flutter/routes.dart';
import 'package:dashboard_flutter/screens/allocations/allocation_view.dart';
import 'package:dashboard_flutter/screens/contractor/contractor_view.dart';
import 'package:dashboard_flutter/screens/gift_redemption/gift_redemption_view.dart';
import 'package:dashboard_flutter/screens/products/products_view.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'screens/gifts/giftview.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xffEDEFF8), // Set the status bar background color
      statusBarIconBrightness:
          Brightness.dark, // Set the status bar content color (black)
    ),
  );

  await GetStorage.init();
  GetStorageHelper.setinitialdata();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContractorProvider(),
          child: ContractorView(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: ProductsScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => GiftProvider(),
          child: GiftsVewScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => RedemptionProvider(),
          child: GiftRedemptionView(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllocationProvider(),
          child: AllocationView(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dhakad Protsahan Employee',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: generateRoutes,
        initialRoute: "/",
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05, .1, .2, .3, .4, .5, .6, .7, .8, .9];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 0; i < 10; i++) {
    swatch[(strengths[i] * 1000).round()] = Color.fromRGBO(
      r,
      g,
      b,
      strengths[i],
    );
  }

  return MaterialColor(color.value, swatch);
}
