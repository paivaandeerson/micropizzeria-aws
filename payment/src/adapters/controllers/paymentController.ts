import express, { Request, Response } from 'express';
import { PaymentService } from '../../domain/services/paymentService';
import { PaymentRepository } from '../repositories/paymentRepository';
import { AdyenRepository } from '../repositories/adyenRepository';

const router = express.Router();

const paymentRepository = new PaymentRepository();
const adyenService = new AdyenRepository();
const paymentService = new PaymentService(paymentRepository, adyenService);

// Health Check Endpoint
router.get('/health', (req: Request, res: Response) => {
  res.status(200).send({
    status: 'OK',
    message: 'Payment service is up and running!'
  });
});

router.get('/all', async (req: Request, res: Response) => {
  const all = await paymentRepository.getAll();
  res.status(200).send(all);
});

router.post('/initiatePayment', async (req: Request, res: Response) => {
  const paymentDetails = req.body;

  try {
    const response = await paymentService.initiatePayment(paymentDetails);

    switch (response.resultCode) {
      case "Authorized":
        res.send({response: "success"});
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
    res.status(500).send('An error occurred while processing the payment');
  }
});

export default router;
