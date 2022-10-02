import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/provider.dart';

import '../../../components/components.dart';
import '../../../components/constants.dart';
import '../../../network/remote/cache_helper.dart';
import '../login/login Screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, value, child) {
      nameController.text =
          value.userModel != null ? value.userModel!.data!.name! : '';
      emailController.text =
          value.userModel != null ? value.userModel!.data!.email! : '';
      phoneController.text =
          value.userModel != null ? value.userModel!.data!.phone! : '';

      if (value.userModel != null) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person)),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'name must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      labelText: 'Email Address',
                      prefixIcon: const Icon(Icons.email_outlined)),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Email Address must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      labelText: 'Phone',
                      prefixIcon: const Icon(Icons.phone)),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    value.isLoding == true
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  value.updateUserDate(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              child: const Text('Update'),
                            ),
                          ),
                    const Spacer(),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                      onPressed  : () async {
                          try {
                            var x = await CacheHelper.removeData(key: 'token');
                            if (x == true) {
                              value.currentindex = 0;
                              navigateReplacementTo(context, LoginScreen());
                            } else {
                              null;
                            }
                          } catch (error) {
                            print(error);
                          }
                        },
                        child: const Text('Log Out'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }else{
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
