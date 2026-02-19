import express from 'express';
import paymentController from './adapters/controllers/paymentController';

const app = express();

app.use(express.json());
app.use('/api', paymentController);

export default app;
