# tokenization-project
Created tokenization project for Credit Card Tokenization.

# I) Project Structure/Organization

The Project is organized into three maven modules as follows under a parent project. The parent project is called tokenization-project

## 1) source module
Contains the Code to Expose a Restful service for posting the Payment information.
Creates a unique transactionID, and sends the message to data-input kafka topic,and shows the status message to Restful client.
  
## 2) flow module
Contains the code to consume the message sent from source module on the data-input topic. Extracts the message and encrypts the Credit Card Information(Token) and stores the TransactionId as Key and the Token as the value to the Redis store. The TransactionId and TokenId information is sent along to the topic data-input.
  
## 3) proof module 
Consumes TransactionId, and Token information from data-output topic, using the TransactionId as the Key looks into the Redis datastore and finds the Token. Once the Token is found the Token data is decrypted, and both the TransactionID and decrypted CreditCard information are printed on the screen, in the follwing format.

{"transactionId":{"cardNumber":"4444444444444448","expirationDate":"02/20","cvvNumber":"130"}}

# II) SOFTWARE PRE-REQUISITES/TESTING ENVIRONMENT

1) JDK 1.8 
2) Maven 3+ version
3) Mac Operating System(May work on any *nix System, but tested only on Mac OS)
4) Other dependencies like Redis and Kafka are bundled with the project to make the setup and testing effortless.

  
# III) Steps to Execute the Project

1) Git Clone or download the project - tokenization-project 

2) Navigate to the downloaded/cloned tokenization-project folder

3) Execute this script to setup Kafka and Redis, and start them $./start_kafka_redis.sh

4) $mvn clean install, This command builds all the 3 modules(source,flow,proof) that are present under tokenization-project
![Maven Clean Install](https://github.com/kanaparthikiran/tokenization-project/blob/master/images/MVN_CLEAN_INSTALL_ALL.png)
5) Open a new Terminal tab and type this command to show source module logs $java -jar source/target/source-1.0.0.jar

6) Open a new Terminal tab and type this command to show flow module logs  $java -jar target/flow-1.0.0.jar

7) Open a new Terminal tab and type this command to show proof module logs $java -jar proof/target/proof-1.0.0.jar

8) Open a new Terminal tab and type this command -
curl -X POST http://localhost:9000/api/auth -H 'Content-Type: application/json' -d '{"cardNumber": "4444444444444448","expirationDate": "02/20","cvvNumber": "130"}'

# IV) Verifying the Results
1) Notice the logs on the source, flow, and proof Terminal tabs as they were opened in the previous steps. 
2) The CreditCard Information is passed in from the curl command and reaches the source module which returns a status message and TransactionId. 
3) The Credit Card Information is sent to downstream to the flow module using data-input topic. The CreditCard information is captured in the flow module, credit card information is encrypted(Tokenized) and stored into redis data store using TransactionId as the Key. 
4) The TransactionId and Token information is sent to the proof module using the data-output topic. 
5) The proof module reads the data-output topic data and gets the transactionID from the message and uses that transactionId to fetch the Token information from Redis data store. 
6) The token information is decrypted and displayed on the screen in the follwing format.
{"transactionId":{"cardNumber":"4444444444444448","expirationDate":"02/20","cvvNumber":"130"}}
