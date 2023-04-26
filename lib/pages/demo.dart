// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class DemoPage extends ConsumerWidget {
//   const DemoPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     int count = 0;
//     final countProvider = Provider<int>((ref) {
//       Timer.periodic(Duration(seconds: 1), (timer) {
//         count++;
//       });
//       return count;
//     });
//     final countChangesProvider = StreamProvider.autoDispose<int>((ref) {
//       final int count = ref.watch(countProvider);
//       return count;
//     });

//     return Scaffold(
//       appBar: AppBar(title: const Text('demo')),
//       body: Center(
//         child: Text('data'),
//       ),
//     );
//   }
// }
