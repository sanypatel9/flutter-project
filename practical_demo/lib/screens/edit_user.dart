import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practical_demo/model/user.dart';
import 'package:practical_demo/services/user_service.dart';

class EditUser extends StatefulWidget {
  final User user;

  const EditUser({Key key, this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var _userNameController = TextEditingController();

  // var _userContactController = TextEditingController();
  // var _userDescriptionController = TextEditingController();
  var _userMathsController = TextEditingController();
  var _userEnglishController = TextEditingController();
  var _userGujaratiController = TextEditingController();

  bool _validateName = false;

  // bool _validateContact = false;
  // bool _validateDescription = false;
  bool _validateMath = false;
  bool _validateEnglish = false;
  bool _validateGujarati = false;
  bool _validateMathValue = false;
  bool _validateEnglishValue = false;
  bool _validateGujaratiValue = false;
  bool _isImageSelected = false;

  var _userService = UserService();
  File image;

  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    setState(() {
      _userNameController.text = widget.user.name ?? '';
      _userMathsController.text = widget.user.maths ?? '';
      _userEnglishController.text = widget.user.english ?? '';
      _userGujaratiController.text = widget.user.gujarati ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Practical"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit New User',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),

              Center(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getMyImages();
                      });
                    },
                    child: Text("Add Student Photo")),
              ),

              const SizedBox(
                height: 20.0,
              ),

              Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20)),
                    height: 200,
                    width: 200,
                    child: image == null
                        ? Icon(
                      Icons.supervised_user_circle_outlined,
                      size: 100,
                    )
                        : Image.file(
                      image,
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  //
                  controller: _userMathsController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Maths Mark',
                    labelText: 'Maths',
                    errorText: _validateMath
                        ? 'Maths Value Can\'t Be Empty'
                        : _validateMathValue
                            ? "Maths Value Can\'t Be Greater Full Mark "
                            : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  //
                  controller: _userEnglishController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Add English Mark',
                    labelText: 'English',
                    errorText: _validateEnglish
                        ? 'English Value Can\'t Be Empty'
                        : _validateEnglishValue
                            ? 'English Value Can\'t Be Greater Full Mark'
                            : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], //                   controller: _userGujaratiController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Add Gujarati Mark',
                    labelText: 'Gujarati',
                    errorText: _validateGujarati
                        ? 'Gujarati Value Can\'t Be Empty'
                        : _validateGujaratiValue
                            ? "Gujarati Value Can\'t Be Greater Full Mark"
                            : null,
                  )),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _userMathsController.text.isEmpty
                              ? _validateMath = true
                              : _validateMath = false;
                          _userEnglishController.text.isEmpty
                              ? _validateEnglish = true
                              : _validateEnglish = false;
                          _userGujaratiController.text.isEmpty
                              ? _validateGujarati = true
                              : _validateGujarati = false;

                          int.parse(_userMathsController.text) > 100
                              ? _validateMathValue = true
                              : _validateMathValue = false;
                          int.parse(_userEnglishController.text) > 100
                              ? _validateEnglishValue = true
                              : _validateEnglishValue = false;
                          int.parse(_userGujaratiController.text) > 100
                              ? _validateGujaratiValue = true
                              : _validateGujaratiValue = false;
                          image!=null ?
                          _isImageSelected=false :
                          _isImageSelected=true ;
                        });
                        if (_validateName == false &&
                            _validateMath == false &&
                            _validateEnglish == false &&
                            _validateGujarati == false &&
                            _validateMathValue == false &&
                            _validateEnglishValue == false &&
                            _validateGujaratiValue == false && _isImageSelected==false) {
                          // print("Good Data Can Save");
                          var _user = User();
                          _user.id = widget.user.id;
                          _user.name = _userNameController.text;
                          _user.maths = _userMathsController.text;
                          _user.english = _userMathsController.text;
                          _user.gujarati = _userMathsController.text;
                          _user.picture=await image.path;

                          var result = await _userService.UpdateUser(_user);
                          Navigator.pop(context, result);
                        }else if (image==null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Select Image"),
                          ));
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _userNameController.text = '';
                        _userMathsController.text = '';
                        _userEnglishController.text = '';
                        _userGujaratiController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Future getMyImages() async {
    final pickedImages = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImages != null) {
        image = File(pickedImages.path);
      }
    });
  }
}
