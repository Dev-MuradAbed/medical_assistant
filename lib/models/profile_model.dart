
class Profile {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? other;
  String? gender;
  String? height;
  String? wight;
  String? birthday;
  String? type;
  String? image;

  Profile({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.other,
    this.gender,
    this.height,
    this.wight,
    this.birthday,
    this.type,
    this.image
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'other': other,
      'gender': gender,
      'height': height,
      'wight': wight,
      'birthday': birthday,
      'type': type,
      'image':image
    };
  }

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    other = json['other'];
    gender = json['gender'];
    height = json['height'];
    wight = json['wight'];
    birthday = json['birthday'];
    image = json['image'];
    type = json['type'];
  }
}
