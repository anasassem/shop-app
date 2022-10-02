import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/modules/shop_app/login/login%20Screen.dart';

import '../../../components/components.dart';
import '../../../providers/loginprovider.dart';
import '../../../providers/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
        builder: (ctx, value, child)
        {
          Provider.of<MyProvider>(context,listen: false).getUserDate();
          return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Image(
                          image: AssetImage('assets/5.jpg'),
                          height: 200,
                          width: 200,
                        ),
                      ),
                      Text(
                        "Register",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your name";
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            label: const Text("Enter your name"),
                            prefixIcon: const Icon(Icons.person),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your Email Address";
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            label: const Text("Enter your email"),
                            prefixIcon: const Icon(Icons.alternate_email),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onFieldSubmitted: (val) {
                          if (formKey.currentState!.validate()) {
                            value.userRegister(context,
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text);
                          }
                        },
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your Password";
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: value.isvisible,
                        onTap: () {},
                        decoration: InputDecoration(
                            label: const Text("Enter your password"),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: value.suffix,
                              onPressed: () {
                                value.changeToVisible();
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your phone";
                          }
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            label: const Text("Enter your phone"),
                            prefixIcon: const Icon(Icons.phone),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      value.isLoding
                          ? const Center(child: CircularProgressIndicator())
                          : defualtButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  value.userRegister(context,
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
                                }
                              },
                              txt: "Register"),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        },
    );
  }
}
