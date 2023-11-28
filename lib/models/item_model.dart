import 'package:hive/hive.dart';

// HiveType annotation to mark the class as a Hive data model
@HiveType(typeId: 0)
class Item extends HiveObject {
  // HiveField annotation to mark class fields for serialization
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? description;

  // Constructor to initialize Item object
  Item({
    required this.id,
    this.title,
    this.description,
  });

  // Factory method to create Item object from JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['body'],
    );
  }

  // Method to convert Item object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}

// TypeAdapter to handle serialization and deserialization of Item objects
class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 0; // Unique identifier for the TypeAdapter

  // Method to read Item object from binary data
  @override
  Item read(BinaryReader reader) {
    final fields = reader.readMap().cast<String, dynamic>();
    return Item.fromJson(fields);
  }

  // Method to write Item object to binary data
  @override
  void write(BinaryWriter writer, Item obj) {
    writer.writeMap(obj.toJson());
  }
}
