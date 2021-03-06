// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(json) => LoginModel.fromJson(json);

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  Result? result;
  dynamic targetUrl;
  bool? success;
  dynamic error;
  bool? unAuthorizedRequest;
  bool? abp;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        result: Result.fromJson(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toJson() => {
        "result": result!.toJson(),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class Result {
  Result({
    this.accessToken,
    this.encryptedAccessToken,
    this.expireInSeconds,
    this.shouldResetPassword,
    this.passwordResetCode,
    this.userId,
    this.requiresTwoFactorVerification,
    this.twoFactorAuthProviders,
    this.twoFactorRememberClientToken,
    this.returnUrl,
    this.refreshToken,
    this.refreshTokenExpireInSeconds,
  });

  String? accessToken;
  String? encryptedAccessToken;
  int? expireInSeconds;
  bool? shouldResetPassword;
  dynamic passwordResetCode;
  int? userId;
  bool? requiresTwoFactorVerification;
  dynamic twoFactorAuthProviders;
  dynamic twoFactorRememberClientToken;
  dynamic returnUrl;
  String? refreshToken;
  int? refreshTokenExpireInSeconds;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        accessToken: json["accessToken"],
        encryptedAccessToken: json["encryptedAccessToken"],
        expireInSeconds: json["expireInSeconds"],
        shouldResetPassword: json["shouldResetPassword"],
        passwordResetCode: json["passwordResetCode"],
        userId: json["userId"],
        requiresTwoFactorVerification: json["requiresTwoFactorVerification"],
        twoFactorAuthProviders: json["twoFactorAuthProviders"],
        twoFactorRememberClientToken: json["twoFactorRememberClientToken"],
        returnUrl: json["returnUrl"],
        refreshToken: json["refreshToken"],
        refreshTokenExpireInSeconds: json["refreshTokenExpireInSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "encryptedAccessToken": encryptedAccessToken,
        "expireInSeconds": expireInSeconds,
        "shouldResetPassword": shouldResetPassword,
        "passwordResetCode": passwordResetCode,
        "userId": userId,
        "requiresTwoFactorVerification": requiresTwoFactorVerification,
        "twoFactorAuthProviders": twoFactorAuthProviders,
        "twoFactorRememberClientToken": twoFactorRememberClientToken,
        "returnUrl": returnUrl,
        "refreshToken": refreshToken,
        "refreshTokenExpireInSeconds": refreshTokenExpireInSeconds,
      };
}
