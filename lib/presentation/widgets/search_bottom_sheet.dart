import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ticket_app/domain/ext.dart';
import 'package:ticket_app/presentation/widgets/search_event.dart';
import 'package:ticket_app/presentation/widgets/search_place.dart';
import '../search/demo_data.dart';
import '../styles/app_colors.dart';
import 'custom_textfield.dart';
import 'popular_searched_list.dart';

class SearchBottomSheet extends ConsumerWidget {
  final String markerId;
  SearchBottomSheet({
    Key? key,
    required this.markerId,
  }) : super(key: key);
  final DraggableScrollableController controller =
      DraggableScrollableController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.18,
      maxChildSize: 1,
      minChildSize: 0.18,
      snap: true,
      snapSizes: const [0.18, 1],
      expand: false,
      controller: controller,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: AppColors.white,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 8),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  controller.isAttached
                      ? controller.size > 0.3
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 16),
                                const BottomSheetFullHeader(),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    BottomSheetTitleAndContent(
                                      title: 'Events',
                                      contentWidget: ref.sharedEvents
                                          .getRange(
                                              0,
                                              ref.updateEventsNumber
                                                  ? ref.sharedEvents.length
                                                  : 2)
                                          .map((event) {
                                        return SearchEvent(event: event);
                                      }).toList(),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        ref.toggleEventsNumber();
                                      },
                                      child: Text(
                                        ref.updateEventsNumber
                                            ? 'Show less events'
                                            : 'Show more events',
                                        style: const TextStyle(
                                            color: AppColors.red),
                                      ),
                                    ),
                                    BottomSheetTitleAndContent(
                                      title: 'Places',
                                      contentWidget: fakePlacesList
                                          .getRange(
                                              0,
                                              ref.updatePlacesNumber
                                                  ? fakePlacesList.length
                                                  : 2)
                                          .map((place) {
                                        return SearchPlace(place: place);
                                      }).toList(),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        ref.togglePlacesNumber();
                                      },
                                      child: Text(
                                        ref.updatePlacesNumber
                                            ? 'Show less places'
                                            : 'Show more places',
                                        style: const TextStyle(
                                            color: AppColors.red),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                              ],
                            )
                          : SearchEvent(event: ref.sharedEvents[0])
                      : SearchEvent(event: ref.sharedEvents[0]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BottomSheetFullHeader extends StatelessWidget {
  const BottomSheetFullHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  hint: 'Event name, artist, place',
                  controller: TextEditingController(),
                  prefIcon: Icon(Icons.search,
                      color: AppColors.grey.withOpacity(0.5)),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, color: AppColors.red),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const PopularSearchedList(),
        ],
      ),
    );
  }
}

class BottomSheetTitleAndContent extends StatelessWidget {
  const BottomSheetTitleAndContent({
    required this.title,
    required this.contentWidget,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<Widget> contentWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontSize: 20,
            ),
          ),
        ),
        ...contentWidget,
      ],
    );
  }
}
