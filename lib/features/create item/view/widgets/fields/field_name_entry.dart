import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/widgets/custom_text_field.dart';
import '../../../providers/providers.dart';

/// This will be used as the name of the elected field
class FieldNameEntry extends ConsumerWidget with CreateItemProvider {
  final String? fieldID;
  FieldNameEntry({
    super.key,
    this.fieldID,
    this.controller,
  });
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var label = "Field Name";
    return CustomTextField(
      label: label,
      controller: controller,
      suffix: SizedBox(
        height: 24,
        width: 24,
        child: CloseButton(
          onPressed: () {
            ref.read(fieldListProvider.notifier).update(
              (state) {
                state.removeWhere((element) => element.fieldID == fieldID);

                return [...state];
              },
            );
          },
        ),
      ),
    );
  }
}
