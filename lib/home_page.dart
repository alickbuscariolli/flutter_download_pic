import 'dart:io';
import 'package:flutter/material.dart';

import 'download_img_ctrl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDownloadingPic = true;
  String? pic;
  bool errorDownloadPic = false;

  @override
  void initState() {
    _downloadPic();
    super.initState();
  }

  void _downloadPic() async {
    setState(() {
      errorDownloadPic = false;
      isDownloadingPic = true;
    });

    pic = await DownloadImgCtrl().call();

    if (pic == null) {
      errorDownloadPic = true;
    }

    setState(() {
      isDownloadingPic = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DOWNLOAD IMAGE APP'),
      ),
      body: isDownloadingPic || errorDownloadPic
          ? Center(
              child: isDownloadingPic
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        const Text('Error downloading pic =('),
                        ElevatedButton(
                          onPressed: _downloadPic,
                          child: const Text('Try again'),
                        )
                      ],
                    ),
            )
          : Image.file(File(pic!), width: 600.0, height: 290.0),
    );
  }
}
