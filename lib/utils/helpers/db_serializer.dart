class DbSerializer {
  List<Map<String, dynamic>> manyToJson(List<dynamic> sets) {
    List list = [];

    sets.forEach((element) {
      list.add(element.toJson());
    });

    return list;
  }
}
