from helpers.first import add


def lambda_handler(event, context):
    version = "0.3.0"
    print(f"{version = }")
    print("Hello, from ECR-based lambda")
    print(event)
    print(f"{add(3,4) = }")
