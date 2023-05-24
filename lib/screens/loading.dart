import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bg1.png'), fit: BoxFit.cover)),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Image.asset('assets/logo.png'),
               const Text(
                  'D.E.H.A.S',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                      ),
                      
                ),
              const SizedBox(height: 10,),
              SpinKitFadingCircle(
                color: Colors.blue[300],
                size: 50,
              ),
            ],
          ),
        ));
  }
}
