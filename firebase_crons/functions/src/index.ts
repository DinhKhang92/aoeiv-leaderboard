import * as functions from "firebase-functions";

import { FirebaseOptions, initializeApp } from "firebase/app";
import { getDatabase, ref, set } from "firebase/database";
import axios from 'axios';

export const scheduledUpdateDatabase = functions.pubsub.schedule("every 5 minutes").onRun((_) => {
    const firebaseConfig: FirebaseOptions = {
        apiKey: "AIzaSyBLWn3Iq2FklNPFsr9tWq6VGbIx2KYWsBE",
        authDomain: "aoe4-leaderboard-ac8c3.firebaseapp.com",
        projectId: "aoe4-leaderboard-ac8c3",
        storageBucket: "aoe4-leaderboard-ac8c3.appspot.com",
        messagingSenderId: "774416121199",
        appId: "1:774416121199:web:f93033d46c5c0bb7a53c9a",
        measurementId: "G-XV8NJHVBW8"
    };
    const app = initializeApp(firebaseConfig);

    const databaseUrl = 'https://aoe4-leaderboard-ac8c3-default-rtdb.europe-west1.firebasedatabase.app';
    const database = getDatabase(app, databaseUrl)

    const baseUrl = 'https://aoeiv.net/api'
    const leaderboardIds = [17, 18, 19, 20];

    leaderboardIds.forEach((leaderboardId) => {
        const url = `${baseUrl}/leaderboard?game=aoe4&leaderboard_id=${leaderboardId}&start=1&count=1000`

        axios.get(url)
            .then(async (res) => {
                if (res.data !== undefined && res.data['leaderboard'].length > 0) {
                    await set(ref(database, `/leaderboard/${leaderboardId}`), res.data);
                    functions.logger.log(`updated database with url: ${url}`)
                } else {
                    functions.logger.error(`updated database failed with url: ${url}`)
                }
            })
            .catch((error) => {
                functions.logger.error(`error: ${error}`)
            })
    });

    functions.logger.log("This will be run every 5 minutes")
});

