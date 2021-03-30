import 'package:flutter/material.dart';
import 'package:pinterest_layout/src/widgets/radial_progress.dart';

class GraficasCircularesPage extends StatefulWidget {
  @override
  _GraficasCircularesPageState createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  double porcentaje = 0.0;

  final Gradient gradiente = new LinearGradient(
      colors: <Color>[Color(0xffC012FF), Color(0xff6D05E8), Colors.red]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              porcentaje += 10;
              if (porcentaje > 100) {
                porcentaje = 0;
              }
            });
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRadiaProgress(porcentaje: porcentaje, color: Colors.blue),
                CustomRadiaProgress(
                  porcentaje: porcentaje,
                  color: Colors.red,
                  gradiente: gradiente,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRadiaProgress(porcentaje: porcentaje, color: Colors.pink),
                CustomRadiaProgress(
                    porcentaje: porcentaje, color: Colors.purple),
              ],
            )
          ],
        ));
  }
}

class CustomRadiaProgress extends StatelessWidget {
  final Color color;
  final Gradient gradiente;
  const CustomRadiaProgress(
      {@required this.porcentaje, @required this.color, this.gradiente});

  final double porcentaje;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 180,
        height: 180,
        child: RadialProgress(
          porcentaje: porcentaje,
          colorPrimario: color,
          colorSecundario: Colors.grey,
          grosorPrimario: 10,
          grosorSecundario: 4,
          colorPrimarioGradiente: gradiente,
        ));
  }
}
