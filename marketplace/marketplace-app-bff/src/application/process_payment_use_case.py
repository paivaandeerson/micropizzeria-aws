import requests
from application.exception.bad_request_exception import BadRequestException
from application.exception.not_found_exception import NotFoundException
from adapter.outbound.payment_api_adapter import PaymentAPIAdapter

class PaymentUseCase:
    def __init__(self, payment_processor=None):
        self._processor = payment_processor or PaymentAPIAdapter()

    def execute(self, payment_data):
        try:
            print(f"[INFO] Processing payment with data: {payment_data}...")
            response = self._processor.process_payment(payment_data)
            print(f"[INFO] Payment processed successfully: {response}")
            return response
        except BadRequestException as e:
            print("[Domain validation - BadRequestException]", e)
            raise
        except NotFoundException as e:
            print("[Domain validation - NotFoundException]", e)
            raise
        except requests.RequestException as e:
            print(f"[Error] Error processing payment: {e}")
            raise
