import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../view_model/sum_up_view_model.dart';

class SaveButton extends HookConsumerWidget {
  final bool disabled;

  const SaveButton({Key? key, required this.disabled}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(sumUpViewModelProvider.notifier);
    const animationDuration = Duration(milliseconds: 300);

    return AnimatedOpacity(
      opacity: disabled ? 0.5 : 1.0,
      duration: animationDuration,
      child: FloatingActionButton(
        backgroundColor: Colors.teal.shade800,
        elevation: 4.0,
        onPressed: disabled
            ? null
            : () {
                provider.save();
                Future.delayed(animationDuration, () {
                });
              },
        child: const Icon(Icons.save),
      ),
    );
  }
}
