import 'package:flutter/material.dart';
import 'dart:async';
import 'dbhelper.dart';

class SQList extends StatefulWidget {
  SQList({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _SQListState createState() => _SQListState();
}

class _SQListState extends State<SQList> {
  Employee employee = Employee("", "", "", "");

  String firstname;
  String lastname;
  String emailId;
  String mobileno;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          '新增联系人',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.view_list),
            tooltip: '保存',
            onPressed: () {
              navigateToAddressList();
            },
          ),
        ],
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: '姓氏'),
                validator: (val) => val.length == 0 ? "如：李" : null,
                onSaved: (val) => this.firstname = val,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: '名称'),
                validator: (val) => val.length == 0 ? '如：哪吒' : null,
                onSaved: (val) => this.lastname = val,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: '手机号码'),
                validator: (val) => val.length == 0 ? '110120119' : null,
                onSaved: (val) => this.mobileno = val,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: '邮件'),
                validator: (val) => val.length == 0 ? '@qq.com' : null,
                onSaved: (val) => this.emailId = val,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  onPressed: _submit,
                  child: Text('保存'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return null;
    }
    var employee = Employee(firstname, lastname, mobileno, emailId);
    var dbHelper = DBHelper();
    dbHelper.saveEmployee(employee);
    _showSnackBar("联系人保存成功");
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  void navigateToAddressList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddressList()),
    );
  }
}

Future<List<Employee>> fetchEmployeesFromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<Employee>> employees = dbHelper.getEmployees();
  return employees;
}

// 通讯录列表
class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '通讯录',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<Employee>>(
          future: fetchEmployeesFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(snapshot.data[index].firstName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          Text(snapshot.data[index].lastName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          Divider()
                        ]);
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Container(
              alignment: AlignmentDirectional.center,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

// Model
class Employee {
  String firstName;
  String lastName;
  String mobileNo;
  String emailId;

  Employee(this.firstName, this.lastName, this.mobileNo, this.emailId);
  Employee.fromMap(Map map) {
    firstName = map[firstName];
    lastName = map[lastName];
    mobileNo = map[mobileNo];
    emailId = map[emailId];
  }
}
