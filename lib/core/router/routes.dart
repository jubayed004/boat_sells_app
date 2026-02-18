import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/features/splash/splash_screen.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.splashScreen.addBasePath,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      ///======================= Initial Route =======================
      GoRoute(
        name: RoutePath.splashScreen,
        path: RoutePath.splashScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const SplashScreen(),
            state: state,
          );
        },
      ),
/*      GoRoute(
        name: RoutePath.onboardingScreen,
        path: RoutePath.onboardingScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: OnboardingScreen(),
            state: state,
          );
        },
      ),*/
/*      GoRoute(
        name: RoutePath.vendorSelectionScreen,
        path: RoutePath.vendorSelectionScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const VendorSelectionScreen(),
            state: state,
          );
        },
      ),*/
/*      GoRoute(
        name: RoutePath.loginScreen,
        path: RoutePath.loginScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const LoginScreen(),
            state: state,
          );
        },
      ),*/
/*      GoRoute(
        name: RoutePath.signUpScreen,
        path: RoutePath.signUpScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const SignUpScreen(),
            state: state,
          );
        },
      ),*/

/*      GoRoute(
        name: RoutePath.forgetPasswordScreen,
        path: RoutePath.forgetPasswordScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const ForgetPasswordScreen(),
            state: state,
          );
        },
      ),*/
/*      GoRoute(
        name: RoutePath.verifyOtpScreen,
        path: RoutePath.verifyOtpScreen.addBasePath,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          final token = args?['token'] as String? ?? '';
          final email = args?['email'] as String? ?? '';
          final isSignUp = args?['isSignUp'] as bool? ?? false;
          return _buildPageWithAnimation(
            child: VerifyOtpScreen(
              token: token,
              isSignUp: isSignUp,
              email: email,
            ),
            state: state,
          );
        },
      ),*/
/*      GoRoute(
        name: RoutePath.resetPasswordScreen,
        path: RoutePath.resetPasswordScreen.addBasePath,
        pageBuilder: (context, state) {
          final token = state.extra as String? ?? '';
          return _buildPageWithAnimation(
            child: ResetPasswordScreen(token: token),
            state: state,
          );
        },
      ),*/
/*
      GoRoute(
        name: RoutePath.activeOtpScreen,
        path: RoutePath.activeOtpScreen.addBasePath,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          final email = args?['email'] as String? ?? '';
          final isSignUp = args?['isSignUp'] as bool? ?? false;
          final token = args?['token'] as String?;

          return _buildPageWithAnimation(
            child: ActiveOtpScreen(
              email: email,
              isSignUp: isSignUp,
              token: token,
            ),
            state: state,
          );
        },
      ),
*/

/*      GoRoute(
        name: RoutePath.driverNavScreen,
        path: RoutePath.driverNavScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: DriverNavScreen(),
            state: state,
          );
        },
      ),*/

      //=================Profile ===================
      // GoRoute(
      //   name: RoutePath.profileScreen,
      //   path: RoutePath.profileScreen.addBasePath,
      //   pageBuilder: (context, state) {
      //     return _buildPageWithAnimation(child: ProfileScreen(), state: state);
      //   },
      // ),
/*      GoRoute(
        name: RoutePath.editProfileScreen,
        path: RoutePath.editProfileScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: EditProfileScreen(),
            state: state,
          );
        },
      ),*/
/*      GoRoute(
        name: RoutePath.professionalInfoEditScreen,
        path: RoutePath.professionalInfoEditScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: ProfessionalInfoEditScreen(),
            state: state,
          );
        },
      ),*/
      /*
      GoRoute(
        name: RoutePath.professionalInfoScreen,
        path: RoutePath.professionalInfoScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: ProfessionalInfoScreen(),
            state: state,
          );
        },
      ),*/

      //=============Setting==========
/*      GoRoute(
        name: RoutePath.changePasswordScreen,
        path: RoutePath.changePasswordScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: ChangePasswordScreen(),
            state: state,
          );
        },
      ),*/

      // GoRoute(
      //   name: RoutePath.bookingsScreen,
      //   path: RoutePath.bookingsScreen.addBasePath,
      //   pageBuilder: (context, state) {
      //     return _buildPageWithAnimation(child: BookingsScreen(), state: state);
      //   },
      // ),
      /*GoRoute(
        name: RoutePath.categoryEventsScreen,
        path: RoutePath.categoryEventsScreen.addBasePath,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final map = (extra is Map<String, dynamic>) ? extra : {};

          final id = map['id'] as String? ?? '';
          final title = map['title'] as String? ?? '';

          return _buildPageWithAnimation(
            child: CategoryEventsScreen(id: id, title: title),
            state: state,
          );
        },
      ),*/
    ],
  );

  static CustomTransitionPage _buildPageWithAnimation({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static GoRouter get route => initRoute;
}
