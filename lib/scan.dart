import 'package:ditto/main.dart';
import 'package:flutter/material.dart';

class ScanKey extends StatefulWidget {
  const ScanKey({Key? key}) : super(key: key);

  @override
  _ScanKeyState createState() => _ScanKeyState();
}

class _ScanKeyState extends State<ScanKey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Container(
        child: Center(
          child: Column(
            children: [
             Padding(
              padding:  EdgeInsets.only(top: 238.0),
              child:  InkWell(child: Text("Back"), onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
              },),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 15,
                          ),borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: "Paste Private KEY"
                  ),
                ),
            ),
             const  SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black
                ),
                  onPressed: (){},
                  child: const Text("Scan key", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))
            ],
          ),
        ),
      ),
    );
  }
}
