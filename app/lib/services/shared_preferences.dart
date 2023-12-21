import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> storeUsername(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<void> storeRole(String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  Future<String?> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<String?> getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  Future<String?> getUsernameAndRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return "${prefs.getString('username')},${prefs.getString('role')}";
  }

  Future<bool> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var clear = await prefs.clear();
    return clear;
  }

  Future<void> setDownloadedFiles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("downloadedFiles", []);
  }

  Future<List<String>?> updateDownloadedFiles(newFile) async {
    var files = await getDownloadedFiles();
    files!.add(newFile);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("downloadedFiles", files);
    return getDownloadedFiles();
  }

  Future<List<String>?> getDownloadedFiles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var x = prefs.getStringList("downloadedFiles");
    return x;
  }
}
