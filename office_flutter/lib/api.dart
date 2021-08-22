import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:office_flutter/constants.dart';
import './file_models.dart';
import 'package:http/http.dart' as http;

class FilesProvider with ChangeNotifier {
  FilesProvider() {
    this.fetchFiles();
  }

  List<File> _file = [];

  List<File> get files {
    return [..._file];
  }

  void addFiles(File file) async {
    final url = Uri.parse('http://10.0.2.2:8000/notes/');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(file));

    if (response.statusCode == 201) {
      file.id = json.decode(response.body)['id'];
      _file.add(file);
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }

  void deleteFile(File file) async {
    final url = Uri.parse('http://10.0.2.2:8000/notes/${file.id}/');
    final response = await http.delete(url);
    if (response.statusCode == 204) {
      _file.remove(file);
      notifyListeners();
    }
  }

  void updateFile(File file) async{
    final url = Uri.parse('http://10.0.2.2:8000/notes/${file.id}/');
    final response = await http.put(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(file));
    if (response.statusCode == 200) {
      _file[_file.indexWhere((element) => element.id == json.decode(response.body)['id'])].content = json.decode(response.body)['content'];
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }

  fetchFiles() async {
    final url = 'http://10.0.2.2:8000/notes/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _file = data.map<File>((json) => File.fromJson(json)).toList();
      print('Fetched From Rest API');
      isLoading = false;
      notifyListeners();
    }
  }
}
