import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hello_flutter_app/SQList/root.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Employee(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, mobileno TEXT,emailId TEXT )");
    print("Created tables");
  }

  void saveEmployee(Employee employee) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Employee(firstname, lastname, mobileno, emailid ) VALUES(' +
              '\'' +
              employee.firstName +
              '\'' +
              ',' +
              '\'' +
              employee.lastName +
              '\'' +
              ',' +
              '\'' +
              employee.mobileNo +
              '\'' +
              ',' +
              '\'' +
              employee.emailId +
              '\'' +
              ')');
    });
  }

  Future<List<Employee>> getEmployees() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Employee');
    List<Employee> employees = List();
    for (int i = 0; i < list.length; i++) {
      employees.add(Employee(list[i]["firstname"], list[i]["lastname"],
          list[i]["mobileno"], list[i]["emailid"]));
    }
    print(employees.length);
    return employees;
  }
}
