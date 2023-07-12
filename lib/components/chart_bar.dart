import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String? label;
  final double? value;
  final double? percentage;

  const ChartBar({
    this.label,
    this.value,
    this.percentage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                // ignore: unnecessary_string_interpolations
                child: Text('${value!.toStringAsFixed(2)}'),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label!),
              ),
            ),
          ],
        );
      },
    );
  }
}

// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, use_key_in_widget_constructors
// import 'package:flutter/material.dart';

// class ChartBar extends StatelessWidget {
//   final String? label;
//   final double? value;
//   final double? percentage;

//   const ChartBar({
//     this.label,
//     this.value,
//     this.percentage,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (ctx, constraints) {
//         return Column(
//           children: [
//             SizedBox(
//               height: constraints.maxHeight * 0.15,
//               child: FittedBox(
//                 child: Text('${value?.toStringAsFixed(2)}'),
//               ),
//             ),
//             SizedBox(height: constraints.maxHeight * 0.05),
//             SizedBox(
//               height: constraints.maxHeight * 0.06,
//               width: 10,
//               child: Stack(
//                 alignment: Alignment.bottomCenter, //de baixo para cima
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                         width: 1.0,
//                       ),
//                       color: Color.fromRGBO(220, 220, 220, 1),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                   FractionallySizedBox(
//                     heightFactor: percentage,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).colorScheme.primary,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: constraints.maxHeight * 0.05),
//             SizedBox(
//                 height: constraints.maxHeight * 0.15,
//                 child: FittedBox(child: Text(label!))),
//           ],
//         );
//       },
//     );
//   }
// }