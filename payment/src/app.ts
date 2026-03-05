import express from 'express';
import AWSXRay from 'aws-xray-sdk';
import paymentController from './adapters/controllers/paymentController';

const app = express();

app.use(AWSXRay.express.openSegment('payment-service'));
app.use(express.json());
app.use('/api', paymentController);


app.use(AWSXRay.express.closeSegment());

export default app;
