def lambda_handler(event, context):
    version = "0.3.0"
    print(f"{version = }")
    print("Hello, from ECR-based lambda")
    print(event)
