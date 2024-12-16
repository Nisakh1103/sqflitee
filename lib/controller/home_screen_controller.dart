import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class HomeScreenController{

  static late Database database;

  static List <Map> employeesList =[];

   // step 1 -- initialize db


  
 static  Future<void> initializeDateBase() async {
    if (kIsWeb) {
  // Change default factory on the web
  databaseFactory = databaseFactoryFfiWeb;
}

// open the database

   database = await openDatabase("employee.db", version: 1,
    onCreate: ( db, int version) async {
  // When creating the db, create the table
  await db.execute(
      'CREATE TABLE Employee (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
});

   }


// Insert some records in a transaction
static addEmployee({required String name, required String designation}) async {
    database.rawInsert( 'INSERT INTO Employee(name, designation) VALUES(?, ?)',
      [name,designation ]);
    await getEmployee();
}
static Future updateEmployee({required String name ,required String designation,required int id}) async {
  await database.rawUpdate(
    'UPDATE employee SET name = ?, designation = ? WHERE id = ?',
    [name,designation,id]);

   await getEmployee();
}
static deleteEmployee(int id ) async {
  await database
    .rawDelete('DELETE FROM employee WHERE id = ?', [id]);
    await getEmployee();
}

// Get the records
static getEmployee() async {
    employeesList = await database.rawQuery('SELECT * FROM Employee');
    log(employeesList.toString());
}

}

