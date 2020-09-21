class Band {
  
  String _name;
  String _genre;
  int _id;

  Band(this._name, this._genre);
  Band.withID(this._id, this._name, this._genre);
  Band.fromDB(Map<String, dynamic> data) {
    this._id = data['id'];
    this._name = data['bandname'];
    this._genre = data['genre'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'bandname': this._name,
      'genre': this._genre
    };
    if (_id != null) {
      data['id'] = this._id;
    }
    return data;
  }

  int getId() {
    return this._id;
  }

  String getBandName() {
    return this._name;
  }

  String getGenre(){
    return this._genre;
  }
}