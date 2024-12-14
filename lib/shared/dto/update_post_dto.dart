class UpdatePostDto {
  final int id;
  final String title;
  final String description;

  const UpdatePostDto({
    required this.id,
    required this.title,
    required this.description
  });
}