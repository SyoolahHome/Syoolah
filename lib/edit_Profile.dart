
import 'package:ditto/profile.dart';
import 'package:flutter/material.dart';

import 'BottomBar.dart';
import 'Messages.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: EdgeInsets.only(top:20),
                child: Row(
                  children: [
                    InkWell(child: Icon(Icons.arrow_back, size: 26), onTap: (){Navigator.pop(context);},), SizedBox(width: 30,),
                    Text("Edit Profile", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Name:" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 15,
                            color: Colors.green
                          ),borderRadius: BorderRadius.circular(50)
                      ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Username:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 15,
                        ),borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Picture url:" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 15,
                        ),borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text("about:" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 15,
                        ),borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text("Banner url:" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 15,
                        ),borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Bitcoin lightning address:" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 15,
                        ),borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Nostr address(nip05):" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 15,
                        ),borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.cyan),
                padding: EdgeInsets.all(10),
                child: InkWell(
                  child:  Center(
                    child: const Text(
                      "Save", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                    ),
                    ),
                  ),onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomBar()));},
                ),
              ),

          ],
          ),
        ),
      ),
    );
  }
}
