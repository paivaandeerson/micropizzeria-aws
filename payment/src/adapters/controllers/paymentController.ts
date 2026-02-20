import express, { Request, Response } from 'express';
import { PaymentService } from '../../domain/services/paymentService';
import { PaymentRepository } from '../repositories/paymentRepository';
import { AdyenRepository } from '../repositories/adyenRepository';

const router = express.Router();

const paymentRepository = new PaymentRepository();
const adyenService = new AdyenRepository();
const paymentService = new PaymentService(paymentRepository, adyenService);

// Health Check Endpoint
router.get('/health', (_req: Request, res: Response) => {
  res.status(200).send({
    status: 'OK',
    message: 'Payment service is up and running!'
  });
});

router.get('/all', async (_req: Request, res: Response) => {
  const all = await paymentRepository.getAll();
  res.status(200).send(all);
});

router.post('/payment', async (req: Request, res: Response) => {
  console.log('[INFO] Processing payment...');

  const paymentDetails = req.body;
  console.log(`[INFO] Payment content: ${JSON.stringify(paymentDetails, null, 2)}`);

  try {
    const response = await paymentService.processPayment(paymentDetails);
    console.log(`[INFO] Payment processing result: ${JSON.stringify(response, null, 2)}`);

    switch (response.resultCode) {
      case "Authorized":
        res.send({ response: "success" });
        break;
      case "Pending":
      case "Received":
        res.redirect('/result/pending');
        break;
      case "Refused":
        res.redirect('/result/failed');
        break;
      default:
        res.redirect('/result/error');
        break;
    }
  } catch (error) {
    console.error('[ERROR] Payment processing failed:', error);
    res.status(500).send('An error occurred while processing the payment');
  }
});

export default router;
