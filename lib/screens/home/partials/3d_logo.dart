import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class RotatingModel extends StatefulWidget {
  const RotatingModel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RotatingModelState();
  }
}

class _RotatingModelState extends State<RotatingModel> {

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ModelViewer(
            src: 'https://firebasestorage.googleapis.com/v0/b/portfolio-e6526.appspot.com/o/logo_3d.glb?alt=media&token=fc065ba4-a017-4846-9e02-d22e6d35c4be',
            animationName: 'Running',
            ar: true,
            autoRotate: true,
            cameraControls: true,
            orientation: '0 1.5 0.5',
            disableZoom: true,
            disableTap: true,
            loading: Loading.lazy,
            exposure: 0.75,
            skyboxImage: 'https://firebasestorage.googleapis.com/v0/b/portfolio-e6526.appspot.com/o/environment.hdr?alt=media&token=9cffa48f-00e0-4f98-a52d-3b1bb404a7b1',
            environmentImage: 'https://firebasestorage.googleapis.com/v0/b/portfolio-e6526.appspot.com/o/skybox.jpg?alt=media&token=3cbc3dc2-fe90-4ca0-9dbb-812d027fda6c',
          ),
        ),
      ),
    ]);
  }
}
