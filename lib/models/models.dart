class Contact {
  final String? name;
  final String number;
  bool isSMS = true;
  Contact({this.name, required this.number});

  String toJstring(){
    return '{"name": "$name","number":"$number"}';
  }
}

