import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:highfive/services/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:highfive/constants/helper.dart';

Future<dynamic> getApiData() async {
  // Replace this with your actual API call
  final response = await http.get(Uri.parse('https://your-api.com/endpoint'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    // Handle error
    throw Exception('Failed to get data');
  }
}

Future<dynamic> sendChat(message, username) async {
  // Replace this with your actual API call
  final response = await http
      .get(Uri.parse('${Helper.wifiIp}addmessage/$message/$username'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    // Handle error
    throw Exception('Failed to get data');
  }
}

Future<dynamic> getChats() async {
  // Replace this with your actual API call
  final response = await http.get(Uri.parse('${Helper.wifiIp}chats'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    // Handle error
    throw Exception('Failed to get data');
  }
}

Future<dynamic> uploadFile() async {
  final result = await FilePicker.platform.pickFiles();
  if (result == null) return;

  final request =
      http.MultipartRequest('POST', Uri.parse('${Helper.wifiIp}uploadfile'));
  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      result.files.first.path!,
    ),
  );

  final response = await request.send();
  if (response.statusCode == 200) {
    // Handle successful upload
    log('File uploaded successfully!');
  } else {
    // Handle error
    log('Error uploading file: ${response.statusCode}');
  }
  return "";
}

Future<dynamic> getFiles() async {
  // Replace this with your actual API call
  final response = await http.get(Uri.parse('${Helper.wifiIp}getfiles'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    // Handle error
    throw Exception('Failed to get data');
  }
}

Future<dynamic> getAnnouncements() async {
  // Replace this with your actual API call
  final response = await http.get(Uri.parse('${Helper.wifiIp}announcements'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    // Handle error
    throw Exception('Failed to get data');
  }
}

Future<dynamic> sendAnnouncements(message) async {
  // Replace this with your actual API call
  final response =
      await http.get(Uri.parse('${Helper.wifiIp}addannouncement/$message'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    // Handle error
    throw Exception('Failed to get data');
  }
}

HttpClient client = HttpClient();

// Future<void> downloadFile(String filename) async {
//   print(filename);
//   await FileDownloader.downloadFile(

//       url:
//           "https://192.168.29.62:5000/static/Picsart_23-12-12_22-06-57-363.jpg",
//       name: "highfive_$filename", //(optional)
//       onProgress: (String? fileName, double progress) {
//         print('FILE ${fileName} HAS PROGRESS $progress');
//       },
//       onDownloadCompleted: (String path) {
//         print('FILE DOWNLOADED TO PATH: $path');
//       },
//       onDownloadError: (String error) {
//         print('DOWNLOAD ERROR: $error');
//       });
// }

Dio dio = Dio();

Future<bool> downloadFile(String filename) async {
  await dio.download(
    "${Helper.wifiIp}static/$filename",
    "/storage/emulated/0/Download/$filename",
    onReceiveProgress: (count, total) {
      log("count $count total $total");
    },
  );
  await SharedPref().updateDownloadedFiles(filename);
  return true;
}
