class Note {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;
  int _status;

  Note(this._title, this._date, this._priority, this._status,
      [this._description]);
  Note.withId(this._id, this._title, this._date, this._priority, this._status,
      [this._description]);

// All the getters
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;
  int get status => _status;

  // All the setter
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2 && newPriority <= 3) {
      this._priority = newPriority;
    }
  }

  set status(int newStatus) {
    if (status >= 1 && status <= 2 && status <= 3 && status <= 4) {
      this.status = newStatus;
    }
  }

  //Used to save and retrive from database

//convert note object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['status'] = _status;
    map['date'] = _date.toString();
    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
    this._status = map['status'];
  }
}
