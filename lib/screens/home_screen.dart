// import 'dart:ui';

// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _typeController = TextEditingController(text: "고양이");
//   final _ageController = TextEditingController();
//   final _weightController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     double widthScreen = MediaQuery.of(context).size.width;
//     double heightScreen = MediaQuery.of(context).size.height;
//     double halfScreen = widthScreen / 2.0;
//     double padding = 10.0;

//     double labelWidth = 50.0;
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Container(
//             //   width: double.infinity,
//             //   // decoration: const BoxDecoration(
//             //   //   image: DecorationImage(
//             //   //     image: AssetImage("assets/images/main-background.png"),
//             //   //     fit: BoxFit.fill,
//             //   //   ),
//             //   // ),
//             //   child: Padding(
//             //     padding: EdgeInsets.only(
//             //         left: padding, right: padding, bottom: padding, top: 50),
//             //     child: Column(
//             //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //       children: [
//             //         // Input data

//             //         Column(
//             //           crossAxisAlignment: CrossAxisAlignment.start,
//             //           mainAxisSize: MainAxisSize.max,
//             //           children: [
//             //             Column(
//             //               children: [
//             //                 // first row
//             //                 Row(
//             //                   mainAxisAlignment: MainAxisAlignment.start,
//             //                   children: [
//             //                     SizedBox(
//             //                       width: halfScreen - padding,
//             //                       // color: Colors.pink,
//             //                       child: Row(
//             //                         mainAxisAlignment: MainAxisAlignment.start,
//             //                         children: [
//             //                           SizedBox(
//             //                             // color: Colors.amber,
//             //                             width: labelWidth,
//             //                             child: const Text("종류"), // Type
//             //                           ),
//             //                           SizedBox(
//             //                             // margin: const EdgeInsets.only(left: 20),
//             //                             width: halfScreen / 1.50,
//             //                             child: TextFormField(
//             //                               controller: _typeController,
//             //                               decoration: inputDecoration(),
//             //                             ),
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                     Container(
//             //                       margin: const EdgeInsets.only(left: 20.0),
//             //                       width: halfScreen - padding - 20.0,
//             //                       child: const Row(
//             //                         mainAxisAlignment: MainAxisAlignment.start,
//             //                         children: [
//             //                           Text("성별"), // Gender
//             //                         ],
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 ),
//             //                 // end first row

//             //                 const SizedBox(height: 5),

//             //                 // second row
//             //                 Row(
//             //                   mainAxisAlignment: MainAxisAlignment.start,
//             //                   children: [
//             //                     SizedBox(
//             //                       width: halfScreen - padding,
//             //                       child: Row(
//             //                         mainAxisAlignment: MainAxisAlignment.start,
//             //                         children: [
//             //                           SizedBox(
//             //                             // color: Colors.amber,
//             //                             width: labelWidth,
//             //                             child: const Text("나이"), // Age
//             //                           ),
//             //                           SizedBox(
//             //                             width: halfScreen / 1.50,
//             //                             child: TextFormField(
//             //                               controller: _ageController,
//             //                               decoration: inputDecoration(),
//             //                             ),
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                     Container(
//             //                       margin: const EdgeInsets.only(left: 20.0),
//             //                       width: halfScreen - padding - 20.0,
//             //                       child: const Row(
//             //                         mainAxisAlignment: MainAxisAlignment.start,
//             //                         children: [
//             //                           Text("크기"), // Size
//             //                         ],
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 ),
//             //                 // end second row

//             //                 const SizedBox(height: 5),

//             //                 // third row
//             //                 Row(
//             //                   mainAxisAlignment: MainAxisAlignment.start,
//             //                   children: [
//             //                     SizedBox(
//             //                       width: halfScreen - padding,
//             //                       child: Row(
//             //                         mainAxisAlignment: MainAxisAlignment.start,
//             //                         children: [
//             //                           SizedBox(
//             //                             // color: Colors.amber,
//             //                             width: labelWidth,
//             //                             child: const Text("무게"),
//             //                           ),
//             //                           SizedBox(
//             //                             width: halfScreen / 2,
//             //                             child: TextFormField(
//             //                               controller: _weightController,
//             //                               decoration: inputDecoration(),
//             //                             ),
//             //                           ),
//             //                           const SizedBox(width: 5),
//             //                           const Text("Kg")
//             //                         ],
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 ),
//             //               ],
//             //             ),

//             //             const SizedBox(height: 20.0),

