import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await instalais();
      return _db;
    } else {
      return _db;
    }
  }
         
  instalais() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'hotel.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("upgrade======================");
    // await db.execute(" ALTER TABLE notese ADD COLUMN title TEXT NOT NULL ");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE hotels (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      hotel_name TEXT NOT NULL,
      hotel_email TEXT NOT NULL,
      hotel_description TEXT NOT NULL,
      hotel_image BLOB
    )
  ''');

    await db.execute('''
    CREATE TABLE room_type (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      room_type_name TEXT NOT NULL,
      room_description TEXT,
      max_capacity INTEGER,
      default_capacity INTEGER,
      room_account INTEGER,
      category_id INTEGER,
      hotel_id INTEGER,
      FOREIGN KEY (category_id) REFERENCES categories(id),
      FOREIGN KEY (hotel_id) REFERENCES hotel(id)
    )
  ''');
    await db.execute('''
    CREATE TABLE categories (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      category_name TEXT NOT NULL,
      hotel_id INTEGER,
      FOREIGN KEY (hotel_id) REFERENCES hotel(id)
    )
  ''');

    await db.execute('''
    CREATE TABLE room_image (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      image_name TEXT NOT NULL,
      image BLOB,
      hotel_id INTEGER,
      room_type_id INTEGER,
      FOREIGN KEY (hotel_id) REFERENCES hotel(id),
      FOREIGN KEY (room_type_id) REFERENCES room_type(id)
    )
  ''');

    await db.execute('''
    CREATE TABLE room_price (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      price DECIMAL NOT NULL,
      hotel_id INTEGER,
      room_type_id INTEGER,
      FOREIGN KEY (hotel_id) REFERENCES hotel(id),
      FOREIGN KEY (room_type_id) REFERENCES room_type(id)
    )
  ''');

    await db.execute('''
CREATE TABLE availability (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  availability_date DATE NOT NULL,
  available_rooms INTEGER NOT NULL,
  room_type_id INTEGER,
  hotel_id INTEGER,
  FOREIGN KEY (hotel_id) REFERENCES hotel(id),
  FOREIGN KEY (room_type_id) REFERENCES room_type(id)
)
''');

    await db.execute('''
    CREATE TABLE bookings (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      booking_date DATE NOT NULL,
      room_type_id INTEGER,
      hotel_id INTEGER,
      availability_id INTEGER,
      FOREIGN KEY (hotel_id) REFERENCES hotel(id),
      FOREIGN KEY (room_type_id) REFERENCES room_type(id),
      FOREIGN KEY (availability_id) REFERENCES availability(id)
    )
  ''');

    print("Database created successfully ===================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  insertDataimag(String sql, List<dynamic> params) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql, params);
    return response;
  }

  updateDataimag(String sql, List<dynamic> params) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql, params);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteitem(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  // deleteData(String sql) async {
  //   Database? mybe = await db;
  //   String response = await mybe!.readTransaction(sql as Future<String> Function(Transaction txn));
  // }

  deteteData() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'Mylibrary.db');
    await deleteDatabase(path);
  }
}
