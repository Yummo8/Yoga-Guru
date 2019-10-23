import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yoga_guru/login.dart';
import 'package:yoga_guru/poses.dart';
import 'package:yoga_guru/scale_route.dart';
import 'package:yoga_guru/size_route.dart';
import 'package:yoga_guru/util/pose_data.dart';

import 'auth.dart';

class Home extends StatelessWidget {
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;
  final List<CameraDescription> cameras;

  const Home({
    this.email,
    this.uid,
    this.displayName,
    this.photoUrl,
    this.cameras,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Yoga Guru'),
        centerTitle: true,
        actions: <Widget>[
          CircleAvatar(
            radius: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: photoUrl == null
                  ? Image.asset(
                      'assets/images/profile-image.png',
                      fit: BoxFit.fill,
                    )
                  : NetworkImage(photoUrl),
            ),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              Auth auth = Auth();
              await auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(
                    cameras: cameras,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Welcome Text
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'Welcome\n$displayName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ),

            // Beginner Button
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ButtonTheme(
                minWidth: 200,
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: FlatButton(
                  color: Colors.green,
                  child: Text(
                    'Beginner',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => _onPoseSelect(
                    context,
                    'Beginner',
                    beginnerAsanas,
                    Colors.green,
                  ),
                ),
              ),
            ),

            // Intermediate Button
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ButtonTheme(
                minWidth: 200,
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: FlatButton(
                  color: Colors.blue,
                  child: Text(
                    'Intermediate',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => _onPoseSelect(
                    context,
                    'Intermediate',
                    intermediateAsanas,
                    Colors.blue,
                  ),
                ),
              ),
            ),

            // Advance Button
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ButtonTheme(
                minWidth: 200,
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: FlatButton(
                  color: Colors.deepPurple,
                  child: Text(
                    'Advance',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => _onPoseSelect(
                    context,
                    'Advance',
                    advanceAsanas,
                    Colors.deepPurple[400],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPoseSelect(
    BuildContext context,
    String title,
    List<String> asanas,
    Color color,
  ) async {
    Navigator.push(
      context,
      ScaleRoute(
        page: Poses(
          cameras: cameras,
          title: title,
          model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
          asanas: asanas,
          color: color,
        ),
      ),
    );
  }
}
