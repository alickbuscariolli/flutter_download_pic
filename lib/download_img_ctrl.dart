import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class DownloadImgCtrl {
  final urlToDownload =
      'https://scontent.fmel16-1.fna.fbcdn.net/v/t1.6435-9/121983714_3687641877963115_3759629493981912286_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=SLe8k8MY4DwAX91tnaC&_nc_ht=scontent.fmel16-1.fna&oh=00_AT9aVf5grbj8qd8g96uHMeBPJaNarweTrU_-SstlzHO7YA&oe=63511A3D';

  Future<String?> call() async {
    try {
      // Note that I'm using http and path_provider dependencies
      final response = await get(Uri.parse(urlToDownload));

      // You need path provider to get phone's root directory
      var documentDirectory = await getApplicationDocumentsDirectory();

      // String to images folder
      var firstPath = "${documentDirectory.path}/images";

      // String to images folder + image name (give a name you like)
      var filePathAndName = "$firstPath/du.jpg";

      // Creates the path
      await Directory(firstPath).create(recursive: true);

      // Creates the file with the image name
      File file = File(filePathAndName);

      // Writes get response in file
      file.writeAsBytesSync(response.bodyBytes);

      // Return image path String to view
      return filePathAndName;
    } catch (error) {
      print("Error downloading pic");
      return null;
    }
  }
}
