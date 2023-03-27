import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Text("Note : \n 16.02.2023 Heavily Under Construction: \n started integrating Nostr.."),
                ],
              ),
              const SizedBox(height: 40),
              const Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              const SizedBox(height: 20),
              const Text("Ditto is like the social networking apps we're used to, \n but better:"),
              Container(
                  margin: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Text("Accessible. No phone number or signup required. Just type in your name or alias and go!"),
                      Text("Secure. It's open source. You can verify that your data stays safe."),
                      Text("Always available. It works offline-first and is not dependent on any single centrally managed server. Users can even connect directly to each other.")
                    ],
                  ),),
              SizedBox(height: 20,),
              Text("In other words, you can't be deplatformed from Ditto."),
              SizedBox(height: 20),
              Text("Released under MIT license. Code:Github."),
              SizedBox(height: 60,),
              Text("version 1.2.2"),
              SizedBox(height: 40,),
              Text("Privacy"),
              SizedBox(height: 40,),
              Text("The application is an unaudited proof-of-concept implementation, so don't use it for security critical purposes."),
              SizedBox(height: 20,),
              Text("FAQ"),
              SizedBox(height: 20,),
              Text("Why is there less spam than on other clients?"),
              SizedBox(height: 30,),
              Text("Ditto rejects all content from authors that your social network has not interacted with. You get way less spam, but the downside is that discovery of new users is more difficult, and sometimes you don't see all the messages that appear on other clients."),
              SizedBox(height: 30,),
              Text("More FAQ"),
              SizedBox(height: 40,),
              Text("Maintainer"),
              SizedBox(height: 10,),
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(".jpg"),
                  ),
                  SizedBox(width: 10,),
                  Text("Mark Steven  @Mark_Steven"),
                  SizedBox(width: 60,),
                  Container(
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.yellow),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: InkWell(
                      child:  const Text(
                        "Follow", style: TextStyle(
                          color: Colors.black,
                          fontSize: 14
                      ),
                      ),onTap: (){},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text("Contact"),
              SizedBox(height: 10,),
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(".jpg"),
                  ),
                  SizedBox(width: 20,),
                  Text("Ditto"),
                  SizedBox(width: 60,),
                  Container(
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.yellow),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: InkWell(
                      child:  const Text(
                        "Follow", style: TextStyle(
                          color: Colors.black,
                          fontSize: 14
                      ),
                      ),onTap: (){},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}
