class Category {
  String organizationId;
  String name;
  dynamic position;
  String categoryType;
  String description;
  DateTime lastUpdated;
  String id;
  dynamic parentId;
  dynamic urlSlug;
  bool isDeleted;
  DateTime dateCreated;
  List<dynamic> subcategories;
  List<dynamic> parents;

  Category({
    required this.organizationId,
    required this.name,
    required this.position,
    required this.categoryType,
    required this.description,
    required this.lastUpdated,
    required this.id,
    this.parentId,
    this.urlSlug,
    required this.isDeleted,
    required this.dateCreated,
    required this.subcategories,
    required this.parents,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        organizationId: json["organization_id"],
        name: json["name"],
        position: json["position"],
        categoryType: json["category_type"],
        description: json["description"],
        lastUpdated: DateTime.parse(json["last_updated"]),
        id: json["id"],
        parentId: json["parent_id"],
        urlSlug: json["url_slug"],
        isDeleted: json["is_deleted"],
        dateCreated: DateTime.parse(json["date_created"]),
        subcategories: List<dynamic>.from(json["subcategories"].map((x) => x)),
        parents: List<dynamic>.from(json["parents"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "organization_id": organizationId,
        "name": name,
        "position": position,
        "category_type": categoryType,
        "description": description,
        "last_updated": lastUpdated.toIso8601String(),
        "id": id,
        "parent_id": parentId,
        "url_slug": urlSlug,
        "is_deleted": isDeleted,
        "date_created": dateCreated.toIso8601String(),
        "subcategories": List<dynamic>.from(subcategories.map((x) => x)),
        "parents": List<dynamic>.from(parents.map((x) => x)),
      };
}
