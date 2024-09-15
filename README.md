# **FlavorShare-iOS App**

This is a Swift/SwiftUI-based iOS application that uses **Firebase Authentication** for user management and a **Node.js/Express** backend for database operations. 
The app currently includes features such as user & recipe management.

## **Features**

- User Authentication (done via Firebase)
- Recipe management (done via Node.js/Express backend server - Need local setup see [Backend Setup](https://github.com/FlavorShare/FlavorShare_Backend))
- SwiftUI-based UI
- REST API Integration

---

## **Prerequisites**

1. **iOS**: Xcode (Version 14 or higher recommended)
2. **Backend**: Node.js and Express setup required (see [Backend Setup](https://github.com/FlavorShare/FlavorShare_Backend) section)
3. **Firebase**: Ensure Firebase is set up with your project for Authentication.

---

## **Installation**

### **1. Clone the repository**

```bash
gh repo clone FlavorShare/FlavorShare-iOS
cd FlavorShare-iOS
```

### **2. iOS Project Setup**

- Open the project in Xcode:

```bash
open FlavorShare_iOS.xcodeproj
```

- Ensure you have installed any required dependencies.

### **3. Backend Setup**

- To set up the backend, navigate to [Backend Setup](https://github.com/FlavorShare/FlavorShare_Backend)

### **4. Set the Base URL**

After cloning the repository, you will need to set the **base URL** for the API in the following files:

1. **RecipeAPIService.swift**
2. **UserAPIService.swift**

Update the following line in both files:

```swift
let baseURL = "https://localhost:3000"
```

Replace `https://localhost:3000` with the URL where your backend is hosted.

-- 

## **Running the iOS App**

1. Open **Xcode** and select your simulator or a connected device.
2. Build and run the app:

```bash
Command + R or Command + B
```
-- 

## **Contributing**

Feel free to open issues or submit pull requests. For major changes, please open an issue first to discuss what you would like to change.
