importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyCQE-mwERpzutmr4jHF2CZouJngnzQMO04",
  authDomain: "pushnotification-f3529.firebaseapp.com",
  projectId: "pushnotification-f3529",
  storageBucket: "pushnotification-f3529.appspot.com",
  messagingSenderId: "704499944798",
  appId: "1:704499944798:web:699729978f31b763cd13cf",
  measurementId: "G-TJVJ9P7R7S"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});