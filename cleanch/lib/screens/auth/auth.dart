import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> login(String phoneNumber, String password) async {
  String url = 'http://54.82.91.150/api/auth/logins';

  // Prepare the request body with username and password
  Map<String, String> body = {
    'phonenumber': phoneNumber,
    'password': password,
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

Future<String> signUp(
    String firstName, String password, String phone, String email) async {
  String url = 'http://15.188.48.71:5000/auth/register';

  Map<String, String> body = {
    'name': firstName,
    'password': password,
    'phone_number': phone,
    'email': email,
  };

  var response = await http.post(Uri.parse(url),
      body: json.encode(body),
      headers: {
        'Client-User-Agent': 'android',
        'Content-Type': 'application/json'
      });
  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 201) {
    var data = json.decode(response.body);
    print(data['message']);
    if (data['message'] == 'User has been registered.') {
      return ('Done');
    }
  } else {
    // Sign-up failed, show error message
    print(response.body);
    return ('Not Done');
    // ...
  }
  return "null";
}

Future<String> phoneNumberHandler(String phoneNumber) async {
  String url = 'http://15.188.48.71:5000/auth/client-login';

  // Prepare the request body with username and password
  Map<String, String> body = {
    'phone_number': phoneNumber,
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
