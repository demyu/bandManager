class Songs {
  int _date, _id;
  String _name, _songOwner;

  Songs(this._name, this._date, this._songOwner);
  Songs.withID(this._id, this._name, this._date, this._songOwner);
  Songs.fromDB(Map<String, dynamic> data) {
    this._id = data['id'];
    this._name = data['songname'];
    this._date = data['date'];
    this._songOwner = data['bandowner'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'songname': this._name,
      'date': this._date,
      'bandowner': this._songOwner
    };
    if (_id != null) {
      data['id'] = this._id;
    }
    return data;
  }

  int getId() {
    return this._id;
  }

  String getSongName() {
    return this._name;
  }

  int getDate(){
    return this._date;
  }

  String getOwner(){
    return this._songOwner;
  }
}