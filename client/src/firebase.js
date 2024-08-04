import firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/storage';

const firebaseConfig = {
  apiKey: 'AIzaSyBYkpSqFok7yU9w6RkpzxYnKnh6WumlFeE',
  authDomain: 'billiards-fe70e.firebaseapp.com',
  projectId: 'billiards-fe70e',
  storageBucket: 'billiards-fe70e.appspot.com',
  messagingSenderId: '62945391421',
  appId: '1:62945391421:web:4b783f0365c22dc9da4b54',
  measurementId: 'G-Q0Z8GXWTQ9'
};
// const firebaseConfig = JSON.parse(process.env.REACT_APP_FIREBASE_CONFIG);
if (!firebaseConfig) {
  console.error('Please set up your firebase config in .env file');
}

firebase.initializeApp(firebaseConfig);
const auth = firebase.auth();
const storage = firebase.storage();

export { auth, storage, firebase as default };
