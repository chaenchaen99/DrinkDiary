import 'package:drink_diary/core/constants/app_constants.dart';
import 'package:drink_diary/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../shared/widgets/build_images.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: AppConstants.defaultLatLng,
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          // Bring your own tiles
          urlTemplate:
              'https://api.maptiler.com/maps/bright-v2/{z}/{x}/{y}.png?key=GUYdiyQdpQ43k4ckiMdH', // For demonstration only
          userAgentPackageName:
              'com.chaeyeon.drinkDiary', // Add your app identifier
          // And many more recommended properties!
        ),
        RichAttributionWidget(
          // Include a stylish prebuilt attribution widget that meets all requirments
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(Uri.parse(
                  'https://openstreetmap.org/copyright')), // (external)
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            showBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 240, // BottomSheet의 높이 조절
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: AppSizes.marginS,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            height: 2,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: AppSizes.marginL,
                            left: AppSizes.marginL,
                            top: AppSizes.marginM),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 바 이름
                            const Text(
                              '샘플 바 이름',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: AppSizes.paddingXS),
                            // 바 장소
                            const Row(
                              children: [
                                Icon(Icons.location_on,
                                    size: 14, color: Colors.grey),
                                SizedBox(width: 4),
                                Text(
                                  '서울시 강남구 테헤란로 123',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSizes.paddingXS),
                            GestureDetector(
                              onTap: () async {
                                final url = Uri.parse('https://naver.com');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  print('Could not launch $url');
                                }
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.link,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    'https://naver.com',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      // if (wine.images?.isNotEmpty ?? false)
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: AppSizes.size8),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.size8),
                                child: BuildImages(
                                  images: null,
                                  index: index,
                                  width: 100,
                                  height: 120,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            );
          },
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
