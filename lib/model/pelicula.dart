
class Pelicula {


  Pelicula(
      {required this.id,
      required this.nombre,
      required this.anioEstreno,
      required this.genero});

  int id;
  String nombre;
  String genero;
  int anioEstreno;

  factory Pelicula.fromJson(Map<String, dynamic> json) => Pelicula(
      id: json["id"],
      nombre: json["nombre"],
      anioEstreno: json["anioEstreno"],
      genero: json["genero"]);

  Map<String, dynamic> toJson()=>{
    "id":id,
    "nombre":nombre,
    "anioEstreno":anioEstreno,
    "genero":genero
  };
}
