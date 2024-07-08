import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutter/src/features/authentification/screens/signup/widgets/signup_api.dart';
import 'package:myflutter/src/utils/translation/translation.dart';
import '../../../../../constants/sizes.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_emailController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _phoneController.text.length < 9) {
      Get.snackbar(
        tr('error'),
        tr('allFieldsRequired'),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.shade400,
        colorText: Colors.white,
      );
      return;
    }
    try {
      await singupApi.submitRegistration(
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
      );
    } catch (e) {
      // Handle any exceptions that may occur during the API call
      print("An error occurred during registration: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: FormHeight - 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: tr('FirstName'),
                prefixIcon: Icon(Icons.person_outline_outlined),
              ),
            ),
            const SizedBox(height: FormHeight - 20),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: tr('LastName'),
                prefixIcon: Icon(Icons.person_outline_outlined),
              ),
            ),
            const SizedBox(height: FormHeight - 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: tr('Email'),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: FormHeight - 20),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: tr('Phone'),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: FormHeight - 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text(tr('Signup').toUpperCase()),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
