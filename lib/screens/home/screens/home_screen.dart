import 'package:barkoder/screens/home/functions/home_helper_functions.dart';
import 'package:barkoder/screens/settings/base_functions/get_functions.dart';
import 'package:barkoder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:barkoder_flutter/barkoder_flutter.dart';

import 'package:barkoder/screens/home/widgets/barcode_button.dart';
import 'package:barkoder/screens/home/widgets/barcode_row.dart';
import 'package:barkoder/utils/barcode_types.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // List<BarcodeType> _lastSelectedBarcodeTypes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 140,
      backgroundColor: Colors.white,
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/bg-header.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 80,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/logos/bkdr-logo.png',
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'What would you like to scan?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 32,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () => openSettingsScreen(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            BarcodeRow(
              title: '1D Barcodes',
              buttons: _build1DBarcodeButtons(context),
            ),
            BarcodeRow(
              title: '2D Barcodes',
              buttons: _build2DBarcodeButtons(context),
            ),
            BarcodeRow(
              title: 'Showcase',
              buttons: _buildShowcaseBarcodeButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  List<BarcodeButton> _build1DBarcodeButtons(BuildContext context) {
    return [
      BarcodeButton(
        title: 'All 1D',
        imagePath: 'assets/icons/ico-1d-all.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selected1DBarcodeTypes', 'allowPinchToZoom1D', 'allowBeep1D', 'allowVibrate1D', 'decodingSpeed1D', 'resolution1D', 'formating1D', 'charset1D', 'continuousScanning1D', 'misshaped1D', '', '', 'bottomsheet1D', '', '1d', '', get1D);
        },
      ),
      BarcodeButton(
        title: '1D Industrial',
        imagePath: 'assets/icons/ico-1d-industrial.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selectedIndustrialBarcodeTypes', 'allowPinchToZoomIndustrial', 'allowBeepIndustrial', 'allowVibrateIndustrial', 'decodingSpeedIndustrial', 'resolutionIndustrial', 'formatingIndustrial', 'charsetIndustrial', 'continuousScanningIndustrial', 'misshapedIndustrial', '', 'continuousThresholdIndustrial', 'bottomsheetIndustrial', '', 'industrial', '', getIndustrial);
        },
      ),
      BarcodeButton(
        title: '1D Retail',
        imagePath: 'assets/icons/ico-1d-retail.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selectedRetailBarcodeTypes', 'allowPinchToZoomRetail', 'allowBeepRetail', 'allowVibrateRetail', 'decodingSpeedRetail', 'resolutionRetail', 'formatingRetail', 'charsetRetail', 'continuousScanningRetail', 'misshapedRetail', 'blurredUPCRetail', '', 'bottomsheetRetail', '', 'ratail', '', getRetail);
        },
      ),
    ];
  }

  List<BarcodeButton> _build2DBarcodeButtons(BuildContext context) {
    return [
      BarcodeButton(
        title: 'All 2D',
        imagePath: 'assets/icons/ico-2d-datamatrix.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selected2DBarcodeTypes', 'allowPinchToZoom2D', 'allowBeep2D', 'allowVibrate2D', 'decodingSpeed2D', 'resolution2D', 'formating2D', 'charset2D', 'continuousScanning2D', '', '', '', 'bottomsheet2D', '', '2d', '', get2D);
        },
      ),
      BarcodeButton(
        title: 'PDF417',
        imagePath: 'assets/icons/ico-2d-pdf417.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selectedPDFBarcodeTypes', 'allowPinchToZoomPDF', 'allowBeepPDF', 'allowVibratePDF', 'decodingSpeedPDF', 'resolutionPDF', 'formatingPDF', 'charsetPDF', 'continuousScanningPDF', '', '', '', 'bottomsheetPDF', '', 'pdf', '', getPDF417);
        },
      ),
      BarcodeButton(
        title: 'DotCode',
        imagePath: 'assets/icons/ico-dotcode.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selectedDOTBarcodeTypes', 'allowPinchToZoomDOT', 'allowBeepDOT', 'allowVibrateDOT', 'decodingSpeedDOT', 'resolutionDOT', 'formatingDOT', 'charsetDOT', 'continuousScanningDOT', '', '', '', 'bottomsheetDOT', '', 'dot', '', getDotCode);
        },
      ),
    ];
  }

  List<BarcodeButton> _buildShowcaseBarcodeButtons(BuildContext context) {
    return [
      BarcodeButton(
        title: 'MultiScan',
        imagePath: 'assets/icons/ico-multi.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selectedMultiScanBarcodeTypes', 'allowPinchToZoomMultiScan', 'allowBeepMultiScan', 'allowVibrateMultiScan', 'decodingSpeedMultiScan', 'resolutionMultiScan', 'formatingMultiScan', 'charsetMultiScan', 'continuousScanningMultiScan', 'misshapedMultiScan', 'blurredUPCMultiScan', '', 'bottomsheetDOT', 'regionOfInterestMultiScan', 'multi', 'locationMultiScan', getMultiScan);
        },
      ),
      BarcodeButton(
        title: 'DPM',
        imagePath: 'assets/icons/ico-dpm.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selectedDPMBarcodeTypes', 'allowPinchToZoomDPM', 'allowBeepDPM', 'allowVibrateDPM', 'decodingSpeedDPM', 'resolutionDPM', 'formatingDPM', 'charsetDPM', 'continuousScanningDPM', '', '', '', 'bottomsheetDOT', '', 'dpm', 'locationDPM', getDPM);
        },
      ),
      BarcodeButton(
        title: 'VIN',
        imagePath: 'assets/icons/ico-vin.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selectedVINBarcodeTypes', 'allowPinchToZoomVIN', 'allowBeepVIN', 'allowVibrateVIN', 'decodingSpeedVIN', 'resolutionVIN', '', '', 'continuousScanningVIN', 'misshapedVIN', '', '', 'bottomsheetVIN', '', 'vin', 'locationVIN', getVIN);
        },
      ),
      BarcodeButton(
        title: 'Deblur',
        imagePath: 'assets/icons/ico-deblur.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selectedDeblurBarcodeTypes', 'allowPinchToZoomDeblur', 'allowBeepDeblur', 'allowVibrateDeblur', '', '', 'formatingDeblur', 'charsetDeblur', 'continuousScanningDeblur', '', '', '', 'bottomsheetDeblur', '', 'deblur', '', getDeblur);
        },
      ),
      BarcodeButton(
        title: 'Misshaped',
        imagePath: 'assets/icons/ico-misshaped.png',
        onTap: () async {
          await _handleBarcodeScan(context, 'selectedMissBarcodeTypes', 'allowPinchToZoomMiss', 'allowBeepMiss', 'allowVibrateMiss', '', '', 'formatingMiss', 'charsetMiss', 'continuousScanningMiss', '', '', '', 'bottomsheetMiss', '', 'miss', '', getMisshaped);
        },
      ),
      BarcodeButton(
        title: 'Gallery scan',
        imagePath: 'assets/icons/ico-gallery.png',
        onTap: () async {
          await _handleBarcodeScan(context, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', getGalleryScan);
        },
      ),
    ];
  }

