import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginsignupusingbloc/bloc/login_bloc.dart';
import 'package:loginsignupusingbloc/ui/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(),
        child: MaterialApp(
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true),
            debugShowCheckedModeBanner: false,
            home: const LoginScreen()));
  }
}
