import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:practical_demo/db_helper/repository.dart';
import 'package:practical_demo/model/user.dart';

class UserService
{
   Repository _repository;
  UserService(){
    _repository = Repository();
  }
  //Save User
  SaveUser(User user) async{
    return await _repository.insertData('users', user.userMap());
  }
  //Read All Users
  readAllUsers() async{
    return await _repository.readData('users');
  }
  //Edit User
  UpdateUser(User user) async{
    return await _repository.updateData('users', user.userMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }


   static String base64String(Uint8List data) {
     return base64Encode(data);
   }
}