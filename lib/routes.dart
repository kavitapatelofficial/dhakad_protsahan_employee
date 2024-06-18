import 'package:dashboard_flutter/screens/allocations/add_allocation.dart';
import 'package:dashboard_flutter/screens/allocations/allocation_search.dart';
import 'package:dashboard_flutter/screens/allocations/allocation_view.dart';
import 'package:dashboard_flutter/screens/contractor/add_contactor.dart';
import 'package:dashboard_flutter/screens/contractor/contractor_view.dart';
import 'package:dashboard_flutter/screens/dashboard/dashboard.dart';
import 'package:dashboard_flutter/screens/gift_redemption/add_redemption.dart';
import 'package:dashboard_flutter/screens/gift_redemption/gift_redemption_view.dart';
import 'package:dashboard_flutter/screens/gift_redemption/redemption_contact_search.dart';
import 'package:dashboard_flutter/screens/gift_redemption/redemption_search.dart';
import 'package:dashboard_flutter/screens/gifts/add_gift.dart';
import 'package:dashboard_flutter/screens/gifts/giftview.dart';

import 'package:dashboard_flutter/screens/otp/otp_screen.dart';
import 'package:dashboard_flutter/screens/points_sales_history/deduct_point_history.dart';
import 'package:dashboard_flutter/screens/points_sales_history/points_sales_history.dart';
import 'package:dashboard_flutter/screens/products/add_products.dart';
import 'package:dashboard_flutter/screens/products/products_view.dart';
import 'package:dashboard_flutter/screens/sign_in/sign_in_screen.dart';
import 'package:dashboard_flutter/screens/splash/splash_screen.dart';
import 'package:dashboard_flutter/screens/user/edit_profile.dart';
import 'package:dashboard_flutter/screens/webview/about_us.dart';
import 'package:dashboard_flutter/screens/webview/disclaimer.dart';
import 'package:dashboard_flutter/screens/webview/privacy_policy.dart';
import 'package:dashboard_flutter/screens/webview/terms_conditions.dart';
import 'package:dashboard_flutter/screens/webview/webview.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => SplashScreen());
    case '/dashboard':
      return MaterialPageRoute(builder: (_) => DashboardScreen());

    case '/signin':
      return MaterialPageRoute(builder: (_) => SignInScreen());

    case '/update-profile':
      return MaterialPageRoute(builder: (_) => UpdateProfileScreen());

    case '/products':
      return MaterialPageRoute(builder: (_) => ProductsScreen());
    case '/add-product':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => AddProductsScreen(
                arguments: args,
              ));

    case '/contractor':
      return MaterialPageRoute(builder: (_) => ContractorView());
    case '/add-contractor':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => AddContractorScreen(
                arguments: args,
              ));

    case '/gifts':
      return MaterialPageRoute(builder: (_) => GiftsVewScreen());
    case '/add-gift':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => AddGiftsScreen(
                arguments: args,
              ));

    case '/allocation':
      return MaterialPageRoute(builder: (_) => AllocationView());
    case '/about':
      return MaterialPageRoute(builder: (_) => AboutScreen());

    case '/terms':
      return MaterialPageRoute(builder: (_) => TermsandCondtions());

    case '/desc':
      return MaterialPageRoute(builder: (_) => DesclaimerScreen());
    case '/privacy':
      return MaterialPageRoute(builder: (_) => PrivcayPolicy());
    case '/allocation-search':
      return MaterialPageRoute(builder: (_) => AllocationSearch());

    case '/redemption-contact-search':
      return MaterialPageRoute(builder: (_) => RedemptionContactSearch());
    case '/add-allocation':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => AddAllocationScreen(
                arguments: args,
              ));

    case '/gift-redemption':
      return MaterialPageRoute(builder: (_) => GiftRedemptionView());
    case '/add-gift-redemption':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => AddGiftRedemptionScreen(
                arguments: args,
              ));

    case '/webview':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => WebviewPage(
                url: args['url'],
                title: args['title'],
              ));
    case '/redemption-search':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => RedemptionSearch(
                gId: args['id'],
                arguments: args,
              ));

    case '/otp':
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (_) => OtpScreen(
                email: args['email'],
                password: '${args['password']}',
              ));

    // case '/new-order':
    // final args = settings.arguments as Map<String, dynamic>;
    //   return MaterialPageRoute(builder: (_) => NewOrderScreen(
    //     name: args['name'],
    //   ));
    case '/points-sales-history':
      return MaterialPageRoute(builder: (_) => PointSalesHistory());
    case '/deduct-point-history':
      return MaterialPageRoute(builder: (_) => DeductPointHistory());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
