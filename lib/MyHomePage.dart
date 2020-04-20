import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_todo/Add.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_todo/Global.dart';
import 'dart:async';
import 'CustomAlert.dart';
import 'database_helper.dart';
import 'Note.dart';
import 'package:sqflite/sqflite.dart';

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              super.setState(() {
                updateListView();
              });
            }),
        title: Text('To Do List'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.done, size: 30),
          Icon(Icons.done_all, size: 30),
          Icon(Icons.done_outline, size: 30),
          Icon(Icons.delete, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.black,
        height: 50.0,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          super.setState(() {
            _page = index;
            updateListView();
          });
        },
      ),
      body: _page == 0
          ? getNoteListView()
          : _page == 1
              ? getDoingListView()
              : _page == 2 ? getDoneListView() : getDeleteListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          navigateToDetail(Note('', '', 2, 1));
        },
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        return this.noteList[position].status == 1
            ? GestureDetector(
                onTap: () {
                  setState(() {
//        list[index].isSelected = true;

                    showDialog(
                      context: context,
                      builder: (_) => LogoutOverlay(noteList[position]),
                    );
//              print("hi");
                  });
                },
                child: Container(
                  child: Card(
                    color: cardColor,
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.20,
                      child: ListTile(
                        leading: Container(
                          width: 5.0,
                          color: this.noteList[position].priority == 1
                              ? Colors.red
                              : Colors.green,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 7),
                          child: Text(this.noteList[position].title,
                              style: Theme.of(context).textTheme.title),
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                this.noteList[position].date,
                                style: TextStyle(color: Colors.white),
                              ),
                              Container(
                                color: Colors.yellow[200],
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "Do",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Edit',
                          color: Colors.blue,
                          icon: Icons.edit,
                          onTap: () => {
                            navigateToDetail(this.noteList[position]),
                          },
                        ),
                        IconSlideAction(
                            caption: 'Stoped',
                            color: Colors.red,
                            icon: Icons.stop,
                            onTap: () => {
                                  _delete(position),
                                }),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                            caption: 'Doing',
                            color: Colors.yellow,
                            icon: Icons.done_all,
                            onTap: () => {
//                        helper.updateNote(note)
                                  _UpdateNextsave(noteList[position].id),
                                }),
                        IconSlideAction(
                            color: Colors.green,
                            icon: Icons.done_outline,
                            caption: 'Done',
                            onTap: () => {
                                  _UpdateDonesave(noteList[position].id),
                                }),
                      ],
                    ),
                  ),
                ),
              )
            : null;
      },
    );
  }

  ListView getDoingListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        print("Main ${this.noteList[position].status}");
        return this.noteList[position].status == 2
            ? GestureDetector(
                onTap: () {
                  setState(() {
//        list[index].isSelected = true;
//
                    showDialog(
                      context: context,
                      builder: (_) => LogoutOverlay(noteList[position]),
                    );
//              print("hi");
                  });
                },
                child: Container(
                  child: Card(
                    color: cardColor,
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.20,
                      child: ListTile(
                        leading: Container(
                          width: 5.0,
                          color: this.noteList[position].priority == 1
                              ? Colors.red
                              : Colors.green,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 7),
                          child: Text(this.noteList[position].title,
                              style: Theme.of(context).textTheme.title),
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                this.noteList[position].date,
                                style: TextStyle(color: Colors.white),
                              ),
                              Container(
                                color: Colors.yellow[200],
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "Doing",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Edit',
                          color: Colors.blue,
                          icon: Icons.edit,
                          onTap: () => {
                            navigateToDetail(this.noteList[position]),
                          },
                        ),
                        IconSlideAction(
                            caption: 'Stoped',
                            color: Colors.red,
                            icon: Icons.stop,
                            onTap: () => {
                                  _delete(position),
                                }),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'DO',
                          color: Colors.yellow,
                          icon: Icons.done,
                          onTap: () => {
                            _UpdateDosave(this.noteList[position].id),
                          },
                        ),
                        IconSlideAction(
                            color: Colors.green,
                            icon: Icons.done_outline,
                            caption: 'Done',
                            onTap: () => {
                                  _UpdateDonesave(noteList[position].id),
                                }),
                      ],
                    ),
                  ),
                ),
              )
            : null;
      },
    );
  }

  ListView getDoneListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        return this.noteList[position].status == 3
            ? GestureDetector(
                onTap: () {
                  setState(() {
//        list[index].isSelected = true;
//
                    showDialog(
                      context: context,
                      builder: (_) => LogoutOverlay(noteList[position]),
                    );
//              print("hi");
                  });
                },
                child: Container(
                  child: Card(
                    color: cardColor,
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.20,
                      child: ListTile(
                        leading: Container(
                          width: 5.0,
                          color: this.noteList[position].priority == 1
                              ? Colors.red
                              : Colors.green,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 7),
                          child: Text(this.noteList[position].title,
                              style: Theme.of(context).textTheme.title),
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                this.noteList[position].date,
                                style: TextStyle(color: Colors.white),
                              ),
                              Container(
                                color: Colors.yellow[200],
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "Done",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Edit',
                          color: Colors.blue,
                          icon: Icons.edit,
                          onTap: () => {
                            navigateToDetail(this.noteList[position]),
                          },
                        ),
                        IconSlideAction(
                            caption: 'Stoped',
                            color: Colors.red,
                            icon: Icons.stop,
                            onTap: () => {
                                  _delete(position),
                                }),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                            caption: 'Doing',
                            color: Colors.yellow,
                            icon: Icons.done_all,
                            onTap: () => {}),
                        IconSlideAction(
                            color: Colors.green,
                            icon: Icons.done,
                            caption: 'Do',
                            onTap: () =>
                                {_UpdateDosave(this.noteList[position].id)}),
                      ],
                    ),
                  ),
                ),
              )
            : null;
      },
    );
  }

  ListView getDeleteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        return GestureDetector(
          onTap: () {
            setState(() {
//        list[index].isSelected = true;
//
              showDialog(
                context: context,
                builder: (_) => LogoutOverlay(noteList[position]),
              );
//              print("hi");
            });
          },
          child: Container(
            child: Card(
              color: cardColor,
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.20,
                child: ListTile(
                  leading: Container(
                    width: 5.0,
                    color: this.noteList[position].priority == 1
                        ? Colors.red
                        : Colors.green,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 7),
                    child: Text(this.noteList[position].title,
                        style: Theme.of(context).textTheme.title),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          this.noteList[position].date,
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          color: Colors.yellow[200],
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Edit',
                    color: Colors.blue,
                    icon: Icons.edit,
                    onTap: () => {
                      navigateToDetail(this.noteList[position]),
                    },
                  ),
                  IconSlideAction(
                      caption: 'Stoped',
                      color: Colors.red,
                      icon: Icons.stop,
                      onTap: () => {
                            print(noteList[position].status),
                          }),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                      caption: 'Doing',
                      color: Colors.yellow,
                      icon: Icons.done_all,
                      onTap: () => {}),
                  IconSlideAction(
                      color: Colors.green,
                      icon: Icons.done_outline,
                      caption: 'Done',
                      onTap: () => {
                            _delete(position),
                          }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void navigateToDetail(Note note) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Add(note);
        },
      ),
    );

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void _delete(position) async {
    int result = await databaseHelper.deleteNote(noteList[position].id);
    if (result != 0) {
      updateListView();
      print('Note Deleted successfully');
    } else {
      print('Error');
    }
  }

  void _UpdateNextsave(int position) async {
    var result = await databaseHelper.updateLevelNote(2, position);
    print("id is $position");
    updateListView();
    print("Result $result");
  }

  void _UpdateDosave(int position) async {
    var result = await databaseHelper.updateLevelNote(1, position);
    print("id is $position");
    updateListView();
    print("Result $result");
  }

  void _UpdateDonesave(int position) async {
    var result = await databaseHelper.updateLevelNote(3, position);
    print("id is $position");
    updateListView();
    print("Result $result");
  }
}
