import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as paths;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageWidget extends StatefulWidget {
  final Function(String path) uploadFile;
  final String urlImage;

  const ImageWidget(this.uploadFile, this.urlImage, {Key key})
      : super(key: key);
  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File _storageImage;

  Future<void> _takePictureCamera() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    final File fileImg = File(imageFile.path);

    if (imageFile == null) {
      return;
    }

    final appDirectory = await syspaths.getApplicationDocumentsDirectory();
    final fileName = paths.basename(imageFile.path);
    final savedImage = await fileImg.copy('${appDirectory.path}/$fileName');
    setState(() {
      _storageImage = fileImg;
      widget.uploadFile(savedImage.path);
    });
  }

  Future<void> _takePictureGallery() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final File fileImg = File(imageFile.path);

    if (imageFile == null) {
      return;
    }

    final appDirectory = await syspaths.getApplicationDocumentsDirectory();
    final fileName = paths.basename(imageFile.path);
    final savedImage = await fileImg.copy('${appDirectory.path}/$fileName');
    setState(() {
      _storageImage = fileImg;
      widget.uploadFile(savedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DottedBorder(
      borderType: BorderType.RRect,
      color: Colors.white,
      dashPattern: const [8, 4],
      strokeWidth: 1,
      child: InkWell(
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: const Color(0xff093545),
                title: Text("From where do you want to take the photo?",
                    style: theme.textTheme.bodyText1.copyWith(height: 1.1)),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      GestureDetector(
                        child: Text("Gallery",
                            style: theme.textTheme.bodyText1
                                .copyWith(height: 1.2)),
                        onTap: () {
                          _takePictureGallery();
                          Navigator.pop(context);
                        },
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      GestureDetector(
                        child: Text("Camera",
                            style: theme.textTheme.bodyText1
                                .copyWith(height: 1.2)),
                        onTap: () {
                          _takePictureCamera();
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              );
            }),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          color: const Color(0xff224957),
          child: Center(
            child: _storageImage != null
                ? Image.file(
                    _storageImage,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  )
                : widget.urlImage != ''
                    ? Image.network(
                        widget.urlImage,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.file_download_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Upload an image here'),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
