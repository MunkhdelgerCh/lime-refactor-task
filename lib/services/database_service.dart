import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:refactor_task/models/item_model.dart';

// Service class responsible for handling local database operations using Hive
class DatabaseService {
  late Box<Item> _itemBox; // Hive Box for storing Item objects

  // Initialize the Hive database
  Future<void> initializeDatabase() async {
    await Hive.initFlutter(); // Initialize Hive for Flutter

    // Get the application's documents directory for storing Hive data
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(
        ItemAdapter()); // Register the ItemAdapter for serialization/deserialization
    _itemBox = await Hive.openBox<Item>(
        'items'); // Open the Hive Box named 'items' (or create it if it doesn't exist)
  }

  // Retrieve a list of items from the local database
  Future<List<Item>> getItemsFromDatabase() async {
    // Retrieve all values from the 'items' Box and convert them to a list
    final items = _itemBox.values.toList();
    return List<Item>.from(items);
  }

  // Insert a list of items into the local database
  Future<void> insertItems(List<Item> items) async {
    await _itemBox.clear(); // Clear the existing items in the 'items' Box
    await _itemBox.addAll(
        items); // Add all items from the provided list to the 'items' Box
  }
}
