import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';

class new_screen extends StatefulWidget {
  const new_screen({super.key});

  @override
  State<new_screen> createState() => _new_screenState();
}

class _new_screenState extends State<new_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // HomeWidget.initiallyLaunchedFromHomeWidget().then((Uri? uri) {
    //   if (uri?.host == 'launchapp') {
    //     Get.toNamed('/homescreen');
    //   } else if (uri?.host == 'newscreen') {
    //     Get.toNamed('/newscreen');
    //   }
    // });
    // HomeWidget.widgetClicked.listen((Uri? uri) {
    //   if (uri?.host == "newscreen") {
    //     Get.toNamed('/newscreen');
    //   } else if (uri?.host == 'launchapp') {
    //     Get.toNamed('/homescreen');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Text("This is new screen");
  }
}
// class new_screen extends StatelessWidget {
//   const new_screen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("This is new screen."),
//     );
//   }
// }
