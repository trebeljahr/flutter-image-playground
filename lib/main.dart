import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:ui' as ui show Image;
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(new DemoPictureApp());

class DemoPictureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  MyWidgetState createState() => new MyWidgetState();
}

ui.Image _image;

class MyWidgetState extends State<MyWidget> {
  Future<Null> _loadAssets(AssetBundle bundle) async {
    ImageMap images = new ImageMap(bundle);
    _image = await images.loadImage('assets/image.jpg');
  }

  @override
  void initState() {
    super.initState();
    AssetBundle bundle = rootBundle;
    _loadAssets(bundle).then((_) {
      setState(() {
        assetsLoaded = true;
        weatherWorld = new WeatherWorld();
      });
    });
  }

  bool assetsLoaded = false;
  WeatherWorld weatherWorld;

  @override
  Widget build(BuildContext context) {
    if (!assetsLoaded) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Rico's Image Library"),
        ),
        body: new Container(
          decoration: new BoxDecoration(
            color: const Color(0xff4aaafb),
          ),
        ),
      );
    }
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Rico's Image Library")
      ),
      body: new Material(
        child: new Stack(
          children: <Widget>[
            new SpriteWidget(weatherWorld),
            new Align(
              alignment: new FractionalOffset(0.5, 0.8),
            ),
          ],
        ),
      ),
    );
  }

}


class WeatherWorld extends NodeWithSize {
  WeatherWorld() : super(const Size(2048.0, 2048.0)) {
    Sprite _sun = new Sprite.fromImage(_image);
    addChild(_sun);
  }
}

