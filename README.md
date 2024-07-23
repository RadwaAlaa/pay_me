# PayFlex
 Payement system demo
# Download apk: 

- https://api.codemagic.io/artifacts/c0e7ff01-36f0-4102-9f19-638dd36ea57c/8015a178-b306-485f-ac8a-a6c91cd4cb6c/app-debug.apk
- https://drive.google.com/file/d/11nsDrNDe8JdP-bTrbgXUoZ6DAYOAAqZA/view?usp=sharing

 a demo app for payment syetme between user and beneficiaries to recharge phone credits.



# App journies :

   # - Login page  
    available test users: 
    verified : ra@gmail.com - 123456
    unverified : en@gmail.com - 123456

    authenticatiin is done through firebase authenticate by email & password.

   # - home page: 
     . retrieve user object 
     . retrieve user's beneficiaries list if exist.
     . add new beneficiary feature.
     . list history of all transactions 


   #  - Top up page: 
      . user can select from the available amounts to recharge the beneficiary.



# Project Structure:

 the app is built with Flutter using Bloc state management with Cubit implementation.

 - data management are done using Firebase firestore.

 the app has modules which represent the main features of the app which are :
 - Login 
 - Home 
 - User
 - Beneficiary
 - Transaction 

 each module has (model, repository, bloc, views) folders to organize the files.

    - model:  has the data files
    - repository: has the repository interface (contract) for the repository class which handles the communication between the backend requests and the UI.
    - bloc: has the cubit implementation which handles the state managemet implementation for the UI.
    - views {screens, widgets}: sceens are consists of widgets which hold the UI pieces.


    Tests: 
    - Unit test for validating the top up process and make sure the recharge amount are correctly deducted from user's balance + 1 AED.

![simulator_screenshot_6D8D6AD5-442F-41E3-B709-6360B7E4DC7B](https://github.com/user-attachments/assets/e9b99323-2dd8-4a48-b126-8e8a2eec0989)
![simulator_screenshot_AF500CFB-DF24-432F-9626-232D9C23C250](https://github.com/user-attachments/assets/282514cc-1f43-4a8d-a90b-9ab1940f4d65)

![simulator_screenshot_684B330B-B03E-448E-BAC7-A9E1FF57D966](https://github.com/user-attachments/assets/d9169495-3e53-4cd5-8a32-64c7d2e9086a)


     
