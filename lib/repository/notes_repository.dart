import 'dart:io';

import 'package:api_learning/model/data_response.dart';
import 'package:api_learning/model/notes.dart';
import 'package:dio/dio.dart';

class NotesRepository {
  final _dio = Dio();
  List<Notes> _notes = [];

  List<Notes> get notes => _notes;

  //=====================Get=============================
//  Future<Map<String,dynamic>> fetchNotes() async {
  //from this

  Future<DataResponse> fetchNotes() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      final _response = await _dio.get(
        "https://jsonplaceholder.typicode.com/posts",
      );
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        final _temp = List.from(_response.data);
        //convert from type dynamic to List with map
        final _data = _temp.map((e) => Map<String, dynamic>.from(e)).toList();

        _notes = _data.map((e) => Notes.json(e)).toList();
        // print(_data);

        return DataResponse.success(
            _notes); 
        
      } else {
        return DataResponse.error("Server Error");
      }
    } on SocketException catch (e) {
      //net error
      return DataResponse.error("No Internet Connection");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  //==============Post================
  Future<DataResponse> addNotes(
      {required String title, required String body}) async {
    try {
      final _body = [
        {
          "title": title,
          "body": body,
          "userId": 2
          // "userId": _userIdController.text,
        }
      ];
      final response = await _dio.post(
          "https://jsonplaceholder.typicode.com/posts",
          data: _body); //Data takes what body to post
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return DataResponse.success([response]);
      } else {
        return DataResponse.error("Unable to add new note");
      }
    } on SocketException catch (e) {
      //net error
      return DataResponse.error("No Internet Connection");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  //update
  Future<DataResponse> updateNotes(
      {required String title, required String body, required int id}) async {
    try {
      final _body = [
        {
          "title": title,
          "body": body,
          "userId": 2
          // "userId": _userIdController.text,
        }
      ];

      final response = await _dio.put(
          "https://jsonplaceholder.typicode.com/posts/$id",
          data: _body); //Data takes what body to post
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // final _noteIndex=_notes.indexWhere((e) => e.id==id);
        // if(_noteIndex!=-1){
        //   final _prevNotes=notes[_noteIndex];
        //   _notes[_noteIndex]=_prevNotes.copyWith();
        // }

        return DataResponse.success([]);
      } else {
        return DataResponse.error("Unable to update note");
      }
    } on SocketException catch (e) {
      //net error
      return DataResponse.error("No Internet Connection");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  //delete
  Future<DataResponse> deleteNotes({required int id}) async {
    try {
      final response = await _dio.delete(
        "https://jsonplaceholder.typicode.com/posts/$id",
      ); //Data takes what body to post
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // _notes = _notes
        //     .where((e) => e.id != id)
        //     .toList(); 
        return DataResponse.success([]);
      } else {
        return DataResponse.error("Unable to delete note");
      }
    } on SocketException catch (e) {
      //net error
      return DataResponse.error("No Internet Connection");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
