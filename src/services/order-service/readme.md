# Order Service

| .NET Api Services         | Http Port | Https Port | Dapr Port | Dapr App ID          | Docker Port|
| -------                   | --------- | ---------- | --------- | -------------        | -----      |
| Order Service             | 5002      | 5022       | 5012      | order-service        | 5052       |

- Docker Build & Run: 

    ```bash
    docker build --rm -f dockerfile -t order-service .
    docker run -it --rm -p 5054:8080 order-service
    ```

- Environment Variables:
    - ApplicationInsights__ConnectionString
    - GraphCfg__TenantId
    - GraphCfg__ClientId
    - GraphCfg__ClientSecret    

- Rest Tester:

    ```bash
    POST http://localhost:5004/send HTTP/1.1
    Content-Type: application/json

    {
        "subject": "A test mail",
        "text": "Explore - Let life surprise you!",
        "recipient": "alexander.pajer@integrations.at"
    }
    ```

- Dapr Run & Test:

    ```bash
    dapr run --app-id order-service --app-port 5002 --dapr-http-port 5012 --resources-path ./components -- dotnet run
    ```
    
    ```bash
    dapr invoke --app-id order-service --method pubsub-test --data '{\"id\": \"1\", \"subject\": \"Explore - Let life surprise you!\" }'
    ```   

    ```bash
     dapr publish --publish-app-id order-service --pubsub 'food-pubsub" --topic "order-requests" --data "{\"subject\": \"A test mail\", \"text\": \"Explore - Let life surprise you!\", \"recipient\": \"alexander.pajer@integrations.at"}'
    ```   