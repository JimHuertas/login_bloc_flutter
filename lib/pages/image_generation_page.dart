import 'dart:async';
import 'dart:typed_data';

import 'package:flutterfire_ui/auth.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';


// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<dynamic> _imageFromUrl() async{
  return (img.Command()
        // Read a WebP image from a file.
        ..decodeWebPFile('https://www.billboard.com/wp-content/uploads/2022/08/suicideboys-press-photo-2022-billboard-pro-1260.jpg?w=942&h=623&crop=1')
        // Resize the image so its width is 120 and height maintains aspect
        // ratio.
        ..copyResize(width: 120)
        // Save the image to a PNG file.
        ..writeToFile('assets/image.png'));
}

class ImageGenerationPage extends StatefulWidget {
  @override
  State<ImageGenerationPage> createState() => _ImageGenerationPageState();
}

class _ImageGenerationPageState extends State<ImageGenerationPage> {
  ByteData? imageBytes;
  GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(187, 244, 155, 1),
        title: const Text("Image Generator", style: TextStyle(color: Colors.black87))
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              width: 300,
              height: 300,
              color: Colors.red,
              child: Image.network(
                'https://cdn.lazyshop.com/files/14e5472b-ebd7-475e-8298-66f4ad088224/product/23ec25fed0c2830b646f9aef93046199.jpeg?x-oss-process=style%2Fthumb',
                alignment: Alignment.center,
                scale: 0.01,
              ),
            ),
          ]
        )
      )
    );
  }
}