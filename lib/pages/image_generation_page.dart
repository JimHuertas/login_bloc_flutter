import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageGenerationPage extends StatefulWidget {
  @override
  State<ImageGenerationPage> createState() => _ImageGenerationPageState();
}

class _ImageGenerationPageState extends State<ImageGenerationPage> {
  ByteData? imageBytes;

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
              color: const Color.fromRGBO(187, 244, 155, 1),
              width: 100,
              height: 50,
              child: ElevatedButton(
                child: const Icon(Icons.save, color: Colors.black87),
                onPressed: () {}//async {
                //   RenderRepaintBoundary boundary = 
                //       // Wrap the container in a RepaintBoundary widget to be able to capture its image
                //       // and convert it to a ui.Image object
                //       RepaintBoundary(
                //         key: GlobalKey(),
                //         child: ClipPath(
                //           clipper: CustomClipPath(),
                //           child: Container(
                //             width: 200,
                //             height: 200,
                //             color: Colors.blue,
                //           ),
                //         ),
                //       ).createRenderObject(context);
                //   // ui.Image image = await boundary.toImage();
                //   // Save the image to the gallery
                //   // ImageGallerySaver.saveImage(Uint8List.fromList(await image.toByteData(format: ui.ImageByteFormat.png).then((byteData) => byteData!.buffer.asUint8List())));
                // },
              ),
            ),
            const SizedBox(height: 50),
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                width: 200, 
                height: 200,
                color: const Color.fromRGBO(187, 244, 155, 1),
              ),
            )
          ],
        )
        // child: Text("gaaaa")
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path>{
  

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

  
}



  // _imageCreaction() {
  //   Container(
  //       width: 150,
  //       height: 150,
  //       color: Colors.black12,
  //       child: (imageBytes != null) 
  //         ? Center(
  //           child: Image.memory(
  //             Uint8List.view(imageBytes!.buffer),
  //               width: 100,
  //               height: 100,
  //           )
  //         )
  //         : Container()
  //     );
  // }

  // _paint(Size size) async {
  //   final rd = Random();
  //   final recorder = PictureRecorder();
  //   final canvas = Canvas(recorder,
  //     Rect.fromPoints(const Offset(0.0, 0.0), Offset(size.width, size.height)));
  //   final paint = Paint()
  //     ..color = Colors.red
  //     ..strokeCap = StrokeCap.butt
  //     ..strokeWidth = 15
  //     ..style = PaintingStyle.stroke;

  //   canvas.drawCircle(
  //       Offset(
  //         rd.nextDouble() * size.width,
  //         rd.nextDouble() * size.height,
  //       ),
  //       20.0,
  //       paint);

  //   final picture = recorder.endRecording();
  //   final img = await picture.toImage(100, 100);
  //   final pngBytes = await img.toByteData(format: ImageByteFormat.png);

  // }