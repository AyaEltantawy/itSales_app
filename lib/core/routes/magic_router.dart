import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Route<dynamic>? onGenerateRoute(RouteSettings settings) => null;

class MagicRouter {
  /// ✅ Safely get current context (null if not ready)
  static BuildContext? get currentContext => navigatorKey.currentContext;

  /// Navigate using route name
  static Future<dynamic>? namedNavigation(String pageName, {Object? arguments}) =>
      navigatorKey.currentState?.pushNamed(pageName, arguments: arguments);

  /// Navigate to widget page
  static Future<dynamic>? navigateTo(Widget page, {Object? arguments}) =>
      navigatorKey.currentState?.push(_materialPageRoute(page));

  /// Navigate with slide transition
  static Future<dynamic>? navigateToWithSlideEffect(
      Widget page, {
        SlideDirection direction = SlideDirection.rtl,
        Curve curve = Curves.easeIn,
      }) {
    if (currentContext == null) return null;

    Offset beginOffset;
    switch (direction) {
      case SlideDirection.ltr:
        beginOffset = const Offset(-1.0, 0.0);
        break;
      case SlideDirection.btt:
        beginOffset = const Offset(0.0, 1.0);
        break;
      case SlideDirection.ttb:
        beginOffset = const Offset(0.0, -1.0);
        break;
      case SlideDirection.rtl:
      default:
        beginOffset = const Offset(1.0, 0.0);
    }

    return Navigator.push(
      currentContext!,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var tween = Tween(begin: beginOffset, end: Offset.zero)
              .chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  /// Navigate and remove all previous routes
  static Future<dynamic>? navigateAndPopAll(Widget page) =>
      navigatorKey.currentState?.pushAndRemoveUntil(
        _materialPageRoute(page),
            (_) => false,
      );

  /// Navigate and remove until first route
  static Future<dynamic>? navigateAndPopUntilFirstPage(Widget page) =>
      navigatorKey.currentState?.pushAndRemoveUntil(
        _materialPageRoute(page),
            (route) => route.isFirst,
      );

  /// Pop current route
  static void pop() => navigatorKey.currentState?.pop();

  /// Pop with result
  static void popWithResult(result) => navigatorKey.currentState?.pop(result);

  /// Internal material page route
  static Route<dynamic> _materialPageRoute(Widget page) =>
      MaterialPageRoute(builder: (_) => page);
}

enum SlideDirection { ltr, rtl, ttb, btt }
