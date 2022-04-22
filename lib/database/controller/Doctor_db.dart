// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DbDoctorController {
//   static final DbDoctorController _instance = DbDoctorController._();
//
//   factory DbDoctorController() {
//     return _instance;
//   }
//
//   DbDoctorController._();
//
//   late Database _database;
//
//   Database get database => _database;
//
//   Future<void> initDatabase() async {
//     // create database name db.sql in path have two table Doctor and Patient Task when create table print massage have name table
//     String databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'db.sql');
//     _database = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute(
//           'CREATE TABLE Doctor(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, address TEXT, phone TEXT, email TEXT, password TEXT)');
//
//       print('Create table Doctor');
//     });
//
//
//   }
//   //   Directory directory = await getApplicationDocumentsDirectory();
//   //   String path = join(directory.path, 'db.sql');
//   //   _database = await openDatabase(path, version: 1,
//   //       onCreate: (Database db, int version) {
//   //         db.execute(
//   //           'CREATE TABLE doctorTasks ('
//   //               'id INTEGER PRIMARY KEY AUTOINCREMENT, '
//   //               'title STRING, '
//   //               'note TEXT, '
//   //               'isCompleted INTEGER, '
//   //               'color INTEGER, '
//   //               'startTime STRING, '
//   //               'endTime STRING, '
//   //               'date INTEGER, '
//   //               'remind INTEGER, '
//   //               'repeat STRING)',
//   //         );
//   //       });
//   //   print('Database created');
//   // }
// }
