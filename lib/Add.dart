import 'package:flutter/material.dart';
import 'Note.dart';
import 'database_helper.dart';
import 'package:intl/intl.dart';
import 'package:my_todo/Add.dart';

class Add extends StatefulWidget {
  final Note note;
  Add(this.note);
  @override
  State<StatefulWidget> createState() {
    return AddState(this.note);
  }
}

class AddState extends State<Add> {
  static var _priorities = ['High', 'Low'];
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Note note;

  AddState(this.note);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.9,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      //dropdown menu
                      child: new ListTile(
                        title: DropdownButton(
                            items: _priorities.map(
                              (String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            value: getPriorityAsString(note.priority),
                            onChanged: (valueSelectedByUser) {
                              setState(() {
                                updatePriorityAsInt(valueSelectedByUser);
                              });
                            }),
                      ),
                    ),
                    // Second Element
                    Padding(
                      padding:
                          EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0),
                      child: TextField(
                        controller: titleController,
                        style: TextStyle(fontSize: 15.0),
                        onChanged: (value) {
                          updateTitle();
                        },
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                      ),
                    ),

                    // Third Element
                    Padding(
                      padding:
                          EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0),
                      child: TextField(
                        controller: descriptionController,
                        style: TextStyle(fontSize: 15.0),
                        onChanged: (value) {
                          updateDescription();
                        },
                        decoration: InputDecoration(
                          labelText: 'Details',
                        ),
                      ),
                    ),

                    // Fourth Element
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 10.0, left: 25.0, right: 25.0),
                      child: Expanded(
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.green,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          top: 1.0, bottom: 25.0, left: 25.0, right: 25.0),
                      child: Container(
                        height: 40.0,
                        width: 100.0,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.green,
                          child: Text(
                            'Cancel',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateTitle() {
    if (note.title != null) {
      note.title = titleController.text;
    } else {}
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

//    note.date = DateFormat.yMMMd().format(DateTime.now());
    note.date = DateFormat.yMd('en_US').format(DateTime.now());
    print(note.date);

//    DateFormat.yMd('en_US').parse('1/10/2012');

    int result;
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      _showAlerDialog('Status', 'Note Saved successfully');
    } else {
      _showAlerDialog('Status', 'Problem saving Note');
    }
  }

//  void _delete() async {
//    moveToLastScreen();
//
//    if (note.id == null) {
//      _showAlerDialog('Status', 'First add a note');
//      return;
//    }
//
//    int result = await helper.deleteNote(note.id);
//    if (result != 0) {
//      _showAlerDialog('Status', 'Note Deleted successfully');
//    } else {
//      _showAlerDialog('Status', 'Error');
//    }
//  }

  //conver to int to save into database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  //convert int to String to show user
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlerDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
