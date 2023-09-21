import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/features/auth/auth_service.dart';
import 'package:todo_list/models/user.dart';
import 'package:todo_list/providers/user_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
  static String routename = "/auth-screen";
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conformpasswordcontroller = TextEditingController();
  String passwordDummy = "";
  String conformpasswordDummy = "";
  bool showpass = true;
  bool conformshowpass = true;
  bool showSignup = true;

  final fromKey = GlobalKey<FormState>();
  bool checkpass = false;
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
                      key: fromKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name.";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Name"),
                              border: OutlineInputBorder(),
                            ),
                            controller: usernamecontroller,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            // key: emailKey,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email.";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              border: OutlineInputBorder(),
                            ),
                            controller: emailcontroller,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password.";
                              }
                              // if (passwordcontroller.text !=
                              //         conformpasswordcontroller.text &&
                              //     checkpass == true) {
                              //   return "Entered passwords are not alike.";
                              // }
                              return null;
                            },
                            obscureText: showpass,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (passval) {
                              setState(() {
                                passwordDummy = passval;
                              });
                            },
                            decoration: InputDecoration(
                                suffixIcon: passwordDummy != ""
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password again.";
                              }

                              if (passwordcontroller.text != value &&
                                  checkpass == true) {
                                return "Entered passwords are not alike.";
                              }

                              return null;
                            },
                            obscureText: conformshowpass,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (passval) {
                              setState(() {
                                conformpasswordDummy = passval;
                              });
                            },
                            decoration: InputDecoration(
                                suffixIcon: conformpasswordDummy != ""
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
                            onPressed: () async {
                              if (passwordDummy != "") {
                                setState(() {
                                  checkpass = true;
                                });
                              } else if (passwordDummy == "") {
                                setState(() {
                                  checkpass = false;
                                });
                              }

                              if (fromKey.currentState!.validate()) {
                                final userCred = User(
                                    username: usernamecontroller.text,
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                                await AuthService.postSignup(userCred, context);
                              }
                            },
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
                                fromKey.currentState?.reset();
                                showSignup = false;
                                emailcontroller.clear();
                                passwordcontroller.clear();
                                conformpasswordcontroller.clear();
                                conformpasswordDummy = "";
                                passwordDummy = "";
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
                      key: fromKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              border: OutlineInputBorder(),
                            ),
                            controller: emailcontroller,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            obscureText: showpass,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (passval) {
                              setState(() {
                                passwordDummy = passval;
                              });
                            },
                            decoration: InputDecoration(
                                suffixIcon: passwordDummy != ""
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
                              if (passwordDummy != "") {
                                setState(() {
                                  checkpass = true;
                                });
                              } else if (passwordDummy == "") {
                                setState(() {
                                  checkpass = false;
                                });
                              }

                              if (fromKey.currentState!.validate()) {
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
                                passwordDummy = "";
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
