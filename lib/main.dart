import 'package:compass/neu_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import "dart:math" as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _fetchPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Builder(
        builder: (context) {
          if (_hasPermission) {
            return _buildCompass(width);
          } else {
            return _buildPermission();
          }
        }
      ),
    );
  }


  void _fetchPermissionStatus(){
    Permission.locationWhenInUse.status.then((status){
      if(mounted){
        setState(() => _hasPermission = status == PermissionStatus.granted);
      }
    });
  }

  Widget _buildCompass(double width){
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Text("An error occurred: ${snapshot.error}");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        double? direction = snapshot.data!.heading;
        // if null, device doesnt support this sensor
        if(direction == null){
          return const Center(child: Text("Device does not have sensors."));
        }

        return NeuCircle(
          child: Transform.rotate(
            angle: direction * (math.pi/180) * -1,  // * -1 to calibrate direction or something
            child: Image.asset("lib/images/compass.png", height: width, color: Colors.white,),
          ),
        );

      }
    );
  }

  Widget _buildPermission(){
    return Center(
      child: ElevatedButton(
        onPressed: (){
          Permission.locationWhenInUse.request().then((ignored){
            _fetchPermissionStatus();
          });
        },
        child: const Text("Request Permission"),
      ),
    );
  }
}
