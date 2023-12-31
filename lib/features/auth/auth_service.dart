import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/components/alert_custom.dart';
import 'package:todo_list/models/user.dart';
import 'package:todo_list/providers/global_variables.dart';

class AuthService {
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  static Future postSignup(User usercred, BuildContext context) async {
    final Map<String, dynamic> data = {
      "username": usercred.username,
      "email": usercred.email,
      "password": usercred.password
    };

    try {
      final response = await http.post(
        Uri.parse("$localuri/auth/signup"),
        body: json.encode(data),
        headers: AuthService.headers,
      );

      // print(response);
      final responsejson = json.decode(response.body);

      if (response.statusCode == 200) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => const AlertCustom(
              errorMessage: "Thank you for registering you can login now.",
            ),
          );
        }
      }
      if (response.statusCode == 400) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertCustom(
              errorMessage: responsejson['msg'],
            ),
          );
        }
      }
      if (response.statusCode == 500) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertCustom(
              errorMessage: responsejson['error'],
            ),
          );
        }
      }
    } catch (e) {
      //
    }
    ;
  }

  static Future fetchLogin(User userCred, BuildContext context) async {
    final Map<String, dynamic> data = {
      "email": userCred.email,
      "password": userCred.password
    };
    try {
      final response = await http.post(Uri.parse("$localuri/auth/signin"),
          body: json.encode(data), headers: headers);
      final responsejson = json.decode(response.body);
      if (response.statusCode == 200) {
        // print('response body: $responsejson + ${response.statusCode}');
        return responsejson;
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) =>
                  AlertCustom(errorMessage: responsejson['message']));
        }
      } else {
        // print("message: ${response.body}+ ${response.statusCode}");
      }
    } catch (e) {
      // print("error: $e");
    }
  }
}
