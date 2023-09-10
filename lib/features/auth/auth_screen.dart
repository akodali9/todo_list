import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/alert_custom.dart';
import 'package:todo_list/features/auth/auth_service.dart';
import 'package:todo_list/models/user.dart';
import 'package:todo_list/providers/user_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailcontroller = TextEditingController(text: "");
  TextEditingController passwordcontroller = TextEditingController(text: "");
  TextEditingController conformpasswordcontroller =
      TextEditingController(text: "");
  String password_dummy = "";
  bool showpass = true;
  bool conformshowpass = true;
  bool showSignup = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: const Text("Welcome"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: showSignup
                  ? Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (emailvalue) {
                              emailcontroller.value =
                                  TextEditingValue(text: emailvalue);
                            },
                            controller: emailcontroller,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: showpass,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (passval) {
                              setState(() {
                                passwordcontroller.value =
                                    TextEditingValue(text: passval);
                              });
                            },
                            decoration: InputDecoration(
                                suffixIcon: passwordcontroller.text != ""
                                    ? IconButton(
                                        icon: showpass
                                            ? const Icon(Icons.remove_red_eye)
                                            : const Icon(
                                                Icons.hide_source_rounded),
                                        onPressed: () {
                                          setState(() {
                                            if (showpass == true) {
                                              showpass = false;
                                            } else {
                                              showpass = true;
                                            }
                                          });
                                        },
                                      )
                                    : const SizedBox(),
                                // label: const Text("Password"),
                                border: const OutlineInputBorder(),
                                labelText: "Password"),
                            controller: passwordcontroller,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: conformshowpass,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (passval) {
                              setState(() {
                                conformpasswordcontroller.value =
                                    TextEditingValue(text: passval);
                              });
                            },
                            decoration: InputDecoration(
                                suffixIcon: conformpasswordcontroller.text != ""
                                    ? IconButton(
                                        icon: conformshowpass
                                            ? const Icon(Icons.remove_red_eye)
                                            : const Icon(
                                                Icons.hide_source_rounded),
                                        onPressed: () {
                                          setState(() {
                                            if (conformshowpass == true) {
                                              conformshowpass = false;
                                            } else {
                                              conformshowpass = true;
                                            }
                                          });
                                        },
                                      )
                                    : const SizedBox(),
                                // label: const Text("Password"),
                                border: const OutlineInputBorder(),
                                labelText: "Conform Password"),
                            controller: conformpasswordcontroller,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Sign-up",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Already have an account?"),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                showSignup = false;
                                emailcontroller.clear();
                                passwordcontroller.clear();
                                conformpasswordcontroller.clear();
                              });
                            },
                            child: const Text(
                              "Sign-in here",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              border: OutlineInputBorder(),
                            ),
                            // onChanged: (emailvalue) {
                            //   emailcontroller.value =
                            //       TextEditingValue(text: emailvalue);
                            // },
                            controller: emailcontroller,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: showpass,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (passval) {
                              setState(() {
                                password_dummy = passval;
                              });

                              // passwordcontroller.value =
                              //     TextEditingValue(text: passval);
                            },
                            decoration: InputDecoration(
                                suffixIcon: password_dummy != ""
                                    ? IconButton(
                                        icon: showpass
                                            ? const Icon(Icons.remove_red_eye)
                                            : const Icon(
                                                Icons.hide_source_rounded),
                                        onPressed: () {
                                          setState(() {
                                            if (showpass == true) {
                                              showpass = false;
                                            } else {
                                              showpass = true;
                                            }
                                          });
                                        },
                                      )
                                    : const SizedBox(),
                                // label: const Text("Password"),
                                border: const OutlineInputBorder(),
                                labelText: "Password"),
                            controller: passwordcontroller,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                              ),
                            ),
                            onPressed: () async {
                              final userCred = User(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                              final response = await AuthService.fetchLogin(
                                  userCred, context);
                              if (context.mounted) {
                                await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .updatetoken(response['token']);
                              }
                            },
                            child: const Text(
                              "Sign-in",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Don't have an account?"),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                showSignup = true;
                                emailcontroller.clear();
                                passwordcontroller.clear();
                              });
                            },
                            child: const Text(
                              "Sign-up here",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
