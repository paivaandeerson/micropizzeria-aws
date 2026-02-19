import uuid
import requests
import os

class StatusAPIAdapter:
    def __init__(self, api_url: str = None, session: requests.Session = None):
        self.api_url = api_url or os.environ.get("STATUS_SERVICE_API", "http://localhost:3000/check-status")
        self.session = session or requests.Session()

    def check_status(self, order_id: uuid.UUID):
        try:
            url = f"{self.api_url}/{order_id}"
            print(f"[INFO] Making request to status service at {url}...")
            response = self.session.get(url)
            print(f"[INFO] Received response from status service: {response.status_code} - {response.text}")
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(e)
            raise