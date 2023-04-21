// model
class ReportWt {
  final dynamic maxRpmGenerator;
  final dynamic maxRpmBilah;
  final dynamic prodKwh;
  final dynamic maxWatt;
  final dynamic maxVolt;
  final dynamic maxAmpere;
  final dynamic maxWindSpeed;
  final dynamic avgWindSpeed;

  ReportWt({
    this.maxRpmGenerator,
    this.maxRpmBilah,
    this.prodKwh,
    this.maxWatt,
    this.maxVolt,
    this.maxAmpere,
    this.maxWindSpeed,
    this.avgWindSpeed,
  });

  factory ReportWt.fromJson(Map<String, dynamic> json) {
    return ReportWt(
        maxRpmGenerator: json['report']['max_rpm_generator'],
        maxRpmBilah: json['report']['max_rpm_bilah'],
        prodKwh: json['report']['prod_kwh'],
        maxWatt: json['report']['max_watt'],
        maxVolt: json['report']['max_volt'],
        maxAmpere: json['report']['max_ampere'],
        maxWindSpeed: json['report']['max_windspeed'],
        avgWindSpeed: json['report']['avg_windspeed']);
  }
}
