import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:text_recognition_app/constants/colors.dart';
import 'package:text_recognition_app/screens/saved_texts_screen.dart';
import 'package:text_recognition_app/services/scan_image.dart';
import 'package:text_recognition_app/utils/helpers.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  bool _isPremissionGranted = false;

  late final Future<void> _future;

  CameraController? _cameraController;

  final _textRecognizer = TextRecognizer();
  late ScanImageService scanService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    scanService = ScanImageService(_textRecognizer);
    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPremissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    } else {
      // print("Camera not selected");
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }
    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    await _cameraController?.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: ((context, snapshot) {
        return Stack(
          children: [
            if (_isPremissionGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);

                    return Center(
                      child: _cameraController == null
                          ? Scaffold(
                              body: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.warning_amber_outlined,
                                      size: 30,
                                      color: primary,
                                    ),
                                    Text("Camera Preview Not available"),
                                  ],
                                ),
                              ),
                            )
                          : CameraPreview(_cameraController!),
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                }),
              ),
            Scaffold(
              backgroundColor: _isPremissionGranted ? Colors.transparent : null,
              body: _isPremissionGranted
                  ? Column(
                      children: [
                        SafeArea(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                backgroundColor: primary,
                                child: IconButton(
                                  onPressed: () => pushPage(
                                    context,
                                    page: const SavedTextsScreen(),
                                  ),
                                  icon: const Icon(
                                    Icons.directions_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3.0),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_cameraController == null) {
                                    return;
                                  }
                                  scanService.scanImage(
                                    cameraController: _cameraController!,
                                    context: context,
                                    mounted: mounted,
                                  );
                                },
                                child: const CircleAvatar(
                                  backgroundColor: primary,
                                  radius: 25,
                                  foregroundColor: Colors.white,
                                  child: Icon(Icons.camera_alt_outlined),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(3.0),
                                margin: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: const Text(
                          "Camera Permission Denied",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            )
          ],
        );
      }),
    );
  }
}
