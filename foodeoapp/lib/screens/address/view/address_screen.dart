import 'dart:async';
import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/custom_appbar.dart';
import 'package:foodeoapp/components/round_button.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/constant/constants.dart';
import 'package:foodeoapp/screens/address/viewmodel/address_viewmodel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder2/geocoder2.dart';

import '../../../constant/theme.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({
    super.key,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final controller = Get.put(AddressViewModel());
  double? lat;
  double? long;
  LatLng? desiLocation = const LatLng(24.860966, 66.990501);
  String _address = '';
  String _area = '';
  late Completer<GoogleMapController> _mapcontroller = Completer();
  @override
  void initState() {
    super.initState();
    _mapcontroller = Completer();
  }

  void onMarkerDragEnd(LatLng position) {
    setState(() {
      desiLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwhite,
        child: Scaffold(
          appBar: CustomAppBar(
            leading: () {
              Navigator.pop(context);
            },
            title: Text(
              "Address",
              style: TextStyle(
                  color: themecontroller.textcolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp),
            ),
            margin: 0,
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Constants.screenPadding),
            child: Column(
              children: [
                Container(
                  height: 200.sp,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(35.sp))),
                  child: GoogleMap(
                    scrollGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    mapToolbarEnabled: false,
                    zoomGesturesEnabled: true,
                    initialCameraPosition:
                        CameraPosition(target: desiLocation!, zoom: 16),
                    onCameraMove: (CameraPosition? position) {
                      if (desiLocation != position!.target) {
                        setState(() {
                          desiLocation = position.target;
                        });
                      }
                    },
                    onCameraIdle: () {
                      log('Camera Idle');
                      getAddressLatLng();
                    },
                    onTap: (latlng) {
                      print(latlng);
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _mapcontroller.complete(controller);
                    },
                    markers: <Marker>{
                      Marker(
                        markerId: const MarkerId('myMarker'),
                        position: desiLocation!,
                        draggable: true,
                        onDragEnd: onMarkerDragEnd,
                      ),
                    },
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.sp, vertical: 12.sp),
                  // height: 80.sp,
                  decoration: BoxDecoration(
                      color: themecontroller.colorwhite,
                      borderRadius: BorderRadius.circular(15.sp)),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 30.sp,
                      backgroundColor: themecontroller.bgcolor,
                      child: SvgPicture.asset(
                        "assets/icons/location.svg",
                      ),
                    ),
                    title: Text(
                      _area,
                      style: TextStyle(
                          color: themecontroller.textcolor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      _address,
                      maxLines: 2,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: 12.sp),
              child: Obx(
                () => RoundButton(
                    margin: Constants.screenPadding,
                    loading: controller.isLoading.value,
                    backgroundColor: themecontroller.colorPrimary,
                    textColor: themecontroller.colorwhite,
                    height: 50.sp,
                    title: "Set Address",
                    onTap: () {
                      controller.setAddress(2, _address, lat!, long!);
                    }),
              )),
        ),
      );
    });
  }

  getAddressLatLng() async {
    try {
      final placemarks = await placemarkFromCoordinates(
        desiLocation!.latitude,
        desiLocation!.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;

        final area = '${placemark.locality}';
        final address = '${placemark.street}, ${placemark.locality}';
        setState(() {
          _area = area;
          _address = address;
          lat = desiLocation!.latitude;

          long = desiLocation!.longitude;
          log("${lat}");
          log("${long}");
          log("${_address}");
        });
      } else {
        setState(() {
          _address = 'address_not_found'.tr;
        });
      }
      GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: desiLocation!.latitude,
        longitude: desiLocation!.longitude,
        googleMapApiKey: 'AIzaSyDiJo02OZXQiW6qh3Vp1vGEUsHGsFpjKdg',
      );

      setState(() {
        _address = data.address;
      });
    } catch (e) {
      log('Address Error ${e}');
    }
  }
}
