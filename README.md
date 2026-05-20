# Kampüsünden 📱

**CS310 Mobile Application Development | Spring 2025-2026 Term Project (Final Submission)**

---

## 📱 About The Project
**Kampüsünden** (From Your Campus) is a premium, campus-exclusive, peer-to-peer marketplace application built with **Flutter** and **Firebase**. It provides university students with a privacy-conscious, localized ecosystem to safely buy, sell, or request second-hand essentials (like dorm appliances, textbooks, electronics, and school supplies) directly within their campus boundaries.

---

## 🎯 The Problem & Our Solution
### The Problem:
University students undergo constant transitions (moving into dorms, changing academic terms, graduation) which creates a high demand for short-term essentials like mini-fridges, water heaters, textbooks, and calculators. Existing second-hand marketplaces (e.g., sahibinden, Dolap) introduce major frictions:
* High commission rates and shipping fees.
* High risk of dealing with unverified strangers.
* Frictions and delays in delivery.

### Our Solution:
**Kampüsünden** provides a secure, zero-commission, face-to-face campus marketplace. Only verified university community members can trade, making transactions safe, instantaneous, and highly cost-effective. Transactions are finalized in person on campus, which completely eliminates shipping fees, decreases the carbon footprint, and builds a trusted peer community.

---

## 👥 Team Organization & Contributions
> **Active Collaboration Statement:** Every team member contributed actively and evenly throughout the project lifecycles, wireframing, widget development, Firebase services, state management, and testing.

* **Murat Kabaağaç (33797) — Project Coordinator**
  * Manages team meetings, tracks milestones, and monitors progress.
* **Alperen Sarışen (33886) — Documentation & Submission Lead**
  * Formulates written reports, compiles submissions, and ensures requirements compliance.
* **Hamza Eren İnan (34502) — Integration & Repository Lead**
  * Oversees Git/GitHub repository structure, coordinates version control, and manages branches.

---

## 🚀 Key Features & Functionality

### 1. 🔐 User Authentication & Profiles
* **Secure Auth:** Users sign up/sign in securely using their university email addresses via **Firebase Authentication**.
* **Detailed User Profiles:** Under the user's name on their profile page, they can show their department, grade, and university.
* **Custom Profile Settings:** A dedicated settings page allows users to seamlessly edit their profile details (e.g., Computer Science, Senior, Sabancı University), which instantly syncs with Firestore and updates their card across the app.
* **User-Specific Feeds:** The profile page displays a horizontal scrollable view of the user's active listings and active requests.

### 2. 🔍 Discover Marketplace & Feed
* **Dual Listing Types:** Browse through products for sale or switch to the requests feed to view what items other students are looking to buy.
* **Advanced Search & Filtering:** Instantly search for listings by keywords or filter by category (e.g., Books, Electronics, Dorm Gear).
* **Sorting Capabilities:** Sort listings dynamically by price (e.g., Cheapest, Most Expensive) or by listing time (Newest).

### 3. 🤝 Real-Time Offer & Negotiation System (Replaces Standard Chat)
To make negotiations extremely smooth, we replaced standard generic messaging with an interactive **Offer System**:
* **Make an Offer:** Clicking on a listing displays a premium "Make Offer" button. Buyers can enter a price proposal, which automatically initializes a secure chat with the seller.
* **Interactive Counter-Offer Loop:** The chat page displays stateful, beautifully-styled negotiation cards:
  * **As the Buyer:** Shows "You made an offer of X ₺" (Waiting for response).
  * **As the Seller:** Shows "User made an offer of X ₺" alongside action buttons: **[Accept]** and **[Counter Offer]**.
  * **Accept:** Instantly marks the listing's offer as accepted with an attractive green notification bubble ("Offer of X ₺ accepted!").
  * **Counter Offer:** Re-opens a price input popup, enabling the seller to offer a counter-price, sending the offer card back to the buyer in real time.
* **Clean Conversations:** The Chat directory displays active negotiations instantly with real-time text status updates.

