// To parse this JSON data, do
//
//     final testMasterResponse = testMasterResponseFromJson(jsonString);

import 'dart:convert';

TestMasterResponse testMasterResponseFromJson(String str) => TestMasterResponse.fromJson(json.decode(str));

String testMasterResponseToJson(TestMasterResponse data) => json.encode(data.toJson());

class TestMasterResponse {
    bool? success;
    String? message;
    dynamic subCode;
    List<Datum>? data;

    TestMasterResponse({
        this.success,
        this.message,
        this.subCode,
        this.data,
    });

    factory TestMasterResponse.fromJson(Map<String, dynamic> json) => TestMasterResponse(
        success: json["success"],
        message: json["message"],
        subCode: json["subCode"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "subCode": subCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    dynamic labId;
    LabName? labName;
    dynamic createdBy;
    AtedByUsername? createdByUsername;
    AtedByUsername? updatedByUsername;
    String? createdAt;
    String? updatedAt;
    dynamic id;
    dynamic facilityId;
    dynamic categoryId;
    Service? service;
    Type? investType;
    double? rate;
    String? codeTest;
    String? tax;
    String? pDiscount;
    String? remark;
    Investigation? investigation;
    Flag? flag;

    Datum({
        this.labId,
        this.labName,
        this.createdBy,
        this.createdByUsername,
        this.updatedByUsername,
        this.createdAt,
        this.updatedAt,
        this.id,
        this.facilityId,
        this.categoryId,
        this.service,
        this.investType,
        this.rate,
        this.codeTest,
        this.tax,
        this.pDiscount,
        this.remark,
        this.investigation,
        this.flag,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        labId: json["labId"],
        labName: labNameValues.map[json["labName"]]!,
        createdBy: json["createdBy"],
        createdByUsername: atedByUsernameValues.map[json["createdByUsername"]]!,
        updatedByUsername: atedByUsernameValues.map[json["updatedByUsername"]]!,
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        facilityId: json["facilityId"],
        categoryId: json["categoryId"],
        service: serviceValues.map[json["service"]]!,
        investType: typeValues.map[json["investType"]]!,
        rate: json["rate"]?.toDouble(),
        codeTest: json["codeTest"],
        tax: json["tax"],
        pDiscount: json["pDiscount"],
        remark: json["remark"],
        investigation: json["investigation"] == null ? null : Investigation.fromJson(json["investigation"]),
        flag: flagValues.map[json["flag"]]!,
    );

    Map<String, dynamic> toJson() => {
        "labId": labId,
        "labName": labNameValues.reverse[labName],
        "createdBy": createdBy,
        "createdByUsername": atedByUsernameValues.reverse[createdByUsername],
        "updatedByUsername": atedByUsernameValues.reverse[updatedByUsername],
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "facilityId": facilityId,
        "categoryId": categoryId,
        "service": serviceValues.reverse[service],
        "investType": typeValues.reverse[investType],
        "rate": rate,
        "codeTest": codeTest,
        "tax": tax,
        "pDiscount": pDiscount,
        "remark": remark,
        "investigation": investigation?.toJson(),
        "flag": flagValues.reverse[flag],
    };
}

enum AtedByUsername {
    HUB
}

final atedByUsernameValues = EnumValues({
    "hub": AtedByUsername.HUB
});

enum Flag {
    C
}

final flagValues = EnumValues({
    "c": Flag.C
});

enum Type {
    PATHOLOGICAL,
    RADIOLOGICAL
}

final typeValues = EnumValues({
    "Pathological": Type.PATHOLOGICAL,
    "Radiological": Type.RADIOLOGICAL
});

class Investigation {
    dynamic labId;
    LabName? labName;
    dynamic createdBy;
    AtedByUsername? createdByUsername;
    AtedByUsername? updatedByUsername;
    String? createdAt;
    String? updatedAt;
    dynamic id;
    Type? type;
    Department? department;
    Section? section;
    String? modality;
    String? category;
    String? investName;
    dynamic tmId;
    dynamic fluidType;
    dynamic isPackage;
    List<TestParameter>? testParameters;
    dynamic rate;
    String? machineName;
    dynamic investRate;
    dynamic investCode;
    dynamic orgRate;
    dynamic discount;
    dynamic orderSequence;
    dynamic testHours;
    String? investLabel;
    dynamic sampleType;
    dynamic machineType;
    dynamic ncdFlag;
    Flag? flag;

    Investigation({
        this.labId,
        this.labName,
        this.createdBy,
        this.createdByUsername,
        this.updatedByUsername,
        this.createdAt,
        this.updatedAt,
        this.id,
        this.type,
        this.department,
        this.section,
        this.modality,
        this.category,
        this.investName,
        this.tmId,
        this.fluidType,
        this.isPackage,
        this.testParameters,
        this.rate,
        this.machineName,
        this.investRate,
        this.investCode,
        this.orgRate,
        this.discount,
        this.orderSequence,
        this.testHours,
        this.investLabel,
        this.sampleType,
        this.machineType,
        this.ncdFlag,
        this.flag,
    });

    factory Investigation.fromJson(Map<String, dynamic> json) => Investigation(
        labId: json["labId"],
        labName: labNameValues.map[json["labName"]]!,
        createdBy: json["createdBy"],
        createdByUsername: atedByUsernameValues.map[json["createdByUsername"]]!,
        updatedByUsername: atedByUsernameValues.map[json["updatedByUsername"]]!,
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        type: typeValues.map[json["type"]]!,
        department: departmentValues.map[json["department"]]!,
        section: sectionValues.map[json["section"]]!,
        modality: json["modality"],
        category: json["category"],
        investName: json["invest_name"],
        tmId: json["tm_id"],
        fluidType: json["fluidType"],
        isPackage: json["isPackage"],
        testParameters: json["testParameters"] == null ? [] : List<TestParameter>.from(json["testParameters"]!.map((x) => TestParameter.fromJson(x))),
        rate: json["rate"],
        machineName: json["machineName"],
        investRate: json["investRate"],
        investCode: json["investCode"],
        orgRate: json["orgRate"],
        discount: json["discount"],
        orderSequence: json["orderSequence"],
        testHours: json["testHours"],
        investLabel: json["investLabel"],
        sampleType: json["sampleType"],
        machineType: json["machineType"],
        ncdFlag: json["ncdFlag"],
        flag: flagValues.map[json["flag"]]!,
    );

    Map<String, dynamic> toJson() => {
        "labId": labId,
        "labName": labNameValues.reverse[labName],
        "createdBy": createdBy,
        "createdByUsername": atedByUsernameValues.reverse[createdByUsername],
        "updatedByUsername": atedByUsernameValues.reverse[updatedByUsername],
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "type": typeValues.reverse[type],
        "department": departmentValues.reverse[department],
        "section": sectionValues.reverse[section],
        "modality": modality,
        "category": category,
        "invest_name": investName,
        "tm_id": tmId,
        "fluidType": fluidType,
        "isPackage": isPackage,
        "testParameters": testParameters == null ? [] : List<dynamic>.from(testParameters!.map((x) => x.toJson())),
        "rate": rate,
        "machineName": machineName,
        "investRate": investRate,
        "investCode": investCode,
        "orgRate": orgRate,
        "discount": discount,
        "orderSequence": orderSequence,
        "testHours": testHours,
        "investLabel": investLabel,
        "sampleType": sampleType,
        "machineType": machineType,
        "ncdFlag": ncdFlag,
        "flag": flagValues.reverse[flag],
    };
}

enum Department {
    BIOCHEMISTRY,
    MICROBIOLOGY,
    PATHOLOGY
}

final departmentValues = EnumValues({
    "BIOCHEMISTRY": Department.BIOCHEMISTRY,
    "MICROBIOLOGY": Department.MICROBIOLOGY,
    "PATHOLOGY": Department.PATHOLOGY
});

enum LabName {
    DOON,
    UPHCAGH
}

final labNameValues = EnumValues({
    "DOON": LabName.DOON,
    "UPHCAGH": LabName.UPHCAGH
});

enum Section {
    BIOCHEMISTRY,
    HEMATOLOGY,
    SEROLOGY_TRF
}

final sectionValues = EnumValues({
    "BIOCHEMISTRY": Section.BIOCHEMISTRY,
    "HEMATOLOGY": Section.HEMATOLOGY,
    "SEROLOGY TRF": Section.SEROLOGY_TRF
});

class TestParameter {
    dynamic tmId;
    String? parameterName;
    String? loincCode;
    String? testCode;
    Reference? result;
    String? unit;
    Reference? reference;
    dynamic methodology;
    String? notes;
    dynamic resultBy;
    dynamic antibiotic;
    dynamic deriable;
    String? sequenceBy;
    String? heading;
    dynamic normalRange;
    dynamic autoFill;
    String? autoFillArray;
    dynamic flag;
    dynamic helpBox;
    dynamic templateName;
    dynamic zoneDiameter;
    String? printHead;
    dynamic maxRange;
    dynamic minRange;
    dynamic linearity;
    dynamic detectionValue;

    TestParameter({
        this.tmId,
        this.parameterName,
        this.loincCode,
        this.testCode,
        this.result,
        this.unit,
        this.reference,
        this.methodology,
        this.notes,
        this.resultBy,
        this.antibiotic,
        this.deriable,
        this.sequenceBy,
        this.heading,
        this.normalRange,
        this.autoFill,
        this.autoFillArray,
        this.flag,
        this.helpBox,
        this.templateName,
        this.zoneDiameter,
        this.printHead,
        this.maxRange,
        this.minRange,
        this.linearity,
        this.detectionValue,
    });

    factory TestParameter.fromJson(Map<String, dynamic> json) => TestParameter(
        tmId: json["tm_id"],
        parameterName: json["parameter_name"],
        loincCode: json["loinc_code"],
        testCode: json["test_code"],
        result: referenceValues.map[json["result"]]!,
        unit: json["unit"],
        reference: referenceValues.map[json["reference"]]!,
        methodology: json["methodology"],
        notes: json["notes"],
        resultBy: json["result_by"],
        antibiotic: json["antibiotic"],
        deriable: json["deriable"],
        sequenceBy: json["sequence_by"],
        heading: json["heading"],
        normalRange: json["normal_range"],
        autoFill: json["auto_fill"],
        autoFillArray: json["auto_fill_array"],
        flag: json["flag"],
        helpBox: json["help_box"],
        templateName: json["template_name"],
        zoneDiameter: json["zone_diameter"],
        printHead: json["print_head"],
        maxRange: json["max_range"],
        minRange: json["min_range"],
        linearity: json["linearity"],
        detectionValue: json["detectionValue"],
    );

    Map<String, dynamic> toJson() => {
        "tm_id": tmId,
        "parameter_name": parameterName,
        "loinc_code": loincCode,
        "test_code": testCode,
        "result": referenceValues.reverse[result],
        "unit": unit,
        "reference": referenceValues.reverse[reference],
        "methodology": methodology,
        "notes": notes,
        "result_by": resultBy,
        "antibiotic": antibiotic,
        "deriable": deriable,
        "sequence_by": sequenceBy,
        "heading": heading,
        "normal_range": normalRange,
        "auto_fill": autoFill,
        "auto_fill_array": autoFillArray,
        "flag": flag,
        "help_box": helpBox,
        "template_name": templateName,
        "zone_diameter": zoneDiameter,
        "print_head": printHead,
        "max_range": maxRange,
        "min_range": minRange,
        "linearity": linearity,
        "detectionValue": detectionValue,
    };
}

enum Reference {
    EMPTY,
    FLUFFY,
    FORWARD_REVERSE_GROUPING_USING_SLIDE_METHOD,
    INDECENT,
    INDIGO,
    PURPLE,
    REFERENCE,
    STICKY,
    TENTACLED
}

final referenceValues = EnumValues({
    " ": Reference.EMPTY,
    "": Reference.FLUFFY,
    "Forward & Reverse grouping using slide method      ": Reference.FORWARD_REVERSE_GROUPING_USING_SLIDE_METHOD,
    "        ": Reference.INDECENT,
    "     ": Reference.INDIGO,
    "   ": Reference.PURPLE,
    "  ": Reference.REFERENCE,
    "      ": Reference.STICKY,
    "    ": Reference.TENTACLED
});

enum Service {
    INVESTIGATION
}

final serviceValues = EnumValues({
    "Investigation": Service.INVESTIGATION
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
