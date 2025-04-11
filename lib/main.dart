import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:t_store/app.dart';
import 'package:t_store/data/repositories/authentication_repository.dart';
import 'package:t_store/firebase_options.dart';

Future<void> main() async {
  //Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //Initialize GetX Local Strorage
  await GetStorage.init();

  //Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  //Initialize Supabase
  await Supabase.initialize(
    url: 'https://xjyqicgkkshowzglsofw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhqeXFpY2dra3Nob3d6Z2xzb2Z3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQzNzc4MDMsImV4cCI6MjA1OTk1MzgwM30.6qv9hXWDfvSxuEBS1sgaHiFWyHNo3hYieh8TMEmgev8',
  );

  //Initialize Authentication

  runApp(const App());
}
