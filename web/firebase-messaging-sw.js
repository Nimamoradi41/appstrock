// Handle clicks before Firebase's own listener so every notification opens the app.
self.addEventListener('notificationclick', (event) => {
  event.stopImmediatePropagation();
  event.notification.close();
  const appUrl = new URL('./', self.location.href).href;
  event.waitUntil((async () => {
    const windows = await clients.matchAll({ type: 'window', includeUncontrolled: true });
    const existing = windows.find((client) => client.url.startsWith(appUrl));
    if (existing) {
      try {
        await existing.focus();
        return;
      } catch (error) {
        console.error('Unable to focus the app window', error);
      }
    }
    await clients.openWindow(appUrl);
  })());
});

importScripts('https://www.gstatic.com/firebasejs/11.9.1/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/11.9.1/firebase-messaging-compat.js');

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyA1DnPt2k7cbCd8m2kswL4IxhxmwCYiD-M",
  authDomain: "nimamoradi41.firebaseapp.com",
  databaseURL: "https://nimamoradi41.firebaseio.com",
  projectId: "nimamoradi41",
  storageBucket: "nimamoradi41.firebasestorage.app",
  messagingSenderId: "523822990960",
  appId: "1:523822990960:web:ffc8326bc7a938c23c96b5",
  measurementId: "G-MYW5JC6DJR"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);
firebase.messaging().onBackgroundMessage((payload) => {
  // Firebase displays notification payloads automatically in the background.
  if (payload.notification) return;
  const data = payload.data || {};
  return self.registration.showNotification(data.title || 'AppStroke', {
    body: data.body || '',
    icon: new URL('icons/Icon-192.png', self.location.href).href,
  });
});
