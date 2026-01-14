// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:uber_users_app/authentication/login_screen.dart';
//
// void main() async {
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   if(Platform.isAndroid){
//     await Firebase.initializeApp(
//       options: FirebaseOptions(
//           apiKey: "AIzaSyCL7PcBZSJGTsATPlqpGKMP1YwDI_cMPfE",
//           authDomain: "uber-users-app-63737.firebaseapp.com",
//           projectId: "uber-users-app-63737",
//           storageBucket: "uber-users-app-63737.firebasestorage.app",
//           messagingSenderId: "925042735536",
//           appId: "1:925042735536:web:620f32cdb651dd6b0c7e75",
//           measurementId: "G-G8HFLLR234"
//       )
//     );
//   } else {
//     await Firebase.initializeApp();
//   }
//
//   runApp(const MyApp());
// }
//
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: Colors.black
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
//


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uber_users_app/authentication/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      if (kIsWeb) {
        // Web requires FirebaseOptions
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyCL7PcBZSJGTsATPlqpGKMP1YwDI_cMPfE",
            authDomain: "uber-users-app-63737.firebaseapp.com",
            projectId: "uber-users-app-63737",
            storageBucket: "uber-users-app-63737.appspot.com",
            messagingSenderId: "925042735536",
            appId: "1:925042735536:web:620f32cdb651dd6b0c7e75",
            measurementId: "G-G8HFLLR234",
          ),
        );
      } else {
        // Mobile platforms (Android/iOS) use default configs
        await Firebase.initializeApp();
      }
    }
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
      debugPrint('Firebase already initialized. Skipping...');
    } else {
      rethrow; // unexpected errors
    }
  }
  
  await Permission.locationWhenInUse.isDenied.then((valueOfPermission){
    if(!kIsWeb){
      Permission.locationWhenInUse.request();
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber Users App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: LoginScreen(),
    );
  }
}

/// geolocator dependency was added and it threw an error

///----------------remember to delete line 1-15 in android build gradle-------------////