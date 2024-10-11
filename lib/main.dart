import 'package:pet_body_health/resources/resources.dart';
import 'package:pet_body_health/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        /*
         Set BleProvider is the second element because call PetProvider
         to BleProiver                 
         Tip: check on Widget Inspector or Widget Tree
        */
        ChangeNotifierProvider(
          create: (context) => PetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BleProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => PetHealthProvider(sharedPref),
        )
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "pet body health",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.4,
              bodyColor: Colors.black,
            ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: themeColor,
          selectionHandleColor: themeColor,
        ),
        // focusColor: Colors.red,
      ),
      home: const MainScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:math';

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//             width: 300,
//             height: 300,
//             child: CustomPaint(
//               painter: Axis3DPainterCustomPainter(),
//             ),
//           ),
//         ),
//       ),
//     ),
//   ));
// }

// class Axis3DPainter extends StatelessWidget {
//   const Axis3DPainter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 300,
//       height: 300,
//       child: CustomPaint(
//         painter: Axis3DPainterCustomPainter(),
//       ),
//     );
//   }
// }

// class Axis3DPainterCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;

//     final center = Offset(size.width / 2, size.height / 2);
//     final boxSize = size.width * 0.8; // Reduce box size to 80% of container
//     final axisLength = boxSize * 0.35;

//     // Draw the grid box
//     final gridPaint = Paint()
//       ..color = Colors.grey.withOpacity(0.5)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0;

//     // Define cube vertices
//     final cubeVertices = [
//       Offset(-boxSize / 2, -boxSize / 2),
//       Offset(boxSize / 2, -boxSize / 2),
//       Offset(boxSize / 2, boxSize / 2),
//       Offset(-boxSize / 2, boxSize / 2),
//     ];

//     final zOffset =
//         Offset(-boxSize / 3 * cos(pi / 6), boxSize / 3 * sin(pi / 6));

//     // Draw front face (dashed)
//     for (int i = 0; i < 4; i++) {
//       drawDashedLine(
//         canvas,
//         center + cubeVertices[i],
//         center + cubeVertices[(i + 1) % 4],
//         gridPaint,
//       );
//     }

//     // Draw back face (dashed)
//     for (int i = 0; i < 4; i++) {
//       final backVertex = cubeVertices[i] + zOffset;
//       drawDashedLine(
//         canvas,
//         center + backVertex,
//         center + cubeVertices[(i + 1) % 4] + zOffset,
//         gridPaint,
//       );
//     }

//     // Draw connecting lines between front and back faces (dashed)
//     for (int i = 0; i < 4; i++) {
//       drawDashedLine(
//         canvas,
//         center + cubeVertices[i],
//         center + cubeVertices[i] + zOffset,
//         gridPaint,
//       );
//     }

//     // Draw X-axis (red)
//     paint.color = Colors.red;
//     canvas.drawLine(center, center + Offset(axisLength, 0), paint);
//     drawArrowhead(canvas, center + Offset(axisLength, 0), 0, paint);

//     // Draw Y-axis (green)
//     paint.color = Colors.green;
//     canvas.drawLine(center, center + Offset(0, -axisLength), paint);
//     drawArrowhead(canvas, center + Offset(0, -axisLength), -pi / 2, paint);

//     // Draw Z-axis (blue)
//     paint.color = Colors.blue;
//     canvas.drawLine(
//         center,
//         center + Offset(-axisLength * cos(pi / 6), axisLength * sin(pi / 6)),
//         paint);
//     drawArrowhead(
//         canvas,
//         center + Offset(-axisLength * cos(pi / 6), axisLength * sin(pi / 6)),
//         5 * pi / 6,
//         paint);

//     // Draw axis labels
//     final textPainter = TextPainter(textDirection: TextDirection.ltr);
//     textPainter.text =
//         const TextSpan(style: TextStyle(color: Colors.black, fontSize: 16));

//     textPainter.text = const TextSpan(
//         text: 'X', style: TextStyle(color: Colors.red, fontSize: 16));
//     textPainter.layout();
//     textPainter.paint(canvas, center + Offset(axisLength + 10, 0));

//     textPainter.text = const TextSpan(
//         text: 'Y', style: TextStyle(color: Colors.green, fontSize: 16));
//     textPainter.layout();
//     textPainter.paint(canvas, center + Offset(0, -axisLength - 20));

//     textPainter.text = const TextSpan(
//         text: 'Z', style: TextStyle(color: Colors.blue, fontSize: 16));
//     textPainter.layout();
//     textPainter.paint(
//         canvas,
//         center +
//             Offset(
//                 -axisLength * cos(pi / 6) - 20, axisLength * sin(pi / 6) + 10));

//     // Draw the object
//     final objectPaint = Paint()
//       ..color = Colors.purple
//       ..style = PaintingStyle.fill;

//     // Scale factors
//     final scale = axisLength * 2; // Full axis length is twice the axisLength

//     // Object coordinates
//     final x = -0.05 * scale;
//     final y =
//         -0.01 * scale; // Negative because Y-axis points upwards in our drawing
//     final z = 0.04 * scale;

//     // Apply simple perspective projection
//     final projectedX = center.dx + x - z * cos(pi / 6);
//     final projectedY = center.dy + y + z * sin(pi / 6);

//     canvas.drawCircle(Offset(projectedX, projectedY), 5, objectPaint);

//     // Draw dashed lines to axes
//     final dashedPaint = Paint()
//       ..color = Colors.grey
//       ..strokeWidth = 1
//       ..style = PaintingStyle.stroke;

//     drawDashedLine(canvas, Offset(projectedX, projectedY),
//         Offset(projectedX, center.dy), dashedPaint);
//     drawDashedLine(canvas, Offset(projectedX, projectedY),
//         Offset(center.dx, projectedY), dashedPaint);
//     drawDashedLine(canvas, Offset(projectedX, projectedY),
//         center + Offset(-z * cos(pi / 6), z * sin(pi / 6)), dashedPaint);
//   }

//   void drawArrowhead(Canvas canvas, Offset tip, double angle, Paint paint) {
//     canvas.save();
//     canvas.translate(tip.dx, tip.dy);
//     canvas.rotate(angle);
//     final path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(-15, -5);
//     path.lineTo(-15, 5);
//     path.close();
//     canvas.drawPath(path, paint);
//     canvas.restore();
//   }

//   void drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
//     final path = Path()..moveTo(start.dx, start.dy);

//     const dashWidth = 5;
//     const dashSpace = 5;
//     final distance = (end - start).distance;
//     final steps = distance / (dashWidth + dashSpace);

//     for (var i = 0; i < steps; i++) {
//       final startFraction = i / steps;
//       final endFraction = (i + 0.5) / steps;
//       path.moveTo(
//         start.dx + (end.dx - start.dx) * startFraction,
//         start.dy + (end.dy - start.dy) * startFraction,
//       );
//       path.lineTo(
//         start.dx + (end.dx - start.dx) * endFraction,
//         start.dy + (end.dy - start.dy) * endFraction,
//       );
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
