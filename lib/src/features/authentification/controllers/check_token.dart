import 'package:http/http.dart' as http;

Future checkToken(token) async {
  try {
    final response = await http.post(
      Uri.parse('http://api.cleanchtraffic.com:5000/api/auth/token/verify/'),
      body: {
        'token': token,
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      return token;
    }
  } catch (error) {
    print('Error sending event: $error');
  }
}
