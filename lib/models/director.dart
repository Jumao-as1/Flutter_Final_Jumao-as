class Director {
  final int id;
  final String name;
  final String bio;
  final String? image; // Optional field for profile image

  Director({
    required this.id,
    required this.name,
    required this.bio,
    this.image,
  });

  // From JSON constructor
  factory Director.fromJson(Map<String, dynamic> json) {
    return Director(
      id: json['id'],
      name: json['name'],
      bio: json['company'] != null ? json['company']['catchPhrase'] : 'No bio available', // Default bio if not found
      image: null, // You can modify this later if actual image URLs are available
    );
  }

  // To JSON method for POST/PUT requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'profile_image': image, // Placeholder for image
    };
  }
}
