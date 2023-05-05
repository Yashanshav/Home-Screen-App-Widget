import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widget/new_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(const MyApp());
}

// Called when Doing Background Work initiated from Widget
@pragma("vm:entry-point")
Future<void> backgroundCallback(Uri? uri) async {
  if (uri?.host == 'updatecounter') {
    int counter = 0;
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      counter = value!;
      counter++;
    });
    await HomeWidget.saveWidgetData<int>('_counter', counter);
    await HomeWidget.updateWidget(
        //this must the class name used in .Kt
        name: 'HomeScreenWidgetProvider',
        iOSName: 'HomeScreenWidgetProvider');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // HomeWidget.initiallyLaunchedFromHomeWidget().then((Uri? uri) {
    //   if (uri?.host == 'launchapp') {
    //     Get.toNamed('/homescreen');
    //   } else if (uri?.host == 'newscreen') {
    //     Get.toNamed('/newscreen');
    //   }
    // });
    HomeWidget.initiallyLaunchedFromHomeWidget().then((Uri? uri) {
      if (uri?.host == 'launchapp') {
        Get.toNamed('/homescreen');
      } else if (uri?.host == 'newscreen') {
        Get.toNamed('/newscreen');
      }
    });
    HomeWidget.widgetClicked.listen((Uri? uri) {
      if (uri?.host == "newscreen") {
        // _uriVal = "gone to new screen";
        Get.toNamed('/newscreen');
      } else if (uri?.host == "launchapp") {
        Get.toNamed('/homescreen');
        // _uriVal = "gone to home screen";
        // loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/homescreen',
      routes: {
        '/homescreen': (context) => const MyHomePage(title: 'My Widget'),
        '/newscreen': (context) => const new_screen(),
        '/newroute': (context) => const NewRoute(),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class NewRoute extends StatelessWidget {
  const NewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("this is the new route screen."),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _uriVal = "no value";

  @override
  void initState() {
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
    //     _uriVal = "gone to new screen";
    //     Get.toNamed('/newscreen');
    //   } else if (uri?.host == "launchapp") {
    //     Get.toNamed('/homescreen');
    //     _uriVal = "gone to home screen";
    //     // loadData();
    //   }
    // });
    loadData(); // This will load data from widget every time app is opened
  }

  void loadData() async {
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      _counter = value!;
    });
    setState(() {});
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    updateAppWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_uriVal),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
