import 'package:ditto/edit_Profile.dart';
import 'package:ditto/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Messages.dart';
import 'about.dart';
import 'globalChats.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int _profileSegmentationValue = 0;
  final Map<int,Widget> _profileTabs = <int,Widget>{
    0: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child:Text("Posts", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white70),)),
    1: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child:Text("Replies", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white70),)),
    2: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child:Text("Likes", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white70))),
  };

  Widget BuildprofileWidget(){
    switch(_profileSegmentationValue){
      case 0:
        return const Center(child: Text("Posts Loading ...", style: TextStyle(fontSize: 25)));
        break;
      case 1:
        return const Center(child: Text("Replies Loading ...", style: TextStyle(fontSize: 25),),);
        break;
      case 2:
        return const Center(child: Text("Loading ...", style: TextStyle(fontSize: 25),),);
        break;
      default:
        return const Center(child: Text("Something Wrong", style: TextStyle(fontSize: 25),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.teal,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: ListTile(
                leading: const Icon(
                  Icons.home,color: Colors.black,
                ),
                title: const Text('Following'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              leading: const Icon(
                  Icons.message,color: Colors.black
              ),
              title: const Text('Messages'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Messages()));
              },
            ),
            ListTile(
              leading: const Icon(
                  Icons.camera_rounded,color: Colors.black
              ),
              title: const Text('Global'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GlobalChatRelays()));
              },
            ),
            ListTile(
              leading: const Icon(
                  Icons.settings,color: Colors.black
              ),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                  Icons.info_outline,color: Colors.black
              ),
              title: const Text('About'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back.jpeg", ), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.teal.withOpacity(0.8), BlendMode.dstATop),),
          ),
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 38),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox.shrink(),
                    PopupMenuButton(
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                        size : 40
                      ),
                        itemBuilder: (_){
                        return <PopupMenuItem<String>>[
                          PopupMenuItem(value: "Logout",child: InkWell(child: Text("Logout"), onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));},),)
                        ];
                        }
                        )
                  ],
                 ),
          ),
         ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              transform: Matrix4.translationValues(0.0, -56.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage("assets/profile.jpeg"),
                      ),
                      Container(
                        width: 100,
                        height: 35,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white70,
                            border: Border.all(color: Colors.blue)
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));},
                            child: const Text(
                              "Edit", style: TextStyle(
                                fontSize: 17,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                            ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const Text("Mark Steven", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Row(
                    children: const [
                      Text("20 Following", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 2),),
                      SizedBox(width: 20,),
                      Text("10 Followers", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 2),)
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoSlidingSegmentedControl(
                      groupValue: _profileSegmentationValue,
                      thumbColor: Colors.grey,
                      backgroundColor: Colors.black,
                      onValueChanged: (changeTab){
                        setState(() {
                          _profileSegmentationValue =changeTab!;
                        });
                      },
                      children: _profileTabs,
                    ),
                  )
                ],
              ),
            ),
          ),
          BuildprofileWidget(),
        ]
      ),
       );
    }
  }