### 4. ➕ Easy Listing Creation
* **Sell or Request:** Create listings with titles, brands, categories, descriptions, and price values.
* **Rigid Validation:** The price input field has active validation restricting space characters or letters. Only numeric values can be entered.
* **Image Uploads:** Upload high-quality pictures to showcase the item, which are stored securely in **Firebase Storage**.

---

## 🛠️ Technology Stack & Packages
* **Framework:** [Flutter](https://flutter.dev/) (v3.22.x or later)
* **Language:** Dart
* **Backend Services (Firebase):**
  * `firebase_core`: Project initialization.
  * `firebase_auth`: Secure user registration and login.
  * `cloud_firestore`: Real-time NoSQL database storing user details, listings, and chat logs.
  * `firebase_storage`: Media bucket hosting uploaded listing photos.
* **State Management:**
  * `provider`: Lightweight, robust state provider managing app authorization and list streams.
* **Utilities & Styling:**
  * `google_fonts` (Poppins): Aesthetic modern typography.
  * `image_picker`: Camera and gallery photo selection.
  * `shared_preferences`: Local cache persistence.

---

## 💻 Installation & Setup

Follow these steps to run the application locally on your emulator or physical device:

### Prerequisites:
* Ensure Flutter SDK is installed (`flutter --version` should be >= 3.22.x).
* Ensure CocoaPods is installed (for iOS development).
* A mobile device or emulator running Android or iOS.

### Step 1: Clone the Repository
```bash
git clone https://github.com/ereninan/CS310-Spring-2026-Group-Project.git
cd CS310-Spring-2026-Group-Project/kampusunden
```

### Step 2: Install Package Dependencies
```bash
flutter pub get
```

### Step 3: Firebase Configuration Setup
For local verification or running on your own database:
1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a project named `Kampusunden`.
2. Install the **FlutterFire CLI** globally:
   ```bash
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   ```
3. Configure your Flutter project with your Firebase instances:
   ```bash
   flutterfire configure
   ```
   Select your Firebase project and platforms (Android, iOS, Web). This will automatically generate a valid `lib/firebase_options.dart` file.
4. Enable the following services in the Firebase Console:
   * **Authentication:** Enable the `Email/Password` provider.
   * **Cloud Firestore:** Enable in Test Mode (or apply rules to authorize reads/writes to authenticated users).
   * **Firebase Storage:** Enable rules allowing reads and writes to authenticated users.

### Step 4: Run the Application
Execute the command in your terminal to compile and run on your active simulator:
```bash
flutter run
```

---

## 🧪 Testing Instructions

The codebase includes an extensive suite of automated tests to ensure correctness and prevent regressions.

### Executing Tests:
To run the automated tests, navigate to the `kampusunden` directory and execute:
```bash
flutter test
```

### Test Coverage Details:
1. **Unit Tests (`test/unit_test.dart`):**
   * **ListingModel Validation:** Verifies the complete serialization (`toMap()`) and deserialization (`fromMap()`) of listings, ensuring data types, optional fields (like `isWanted`), and Firestore `Timestamp` values parse correctly.
   * **MessageModel Validation:** Tests the custom chat and offer messaging system schemas, verifying the `type` ('text', 'offer', 'offer_accepted') and `offerAmount` parameters serialize without any data loss.
2. **Widget Tests (`test/widget_test.dart`):**
   * **ProductCard Rendering:** Verifies that our custom marketplace product cards render brand names, titles, and price formatting exactly as expected.
   * **Placeholder Rendering:** Validates that if a listing has an empty image URL, the card automatically falls back to displaying a premium placeholder icon (`Icons.image_not_supported`).

---

## ⚠️ Known Limitations & Assumptions
* **Internet Connection:** App demands a stable internet connection to communicate with Firebase Firestore and load cloud-hosted product images.
* **Profile Images:** Profile pictures currently default to a local asset image placeholder (`lib/data/images/profileImg.png`) for simplicity.
* **Notification Badges:** Real-time chat works perfectly inside the message screen, but device push notifications are not configured for production.
