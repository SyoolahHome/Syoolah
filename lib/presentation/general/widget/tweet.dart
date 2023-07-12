import 'package:ditto/services/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TweetWidget extends StatelessWidget {
  final String avatar;
  final String pubkey;
  final int timestamp;
  final String text;

  const TweetWidget({
    super.key,
    required this.avatar,
    required this.pubkey,
    required this.timestamp,
    required this.text,
  });

  String formatDate(int secondsUnixTimestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      secondsUnixTimestamp * 1000,
      isUtc: true,
    ).toLocal().toString();
    return date.substring(0, date.length - 4);
  }

  int setColor() {
    final pubKeyChars = pubkey.substring(0, 6);
    const color = '0xff';
    final result = '$color$pubKeyChars';
    return int.parse(result);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(setColor()),
                    ),
                  ),
                  onTap: () {
                    AppUtils.instance
                        .displaySnackBar(context, "Soon In sha'Allah");
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 5.0),
                              child: InkWell(
                                child: Text(
                                  pubkey.substring(0, 8),
                                ),
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(text: pubkey),
                                  );
                                  AppUtils.instance.displaySnackBar(
                                    context,
                                    'Copied to clipboard: $pubkey',
                                  );
                                },
                              ),
                            ),
                            Text(
                              formatDate(timestamp),
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.sailing,
                            size: 14.0,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            AppUtils.instance.displaySnackBar(
                              context,
                              "I'm useless for the moment",
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectableText(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
