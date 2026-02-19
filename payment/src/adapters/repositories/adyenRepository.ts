import { Response } from 'express';
import axios from 'axios';
import { Payment } from '../../domain/models/payment';

export class AdyenRepository {
  async processPayment(payment: Payment): Promise<any> {
    const request = {
      paymentMethod: {
        type: "scheme",
        number: payment.cardNumber,
        expiryMonth: payment.expiryMonth,
        expiryYear: payment.expiryYear,
        holderName: payment.cardholderName,
        cvc: payment.cardSecurityCode,
      }
    };
    // const response = await axios.post('https://your-adyen-endpoint/api/initiatePayment', request);    
    const response = { data: { resultCode: 'Authorised' } };

    return response.data;
  }
}
