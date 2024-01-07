class OwnerModel {
  OwnerModel(
      {required this.id,
      required this.hostelName,
      required this.emailAddress,
      required this.mobileNumber,
      required this.ownwerName,
      required this.profilePictuer,
      required this.noOfRoomsInFloors});
  final String id;
  String ownwerName;
  String hostelName;
  final String emailAddress;
  final String mobileNumber;
  String profilePictuer;
  final List<int> noOfRoomsInFloors;

  Map<String, dynamic> toJson() {
    return {
      'OwnerName': ownwerName,
      'HostelName': hostelName,
      'EmailAddress': emailAddress,
      'MobileNumber': mobileNumber,
      'ProfilePictuer': profilePictuer,
      'RoomsInFloors': noOfRoomsInFloors
    };
  }
}
