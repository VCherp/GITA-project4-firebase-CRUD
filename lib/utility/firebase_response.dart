class FirebaseResponse {
  final bool success;
  final String? location;
  final String? error;

  FirebaseResponse(this.success, {this.location, this.error});
}
