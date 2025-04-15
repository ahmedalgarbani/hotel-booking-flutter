class favrourHotelsModel {
  final int id;
  final String name;
  final String image;
  final String description;
  final String location;
  final List<favrourmodelRoomm> rooms;

  favrourHotelsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.location,
    required this.rooms,
  });

  factory favrourHotelsModel.fromJson(Map<String, dynamic> jsonData) {
    print("بيانات الفندق: ${jsonData}");
    print("بيانات الفندق: ${jsonData}");
    print("بيانات الفندق: ${jsonData}");

    print("اسم الفندق: ${jsonData['name']}");
    print("اسم الفندق: ${jsonData['name']}");
    print("اسم الفندق: ${jsonData['name']}");
    print("اسم الفندق: ${jsonData['name']}");
   
  return favrourHotelsModel(
    id: jsonData['id'] ?? 0,  
    name: jsonData['name'] ??"", 
    image: jsonData['profile_picture'] ?? "",  
    description: jsonData['description'] ??"",  
    location: jsonData['location'] ?? "",  
    rooms: (jsonData['rooms'] as List<dynamic>?)
            ?.map((room) => favrourmodelRoomm.fromJson(room))
            .toList() ?? [], 
  );


  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_picture': image,
      'description': description,
      'location': location,
      'rooms': rooms.map((room) => room.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Hotel(name: $name, image: $image)';
  }
}

class favrourmodelRoomm {
  final int id;
  final String name;
  final String description;
  final int defaultCapacity;
  final int maxCapacity;
  final int bedsCount;
  final int roomsCount;
  final double basePrice;
  final List<mfavrourodelRoomImagee> roomImages;
  final List<favrourmodelServiceModel> services;

  favrourmodelRoomm({
    required this.id,
    required this.name,
    required this.description,
    required this.defaultCapacity,
    required this.maxCapacity,
    required this.bedsCount,
    required this.roomsCount,
    required this.basePrice,
    required this.roomImages,
    required this.services,
  });

  factory favrourmodelRoomm.fromJson(Map<String, dynamic> jsonData) {
    return favrourmodelRoomm(
      id: jsonData['id'] ?? 0,
      name: jsonData['name'] ??"",
      description: jsonData['description'] ?? "",
      defaultCapacity: jsonData['default_capacity'] ?? 0,
      maxCapacity: jsonData['max_capacity'] ?? 0,
      bedsCount: jsonData['beds_count'] ?? 0,
      roomsCount: jsonData['rooms_count'] ?? 0,
      basePrice: double.tryParse(jsonData['base_price'].toString()) ?? 0.0,
      roomImages: (jsonData['images'] as List<dynamic>?)
              ?.map((img) => mfavrourodelRoomImagee.fromJson(img))
              .toList() ??
          [], // ✅ تجنب Null
      services: (jsonData['services'] as List<dynamic>?)
              ?.map((service) => favrourmodelServiceModel.fromJson(service))
              .toList() ??
          [], // ✅ تجنب Null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'default_capacity': defaultCapacity,
      'max_capacity': maxCapacity,
      'beds_count': bedsCount,
      'rooms_count': roomsCount,
      'base_price': basePrice,
      'images': roomImages.map((image) => image.toJson()).toList(),
      'services': services.map((service) => service.toJson()).toList(),
    };
  }
}

class mfavrourodelRoomImagee {
  final int id;
  final String imageUrl;
  final bool isMain;
  final String caption;

  mfavrourodelRoomImagee({
    required this.id,
    required this.imageUrl,
    required this.isMain,
    required this.caption,
  });

  factory mfavrourodelRoomImagee.fromJson(Map<String, dynamic> jsonData) {
    return mfavrourodelRoomImagee(
      id: jsonData['id'] ?? 0,
      imageUrl: jsonData['image_url'] ?? "",
      isMain: jsonData['is_main'] ?? false,
      caption: jsonData['caption'] ??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'is_main': isMain,
      'caption': caption,
    };
  }
}

class favrourmodelServiceModel {
  final int id;
  final String name;
  final String description;
  final double? additionalFee;

  favrourmodelServiceModel({
    required this.id,
    required this.name,
    required this.description,
    this.additionalFee,
  });

  factory favrourmodelServiceModel.fromJson(Map<String, dynamic> jsonData) {
    return favrourmodelServiceModel(
      id: jsonData['id'] ?? 0,
      name: jsonData['name'] ?? "",
      description: jsonData['description'] ?? "",
      additionalFee: jsonData['additional_fee'] != null
          ? double.tryParse(jsonData['additional_fee'].toString()) ?? 0.0
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'additional_fee': additionalFee,
    };
  }
}
