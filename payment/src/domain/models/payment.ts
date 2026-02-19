export interface PaymentDetails {
  cardNumber: string;
  expiryMonth: string;
  expiryYear: string;
  cardholderName: string;
  cardSecurityCode: string;
}

export class Payment {
  id?: string;
  cardNumber: string;
  expiryMonth: string;
  expiryYear: string;
  cardholderName: string;
  cardSecurityCode: string;

  constructor({ cardNumber, expiryMonth, expiryYear, cardholderName, cardSecurityCode }: PaymentDetails) {
    this.cardNumber = cardNumber;
    this.expiryMonth = expiryMonth;
    this.expiryYear = expiryYear;
    this.cardholderName = cardholderName;
    this.cardSecurityCode = cardSecurityCode;
  }
}
