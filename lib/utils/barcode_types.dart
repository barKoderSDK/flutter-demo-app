import 'package:barkoder_flutter/barkoder_flutter.dart';

// 1D Barcodes
List<BarcodeType> get1D() {
  return [
    BarcodeType.code93,
    BarcodeType.code39,
    BarcodeType.codabar,
    BarcodeType.code11,
    BarcodeType.upcA,
    BarcodeType.upcE,
    BarcodeType.ean13,
    BarcodeType.ean8,
    BarcodeType.code25,
    BarcodeType.interleaved25,
    BarcodeType.itf14,
    BarcodeType.telepen,
  ];
}

List<BarcodeType> getIndustrial() {
  return [
    BarcodeType.code128,
    BarcodeType.code93,
    BarcodeType.code39,
    BarcodeType.codabar,
    BarcodeType.code11,
    BarcodeType.code25,
    BarcodeType.interleaved25,
    BarcodeType.itf14,
    BarcodeType.telepen,
  ];
}

List<BarcodeType> getRetail() {
  return [
    BarcodeType.upcA,
    BarcodeType.upcE,
    BarcodeType.ean13,
    BarcodeType.ean8,
  ];
}

List<BarcodeType> get2D() {
  return [
    BarcodeType.aztec,
    BarcodeType.aztecCompact,
    BarcodeType.qr,
    BarcodeType.qrMicro,
    BarcodeType.datamatrix,
  ];
}

List<BarcodeType> getPDF417() {
  return [
    BarcodeType.pdf417,
    BarcodeType.pdf417Micro,
  ];
}

List<BarcodeType> getDotCode() {
  return [
    BarcodeType.dotcode
  ];
}

List<BarcodeType> getMultiScan() {
  return [
    BarcodeType.code93,
    BarcodeType.code39,
    BarcodeType.codabar,
    BarcodeType.code11,
    BarcodeType.upcA,
    BarcodeType.upcE,
    BarcodeType.ean13,
    BarcodeType.ean8,
    BarcodeType.code25,
    BarcodeType.interleaved25,
    BarcodeType.itf14,
    BarcodeType.telepen,
    BarcodeType.aztec,
    BarcodeType.aztecCompact,
    BarcodeType.qr,
    BarcodeType.qrMicro,
    BarcodeType.datamatrix,
  ];
}

List<BarcodeType> getDPM() {
  return [
    BarcodeType.datamatrix
  ];
}

List<BarcodeType> getVIN() {
  return [
    BarcodeType.qr,
    BarcodeType.code128,
    BarcodeType.code39,
    BarcodeType.datamatrix,
  ];
}

List<BarcodeType> getDeblur() {
  return [
    BarcodeType.upcA,
    BarcodeType.upcE,
    BarcodeType.ean13,
    BarcodeType.ean8,
  ];
}

List<BarcodeType> getMisshaped() {
  return [
    BarcodeType.code128,
    BarcodeType.code93,
    BarcodeType.code39,
    BarcodeType.codabar,
    BarcodeType.code11,
    BarcodeType.coop25,
    BarcodeType.interleaved25,
    BarcodeType.itf14,
    BarcodeType.telepen,
  ];
}

List<BarcodeType> getGalleryScan() {
  return [
    
  ];
}

List<BarcodeType> getAll() {
  return [
    BarcodeType.code93,
    BarcodeType.code39,
    BarcodeType.codabar,
    BarcodeType.code11,
    BarcodeType.upcA,
    BarcodeType.upcE,
    BarcodeType.ean13,
    BarcodeType.ean8,
    BarcodeType.code25,
    BarcodeType.interleaved25,
    BarcodeType.itf14,
    BarcodeType.telepen,
    BarcodeType.aztec,
    BarcodeType.aztecCompact,
    BarcodeType.qr,
    BarcodeType.qrMicro,
    BarcodeType.datamatrix,
  ];
}