import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class lungcancpage extends StatefulWidget {
  const lungcancpage({Key? key}) : super(key: key);

  @override
  State<lungcancpage> createState() => _lungcancpageState();
}

class _lungcancpageState extends State<lungcancpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: lungcanchomepage(),
    );
  }
}


class lungcanchomepage extends StatefulWidget {
  const lungcanchomepage({Key? key}) : super(key: key);

  @override
  State<lungcanchomepage> createState() => _lungcanchomepageState();
}

class _lungcanchomepageState extends State<lungcanchomepage> {

  static const bcinactivecardcolor = Color(0xFF111f4e);
  static const bcactivecardcolor = Color(0xff21a2dd);

  Color bccard1 = bcinactivecardcolor;
  Color bccard2 = bcinactivecardcolor;

  void bccolorchanger(int bccvalue) {
    if (bccvalue == 1) {
      if (bccard1 == bcinactivecardcolor) {
        bccard1 = bcactivecardcolor;
        bccard2 = bcinactivecardcolor;
      } else {
        bccard1 = bcinactivecardcolor;
      }
    }
    if (bccvalue == 2) {
      if (bccard2 == bcinactivecardcolor) {
        bccard2 = bcactivecardcolor;
        bccard1 = bcinactivecardcolor;
      } else {
        bccard2 = bcinactivecardcolor;
      }
    }
  }

  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  ClassifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assetlung/model_unquant.tflite', labels: 'assetlung/labels.txt');
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickcamImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    ClassifyImage(_image);
  }

  pickgalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    ClassifyImage(_image);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000628),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Predict Lung Cancer :',
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        bccolorchanger(1);
                      });
                      pickcamImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: bccard1,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      height: 150.0,
                      child: Center(
                        child: Lottie.asset(
                          'images/5383-loading-16-camera.json',
                          width: 250.0,
                          height: 250.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        bccolorchanger(2);
                      });
                      pickgalleryImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: bccard2,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      height: 150.0,
                      child: Center(
                        child: Lottie.asset(
                          'images/5315-archived-folder-document.json',
                          width: 250.0,
                          height: 250.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _loading
                      ? Container(
                    child: Center(
                      child: Text(''),
                    ),
                  )
                      : Container(
                    child: Column(
                      children: [
                        Container(
                          child: Image.file(
                            _image,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        _output != null
                            ? Column(
                          children: [
                            Text(
                              '${_output[0]['label']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              'Accuracy: ${_output[0]['confidence'] * 100}%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18),
                            )
                          ],
                        )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

