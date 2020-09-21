class Members {
  String _name, _intrument, _bandowner;
  int _id;
  Members(this._name, this._intrument, this._bandowner);
  Members.withID(this._id, this._name, this._intrument, this._bandowner);
  Members.fromDB(Map<String, dynamic> data) {
    this._id = data['id'];
    this._name = data['membername'];
    this._intrument = data['instrument'];
    this._bandowner =data['bandowner'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'membername': this._name,
      'instrument': this._intrument,
      'bandowner': this._bandowner
    };
    if (_id != null) {
      data['id'] = this._id;
    }
    return data;
  }

  int getId() {
    return this._id;
  }

  String getMember(){
    return this._name;
  }

  String getOwner(){
    return this._bandowner;
  }

  String getInstrument(){
    return this._intrument;
  }
}
