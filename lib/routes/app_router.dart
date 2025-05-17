import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:ubtsimulation/features/ubt_simulation/ubt_simulation_page.dart';
import 'package:ubtsimulation/pages/auth/home_screen.dart';
import 'package:ubtsimulation/pages/auth/login_screen.dart';
import 'package:ubtsimulation/pages/onboarding/onboarding_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/onboarding',
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final isOnboarding = state.uri.path == '/onboarding';
    final isLoggingIn = state.uri.path == '/login';

    // Jika user sudah login, arahkan ke home dari mana saja
    if (user != null && (isLoggingIn || isOnboarding)) return '/home';

    // Jika user belum login dan sedang di onboarding atau login, biarkan
    if (user == null && (isOnboarding || isLoggingIn)) return null;

    // Jika user belum login dan bukan di onboarding atau login, arahkan ke onboarding
    if (user == null) return '/onboarding';

    return null;
  },
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/ubt-simulation',
      builder: (context, state) => UbtSimulationPage(),
    ),
  ],
);
