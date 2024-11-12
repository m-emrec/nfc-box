part of tag_detail_view;

class _FloatingButtonColumn extends StatelessWidget {
  final WidgetRef ref;
  const _FloatingButtonColumn({
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Save button
        Visibility(
          visible: TagDetailProvider.isEdited(ref),
          child: FloatingActionButton.small(
            onPressed: () {},
            backgroundColor: AppColors.secondaryTeal,
            child: const Icon(
              Icons.save_outlined,
            ),
          ),
        ),

        /// Add button
        FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
          ),
        )
      ],
    );
  }
}
