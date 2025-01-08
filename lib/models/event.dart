class Event {
  //data class //Model
  static const String collectionName = 'Events';
  String id;
  String title;
  String discription;
  String image;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;
  int selectedCatId;

  Event(
      {this.id = '',
      required this.title,
      required this.discription,
      required this.image,
      required this.eventName,
      required this.dateTime,
      required this.time,
      this.isFavorite = false,
      required this.selectedCatId});

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'discription': discription,
      'image': image,
      'eventName': eventName,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
      'isFavorite': isFavorite,
      'selectedCatId': selectedCatId,
    };
  }

  Event.fromFireStore(Map<String, dynamic>? data)
      : this(
            id: data!['id'] as String,
            title: data['title'] as String,
            discription: data['discription'] as String,
            image: data['image'] as String,
            eventName: data['eventName'] as String,
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            time: data['time'] as String,
            isFavorite: data['isFavorite'] as bool,
            selectedCatId: data['selectedCatId'] as int);
}
