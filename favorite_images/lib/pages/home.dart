import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  late List<File?> fileList = [];
  late bool btnClicked = false;
  File? selectedFile;

  void getImage(source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    setState(() {
      File? file = File(pickedImage!.path);
      fileList.add(file);
      setState(() => btnClicked = false);
    });
  }

  bool isSingleFileSelected() => selectedFile == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ImagesLibrary"),
          backgroundColor: Colors.deepOrange[600],
          actions: [
            !btnClicked
                ? IconButton(
                    onPressed: () => setState(() => btnClicked = true),
                    icon: Icon(Icons.add),
                  )
                : Row(
                    children: [
                      myButton("Choose from gallery", ImageSource.gallery),
                      myButton("Take a picture", ImageSource.camera)
                    ],
                  )
          ],
        ),
        body: GestureDetector(
          onTap: () => setState(() => btnClicked = false),
          child: ImageViewContainer(),
        ));
  }

  Widget ImageViewContainer() {
    return fileList.isNotEmpty ? getImages() : Center(child: Text("NO IMAGES"));
  }

  Widget getImages() {
    return isSingleFileSelected()
        ? GridView.count(
            crossAxisCount: 2,
            children: fileList.map((e) => imageCard(e!)).toList())
        : singleImage(selectedFile!);
  }

  Tooltip myButton(
    String text,
    ImageSource source,
  ) {
    return Tooltip(
      message: text,
      child: IconButton(
        onPressed: () {
          getImage(source);
        },
        icon: source == ImageSource.gallery
            ? Icon(Icons.ballot_outlined)
            : Icon(Icons.camera_alt_outlined),
      ),
    );
  }

  GestureDetector imageCard(File pickedFile) {
    return GestureDetector(
      onTap: () => setState(() => selectedFile = pickedFile),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(pickedFile), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }

  InteractiveViewer singleImage(File? currentSelectedFile) {
    return InteractiveViewer(
      maxScale: 4.0,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          int sensitivity = 20;
          // Swiping in right direction.
          if (details.delta.dx > sensitivity) {
            setState(() => selectedFile = null);
          }
        },
        child: Container(
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: FileImage(currentSelectedFile!)),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
        ),
      ),
    );
  }
}
