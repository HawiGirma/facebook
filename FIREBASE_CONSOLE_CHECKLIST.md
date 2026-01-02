# Firebase Console Configuration Checklist

## ✅ Required Steps for Authentication to Work

### Step 1: Enable Firebase Authentication

1. Go to [Firebase Console](https://console.firebase.google.com/project/facebook-36350)
2. Click **Authentication** in the left menu
3. If you see "Get started", click it
4. You should see the Authentication dashboard

### Step 2: Enable Email/Password Provider

1. In Authentication, click **Sign-in method** tab
2. Find **Email/Password** in the list
3. Click on it
4. Toggle **Enable** to ON
5. Click **Save**

### Step 3: Enable Google Sign-In Provider

1. In Authentication → **Sign-in method** tab
2. Find **Google** in the list
3. Click on it
4. Toggle **Enable** to ON
5. Enter a **Project support email** (your email)
6. Click **Save**

### Step 4: For Web - Get Web Client ID

1. Go to **Project Settings** (gear icon)
2. Scroll to **Your apps** section
3. Find your **Web app** (</> icon)
4. Look for **OAuth 2.0 Client IDs**
5. Copy the **Web client (auto created by Google Service)** Client ID
6. It looks like: `1078849438390-xxxxxxxxxxxxx.apps.googleusercontent.com`
7. Add it to `web/index.html` (replace `YOUR_WEB_CLIENT_ID.apps.googleusercontent.com`)

### Step 5: For Android - Verify google-services.json

1. Make sure `android/app/google-services.json` exists
2. It should have been downloaded from Firebase Console when you added the Android app

---

## 🔍 Verification

After completing the above:

### Test Email/Password Sign-Up:
1. Open app → Sign Up screen
2. Enter name, email, password
3. Click "Sign Up"
4. Should redirect to Home screen if successful
5. If error, check the error message for details

### Test Google Sign-In:
1. Open app → Click "Sign in with Google"
2. Should open Google sign-in popup
3. Select account
4. Should redirect to Home screen if successful
5. If error, check the error message for details

---

## ❌ Common Issues

### "Firebase is not initialized"
- **Solution:** Make sure `firebase_options.dart` exists and Firebase.initializeApp() runs successfully

### "Email/Password provider not enabled"
- **Solution:** Enable Email/Password in Firebase Console → Authentication → Sign-in method

### "Google Sign-In failed: invalid_client"
- **Solution:** 
  - For Web: Add correct Web Client ID to `web/index.html`
  - For Android: Make sure `google-services.json` is in `android/app/`

### "operation-not-allowed"
- **Solution:** Enable the provider (Email/Password or Google) in Firebase Console

---

## 📝 Quick Links

- **Your Firebase Project:** https://console.firebase.google.com/project/facebook-36350
- **Authentication Settings:** https://console.firebase.google.com/project/facebook-36350/authentication/providers
- **Project Settings:** https://console.firebase.google.com/project/facebook-36350/settings/general

