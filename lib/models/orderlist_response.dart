// To parse this JSON data, do
//
//     final orderListResponse = orderListResponseFromJson(jsonString);

import 'dart:convert';

OrderListResponse orderListResponseFromJson(String str) => OrderListResponse.fromJson(json.decode(str));

String orderListResponseToJson(OrderListResponse data) => json.encode(data.toJson());

class OrderListResponse {
    bool? success;
    String? message;
    dynamic subCode;
    List<Datum>? data;

    OrderListResponse({
        this.success,
        this.message,
        this.subCode,
        this.data,
    });

    factory OrderListResponse.fromJson(Map<String, dynamic> json) => OrderListResponse(
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
    String? labName;
    dynamic id;
    String? facility;
    String? facilityNumber;
    dynamic ward;
    Patient? patient;
    String? status;
    String? departmentStatus;
    dynamic pickupStatus;
    String? billNo;
    String? location;
    dynamic hubIp;
    String? custom1;
    dynamic custom2;
    List<OrderDetail>? orderDetails;

    Datum({
        this.labId,
        this.labName,
        this.id,
        this.facility,
        this.facilityNumber,
        this.ward,
        this.patient,
        this.status,
        this.departmentStatus,
        this.pickupStatus,
        this.billNo,
        this.location,
        this.hubIp,
        this.custom1,
        this.custom2,
        this.orderDetails,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        labId: json["labId"],
        labName: json["labName"],
        id: json["id"],
        facility: json["facility"],
        facilityNumber: json["facilityNumber"],
        ward: json["ward"],
        patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
        status: json["status"],
        departmentStatus: json["departmentStatus"],
        pickupStatus: json["pickupStatus"],
        billNo: json["billNo"],
        location: json["location"],
        hubIp: json["hubIp"],
        custom1: json["custom1"],
        custom2: json["custom2"],
        orderDetails: json["orderDetails"] == null ? [] : List<OrderDetail>.from(json["orderDetails"]!.map((x) => OrderDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "labId": labId,
        "labName": labName,
        "id": id,
        "facility": facility,
        "facilityNumber": facilityNumber,
        "ward": ward,
        "patient": patient?.toJson(),
        "status": status,
        "departmentStatus": departmentStatus,
        "pickupStatus": pickupStatus,
        "billNo": billNo,
        "location": location,
        "hubIp": hubIp,
        "custom1": custom1,
        "custom2": custom2,
        "orderDetails": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
    };
}

class OrderDetail {
    dynamic labId;
    String? labName;
    dynamic id;
    dynamic patientId;
    Investigation? investigation;
    dynamic investType;
    String? status;
    String? authorizedById;
    double? testRate;
    String? testName;
    String? sampleTime;
    String? barcode;
    dynamic packageId;
    dynamic canceledBy;
    String? printTime;
    dynamic printFlag;
    String? authorizedTime;
    String? verifyBy;
    String? verifyTime;
    dynamic verifyFlag;
    dynamic machineStatus;
    String? specimenType;
    String? corelationWithDiagnosis;
    String? reportingError;
    String? toConfirmFindings;
    String? deviceError;
    String? technicianOrOperatorError;
    dynamic remark;
    dynamic sampleReason;
    String? sampleCollectedBy;
    String? printBy;
    dynamic sampleRejectedBy;
    dynamic billStatus;
    dynamic quantity;
    dynamic billNo;
    String? techVerifiedById;
    dynamic techVerifiedTime;
    dynamic sampleRerunFlag;
    dynamic sampleRerunBy;
    dynamic smsCount;
    String? smsDate;
    dynamic flag;
    dynamic equasFlag;
    dynamic samplePickupBy;
    dynamic sampleReceivedBy;
    dynamic samplePickupTime;
    dynamic sampleReceivedTime;
    dynamic sampleStatus;
    dynamic hubWorklistViewFlag;
    dynamic hubWorklistViewFlagTime;
    String? hubWorklistViewFlagBy;
    dynamic diffInHours;
    dynamic holdTime;
    dynamic holdReason;
    dynamic holdFlag;
    dynamic superHubFlag;
    dynamic selfVerfiedFlag;
    dynamic techVerifieTime;
    dynamic createdBy;
    String? createdByUsername;
    String? updatedByUsername;
    String? createdAt;
    String? updatedAt;

    OrderDetail({
        this.labId,
        this.labName,
        this.id,
        this.patientId,
        this.investigation,
        this.investType,
        this.status,
        this.authorizedById,
        this.testRate,
        this.testName,
        this.sampleTime,
        this.barcode,
        this.packageId,
        this.canceledBy,
        this.printTime,
        this.printFlag,
        this.authorizedTime,
        this.verifyBy,
        this.verifyTime,
        this.verifyFlag,
        this.machineStatus,
        this.specimenType,
        this.corelationWithDiagnosis,
        this.reportingError,
        this.toConfirmFindings,
        this.deviceError,
        this.technicianOrOperatorError,
        this.remark,
        this.sampleReason,
        this.sampleCollectedBy,
        this.printBy,
        this.sampleRejectedBy,
        this.billStatus,
        this.quantity,
        this.billNo,
        this.techVerifiedById,
        this.techVerifiedTime,
        this.sampleRerunFlag,
        this.sampleRerunBy,
        this.smsCount,
        this.smsDate,
        this.flag,
        this.equasFlag,
        this.samplePickupBy,
        this.sampleReceivedBy,
        this.samplePickupTime,
        this.sampleReceivedTime,
        this.sampleStatus,
        this.hubWorklistViewFlag,
        this.hubWorklistViewFlagTime,
        this.hubWorklistViewFlagBy,
        this.diffInHours,
        this.holdTime,
        this.holdReason,
        this.holdFlag,
        this.superHubFlag,
        this.selfVerfiedFlag,
        this.techVerifieTime,
        this.createdBy,
        this.createdByUsername,
        this.updatedByUsername,
        this.createdAt,
        this.updatedAt,
    });

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        labId: json["labId"],
        labName: json["labName"],
        id: json["id"],
        patientId: json["patientId"],
        investigation: json["investigation"] == null ? null : Investigation.fromJson(json["investigation"]),
        investType: json["investType"],
        status: json["status"],
        authorizedById: json["authorizedById"],
        testRate: json["testRate"]?.toDouble(),
        testName: json["testName"],
        sampleTime: json["sampleTime"],
        barcode: json["barcode"],
        packageId: json["packageId"],
        canceledBy: json["canceledBy"],
        printTime: json["printTime"],
        printFlag: json["printFlag"],
        authorizedTime: json["authorizedTime"],
        verifyBy: json["verifyBy"],
        verifyTime: json["verifyTime"],
        verifyFlag: json["verify_flag"],
        machineStatus: json["machineStatus"],
        specimenType: json["specimenType"],
        corelationWithDiagnosis: json["corelationWithDiagnosis"],
        reportingError: json["reportingError"],
        toConfirmFindings: json["toConfirmFindings"],
        deviceError: json["deviceError"],
        technicianOrOperatorError: json["technicianOrOperatorError"],
        remark: json["remark"],
        sampleReason: json["sampleReason"],
        sampleCollectedBy: json["sampleCollectedBy"],
        printBy: json["printBy"],
        sampleRejectedBy: json["sampleRejectedBy"],
        billStatus: json["billStatus"],
        quantity: json["quantity"],
        billNo: json["billNo"],
        techVerifiedById: json["techVerifiedById"],
        techVerifiedTime: json["techVerifiedTime"],
        sampleRerunFlag: json["sampleRerunFlag"],
        sampleRerunBy: json["sampleRerunBy"],
        smsCount: json["smsCount"],
        smsDate: json["smsDate"],
        flag: json["flag"],
        equasFlag: json["equasFlag"],
        samplePickupBy: json["samplePickupBy"],
        sampleReceivedBy: json["sampleReceivedBy"],
        samplePickupTime: json["samplePickupTime"],
        sampleReceivedTime: json["sampleReceivedTime"],
        sampleStatus: json["sampleStatus"],
        hubWorklistViewFlag: json["hubWorklistViewFlag"],
        hubWorklistViewFlagTime: json["hubWorklistViewFlagTime"],
        hubWorklistViewFlagBy: json["hubWorklistViewFlagBy"],
        diffInHours: json["diffInHours"],
        holdTime: json["holdTime"],
        holdReason: json["holdReason"],
        holdFlag: json["holdFlag"],
        superHubFlag: json["superHubFlag"],
        selfVerfiedFlag: json["selfVerfiedFlag"],
        techVerifieTime: json["techVerifieTime"],
        createdBy: json["createdBy"],
        createdByUsername: json["createdByUsername"],
        updatedByUsername: json["updatedByUsername"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "labId": labId,
        "labName": labName,
        "id": id,
        "patientId": patientId,
        "investigation": investigation?.toJson(),
        "investType": investType,
        "status": status,
        "authorizedById": authorizedById,
        "testRate": testRate,
        "testName": testName,
        "sampleTime": sampleTime,
        "barcode": barcode,
        "packageId": packageId,
        "canceledBy": canceledBy,
        "printTime": printTime,
        "printFlag": printFlag,
        "authorizedTime": authorizedTime,
        "verifyBy": verifyBy,
        "verifyTime": verifyTime,
        "verify_flag": verifyFlag,
        "machineStatus": machineStatus,
        "specimenType": specimenType,
        "corelationWithDiagnosis": corelationWithDiagnosis,
        "reportingError": reportingError,
        "toConfirmFindings": toConfirmFindings,
        "deviceError": deviceError,
        "technicianOrOperatorError": technicianOrOperatorError,
        "remark": remark,
        "sampleReason": sampleReason,
        "sampleCollectedBy": sampleCollectedBy,
        "printBy": printBy,
        "sampleRejectedBy": sampleRejectedBy,
        "billStatus": billStatus,
        "quantity": quantity,
        "billNo": billNo,
        "techVerifiedById": techVerifiedById,
        "techVerifiedTime": techVerifiedTime,
        "sampleRerunFlag": sampleRerunFlag,
        "sampleRerunBy": sampleRerunBy,
        "smsCount": smsCount,
        "smsDate": smsDate,
        "flag": flag,
        "equasFlag": equasFlag,
        "samplePickupBy": samplePickupBy,
        "sampleReceivedBy": sampleReceivedBy,
        "samplePickupTime": samplePickupTime,
        "sampleReceivedTime": sampleReceivedTime,
        "sampleStatus": sampleStatus,
        "hubWorklistViewFlag": hubWorklistViewFlag,
        "hubWorklistViewFlagTime": hubWorklistViewFlagTime,
        "hubWorklistViewFlagBy": hubWorklistViewFlagBy,
        "diffInHours": diffInHours,
        "holdTime": holdTime,
        "holdReason": holdReason,
        "holdFlag": holdFlag,
        "superHubFlag": superHubFlag,
        "selfVerfiedFlag": selfVerfiedFlag,
        "techVerifieTime": techVerifieTime,
        "createdBy": createdBy,
        "createdByUsername": createdByUsername,
        "updatedByUsername": updatedByUsername,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}

class Investigation {
    dynamic labId;
    String? labName;
    dynamic createdBy;
    String? createdByUsername;
    String? updatedByUsername;
    String? createdAt;
    String? updatedAt;
    dynamic id;
    String? type;
    String? department;
    String? section;
    String? modality;
    String? category;
    String? investName;
    dynamic tmId;
    dynamic fluidType;
    dynamic isPackage;
    List<TestParameter>? testParameters;
    double? rate;
    String? machineName;
    double? investRate;
    dynamic investCode;
    double? orgRate;
    double? discount;
    dynamic orderSequence;
    dynamic testHours;
    String? investLabel;
    dynamic sampleType;
    dynamic machineType;
    dynamic ncdFlag;
    String? flag;

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
        labName: json["labName"],
        createdBy: json["createdBy"],
        createdByUsername: json["createdByUsername"],
        updatedByUsername: json["updatedByUsername"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        type: json["type"],
        department: json["department"],
        section: json["section"],
        modality: json["modality"],
        category: json["category"],
        investName: json["invest_name"],
        tmId: json["tm_id"],
        fluidType: json["fluidType"],
        isPackage: json["isPackage"],
        testParameters: json["testParameters"] == null ? [] : List<TestParameter>.from(json["testParameters"]!.map((x) => TestParameter.fromJson(x))),
        rate: json["rate"]?.toDouble(),
        machineName: json["machineName"],
        investRate: json["investRate"]?.toDouble(),
        investCode: json["investCode"],
        orgRate: json["orgRate"]?.toDouble(),
        discount: json["discount"]?.toDouble(),
        orderSequence: json["orderSequence"],
        testHours: json["testHours"],
        investLabel: json["investLabel"],
        sampleType: json["sampleType"],
        machineType: json["machineType"],
        ncdFlag: json["ncdFlag"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "labId": labId,
        "labName": labName,
        "createdBy": createdBy,
        "createdByUsername": createdByUsername,
        "updatedByUsername": updatedByUsername,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "type": type,
        "department": department,
        "section": section,
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
        "flag": flag,
    };
}

class TestParameter {
    dynamic tmId;
    String? parameterName;
    String? loincCode;
    String? testCode;
    String? result;
    String? unit;
    String? reference;
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
    double? maxRange;
    double? minRange;
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
        result: json["result"],
        unit: json["unit"],
        reference: json["reference"],
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
        maxRange: json["max_range"]?.toDouble(),
        minRange: json["min_range"]?.toDouble(),
        linearity: json["linearity"],
        detectionValue: json["detectionValue"],
    );

    Map<String, dynamic> toJson() => {
        "tm_id": tmId,
        "parameter_name": parameterName,
        "loinc_code": loincCode,
        "test_code": testCode,
        "result": result,
        "unit": unit,
        "reference": reference,
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

class Patient {
    dynamic labId;
    String? labName;
    dynamic id;
    String? mrn1;
    dynamic mrn2;
    String? title;
    String? firstName;
    String? middleName;
    String? lastName;
    String? relativeName;
    String? birthday;
    String? gender;
    String? mobileNo;
    String? email;
    String? street;
    dynamic state;
    dynamic city;
    String? district;
    String? flag;
    String? aadhaarNo;
    dynamic emergencyContact;
    String? relationWithPatient;
    String? oldUhid;
    String? ward;
    dynamic samgraId;
    dynamic mapId;
    String? age;
    String? name;

    Patient({
        this.labId,
        this.labName,
        this.id,
        this.mrn1,
        this.mrn2,
        this.title,
        this.firstName,
        this.middleName,
        this.lastName,
        this.relativeName,
        this.birthday,
        this.gender,
        this.mobileNo,
        this.email,
        this.street,
        this.state,
        this.city,
        this.district,
        this.flag,
        this.aadhaarNo,
        this.emergencyContact,
        this.relationWithPatient,
        this.oldUhid,
        this.ward,
        this.samgraId,
        this.mapId,
        this.age,
        this.name,
    });

    factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        labId: json["labId"],
        labName: json["labName"],
        id: json["id"],
        mrn1: json["mrn1"],
        mrn2: json["mrn2"],
        title: json["title"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        relativeName: json["relativeName"],
        birthday: json["birthday"],
        gender: json["gender"],
        mobileNo: json["mobileNo"],
        email: json["email"],
        street: json["street"],
        state: json["state"],
        city: json["city"],
        district: json["district"],
        flag: json["flag"],
        aadhaarNo: json["aadhaarNo"],
        emergencyContact: json["emergencyContact"],
        relationWithPatient: json["relationWithPatient"],
        oldUhid: json["oldUhid"],
        ward: json["ward"],
        samgraId: json["samgraId"],
        mapId: json["mapId"],
        age: json["age"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "labId": labId,
        "labName": labName,
        "id": id,
        "mrn1": mrn1,
        "mrn2": mrn2,
        "title": title,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "relativeName": relativeName,
        "birthday": birthday,
        "gender": gender,
        "mobileNo": mobileNo,
        "email": email,
        "street": street,
        "state": state,
        "city": city,
        "district": district,
        "flag": flag,
        "aadhaarNo": aadhaarNo,
        "emergencyContact": emergencyContact,
        "relationWithPatient": relationWithPatient,
        "oldUhid": oldUhid,
        "ward": ward,
        "samgraId": samgraId,
        "mapId": mapId,
        "age": age,
        "name": name,
    };
}