//             //             // 활동 : Activity
//             //             Column(
//             //               crossAxisAlignment: CrossAxisAlignment.start,
//             //               children: [
//             //                 const Text("활동"), // Activity
//             //                 const SizedBox(height: 2),
//             //                 Container(
//             //                   width: double.infinity,
//             //                   height: 100,
//             //                   decoration: BoxDecoration(
//             //                       border: Border.all(
//             //                           color: Colors.orange, width: 2.0)),
//             //                   child: Padding(
//             //                     padding: const EdgeInsets.all(5),
//             //                     child: Row(
//             //                       mainAxisAlignment:
//             //                           MainAxisAlignment.spaceBetween,
//             //                       children: [
//             //                         Row(
//             //                           children: [
//             //                             const SizedBox(
//             //                               width: 80,
//             //                               child: Text("걸음걸이"), // Gait
//             //                             ),
//             //                             SizedBox(
//             //                               // margin: const EdgeInsets.only(left: 20),
//             //                               width: halfScreen / 2.0,
//             //                               child: TextFormField(
//             //                                 controller: null,
//             //                                 cursorColor: Colors.orange,
//             //                                 decoration: inputDecoration(),
//             //                               ),
//             //                             ),
//             //                           ],
//             //                         ),
//             //                         Row(
//             //                           mainAxisAlignment: MainAxisAlignment.end,
//             //                           children: [
//             //                             const Text("활동령"),
//             //                             const SizedBox(width: 10),
//             //                             SizedBox(
//             //                               width: halfScreen /
//             //                                   2.0, // one of half screen
//             //                               child: TextFormField(
//             //                                 controller: null,
//             //                                 cursorColor: Colors.orange,
//             //                                 decoration: inputDecoration(),
//             //                               ),
//             //                             ),
//             //                           ],
//             //                         ),
//             //                       ],
//             //                     ),
//             //                   ),
//             //                 )
//             //               ],
//             //             ),

//             //             const SizedBox(height: 20),

//             //             // 심박수 : Heart rate

//             //             Column(
//             //               crossAxisAlignment: CrossAxisAlignment.start,
//             //               children: [
//             //                 const Text("심박수"), // Activity
//             //                 const SizedBox(height: 2),
//             //                 Container(
//             //                   width: double.infinity,
//             //                   height: 100,
//             //                   decoration: BoxDecoration(
//             //                       border: Border.all(
//             //                           color: Colors.orange, width: 2.0)),
//             //                   child: Padding(
//             //                     padding: const EdgeInsets.all(5),
//             //                     child: Row(
//             //                       mainAxisAlignment:
//             //                           MainAxisAlignment.spaceBetween,
//             //                       children: [
//             //                         Row(
//             //                           children: [
//             //                             const SizedBox(
//             //                               width: 80,
//             //                               child: Text("심박수"), // heart rate
//             //                             ),
//             //                             SizedBox(
//             //                               // margin: const EdgeInsets.only(left: 20),
//             //                               width: halfScreen / 2.0,
//             //                               child: TextFormField(
//             //                                 controller: null,
//             //                                 cursorColor: Colors.orange,
//             //                                 decoration: inputDecoration(),
//             //                               ),
//             //                             ),
//             //                           ],
//             //                         ),
//             //                         Row(
//             //                           mainAxisAlignment: MainAxisAlignment.end,
//             //                           children: [
//             //                             const Text(
//             //                                 "심박상황"), // heart rate situation
//             //                             const SizedBox(width: 10),
//             //                             SizedBox(
//             //                               width: halfScreen /
//             //                                   2.0, // one of half screen
//             //                               child: TextFormField(
//             //                                 controller: null,
//             //                                 cursorColor: Colors.orange,
//             //                                 decoration: inputDecoration(),
//             //                               ),
//             //                             ),
//             //                           ],
//             //                         ),
//             //                       ],
//             //                     ),
//             //                   ),
//             //                 )
//             //               ],
//             //             ),

//             //             const SizedBox(height: 20),

//             //             // 상태 저장 :
//             //             Column(
//             //               crossAxisAlignment: CrossAxisAlignment.start,
//             //               children: [
//             //                 const Text("상태 저장"), //
//             //                 const SizedBox(height: 2),
//             //                 Container(
//             //                   width: double.infinity,
//             //                   height: 100,
//             //                   decoration: BoxDecoration(
//             //                       border: Border.all(
//             //                           color: Colors.orange, width: 2.0)),
//             //                   child: Padding(
//             //                     padding: const EdgeInsets.all(5),
//             //                     child: Row(
//             //                       mainAxisAlignment:
//             //                           MainAxisAlignment.spaceBetween,
//             //                       children: [
//             //                         // Row(
//             //                         //   children: [
//             //                         //     SizedBox(
//             //                         //       // margin: const EdgeInsets.only(left: 20),
//             //                         //       width: halfScreen / 2.0,
//             //                         //       child: TextFormField(
//             //                         //         controller: null,
//             //                         //         cursorColor: Colors.orange,
//             //                         //         decoration: inputDecoration(),
//             //                         //       ),
//             //                         //     ),
//             //                         //   ],
//             //                         // ),
//             //                       ],
//             //                     ),
//             //                   ),
//             //                 )
//             //               ],
//             //             ),
//             //           ],
//             //         ),

