import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'camera_service_interface.dart';

class CameraService implements CameraServiceInterface {
  CameraController _controller;

  @override
  Future<List<CameraDescription>> getAvailableCameras() async {
    final cameras = await availableCameras();
    return cameras;
  }

  @override
  Future<void> createCameraController() async {
    final camera = await getFirstCamera();
    _controller = CameraController(camera, ResolutionPreset.high);
  }

  @override
  Future<CameraDescription> getFirstCamera() async {
    final cameras = await getAvailableCameras();
    final firstCamera = cameras.first;
    return firstCamera;
  }

  @override
  Future<void> initializeController() async {
    if (_controller == null) await createCameraController();
    await _controller.initialize();
  }

  @override
  Future<CameraPreview> getCameraPreview() async {
    await initializeController();
    return CameraPreview(_controller);
  }

  @override
  Future<String> takePicture() async {
    // await initializeController();
    final directoryPath = (await getTemporaryDirectory()).path;
    final imagePath = join(directoryPath, "${DateTime.now()}.jpg");
    await _controller.takePicture(imagePath);
    return imagePath;
  }
}
