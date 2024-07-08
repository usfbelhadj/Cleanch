import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myflutter/src/constants/sizes.dart';
import 'package:myflutter/src/features/authentification/models/user/user_controller.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

import '../../../constants/colors.dart';
import 'controllers/edit_profile.dart';
import 'user_profile.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final box = GetStorage();
  final userControllers = Get.find<UserController>();

  TextEditingController _firstNameController = TextEditingController();

  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    final userData = userControllers.userData.value;
    String firstName = userData['first_name'];
    String lastName = userData['last_name'];
    String email = userData['email'];
    String phone = userData['phone'];
    _firstNameController.text = firstName;
    _lastNameController.text = lastName;
    _emailController.text = email;
    _phoneController.text = phone;

    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accessToken = box.read('accessToken');
    print(accessToken);
    final userData = userControllers.userData.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 150, 222, 255),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        title: Obx(
          () {
            return Text(
              tr('EditProfile'),
              style: Theme.of(context).textTheme.headlineSmall,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(DefaultSize),
          child: Column(children: [
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    label: Text(tr('FirstName')),
                    prefixIcon: Icon(Icons.person_outline_outlined),
                  ),
                ),
                const SizedBox(height: FormHeight - 20),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    label: Text(tr('LastName')),
                    prefixIcon: Icon(Icons.person_outline_outlined),
                  ),
                ),
                const SizedBox(height: FormHeight - 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text(tr('Email')),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: FormHeight - 20),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text(tr('Phone')),
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                const SizedBox(height: FormHeight),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async => {
                      if (_emailController.text.isEmpty &&
                          _firstNameController.text.isEmpty &&
                          _lastNameController.text.isEmpty &&
                          _phoneController.text.isEmpty)
                        {
                          Get.snackbar("Error", "Please fill all fields"),
                        },
                      if (_emailController.text.isEmpty)
                        {
                          _emailController.text = userData['email'],
                        },
                      if (_firstNameController.text.isEmpty)
                        {
                          _firstNameController.text = userData['first_name'],
                        },
                      if (_lastNameController.text.isEmpty)
                        {
                          _lastNameController.text = userData['last_name'],
                        },
                      if (_phoneController.text.isEmpty)
                        {
                          _phoneController.text = userData['phone'],
                        },
                      await editProfile(
                        {
                          'email': _emailController.text,
                          'first_name': _firstNameController.text,
                          'last_name': _lastNameController.text,
                          'phone': _phoneController.text,
                          "language": "string",
                          "last_location": "string",
                          "device": "string"
                        },
                      ),
                      Get.to(() => UserProfile()),
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 150, 222, 255),
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: Text(tr('EditProfile'),
                        style: TextStyle(color: DarkColor)),
                  ),
                ),
                const SizedBox(height: FormHeight),
              ],
            )),
          ]),
        ),
      ),
      extendBody: true,
    );
  }
}
