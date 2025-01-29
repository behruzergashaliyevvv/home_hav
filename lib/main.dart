import 'package:flutter/material.dart';
import 'package:uyishi/core/common/app/services/injcetion_container.dart';
import 'package:uyishi/core/utils/constants/prefs_keys.dart';
import 'package:uyishi/features/auth/presentation/controller/auth_provider.dart';
import 'package:uyishi/features/auth/presentation/screens/login_screen.dart';
import 'package:uyishi/features/home/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<AuthProvider>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: getIt<SharedPreferences>().getString(PrefsKeys.tokenKey) != null
            ? LoginScreen()
            : LoginScreen(),
      ),
    );
  }
}
