import 'package:flutter/material.dart';

import 'app_event.dart';
import 'app_list.dart';
import 'internetBlock/blackhole_vpn.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Add this for using flutter plugin before runApp()
//Get installed apps
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool? isVpnActive;
  late List<App>? installedApps;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    setState(() {});
    isVpnActive = await isActive(); //Get if vpn active or not
    installedApps = await getApps();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: installedApps != null || isVpnActive == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ExampleApp(
              isVpnActive: isVpnActive!,
              installedApps: installedApps!,
            ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
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

class ExampleApp extends StatelessWidget {
  const ExampleApp(
      {super.key, required this.isVpnActive, required this.installedApps});
  final bool isVpnActive;
  final List<App> installedApps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device apps demo')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Object>(
                        builder: (BuildContext context) => MyAppList(
                              isVpnActive: isVpnActive,
                              installedApps: installedApps,
                            )),
                  );
                },
                child: const Text('Applications list')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Object>(
                        builder: (BuildContext context) =>
                            const AppsEventsScreen()),
                  );
                },
                child: const Text('Applications events'))
          ],
        ),
      ),
    );
  }
}
