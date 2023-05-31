import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      body: Container(child: Column(children: [],)),
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
    );
  }
}
