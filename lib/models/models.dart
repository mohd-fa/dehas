class Contact {
  final String? name;
  final String number;
  final String? docid;
  Contact({this.name, required this.number, this.docid});

  String toJstring(){
    return '{"name": "$name","number":"$number"}';
  }
}

