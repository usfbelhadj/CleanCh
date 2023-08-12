import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> loginOTP(String phoneNumber, String password) async {
  String url = 'http://api.cleanchtraffic.com:5000/api/auth/otp/';

  // Prepare the request body with username and password
  Map<String, String> body = {
    'phone': phoneNumber,
    'otp': password,
  };

  // Send the POST request to the Flask authentication route
  var response =
      await http.post(Uri.parse(url), body: json.encode(body), headers: {
    'Client-User-Agent': 'android',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });

  // Handle the response
  if (response.statusCode == 200) {
    print(response.body);
    print('Done');

    return 'Done'; // Login successful
  } else {
    print(response.body);
    return 'not done';
  }
}

Future<String> signUp(
    String firstName, String lastName, String phone, String email) async {
  String url = 'http://api.cleanchtraffic.com:5000/api/auth/registration/';

  Map<String, String> body = {
    'first_name': firstName,
    'last_name': lastName,
    'phone': phone,
    'email': email,
  };

  var response = await http.post(Uri.parse(url),
      body: json.encode(body),
      headers: {
        'Client-User-Agent': 'android',
        'Content-Type': 'application/json'
      });
  print(response.statusCode);

  if (response.statusCode == 201) {
    return ('Done');
  } else {
    // Sign-up failed, show error message
    print(response.body);
    return ('Not Done');
    // ...
  }
}

Future<String> phoneNumberHandler(String phoneNumber) async {
  print(phoneNumber);
  String url = 'http://api.cleanchtraffic.com:5000/api/auth/phone_exists/';

  // Prepare the request body with username and password
  Map<String, String> body = {
    'phone': phoneNumber,
  };

  // Send the POST request to the Flask authentication route
  var response =
      await http.post(Uri.parse(url), body: json.encode(body), headers: {
    'Client-User-Agent': 'android',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });

  // Handle the response
  if (response.statusCode == 200) {
    print('Done');

    return 'Done'; // Login successful
  } else {
    print(response.body);
    return 'not done';
  }
}
