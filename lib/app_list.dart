import 'dart:developer' show log;

import 'package:flutter/material.dart';

import 'internetBlock/blackhole_vpn.dart';

class MyAppList extends StatefulWidget {
  const MyAppList(
      {super.key, required this.isVpnActive, required this.installedApps});
  final bool isVpnActive;
  final List<App> installedApps;
  @override
  State<MyAppList> createState() => _MyAppListState();
}

class _MyAppListState extends State<MyAppList> {
  late bool _isVpnOn;
  //The selected apps for pass to blackhole vpn
  final _selectedApps = <App>[];

  @override
  void initState() {
    _isVpnOn = widget.isVpnActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Blackhole Vpn Example'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_isVpnOn
                ? "Blackhole vpn active"
                : "Select the apps which you want to prevent to connect internet"),
            Expanded(
              child: ListView.builder(
                itemCount: widget.installedApps.length,
                itemBuilder: (context, index) {
                  final app = widget.installedApps[index];
                  return SwitchListTile(
                    title: Text(
                        app.name ?? "\n"), //Use new line if app name is unknown
                    secondary: app.image,
                    subtitle: Text(app.packageName),
                    value: _selectedApps.contains(app),
                    onChanged: (bool value) {
                      if (value) {
                        setState(() {
                          _selectedApps.add(app);
                        });
                      } else {
                        setState(() {
                          _selectedApps.remove(app);
                        });
                      }
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: _isVpnOn
                    ? () async {
                        await stopVpn(); //Stop Blackhole Vpn
                        setState(() {
                          _isVpnOn = false;
                        });
                      }
                    : () async {
                        //Start vpn service
                        final isActivated = await runVpnService(_selectedApps);
                        if (isActivated) {
                          //Vpn permission granted
                          setState(() {
                            _isVpnOn = true;
                          });
                        } else {
                          //Vpn permission not granted
                          log("Vpn permission not granted");
                        }
                      },
                child: Text(
                    _isVpnOn ? "Stop Blackhole Vpn" : "Start Blackhole Vpn"))
          ],
        ),
      ),
    );
  }
}
