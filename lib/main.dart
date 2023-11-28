import 'package:flutter/material.dart';
import 'providers/data_provider.dart';
import 'services/api_service.dart';
import 'services/database_service.dart';
import 'screens/my_home_page.dart';
import 'package:get/get.dart';

void main() {
  // Initialize database service and API service
  final DatabaseService databaseService = DatabaseService();
  final ApiService apiService =
      ApiService('https://jsonplaceholder.typicode.com');

  // Inject DataModel with ApiService and DatabaseService dependencies using GetX
  Get.put<DataModel>(DataModel(apiService, databaseService));

  runApp(
    const MyApp(),
  );
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Configure the MaterialApp with theme and home screen
    return MaterialApp(
      title: 'Refactor Task App',
      // Light theme configuration
      theme: ThemeData(primarySwatch: Colors.blue),
      // Dark theme configuration
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
        ),
      ),
      // Theme mode set to system, allowing the app to automatically switch between light and dark mode based on system settings
      themeMode: ThemeMode.system,
      // Set the initial screen to MyHomePage
      home: const MyHomePage(),
    );
  }
}
