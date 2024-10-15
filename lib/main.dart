import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('com.example.anotherapp/params');
  String param1 = '';
  String param2 = '';

  @override
  void initState() {
    super.initState();
    _getParamsFromNative();
  }

  Future<void> _getParamsFromNative() async {
    try {
      final result = await platform.invokeMethod<Map>('sendParams');
      if (result != null) {
        setState(() {
          param1 = result['param1'] ?? '';
          param2 = result['param2'] ?? '';
        });
      }
    } on PlatformException catch (e) {
      print("Failed to get params: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('App B with Parameters')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Param 1: $param1'),
              Text('Param 2: $param2'),
            ],
          ),
        ),
      ),
    );
  }
}
