import 'dart:developer';
import 'package:frontend_docker/model/pelicula.dart';
import 'package:frontend_docker/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<http.Response> crearPelicula(Pelicula pelicula) {
    var url = Uri.parse(
        ApiConstants.baseUrl + ApiConstants.endPoint + ApiConstants.insert);
    return http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pelicula.toJson()),
    );
  }

  Future<List<Pelicula>?> getPeliculas() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.endPoint + ApiConstants.list);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Pelicula> peliculas = List<Pelicula>.from(
            json.decode(response.body).map((e) => Pelicula.fromJson(e)));
        return peliculas;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