//             //         // Button
//             //         Row(
//             //           mainAxisAlignment: MainAxisAlignment.center,
//             //           children: [
//             //             // get data from devices Iot
//             //             ElevatedButton(
//             //               onPressed: () {},
//             //               style: ElevatedButton.styleFrom(
//             //                 padding: EdgeInsets.zero,
//             //                 foregroundColor: Colors.white,
//             //               ),
//             //               child: Ink(
//             //                 width: 320 / 3,
//             //                 height: 147 / 3,
//             //                 decoration: const BoxDecoration(
//             //                   image: DecorationImage(
//             //                     image: AssetImage("assets/images/button.png"),
//             //                   ),
//             //                 ),
//             //                 child: Container(
//             //                   alignment: Alignment.center,
//             //                   child: const Text(
//             //                     "측정",
//             //                     style: TextStyle(
//             //                       fontSize: 26,
//             //                       fontWeight: FontWeight.bold,
//             //                     ),
//             //                   ),
//             //                 ),
//             //               ),
//             //             ),

//             //             const SizedBox(width: 30),

//             //             // save to db
//             //             ElevatedButton(
//             //               onPressed: () {},
//             //               style: ElevatedButton.styleFrom(
//             //                 foregroundColor: Colors.white,
//             //                 padding: EdgeInsets.zero,
//             //               ),
//             //               child: Ink(
//             //                 width: 320 / 3,
//             //                 height: 147 / 3,
//             //                 decoration: const BoxDecoration(
//             //                   image: DecorationImage(
//             //                     image: AssetImage("assets/images/button.png"),
//             //                   ),
//             //                 ),
//             //                 child: Container(
//             //                   alignment: Alignment.center,
//             //                   child: const Text(
//             //                     "저장",
//             //                     style: TextStyle(
//             //                       fontSize: 26,
//             //                       fontWeight: FontWeight.bold,
//             //                     ),
//             //                   ),
//             //                 ),
//             //               ),
//             //             ),
//             //           ],
//             //         )
//             //       ],
//             //     ),
//             //   ),
//             // ),

//             // // 2 vertical lines
//             // Align(
//             //   alignment: Alignment.centerLeft,
//             //   child: Container(
//             //     width: 5,
//             //     color: const Color(0xff39bcb5),
//             //   ),
//             // ),
//             // Align(
//             //   alignment: Alignment.centerRight,
//             //   child: Container(
//             //     width: 5,
//             //     color: const Color(0xff39bcb5),
//             //   ),
//             // ),

//             // appBar bluetooth
//             // Align(
//             //   alignment: Alignment.topCenter,
//             //   child: Container(
//             //     color: const Color(0xff39bcb5),
//             //     // color: Colors.amber,
//             //     width: double.infinity,
//             //     height: 80,
//             //     child: Stack(
//             //       children: [
//             //         Container(
//             //           height: 4,
//             //           decoration: const BoxDecoration(
//             //             gradient: LinearGradient(
//             //               colors: [
//             //                 Color.fromARGB(255, 74, 74, 74),
//             //                 Color.fromARGB(255, 238, 238, 238),
//             //               ],
//             //               begin: Alignment.topCenter,
//             //               end: Alignment.bottomCenter,
//             //             ),
//             //           ),
//             //           child: Row(
//             //             children: [
//             //               Icon(
//             //                 Icons.add,
//             //               ),
//             //               Icon(Icons.add),
//             //             ],
//             //           ),
//             //         ),
//             //         Positioned(
//             //           top: 60,
//             //           child: Container(
//             //             // margin: const EdgeInsets.only(top: 30),
//             //             height: 30,
//             //             width: 30,
//             //             decoration: const BoxDecoration(
//             //               gradient: LinearGradient(
//             //                 colors: [
//             //                   Color.fromARGB(255, 74, 74, 74),
//             //                   Color.fromARGB(255, 238, 238, 238),
//             //                 ],
//             //                 begin: Alignment.topCenter,
//             //                 end: Alignment.bottomCenter,
//             //               ),
//             //             ),
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),

//             // empty bottom
//             // Align(
//             //   alignment: Alignment.bottomCenter,
//             //   child: Container(
//             //     width: double.infinity,
//             //     height: 25,
//             //     color: const Color(0xff39bcb5),
//             //     child: Column(
//             //       children: [
//             //         Container(
//             //           margin: const EdgeInsets.only(top: 5),
//             //           height: 4,
//             //           decoration: const BoxDecoration(
//             //             gradient: LinearGradient(
//             //               colors: [
//             //                 Color.fromARGB(255, 74, 74, 74),
//             //                 Color.fromARGB(255, 238, 238, 238),
//             //               ],
//             //               begin: Alignment.topCenter,
//             //               end: Alignment.bottomCenter,
//             //             ),
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   // outline input border
//   OutlineInputBorder outlineInputBorder() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(2.0),
//       borderSide: const BorderSide(width: 2, color: Colors.orange),
//     );
//   }

//   InputDecoration inputDecoration() {
//     return InputDecoration(
//       border: outlineInputBorder(),
//       enabledBorder: outlineInputBorder(),
//       focusedBorder: outlineInputBorder(),
//       contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
//     );
//   }
// }
