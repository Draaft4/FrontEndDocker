import 'package:flutter/material.dart';
import 'package:frontend_docker/model/pelicula.dart';
import 'services/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Front End Docker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Docker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pelicula>? listPelicula;

  final controllerNombre = TextEditingController();
  final controllerGenero = TextEditingController();
  final controllerAnio = TextEditingController();
  final controllerPuerto = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    listPelicula =
        await ApiService().getPeliculas(int.parse(controllerPuerto.text));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            formulario(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            listPelicula == null || listPelicula!.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listPelicula!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(listPelicula![index].id.toString()),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(listPelicula![index].nombre),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(listPelicula![index].genero),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(listPelicula![index].anioEstreno.toString())
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            getData();
          }),
    );
  }

  Widget formulario() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          crearCampo("Puerto", TextInputType.number, controllerPuerto),
          crearCampo("Nombre Pelicula", TextInputType.text, controllerNombre),
          crearCampo("Genero Pelicula", TextInputType.text, controllerGenero),
          crearCampo("Año de Estreno", TextInputType.number, controllerAnio),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: () {
                String nombre = controllerNombre.text;
                String genero = controllerGenero.text;
                int anio = int.parse(controllerAnio.text);
                Pelicula pelicula = Pelicula(
                    id: 0, nombre: nombre, anioEstreno: anio, genero: genero);
                ApiService()
                    .crearPelicula(pelicula, int.parse(controllerPuerto.text));
                getData();
              },
              child: const Text("Insertar"))
        ],
      ),
    );
  }

  Widget crearCampo(
      String valorCampo, TextInputType tipo, TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Text("$valorCampo:"),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              keyboardType: tipo,
              controller: control,
            ),
          )),
        ],
      ),
    );
  }
}
