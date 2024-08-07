import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/helpers/device_info.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/models/auto_complete_response.dart';

class SearchList extends StatelessWidget {
  SearchList(
      {super.key,
      required this.onClickSetLocation,
      this.locations = const [],
      required this.onSelectedLocation});

  VoidCallback onClickSetLocation;
  List<Prediction> locations;
  ArgumentCallback<Prediction> onSelectedLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceInfo.height,
      width: DeviceInfo.width * 0.5,
      color: backgroundTheme,
      child: Column(
        children: [
          Column(
            children: List.generate(
                locations.length,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          onSelectedLocation(locations[index]);
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(locations[index].description ?? ""),
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => onClickSetLocation(),
              child: const Row(
                children: [
                  Icon(Icons.add_location_outlined),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(flex: 1, child: Text("Set location on map")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
