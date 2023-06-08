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
            src: 'assets/models/logo_3d.glb',
            animationName: 'Running',
            ar: true,
            autoRotate: true,
            cameraControls: true,
            orientation: '0 1.5 0.5',
            disableZoom: true,
            disableTap: true,
            loading: Loading.lazy,
            exposure: 0.75,
            skyboxImage: 'assets/models/environment.hdr',
            environmentImage: 'assets/models/skybox.jpg',
          ),
        ),
      ),
    ]);
  }
}
