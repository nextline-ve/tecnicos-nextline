class ModelMessage {
  String customId;
  String type;
  String message;
  String imageUrl;
  String date;

  ModelMessage(
      {this.customId, this.type, this.message, this.imageUrl, this.date});

  ModelMessage.fromJson(Map<String, dynamic> json) {
    customId = json['customId'];
    type = json['type'];
    message = json['message'];
    imageUrl = json['imageUrl'];
    date = json['date'] != null ? json['date'] : "";
  }

  ModelMessage.fromSnapshot(Map<dynamic, dynamic> json) {
    customId = json['customId'].toString();
    type = json['type'];
    message = json['message'];
    imageUrl = json['imageUrl'] ?? "";
    date = json['date'] != null ? parseDate(json['date']) : "";
  }

  String parseDate(String date) {
    List<String> dateData = date.split("/");
    if (dateData.length < 2) {
      dateData = date.split("-");
    }
    List<String> yearAndTime = dateData[2].split(" ");
    List<String> time = yearAndTime[1].split(":");
    return "${yearAndTime[0]}-${parseNumber(dateData[1])}-${parseNumber(dateData[0])} ${parseNumber(time[0])}:${parseNumber(time[1])}:00";
  }

  static String parseNumber(String numberUnparsed) {
    int number = int.parse(numberUnparsed);
    if (number < 10 && numberUnparsed.length < 2) {
      return "0" + numberUnparsed;
    }
    return numberUnparsed;
  }

  static String presentDate(String date) {
    List<String> dateData = date.split("-");
    List<String> dayAndTime = dateData[2].split(" ");
    List<String> time = dayAndTime[1].split(":00");
    return "${dayAndTime[0]}-${parseNumber(dateData[1])}-${parseNumber(dateData[0])} ${time[0]}:${time[1]}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customId'] = this.customId;
    data['type'] = this.type;
    data['message'] = this.message;
    data['imageUrl'] = this.imageUrl ?? "";
    data['date'] = this.date != null ? this.date : "";
    return data;
  }
}
