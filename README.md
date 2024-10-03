The Pokus Test Application is a banking authorization and integration app developed for the iOS platform. It allows users to manage their bank account authorization processes through different banks (such as Akbank). When users are redirected to Pokus from another bank (like Akbank), they are presented with an authorization screen where they select the type of account they want to authorize. After making the selection, the user is redirected back to the originating bank (Akbank), where the authorized bank and account type are displayed.

Key Features
Authorization Screen: Users are directed to Pokus to select an account type for authorization. Once the selection is complete, they are redirected back to the originating bank app, and the authorization process is finalized.

Firebase Integration: The app uses Firebase Authentication to handle user verification. It also utilizes Firebase Storage and Firestore Database to securely store user data and bank authorization details.

Deep Linking
The Pokus Test Application uses deep linking to interact with other applications (such as Akbank). This enables users to be seamlessly redirected from Akbank to Pokus to complete their authorization process. Deep linking makes app transitions smooth and enhances the overall user experience.

User Email Validation
An important note: if the user’s email address in Akbank is not the same as the email address in Pokus, the redirection will not happen, and the authorization process will fail. However, when the email addresses in both applications match, the user can successfully log in to Pokus from Akbank, and the authorization process is completed. This requires users to use the same credentials in both applications, ensuring security.

Core Technologies of the Application
Firebase Authentication: Used for user registration and login processes.
Firebase Storage: Ensures secure storage of user data.
Firestore Database: Manages user data and authorization information in real time.
Deep Linking: Facilitates data transfer and interaction between applications.
The Pokus Test Application offers a modern solution that enables users to securely and easily manage their bank account authorization processes. It provides smooth integration with apps like Akbank and makes managing bank accounts more convenient for users.
