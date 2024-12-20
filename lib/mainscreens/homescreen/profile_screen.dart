// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unused_field, unused_local_variable
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:robosoc/mainscreens/login_registerscreen/login_screen.dart';
import 'package:robosoc/models/component.dart';
import 'package:robosoc/utilities/image_picker.dart';
import 'package:robosoc/widgets/issued_commponent_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _image;
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  // selectImage
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  // Saving data
  void saveProfile() async {
    String name = nameController.text;
    String role = roleController.text;
    // Code for saving the profile data (not fully implemented here)
  }

  final List<Component> _issuedComponents = [
    Component(name: "Arduino", quantity: 5),
    Component(name: "Bread Board", quantity: 2),
    Component(name: "Jumper Wires", quantity: 10),
    Component(name: "Arduino", quantity: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
                const Text(
                  "Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                _image != null
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 3),
                            borderRadius: BorderRadius.circular(100)),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: MemoryImage(_image!),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 3),
                            borderRadius: BorderRadius.circular(100)),
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/defaultPerson.png"),
                        ),
                      ),
                _image != null
                    ? SizedBox()
                    : Positioned(
                        top: 2,
                        right: 3,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(
                            size: 18,
                            Icons.add_a_photo,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      )
              ],
            ),
            Column(
              children: [
                const Text(
                  "Babu Rao",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Text(
                  "Coordinator",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20),
                ),
                (_issuedComponents.isEmpty)
                    ? const SizedBox(
                        child: Center(
                          child: Text(
                            "No component Issued...",
                            style: TextStyle(
                                color: Color.fromARGB(255, 98, 98, 98),
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      )
                    : SafeArea(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Currently Issued Components",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 98, 98, 98),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                                ..._issuedComponents.map((component) {
                                  return IssuedCommponentCard(
                                      component: component);
                                })
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
