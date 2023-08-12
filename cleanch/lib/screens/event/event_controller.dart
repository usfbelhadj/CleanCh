import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> events() async {
  String url = 'http://api.cleanchtraffic.com:5000/api/events/';

  // Prepare the request body with username and password

  // Send the POST request to the Flask authentication route
  var response = await http.get(Uri.parse(url), headers: {
    'Client-User-Agent': 'android',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkxODczNDE3LCJpYXQiOjE2OTE4NjI2MTcsImp0aSI6IjZkOTZmYWJiODMxNDQ3NzI5MjkwMTM0ZTgyMDlhMGU1IiwidXNlcl9pZCI6Mn0.tehhdmJFHrEjHIV3YfKbwU4hat2orTfYr53RF0k5gfQ'
  });

  print(response.headers);

  // Handle the response
  if (response.statusCode == 200) {
    print('Done');
    print(response.body);

    return 'Done'; // Login successful
  } else {
    print(response.body);
    return 'not done';
  }
}

Future<String> addEvents() async {
  String url = 'http://api.cleanchtraffic.com:5000/api/events/init/';

  Map<String, String> body = {
    "event_type": "MoreEvent",
    "latitude": "37.421998",
    "longitude": "-122.084"
  };
  var response =
      await http.post(Uri.parse(url), body: json.encode(body), headers: {
    'Client-User-Agent': 'android',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkxODczNDE3LCJpYXQiOjE2OTE4NjI2MTcsImp0aSI6IjZkOTZmYWJiODMxNDQ3NzI5MjkwMTM0ZTgyMDlhMGU1IiwidXNlcl9pZCI6Mn0.tehhdmJFHrEjHIV3YfKbwU4hat2orTfYr53RF0k5gfQ'
  });

  print(response.headers);

  // Handle the response
  if (response.statusCode == 200) {
    print('Done');
    print(response.body);

    return 'Done'; // Login successful
  } else {
    print(response.body);
    return 'not done';
  }
}
