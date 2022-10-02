import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/modules/shop_app/register/register_screen.dart';
import 'package:shopapp/providers/loginprovider.dart';
import 'package:shopapp/providers/provider.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Consumer<LoginProvider>(
        builder: (ctx, value, child) {
          Provider.of<MyProvider>(context,listen: false).getUserDate();
          return Scaffold(
          appBar: AppBar(),
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
                          image: AssetImage('assets/4.jpg'),
                          height: 200,
                          width: 200,
                        ),
                      ),
                      Text(
                        "Login",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 15,
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
                            value.userLogin(context,
                                email: emailController.text,
                                password: passwordController.text);
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
                      value.isLoding
                          ? const Center(child: CircularProgressIndicator())
                          : defualtButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  value.userLogin(context,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              txt: "Login"),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("don't have an account"),
                          defualtTextButton(
                            function: () {
                              navigateTo(context,  RegisterScreen());
                            },
                            txt: "Register Now",
                          ),
                        ],
                      )
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
