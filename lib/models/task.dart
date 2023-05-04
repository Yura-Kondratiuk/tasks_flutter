

class Task {
   int? _id;
   late String _title;
   late String _detail;
   late String  _date;
   late int _priority;

  Task.withoutId(this._title,this._date,this._priority,this._detail);

  Task.whithId(this._id,this._title,this._date,this._priority,this._detail);

  int? get id => _id;
  String get title => _title;
  String get detail => _detail;
  String get date => _date;
  int get priority => _priority;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title =newTitle;
    }
  }
    set detail(String newDetail) {
      if (newDetail.length <= 255) {
        _detail =newDetail;
      }
    }
    set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2){
      _priority = newPriority;
      }
    }

    set date(String newDate) {
    _date = newDate;
    }
    Map<String, dynamic> toMap() {
      var map = <String, dynamic>{};
      if(id != null){
        map['id'] =_id;}
      map['title'] = _title;
      map['detail'] = _detail;
      map['priority'] = _priority;
      map['date'] = _date;

      return map;
    }

    Task.fromMapObject(Map<String,dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _detail = map['detail'];
    _priority = map['priority'];
    _date = map['date'];

    }
}