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

  async processPayment(paymentDetails: PaymentDetails) {
    console.log("[INFO] Processing payment...");
    console.log(`[INFO] Payment content: ${JSON.stringify(paymentDetails, null, 2)}`);
    
    const payment = await this.paymentDBRepository.createPayment(paymentDetails);
    const response = await this.adyenRepository.processPayment(payment);
    
    console.log(`[INFO] Payment processing result: ${JSON.stringify(response, null, 2)}`);
    return response;
  }
}
