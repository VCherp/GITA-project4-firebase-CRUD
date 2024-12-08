import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/firebase_button.dart';
import '../widgets/firebase_text_field.dart';
import '/utility/firebase_wrapper.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  static const accentColor = Color.fromRGBO(255, 145, 0, 1);

  final _firebaseWrapper = FirebaseWrapper();

  final GlobalKey<FirebaseTextFieldState> _personKey = GlobalKey();
  final GlobalKey<FirebaseTextFieldState> _locationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var person = '';
    var location = '';

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'FIREBASE CRUD',
          style: TextStyle(
            color: accentColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        )),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/firebase.svg',
            height: 300,
          ),
          const SizedBox(
            height: 30,
          ),
          FirebaseTextField(
              key: _personKey,
              labelText: 'Person',
              icon: Icons.person,
              onEditingComplete: (String text) {
                person = text;
              }),
          FirebaseTextField(
              key: _locationKey,
              labelText: 'Location',
              icon: Icons.location_on,
              onEditingComplete: (String text) {
                location = text;
              }),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FirebaseButton(
                    title: 'CREATE',
                    onPress: () async {
                      final response =
                          await _firebaseWrapper.create(person, location);

                      if (context.mounted) {
                        if (response.success) {
                          _personKey.currentState?.clear();
                          _locationKey.currentState?.clear();

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'CREATE: Person location was added successfully.')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Error while creating data : ${response.error ?? ''}'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  FirebaseButton(
                    title: 'READ',
                    onPress: () async {
                      _locationKey.currentState?.clear();

                      final response = await _firebaseWrapper.read(person);

                      if (context.mounted) {
                        if (response.success) {
                          location = response.location ?? '';

                          _locationKey.currentState?.fillData(location);

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'READ: Person location was read successfully.')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Error while reading data : ${response.error ?? ''}'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FirebaseButton(
                    title: 'UPDATE',
                    onPress: () async {
                      final response =
                          await _firebaseWrapper.update(person, location);

                      if (context.mounted) {
                        if (response.success) {
                          _personKey.currentState?.clear();
                          _locationKey.currentState?.clear();

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'UPDATE: Person location was updated successfully.')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Error while updating data : ${response.error ?? ''}'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  FirebaseButton(
                    title: 'DELETE',
                    onPress: () async {
                      final response = await _firebaseWrapper.delete(person);

                      if (context.mounted) {
                        if (response.success) {
                          _personKey.currentState?.clear();
                          _locationKey.currentState?.clear();

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'DELETE: Person location was deleted successfully.')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Error while deleting data : ${response.error ?? ''}'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
