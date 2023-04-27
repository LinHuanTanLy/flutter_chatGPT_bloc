import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);

class CounterDemo extends ConsumerWidget {
  const CounterDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('counter'),
      ),
      body: Center(child: Text(count.toString())),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("++${ref.watch(counterProvider)}");
          ref.read(counterProvider.notifier).state++;
          debugPrint("++${ref.watch(counterProvider)}");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
