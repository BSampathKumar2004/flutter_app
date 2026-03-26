import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(MyApp());
}

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  List<ScanResult> devices = [];

  @override
  void initState() {
    super.initState();
    startScan();
  }

  void startScan() async {
    devices.clear();

    FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        devices = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Devices 🔍"),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index].device;
          return ListTile(
            title: Text(device.name.isNotEmpty
                ? device.name
                : "Unknown Device"),
            subtitle: Text(device.id.toString()),
          );
        },
      ),
    );
  }
}