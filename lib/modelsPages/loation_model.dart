class LocationModel {
  List<DistrictModel> destricts;

  LocationModel({required this.destricts});

  Map<String, dynamic> toMap() {
    return {
      'districts': destricts.map((district) => district.toMap()).toList(),
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> districtList = map['districts'] ?? [];
    List<DistrictModel> parsedDistricts = districtList
        .map((district) => DistrictModel.fromMap(district))
        .toList();

    return LocationModel(destricts: parsedDistricts);
  }
}

class DistrictModel {
  String destrict;
  List<UpazilaModel> upazilas;

  DistrictModel({required this.destrict, required this.upazilas});

  Map<String, dynamic> toMap() {
    return {
      'district': destrict,
      'upazilas': upazilas.map((upazila) => upazila.toMap()).toList(),
    };
  }

  factory DistrictModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> upazilaList = map['upazilas'] ?? [];
    List<UpazilaModel> parsedUpazilas =
        upazilaList.map((upazila) => UpazilaModel.fromMap(upazila)).toList();

    return DistrictModel(
      destrict: map['district'] ?? '',
      upazilas: parsedUpazilas,
    );
  }
}

class UpazilaModel {
  String upazila;
  List<String> areas;

  UpazilaModel({required this.upazila, required this.areas});

  Map<String, dynamic> toMap() {
    return {
      'upazila': upazila,
      'areas': areas,
    };
  }

  factory UpazilaModel.fromMap(Map<String, dynamic> map) {
    return UpazilaModel(
      upazila: map['upazila'] ?? '',
      areas: List<String>.from(map['areas'] ?? []),
    );
  }
}
