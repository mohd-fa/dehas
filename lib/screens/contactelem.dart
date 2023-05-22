import 'package:flutter/material.dart';
import 'package:dehas/models/models.dart';

class ContactElem extends StatefulWidget {
  final Contact contact;
  const ContactElem({super.key, required this.contact});

  @override
  State<ContactElem> createState() => _ContactElemState();
}

class _ContactElemState extends State<ContactElem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              CircleAvatar(
                  minRadius: 25,
                  backgroundColor: Colors.grey[400],
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                  )),
              const SizedBox(width: 10),
              Text((widget.contact.name ?? ''),maxLines: 2,textAlign: TextAlign.center,)
            ],
          ),
          Switch(
            activeColor: Colors.red,
            splashRadius: 40.0,
            value: widget.contact.isSMS,
            onChanged: (value) {
              setState((){
                widget.contact.isSMS = value;
              });
            },
          ),

        ],
      ),
    );
  }
}
