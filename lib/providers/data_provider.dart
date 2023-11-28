import 'package:get/get.dart';
import '../models/item_model.dart';
import 'package:refactor_task/services/api_service.dart';
import 'package:refactor_task/services/database_service.dart';

// Enum to represent different view modes
enum ViewMode { list, grid }

// Controller class responsible for managing data and state using GetX
class DataModel extends GetxController {
  final ApiService apiService; // Service for fetching data from the API
  final DatabaseService
      databaseService; // Service for local database operations
  final RxList<Item> items = <Item>[].obs; // Observable list of items

  final Rx<ViewMode> viewMode = ViewMode.list.obs; // Observable view mode

  // Constructor to initialize the controller with required services
  DataModel(this.apiService, this.databaseService);

  // Lifecycle method called when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    _initializeData(); // Initialize data when the controller is created
  }

  // Method to initialize data by fetching from the local database or API
  Future<void> _initializeData() async {
    try {
      await databaseService
          .initializeDatabase(); // Initialize the local database

      // Retrieve items from the local database
      final localItems = await databaseService.getItemsFromDatabase();

      // If local items are available, add them to the observable list
      if (localItems.isNotEmpty) {
        items.addAll(localItems);
      } else {
        // If no local items, fetch items from the API
        await _fetchItemsFromApi();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize data: $e');
    }
  }

  // Method to fetch items from the API and store them locally
  Future<void> _fetchItemsFromApi() async {
    try {
      final fetchedItems =
          await apiService.fetchItems(); // Fetch items from the API
      await databaseService
          .insertItems(fetchedItems); // Insert items into the local database
      items.assignAll(
          fetchedItems); // Assign fetched items to the observable list
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data from API: $e');
    }
  }

  // Method to fetch and store items (can be triggered by user action)
  Future<void> fetchAndStoreItems() async {
    await _fetchItemsFromApi();
  }
}
