import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_mobx/screens/login_screen.dart';
import 'package:study_mobx/stores/login_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
      create: (_) => LoginStore(),
      child: MaterialApp(
        title: 'Study MobX',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          scaffoldBackgroundColor: Colors.deepPurpleAccent,
        ),
        home: LoginScreen(),
      ),
    );
  }
}