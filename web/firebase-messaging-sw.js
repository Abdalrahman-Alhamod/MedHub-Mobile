importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: 'AIzaSyBqfTNc7X_NSIjFpnRsjEi5G8IYX-AZmTs',
    appId: '1:895894180005:web:1b78e2ab49793ad2cf7d4c',
    messagingSenderId: '895894180005',
    projectId: 'medhub-d9cfb',
    authDomain: 'medhub-d9cfb.firebaseapp.com',
    storageBucket: 'medhub-d9cfb.appspot.com',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});