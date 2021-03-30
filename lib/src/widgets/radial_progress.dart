import 'dart:math';

import 'package:flutter/material.dart';
class RadialProgress extends StatefulWidget {

  final porcentaje;
  final Color  colorPrimario;
  final Gradient  colorPrimarioGradiente;
  final Color  colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;


  const RadialProgress({ 
    @required this.porcentaje,
    this.colorPrimario    = Colors.blue, 
    this.colorSecundario  = Colors.grey, 
    this.grosorSecundario = 4,
    this.grosorPrimario   = 10,
    this.colorPrimarioGradiente
  });




  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {
  
  AnimationController controller;
  double porcentajeAnterior;

  @override
  void initState() {
    
    porcentajeAnterior = widget.porcentaje;
    controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 200));




    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {

    controller.forward(from: 0.0);
    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: controller, 
      builder: (context, child) {
        return Container(
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              height: double.infinity,
              child: CustomPaint(
                painter: _MiRadiaProgress( 
                  ( widget.porcentaje - diferenciaAnimar ) + ( diferenciaAnimar * controller.value ),
                  widget.colorPrimario,
                  widget.colorSecundario,
                  widget.grosorSecundario,
                  widget.grosorPrimario,
                  widget.colorPrimarioGradiente
                ),
              ),
          );
        },
      );

    
  }
}


class _MiRadiaProgress extends CustomPainter{

  final porcentaje;
  final Color  colorPrimario;
  final Color  colorSecundario;
  final double grosorSecundario;
  final double grosorPrimario;
  final Gradient colorPrimarioGradiente;
  _MiRadiaProgress( 
    this.porcentaje,
    this.colorPrimario, 
    this.colorSecundario,
    this.grosorSecundario,
    this.grosorPrimario,
    this.colorPrimarioGradiente
  );

  @override
  void paint(Canvas canvas, Size size) {

    // final porcentaje = 75;

    final Rect rect = new Rect.fromCircle(
      center: Offset(0,0), 
      radius: 180
    );


    //Circulo Completado
    final paint= new Paint()
          ..strokeWidth = grosorSecundario
          ..color       = colorSecundario
          ..style       = PaintingStyle.stroke;

    final Offset center = new Offset(size.width * 0.5,size.height / 2);
    final double radio  = min(size.width*0.5, size.height*0.5);

    canvas.drawCircle(center, radio, paint);

    //Arco
    final paintArco= new Paint()
          ..strokeWidth = grosorPrimario
          // ..color       = colorPrimario
          // ..shader      = gradiente.createShader(rect)
          ..strokeCap   = StrokeCap.round
          ..style       = PaintingStyle.stroke;

    if (colorPrimarioGradiente!=null){
      paintArco.shader = colorPrimarioGradiente.createShader(rect);
    }else{
      paintArco.color  = colorPrimario;
    }

    // Parte que se deberá ir llenando
    double arcAngle = 2 * pi * ( porcentaje / 100 );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radio),
      -pi / 2,
      arcAngle,
      false,
      paintArco
    );



      
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


}