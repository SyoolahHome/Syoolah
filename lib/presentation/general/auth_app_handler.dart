import 'package:flutter/material.dart';

class AuthenticationStreamHandler extends StatefulWidget {
  const AuthenticationStreamHandler({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<AuthenticationStreamHandler> createState() =>
      _AuthenticationStreamHandlerState();
}

class _AuthenticationStreamHandlerState
    extends State<AuthenticationStreamHandler> {
  // StreamSubscription? streamSubscription;
  @override
  void initState() {
    // streamSubscription =
    //     LocalDatabase.instance.getPrivateKeyStream().listen((event) {
    //   if (event != null) {
    //     Navigator.pushNamed(context, Paths.bottomBar);
    //   } else {
    //     Navigator.of(context).pushNamed(Paths.SignUp);
    //   }
    // });

    // LocalDatabase.instance
    //     .setPrivateKey(LocalDatabase.instance.getPrivateKey());

    super.initState();
  }

  @override
  void dispose() {
    // streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
