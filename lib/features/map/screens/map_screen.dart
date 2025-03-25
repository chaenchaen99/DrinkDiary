import 'package:drink_diary/core/constants/app_constants.dart';
import 'package:drink_diary/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/widgets/build_images.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isBottomSheetVisible = false;
  String _selectedBarName = '';
  String _selectedBarAddress = '';
  String _selectedBarLink = '';

  void _showBottomSheet(String name, String address, String link) {
    setState(() {
      _isBottomSheetVisible = true;
      _selectedBarName = name;
      _selectedBarAddress = address;
      _selectedBarLink = link;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // FlutterMap 위젯
        FlutterMap(
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
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(Uri.parse(
                      'https://openstreetmap.org/copyright')), // External link
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                _showBottomSheet(
                  '바 이름',
                  '서울시 강남구 테헤란로 38길',
                  'https://naver.com',
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
        ),

        if (_isBottomSheetVisible)
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ListView(
                  controller: controller,
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: AppSizes.marginS),
                    Center(
                      child: Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.marginL,
                        vertical: AppSizes.marginM,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedBarName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: AppSizes.paddingXS),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                _selectedBarAddress,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.paddingXS),
                          GestureDetector(
                            onTap: () async {
                              final url = Uri.parse(_selectedBarLink);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                print('Could not launch $url');
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.link,
                                    size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  _selectedBarLink,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
                    const SizedBox(height: AppSizes.marginS),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
