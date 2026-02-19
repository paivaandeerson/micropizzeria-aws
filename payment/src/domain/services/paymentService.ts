import { PaymentDetails, Payment } from '../models/payment';
import { PaymentRepository } from '../../adapters/repositories/paymentRepository';
import { AdyenRepository } from '../../adapters/repositories/adyenRepository';

export class PaymentService {
  private paymentDBRepository: PaymentRepository;
  private adyenRepository: AdyenRepository;

  constructor(paymentRepository: PaymentRepository, adyenService: AdyenRepository) {
    this.paymentDBRepository = paymentRepository;
    this.adyenRepository = adyenService;
  }

  async initiatePayment(paymentDetails: PaymentDetails) {
    const payment = await this.paymentDBRepository.createPayment(paymentDetails);
    const response = await this.adyenRepository.processPayment(payment);
    return response;
  }
}
