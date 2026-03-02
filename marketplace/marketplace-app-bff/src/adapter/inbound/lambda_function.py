import json
import requests

from src.application.exception.bad_request_exception import BadRequestException
from src.application.exception.not_found_exception import NotFoundException
from src.application.process_payment_use_case import PaymentUseCase
from src.application.status_use_case import StatusUseCase


def lambda_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    method = event["requestContext"]["http"]["method"]
    path = event["rawPath"]
    
    print("[INFO] method: " + method)
    print("[INFO] path: " + path)

    try:        
        match (method, path):
            case ("GET", "/api/v1/check-status/{order_id}"):
                
                order_id = event["pathParameters"]["order_id"]
                print("[INFO] order_id: " + order_id)
                print("[INFO] Checking status ...")

                order_id = event["pathParameters"]["order_id"]
                print(f"[INFO] Checking status for order_id: {order_id}...")
                
                message = StatusUseCase().execute(order_id)

                print(f"[INFO] Status check result: {message}")     
                return {
                    "statusCode": 200,
                    "body": json.dumps({
                        "message": message,
                    }),
                }
            
            case ("POST", "/api/v1/payment"):
                print("[INFO] Processing payment...")
               
                content = json.loads(event["body"])
                print(f"[INFO] Payment content: {json.dumps(content, indent=2)}")
                
                message = PaymentUseCase().execute(content)

                print(f"[INFO] Payment processing result: {message}")
                return {
                    "statusCode": 201,
                    "body": json.dumps({
                        "message": message,
                    }),
                }
            case _:
                print("[WARNING] No matching route found.")
                return {
                    "statusCode": 404,
                    "body": json.dumps({
                        "message": "No matching route found.",
                    }),
                }

    except BadRequestException as e:
        print("[Domain validation - BadRequestException]", e)
        return {
            "statusCode": 400,
            "body": json.dumps({
                "message": e.message,
            }),
        }
    
    except NotFoundException as e:
        print("[Domain validation - NotFoundException]", e)
        return {
            "statusCode": 404,
            "body": json.dumps({
                "message": e.message,
            }),
        }

    except requests.RequestException as e:
        print(e)
        return {
            "statusCode": 500,
            "body": json.dumps({
                "message": "error processing request",
            }),
        }

    print("[WARNING] Unhandled request method and path.", event, method, path)
    return {
        "statusCode": 400,
        "body": json.dumps({
            "message": "bad request",
        }),
    }

def return_200_successful(message):
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": message,
        }),
    }