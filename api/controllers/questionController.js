const questionModel = require("../models/questionModel");
const leagueModel = require("../models/leagueModel");

async function getQuestionController(req, res) {
  const { subTopic, difficulty, howMany } = req.body;

  const difficultyMap = {
    1: 'Fácil',
    2: 'Médio',
    3: 'Difícil'
  };
  const difficultyString = difficultyMap[difficulty];

  if (!difficultyString) {
    return res.status(400).json({ message: "Dificuldade inválida." });
  }

  try {
    const questions = await questionModel.getQuestionByAllModel(subTopic, difficultyString, howMany);
    if (questions.length > 0) {
      res.status(200).json({ message: questions });
    } else {
      res.status(404).json({ message: "Nenhuma questão encontrada" });
    }
  } catch (error) {
    console.error("Erro no getQuestionController:", error);
    res.status(500).json({ message: "Erro interno ao buscar questões" });
  }
}

async function addPointsContextConnection(req, res) {
  const { context, accuracy } = req.body;
  const id = req.userData.id;

  const pointsMap = {
    'Fácil': 10,
    'Médio': 20,
    'Difícil': 30
  };

  try {
    if (context === "league") {
      let points = 0;
      for (let i = 0; i < accuracy.length; i++) {
        const diff = accuracy[i];
        points += pointsMap[diff] || 0;
      }

      const leagueData = await leagueModel.verifyUserLeagueAndPoints(id);
      const currentLeagueId = Number(leagueData[0]);
      const currentPoints = Number(leagueData[1]);
      const newPoints = currentPoints + points;

      console.log("🟢 Usuário:", id);
      console.log("🟢 Liga:", currentLeagueId);
      console.log("🟢 Pontos atuais:", currentPoints);
      console.log("🟢 Pontos ganhos:", points);
      console.log("🟢 Novo total:", newPoints);

      await questionModel.addPoints(id, currentLeagueId, newPoints);

      res.status(200).json({ message: "Pontos adicionados com sucesso!" });
    } else {
      res.status(400).json({ message: "Contexto inválido. Use 'league'." });
    }
  } catch (error) {
    console.error("❌ Erro ao adicionar pontos:", error);
    res.status(500).json({ message: "Erro ao adicionar pontos: " + error.message });
  }
}

async function getQuestionInfoController(req, res) {
  try {
    const repeatedQuestionsObject = await questionModel.getQuestionInfoModel();

    const questions = {};
    for (const row of repeatedQuestionsObject) {
      const subject = row.subject;
      const topic = row.topic;
      const subtopic = row.subtopic;

      if (!questions[subject]) questions[subject] = {};
      if (!questions[subject][topic]) questions[subject][topic] = [];
      questions[subject][topic].push(subtopic);
    }

    res.status(200).json({ message: questions });
  } catch (error) {
    console.error("Erro no getQuestionInfoController:", error);
    res.status(500).json({ message: "Erro interno no servidor." });
  }
}

module.exports = {
  getQuestionController,
  getQuestionInfoController,
  addPointsContextConnection
};
