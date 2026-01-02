# How to Get Your Web Client ID - Step by Step

## 🎯 Quick Fix for "Error 401: invalid_client"

### Step 1: Open Firebase Console

**Direct Link to Your Project Settings:**
https://console.firebase.google.com/project/facebook-36350/settings/general

### Step 2: Find Your Web App

1. Scroll down to **"Your apps"** section
2. Look for the **Web app** (it has a `</>` icon)
3. Click on it or find it in the list

### Step 3: Get the Web Client ID

1. In the Web app section, look for **"OAuth 2.0 Client IDs"**
2. Find **"Web client (auto created by Google Service)"**
3. **Copy the Client ID** - it looks like:
   ```
   1078849438390-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com
   ```
   (The x's are a long string of characters)

### Step 4: Update web/index.html

1. Open `web/index.html` in your editor
2. Find line 41:
   ```html
   <meta name="google-signin-client_id" content="YOUR_WEB_CLIENT_ID.apps.googleusercontent.com">
   ```
3. Replace `YOUR_WEB_CLIENT_ID.apps.googleusercontent.com` with your actual Client ID
4. Save the file

### Step 5: Restart Your App

```bash
flutter clean
flutter run -d chrome
```

---

## 🔍 Alternative: Get from Google Cloud Console

If you can't find it in Firebase Console:

1. Go to: https://console.cloud.google.com/apis/credentials?project=facebook-36350
2. Under **"OAuth 2.0 Client IDs"**, find the one with type **"Web client"**
3. Click on it to see the Client ID
4. Copy it

---

## ⚠️ Important Notes

- The Client ID must start with `1078849438390-` (your project number)
- It must end with `.apps.googleusercontent.com`
- Don't include any spaces
- Make sure you're copying the **Web client** ID, not Android or iOS

---

## ✅ After Adding Client ID

Once you update `web/index.html` and restart:
- Google Sign-In should work on web
- No more "Error 401: invalid_client"
- You'll be able to sign in with Google

---

## 💡 Better Option: Test on Android

For your mobile lab, **testing on Android is easier**:

```bash
flutter run -d emulator
```

**Why Android is better:**
- ✅ No need for Web Client ID
- ✅ Uses `google-services.json` (already configured)
- ✅ More reliable for mobile development
- ✅ Better matches your lab requirements

