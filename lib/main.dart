import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_task/features/auth/bloc/auth_bloc.dart';
import 'package:remember_task/features/auth/data/auth_repository.dart';
import 'package:remember_task/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (FirebaseAuth.instance.app.name == '[DEFAULT]') {
    // Pastikan kita mengarahkan ke emulator di sini
    await FirebaseAuth.instance
        .useAuthEmulator('10.0.2.2', 9099); // 10.0.2.2 untuk Android Emulator
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthRepository()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
