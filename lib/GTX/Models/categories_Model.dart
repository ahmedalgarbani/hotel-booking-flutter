class CategoriesModel
 {
  final int id;
  final String name;
  final String description;
    

  CategoriesModel
({
    required this.id,
    required this.name,
    required this.description,
     
  });

  factory CategoriesModel
.fromJson(Map<String, dynamic> jsonData) {
    return CategoriesModel
(
      id: jsonData['id'] ?? '',  
      name: jsonData['name'] ?? '',  
      description: jsonData['description'] ?? '',
             
    );
  }
}