SizedBox _buildBottomAppBar(BuildContext context) {
    return SizedBox(
      height: 140.0,
      child: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.history, color: Colors.white),
                  onPressed: () => openRecentScans(context),
                ),
                const Text(
                  'Recent Scans',
                  style: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  // onTap: () {
                  //   List<BarcodeType> barcodeTypesToScan =
                  //       _lastSelectedBarcodeTypes.isNotEmpty
                  //           ? _lastSelectedBarcodeTypes
                  //           : getAll();

                  //   startScanning(
                  //       context,
                  //       barcodeTypesToScan,
                  //       false,
                  //       true,
                  //       true,
                  //       DecodingSpeed.slow,
                  //       BarkoderResolution.high,
                  //       FormattingType.disabled,
                  //       'Not set',
                  //       false,
                  //       false,
                  //       false,
                  //       5,
                  //       true,
                  //       false,
                  //       '1d');
                  // },
                  onTap: () async {
                    await _handleBarcodeScan(context, 'selectedAllBarcodeTypes', 'allowPinchToZoomAll', 'allowBeepAll', 'allowVibrateAll', 'decodingSpeedAll', 'resolutionAll', 'formatingAll', 'charsetAll', 'continuousScanningAll', 'misshapedAll', 'blurredUPCAll', '', 'bottomsheetAll', 'regionOfInterestAll', 'all', 'locationAll', getAll);
                  },
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.mainRed, width: 4.0),
                      color: AppColor.mainRed,
                    ),
                    child: Center(
                      child: Image.asset('assets/icons/scan-icon.png'),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Scan',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.white),
                  onPressed: () => openAboutScreen(context),
                ),
                const Text(
                  'About',
                  style: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleBarcodeScan(
    BuildContext context,
    String type,
    String pinchToZoomKey,
    String beepKey,
    String vibrateKey,
    String speedKey,
    String resolutionKey,
    String formatingKey,
    String charsetKey,
    String continuousScanningResultKey,
    String misshapedKey,
    String blurredUPCKey,
    String continuousThresholdKey,
    String showBottomsheetKey,
    String regionOfInterestKey,
    String locationKey,
    String settingsKey,
    List<BarcodeType> Function() getDefaultBarcodeTypes,
  ) async {
    var selectedBarcodeTypes = await getSelectedBarcodeTypes(type);
    if (selectedBarcodeTypes.isEmpty) {
      selectedBarcodeTypes = getDefaultBarcodeTypes();
    }
    bool allowPinchToZoom = await getAllowPinchToZoomSetting(pinchToZoomKey);
    bool allowBeep = await getBeepSetting(beepKey);
    bool allowVibrate = await getVibrateSetting(vibrateKey);
    DecodingSpeed changeSpeed = await getDecodingSpeedSetting(speedKey);
    BarkoderResolution changeResolution = await getResolutionSetting(resolutionKey);
    FormattingType changeFormatting = await getFormatingSetting(formatingKey);
    String changeCharset = await getCharsetSetting(charsetKey);
    bool allowContinuousScanningResult = await getAllowContinuousScanning(continuousScanningResultKey);
    bool allowMisshaped = await getAllowMisshaped(misshapedKey);
    bool allowBlurredUPC = await getAllowBlurredUPC(blurredUPCKey);
    int allowContinuousThreshold = await getContinuousThreshold(continuousThresholdKey);
    bool showBottomsheet = await getShowBottomsheet(showBottomsheetKey);
    bool regionOfInterest = await getRegionOfInterest(regionOfInterestKey);
    bool location = await getLocationInPreview(locationKey);
    // _updateLastSelectedBarcodeTypes(selectedBarcodeTypes);
    // ignore: use_build_context_synchronously
    startScanning(context, selectedBarcodeTypes, allowPinchToZoom, allowBeep, allowVibrate, changeSpeed, changeResolution, changeFormatting, changeCharset, allowContinuousScanningResult, allowMisshaped, allowBlurredUPC, allowContinuousThreshold, showBottomsheet, regionOfInterest, location, settingsKey);
  }

  // void _updateLastSelectedBarcodeTypes(List<BarcodeType> selectedTypes) {
  //   setState(() {
  //     _lastSelectedBarcodeTypes = selectedTypes;
  //   });
  // }
}
