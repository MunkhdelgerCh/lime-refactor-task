import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:refactor_task/models/item_model.dart';
import 'dart:async';

// Class responsible for making API calls and fetching data
class ApiService {
  final String baseUrl;

  // Constructor to initialize the base URL
  ApiService(this.baseUrl);

  // Asynchronous method to fetch a list of items from the API
  Future<List<Item>> fetchItems() async {
    // Send an HTTP GET request to the specified endpoint
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Decode the JSON response and map it to a list of Item objects
      final data = json.decode(response.body) as List;
      return data.map((item) => Item.fromJson(item)).toList();
    } else {
      // If the response status code is not 200, throw an exception
      throw Exception('Failed to fetch data from API');
    }
  }
}
