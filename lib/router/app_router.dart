import 'package:go_router/go_router.dart';
import 'package:remember_task/features/auth/presentation/register_screen.dart';
import 'package:remember_task/features/dashboard/presentation/dashboard_screen.dart';
import 'package:remember_task/features/splash/presentation/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import screens
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/auth/presentation/login_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/', // Splash Screen sebagai halaman awal
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => DashboardScreen(),
    ),
    // Tambahkan rute lain sesuai kebutuhan
  ],
  redirect: (context, state) async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (state.uri.toString() == '/' && isFirstTime) {
      return '/onboarding';
    } else if (state.uri.toString() == '/' && !isFirstTime) {
      return '/login';
    }

    return null; // Tidak ada redirect
  },
);
