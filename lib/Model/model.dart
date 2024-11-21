class SavedDataEntry {
  final String qrData;
  final String locationData;
  final String ipData;
  final String date;
  final String time;

  SavedDataEntry({
    required this.qrData,
    required this.locationData,
    required this.ipData,
    required this.date,
    required this.time,
  });

  factory SavedDataEntry.fromString(String data) {
    List<String> parts = data.split(', ');
    String qr = parts[0].split('QR: ').last;
    String time = parts[1].split('Time: ').last;
    String date = parts[2].split('Date: ').last;
    String location = parts[3].split('Location: ').last;
    String ip = parts[4].split('IP: ').last;

    return SavedDataEntry(qrData: qr, locationData: location, ipData: ip, date: data, time: time);
  }

  @override
  String toString() {
    return 'QR: $qrData, Time: $time, Date: $date, Location: $locationData, IP: $ipData';
  }
}
