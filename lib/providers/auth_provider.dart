import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  Future<Response> getUser(int id) => get('http://youapi/users/$id');

  Future<Response> signUp(Map data) => post('http://youapi/users', data);

  Future<Response> signIn(Map data) => post('http://youapi/users', data);
  // // Post request with File
  // Future<Response<CasesModel>> postCases(List<int> image) {
  //   final form = FormData({
  //     'file': MultipartFile(image, filename: 'avatar.png'),
  //     'otherFile': MultipartFile(image, filename: 'cover.png'),
  //   });
  //   return post('http://youapi/users/upload', form);
  // }

  // GetSocket userMessages() {
  //   return socket('https://yourapi/users/socket');
  // }
}
