class EventModel {
  int? id;
  String? title,
      description,
      banner_image,
      date_time,
      organiser_name,
      organiser_icon,
      venue_name,
      venue_city,
      venue_country;

  EventModel(
      {this.id,
      this.title,
      this.description,
      this.banner_image,
      this.date_time,
      this.organiser_name,
      this.organiser_icon,
      this.venue_name,
      this.venue_city,
      this.venue_country});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    banner_image = json['banner_image'];
    date_time = json['date_time'];
    organiser_name = json['organiser_name'];
    organiser_icon = json['organiser_icon'];
    venue_name = json['venue_name'];
    venue_city = json['venue_city'];
    venue_country = json['venue_country'];
  }
}
