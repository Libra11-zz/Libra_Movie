// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class GithubScreen extends StatefulWidget {
//   @override
//   _GithubScreenState createState() => _GithubScreenState();
// }

// class _GithubScreenState extends State<GithubScreen> {
//   Completer<WebViewController> _controller = Completer<WebViewController>();
//   num _stackToView = 1;

//   void _handleLoad(String value) {
//     setState(() {
//       _stackToView = 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           title: Text("Github"),
//         ),
//         body: IndexedStack(
//           index: _stackToView,
//           children: <Widget>[
//             WebView(
//               initialUrl: "https://github.com/Libra11/Libra_Movie",
//               javascriptMode: JavascriptMode.unrestricted,
//               onPageFinished: _handleLoad,
//               onWebViewCreated: (WebViewController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//             Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           ],
//         ));
//   }
// }
