import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ContactElem extends StatelessWidget {
  final bool add;
  final String? name;
  const ContactElem({super.key, this.name, this.add = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/8,
      child: Column(
        children: [
          CircleAvatar(
              minRadius: 25,
              backgroundColor: Colors.grey[400],
              child: Icon(
                !add ? Icons.person_rounded : Icons.person_add_rounded,
                color: Colors.white,
              )),
          SizedBox(height: 5),
          Text(add ? 'Add Contact' : (name ?? ''),maxLines: 2,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
