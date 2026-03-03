import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/role_selection_screen.dart';
import '../screens/auth/profile_setup_screen.dart';
import '../screens/organizer/organizer_dashboard.dart';
import '../screens/organizer/create_event_wizard.dart';
import '../screens/main/main_layout.dart';
import '../screens/event_detail/event_detail_screen.dart';
import '../screens/ticket_purchase/ticket_purchase_screen.dart';
import '../screens/tickets/digital_ticket_detail.dart';
import '../screens/organizer/attendee_check_in.dart';
import '../screens/community/discussion_board.dart';
import '../screens/profile/user_profile_screen.dart';
import '../screens/profile/notification_screen.dart';

class AppRouter {
  static GoRouter createRouter(AuthProvider authProvider) {
    return GoRouter(
      initialLocation: '/splash',
      refreshListenable: authProvider,
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/create-event',
          builder: (context, state) => const CreateEventWizard(),
        ),
        GoRoute(
          path: '/organizer',
          builder: (context, state) => const OrganizerDashboard(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/role-selection',
          builder: (context, state) => const RoleSelectionScreen(),
        ),
        GoRoute(
          path: '/profile-setup',
          builder: (context, state) => const ProfileSetupScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const MainLayout(),
        ),
        GoRoute(
          path: '/event/:id',
          builder: (context, state) => EventDetailScreen(id: state.pathParameters['id'] ?? ""),
        ),
        GoRoute(
          path: '/purchase/:id',
          builder: (context, state) => TicketPurchaseScreen(id: state.pathParameters['id'] ?? ""),
        ),
        GoRoute(
          path: '/check-in',
          builder: (context, state) => const AttendeeCheckIn(),
        ),
        GoRoute(
          path: '/discussions',
          builder: (context, state) => const DiscussionBoard(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const UserProfileScreen(),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationScreen(),
        ),
        GoRoute(
          path: '/ticket/:id',
          builder: (context, state) => DigitalTicketDetail(id: state.pathParameters['id']!),
        ),
        // Add more routes here as we build them...
        // For now, redirect anything not found to splash
      ],
      redirect: (context, state) {
        final isLoading = authProvider.isLoading;
        final isAuthenticated = authProvider.isAuthenticated;
        final hasSeenOnboarding = authProvider.hasSeenOnboarding;
        
        final isSplash = state.matchedLocation == '/splash';
        final isOnboarding = state.matchedLocation == '/onboarding';
        final isLogin = state.matchedLocation == '/login';
        final isRegister = state.matchedLocation == '/register';
        
        // 1. If still loading from SharedPreferences, stay on splash
        if (isLoading) return isSplash ? null : '/splash';

        // 2. If authenticated:
        if (isAuthenticated) {
          // If on an auth/onboarding route, go to home
          if (isSplash || isOnboarding || isLogin || isRegister) return '/home';
          return null;
        }

        // 3. If NOT authenticated:
        if (isSplash) {
          // From splash, decide based on onboarding flag
          return hasSeenOnboarding ? '/login' : '/onboarding';
        }

        // If on onboarding but already seen it, go to login
        if (isOnboarding && hasSeenOnboarding) return '/login';

        // If not authenticated and NOT on allowed routes, force login/onboarding
        bool isAllowed = isOnboarding || isLogin || isRegister;
        if (!isAllowed) return hasSeenOnboarding ? '/login' : '/onboarding';

        return null;
      },
    );
  }
}
