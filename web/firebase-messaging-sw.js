// Import and configure the Firebase SDK
importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js');

firebase.initializeApp({
  apiKey: "AIzaSyDgk4J72SQ8NcWqSILnxH56wEo4rIl9XjE",
  authDomain: "medic-87909.firebaseapp.com",
  projectId: "medic-87909",
  storageBucket: "medic-87909.appspot.com",
  messagingSenderId: "894988944297",
  appId: "1:894988944297:web:340c85ce1f8c80d0b57ab8",
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);

  // Customize notification here
  const notificationTitle = 'Background Message Title';
  const notificationOptions = {
    body: 'Background Message body.',
    // icon: '/firebase-logo.png'  // Optionally define an icon
  };

  return self.registration.showNotification(notificationTitle,
    notificationOptions);
});
