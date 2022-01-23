import * as functions from "firebase-functions";
import axios from 'axios';

import { initializeApp } from "firebase/app";
import { getDatabase, ref, set } from "firebase/database";
import { getFirestore, setDoc, doc } from "firebase/firestore";

import { firebaseConfig } from "./config";

export const scheduledUpdateFirestore = functions.pubsub.schedule("every 5 minutes").onRun((_) => {
    initializeApp(firebaseConfig);

    const firestore = getFirestore();


    const baseUrl = 'https://aoeiv.net/api'
    const leaderboardIds = [17, 18, 19, 20];

    leaderboardIds.forEach((leaderboardId) => {
        const url = `${baseUrl}/leaderboard?game=aoe4&leaderboard_id=${leaderboardId}&start=1&count=100`

        axios.get(url)
            .then(async (res: any) => {
                if (res.data !== undefined && res.data['leaderboard'].length > 0) {
                    await setDoc(doc(firestore, "leaderboard", `${leaderboardId}`), res.data);
                    functions.logger.log(`updated firestore with url: ${url}`)
                } else {
                    functions.logger.error(`updated firestore failed with url: ${url}`)
                }
            })
            .catch((error: any) => {
                functions.logger.error(`error: ${error}`)
            })
    });

    functions.logger.log("scheduledUpdateFirestore will be run every 5 minutes")
});

export const scheduledUpdateDatabase = functions.pubsub.schedule("every 5 minutes").onRun((_) => {
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

    functions.logger.log("scheduledUpdateDatabase will be run every 5 minutes")
});

