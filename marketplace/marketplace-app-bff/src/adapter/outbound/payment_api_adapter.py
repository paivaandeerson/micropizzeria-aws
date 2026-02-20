import requests
import os

DEFAULT_API_URL = os.environ.get("PAYMENT_SERVICE_API", "http://payment-container:3000/api/payment")

class PaymentAPIAdapter:
    def __init__(self, api_url: str | None = None, session: requests.Session | None = None):
        self.api_url = api_url or DEFAULT_API_URL
        self.session = session or requests.Session()

    def process_payment(self, payment_data):
        try:
            print(f"[INFO] Making request to payment service {self.api_url} with data: {payment_data}...")
            response = self.session.post(self.api_url, json=payment_data)
            print(f"[INFO] Received response from payment service: {response.status_code} - {response.text}")
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(e)
            raise