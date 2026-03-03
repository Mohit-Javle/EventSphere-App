import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'providers/auth_provider.dart';
import 'providers/event_provider.dart';
import 'providers/location_provider.dart';
import 'providers/theme_provider.dart';
import 'shared/theme/es_theme.dart';
import 'routes/app_router.dart';
// import 'firebase_options.dart'; // Uncomment after running 'flutterfire configure'

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // } catch (e) {
  //   debugPrint("Firebase initialization failed: \$e");
  // }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const EventSphereApp(),
    ),
  );
}

class EventSphereApp extends StatelessWidget {
  const EventSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp.router(
            title: 'EventSphere',
            debugShowCheckedModeBanner: false,
            theme: EsTheme.darkTheme,
            routerConfig: AppRouter.createRouter(context.read<AuthProvider>()),
          ),
        );
      },
    );
  }
}
