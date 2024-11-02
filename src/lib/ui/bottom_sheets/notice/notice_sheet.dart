
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gyde_app/ui/bottom_sheets/notice/notice_sheet_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class NoticeSheet extends StackedView<NoticeSheetModel> {
	const NoticeSheet({
		required this.completer,
		required this.request,
		super.key,
	});
	final Function(SheetResponse)? completer;
	final SheetRequest request;

	@override
	Widget builder(
		BuildContext context,
		NoticeSheetModel viewModel,
		Widget? child,
	) {
		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
			decoration: BoxDecoration(
				color: Theme.of(context).colorScheme.surface, // Use theme surface color
				borderRadius: const BorderRadius.only(
					topLeft: Radius.circular(10),
					topRight: Radius.circular(10),
				),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.min,
				children: [
					Text(
						request.title!,
						style: Theme.of(context).textTheme.displayLarge, // Use theme displayLarge for title
					),
					verticalSpaceTiny,
					Text(
						request.description!,
						style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface), // Use theme bodyMedium for description and apply onSurface color
						maxLines: 3,
						softWrap: true,
					),
					verticalSpaceLarge,
				],
			),
		);
	}

	@override
	NoticeSheetModel viewModelBuilder(BuildContext context) => NoticeSheetModel();
}
