import uuid
from adapter.outbound.status_api_adapter import StatusAPIAdapter

class StatusUseCase:
    def __init__(self, status_adapter=None):
        self._status_adapter = status_adapter or StatusAPIAdapter()

    def execute(self, order_id: uuid.UUID):
        try:
            print("[INFO] Checking status using status API adapter...")
            status_response = self._status_adapter.check_status(order_id)
            print(f"[INFO] Status response: {status_response}")
            return status_response
        except Exception as e:
            print(f"[Error] Error checking status: {e}")
            raise