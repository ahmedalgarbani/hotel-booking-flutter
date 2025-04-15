class PaymentAccount {
  final int id;
  final PaymentOption paymentOption;
  final String accountName;
  final String accountNumber;
  final String iban;
  final String description;

  PaymentAccount({
    required this.id,
    required this.paymentOption,
    required this.accountName,
    required this.accountNumber,
    required this.iban,
    required this.description,
  });

  factory PaymentAccount.fromJson(Map<String, dynamic> jsonData) {
    return PaymentAccount(
      id: jsonData['id'] ?? 0, 
      accountName: jsonData['account_name'] ?? "",
      accountNumber: jsonData['account_number'] ?? "",
      iban: jsonData['iban'] ?? "",
      description: jsonData['description'] ?? "",
      paymentOption: jsonData['payment_option'] != null 
          ? PaymentOption.fromJson(jsonData['payment_option'])
          : PaymentOption(id: 0, methodName: "", logo: "", currency: Currency(id: 0, currencyName: "", currencySymbol: "")),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'payment_option': paymentOption.toJson(),
      'account_name': accountName,
      'account_number': accountNumber,
      'iban': iban,
      'description': description,
    };
  }
}

class PaymentOption {
  final int id;
  final String methodName;
  final String logo;
  final Currency currency;

  PaymentOption({
    required this.id,
    required this.methodName,
    required this.logo,
    required this.currency,
  });

  factory PaymentOption.fromJson(Map<String, dynamic> jsonData) {
    String baseUrl = "http://192.168.183.85:8000"; 
  String logoPath = jsonData['logo'] ?? "";
    print("jsonData['logo']");
    print("jsonData['logo']");
    print("jsonData['logo']");
    print("jsonData['logo']");
    print("jsonData['logo']");
    print("jsonData['logo']");
    print("jsonData['logo']");
    print("jsonData['logo']");
    print(jsonData['logo']);
    return PaymentOption(
      id: jsonData['id'] ?? 0,
      methodName: jsonData['method_name'] ?? "",
logo: logoPath.startsWith("http") ? logoPath : baseUrl + logoPath, 
      currency: jsonData['currency'] != null
          ? Currency.fromJson(jsonData['currency'])
          : Currency(id: 0, currencyName: "", currencySymbol: ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'method_name': methodName,
      'logo': logo,
      'currency': currency.toJson(),
    };
  }
}

class Currency {
  final int id;
  final String currencyName;
  final String currencySymbol;

  Currency({
    required this.id,
    required this.currencyName,
    required this.currencySymbol,
  });

  factory Currency.fromJson(Map<String, dynamic> jsonData) {
    return Currency(
      id: jsonData['id'] ?? 0,
      currencyName: jsonData['currency_name'] ?? "",
      currencySymbol: jsonData['currency_symbol'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currency_name': currencyName,
      'currency_symbol': currencySymbol,
    };
  }
}
