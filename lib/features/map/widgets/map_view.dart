import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../core/constants/app_constants.dart';

class MapView extends StatelessWidget {
  final VoidCallback onMarkerTap;

  const MapView({
    super.key,
    required this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: AppConstants.defaultLatLng,
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.maptiler.com/maps/bright-v2/{z}/{x}/{y}.png?key=GUYdiyQdpQ43k4ckiMdH',
          userAgentPackageName: 'com.chaeyeon.drinkDiary',
        ),
        GestureDetector(
          onTap: onMarkerTap,
          child: MarkerLayer(
            markers: [
              Marker(
                point: AppConstants.defaultLatLng,
                width: 30,
                height: 60,
                child: Image.asset('assets/icons/place_bar.png'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
