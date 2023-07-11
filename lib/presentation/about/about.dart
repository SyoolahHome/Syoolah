import 'package:ditto/presentation/bottom_bar_screen/widgets/bottom_bar.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    final pars = "aboutContent".tr().split("\n");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: MarginedBody(
        child: Column(
          children: <Widget>[
            SizedBox(height: height * 3),
            Animate(
              effects: <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(0, 0.5),
                ),
              ],
              child: HeadTitle(
                title: "about".tr(),
                isForSection: true,
              ),
            ),
            SizedBox(height: height * 3),
            ...pars.indexedMap(
              (index, item) => Animate(
                delay: (200 + index * 100).ms,
                effects: <Effect>[
                  FadeEffect(),
                  SlideEffect(
                    begin: Offset(0, 0.5),
                  ),
                ],
                child: Text(item),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: const <Widget>[
                  Text(
                    "Note : \n 16.02.2023 Heavily Under ruction: \n started integrating Nostr..",
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                "About",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              const Text(
                "Ditto is like the social networking apps we're used to, \n but better:",
              ),
              Container(
                margin: const EdgeInsets.all(40.0),
                child: Column(
                  children: const [
                    Text(
                      "Accessible. No phone number or signup required. Just type in your name or alias and go!",
                    ),
                    Text(
                      "Secure. It's open source. You can verify that your data stays safe.",
                    ),
                    Text(
                      "Always available. It works offline-first and is not dependent on any single centrally managed server. Users can even connect directly to each other.",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "In other words, you can't be deplatformed from Ditto.",
              ),
              const SizedBox(height: 20),
              const Text("Released under MIT license. Code:Github."),
              const SizedBox(
                height: 60,
              ),
              const Text("version 1.2.2"),
              const SizedBox(
                height: 40,
              ),
              const Text("Privacy"),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "The application is an unaudited proof-of-concept implementation, so don't use it for security critical purposes.",
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("FAQ"),
              const SizedBox(
                height: 20,
              ),
              const Text("Why is there less spam than on other clients?"),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Ditto rejects all content from authors that your social network has not interacted with. You get way less spam, but the downside is that discovery of new users is more difficult, and sometimes you don't see all the messages that appear on other clients.",
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("More FAQ"),
              const SizedBox(
                height: 40,
              ),
              const Text("Maintainer"),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(".jpg"),
                    radius: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Mark Steven  @Mark_Steven"),
                  const SizedBox(
                    width: 60,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const InkWell(
                      child: Text(
                        "Follow",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Contact"),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(".jpg"),
                    radius: 18,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("Ditto"),
                  const SizedBox(
                    width: 60,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const InkWell(
                      child: Text(
                        "Follow",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
