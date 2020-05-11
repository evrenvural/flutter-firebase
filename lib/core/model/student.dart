class Student {
  String key;
  String name;
  int value;

  Student({this.key, this.name, this.value});

  Student.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
