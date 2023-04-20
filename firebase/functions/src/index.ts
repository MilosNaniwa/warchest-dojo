import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import * as AlphaBetaEngine from "./engine/alpha_beta_engine.dart";

admin.initializeApp(functions.config().firebase);

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
export const onCreateGameStateOfPrototype = functions
  .region("asia-northeast1")
  .runWith({
    timeoutSeconds: 30,
    memory: "1GB",
  })
  .firestore.document("/prototype/{gameMatchId}/game/{gameStateId}")
  .onCreate(async (snapshot) => {
    console.log(`処理開始`);
    console.log(
      `処理対象: /prototype/${snapshot.ref.parent.parent?.id}/game/${snapshot.id}`
    );

    const gameStateData = snapshot.data()["game_state"];
    const player = gameStateData?.turn;
    const opponent = player === "red" ? "blue" : "red";
    const json = JSON.stringify(gameStateData);

    const actionRaw = AlphaBetaEngine.methodChannel([
      "find_best_action",
      json,
      player,
      opponent,
    ]);

    const actionJson = JSON.parse(actionRaw);

    await snapshot.ref.update({ action: { ...actionJson } });

    console.log(`正常終了`);
  });
