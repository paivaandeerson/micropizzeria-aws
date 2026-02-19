import { MongoClient, Db, Collection, ObjectId } from 'mongodb';
import { MongoMemoryServer } from 'mongodb-memory-server';
import { PaymentDetails, Payment } from '../../domain/models/payment';

class PaymentRepository {
  private client: MongoClient;
  private db: Db;
  private collection: Collection<Payment>;

  constructor() {
    MongoMemoryServer.create().then((value) => {
      const uri = value.getUri();
      this.client = new MongoClient(uri);

      this.client.connect().then(() => {
        this.db = this.client.db('paymentdb');
        this.collection = this.db.collection('payments');
      });
    });
  }

  async createPayment(paymentDetails: PaymentDetails): Promise<Payment> {
    const payment = new Payment(paymentDetails);
    const result = await this.collection.insertOne({
      ...payment,
      _id: new ObjectId(),
    });
    payment.id = result.insertedId.toString();
    console.log(`payment ${payment.id} was created`)
    return payment;
  }

  async getPaymentById(id: string): Promise<Payment | null> {
    const payment = await this.collection.findOne({ _id: new ObjectId(id) });
    return payment ? new Payment(payment) : null;
  }

  async getAll(): Promise<Payment[]> {
    const payments = await this.collection.find().toArray();
    return payments.map(payment => {
      payment.id = payment._id.toString();
      return payment;
    });
  }
}

export { PaymentRepository };
