import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticket_app/domain/ext.dart';

import '../widgets/popular_searched_list.dart';
import '../../domain/constants.dart';
import '../styles/app_colors.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/search_bottom_sheet.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  addMarker(markerID, context, icon) {
    _getAssetIcon(context, icon).then(
      (BitmapDescriptor icon) {
        _setMarkerIcon(markerID, icon);
      },
    );
  }

  void _setMarkerIcon(String markerID, BitmapDescriptor assetIcon) {
    final Marker marker = Marker(
      markerId: MarkerId(markerID),
      position: ref.markersMap[markerID]!.position,
      onTap: () => showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        isScrollControlled: true,
        isDismissible: true,
        builder: (context) {
          return SearchBottomSheet(
            markerId: markerID,
          );
        },
      ),
    );
    if (mounted) {
      setState(
        () {
          ref.setMarker(
            marker.copyWith(
              iconParam: assetIcon,
            ),
          );
        },
      );
    }
  }

  Future<BitmapDescriptor> _getAssetIcon(BuildContext context, icon) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config = createLocalImageConfiguration(context);

    AssetImage(icon)
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      final ByteData? bytes =
          await image.image.toByteData(format: ImageByteFormat.png);
      if (bytes == null) {
        bitmapIcon.completeError(Exception('Unable to encode icon'));
        return;
      }
      final BitmapDescriptor bitmap =
          BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));

    return await bitmapIcon.future;
  }

  addFakeMarkers(BuildContext context, WidgetRef ref) {
    for (var event in ref.sharedEvents) {
      addMarker(event.id.toString(), context, ref.getMarkerIcon(event));
    }
  }

  @override
  Widget build(BuildContext context) {
    addFakeMarkers(context, ref);
    ref.markersMap;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialLocation,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              markers: ref.markersMap.values.toSet(),
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(mapStyle);
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    AppColors.white,
                    AppColors.white.withOpacity(0.1),
                  ])),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios,
                          color: AppColors.red,
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          hint: 'Event name, artist, place',
                          controller: TextEditingController(),
                          prefIcon: Icon(Icons.search,
                              color: AppColors.grey.withOpacity(0.5)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const PopularSearchedList(),
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.gps_fixed,
                            color: AppColors.red,
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
