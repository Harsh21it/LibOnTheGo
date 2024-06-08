// ignore_for_file: use_build_context_synchronously, unused_local_variable, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:libonthego/widget/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class FormFill extends StatefulWidget {
  const FormFill({super.key});

  @override
  State<FormFill> createState() {
    return _FormFill();
  }
}

class _FormFill extends State<FormFill> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticating = false;
  var _enteredUsername = '';
  var _enteredRoll = '';
  var _enteredContact = '';
  var _enteredYoS = '';
  var _enteredbranch = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid || !_isLogin && _selectedImage == null) {
      return;
    }

    _formKey.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');
        await storageRef.putFile(_selectedImage!);
        final imageURL = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'imageUrl': imageURL,
          'rollNo': _enteredRoll,
          'contact': _enteredContact,
          'yos': _enteredYoS,
          'branch': _enteredbranch,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message ?? 'Authentication Failed.',
          ),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 0,
                left: 20,
                right: 20,
              ),
              width: 200,
              child: Image.asset('assets/images/Icon.png'),
            ),
            const SizedBox(
              height: 85,
            ),
            Container(
              child: Card(
                color: const Color.fromARGB(218, 255, 255, 255),
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              onPickImage: (pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@dtu.ac.in')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Username'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please enter a valid username';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredUsername = value!;
                              },
                            ),
                          if (!_isLogin)
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Roll No.'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please enter a valid RollNo';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredRoll = value!;
                              },
                            ),
                          if (!_isLogin)
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Branch'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please enter a valid branch';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredbranch = value!;
                              },
                            ),
                          if (!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Contact Number'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return 'Please enter a valid contact number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredContact = value!;
                              },
                            ),
                          if (!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText:
                                      'Year of Study(First,Second,Third,Forth)'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please enter a valid year of study';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredYoS = value!;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: () {
                                print('Pressed');
                                _submit();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(_isLogin ? 'Login' : 'Sign up'),
                            ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin
                                    ? 'Create an account'
                                    : 'I already have an account.',
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
