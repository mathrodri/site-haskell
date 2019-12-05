var questions = [{
	"question": "Quais são os requisitos necessários para ser um coach  ?",
	"option1": "Ter formação e experiência comprovada na área de atuação assim como ser referência e ter influência sobre as outras pessoas do seu ramo",
	"option2": "Ter alguma certificação na área de atuação, saber conversar e convencer as pessoas.",
	"option3": "Estar com muito tempo livre, não ter o que fazer e querer ganhar dinheiro fácil falando bobagens.",
	"option4": "Apenas ter trabalhado na área de atuação já é o suficiente.",
	"answer": "3"
}, {
	"question": "Qual deve ser a postura de um coach caso seu respectivo cliente o chame em um horário não comercial ?",
	"option1": "Dar uma solução breve e sucinta ao cliente, explicando calmamente sobre os horários de atendimento",
	"option2": "Mandar o cliente ir para onde Judas bateu as botas e adverti-lo sobre o horário",
	"option3": "Parar qualquer atividade que esteja fazendo no momento para resolver o problema do cliente não importa o que seja.",
	"option4": " Falar qualquer besteira rápida para cliente achar que o coach em questão é sabichão e parar de encher o saco.",
	"answer": "4"
}, {
	"question": "O que um coach precisa para passar confiabilidade ás pessoas ?",
	"option1": "Só precisa falar qualquer coisa que as pessoas queiram ouvir e contar um monte case falso de sucesso.",
	"option2": " Precisa possuir grandes clientes de sucesso e nome, ter boas referências e ser reconhecido popularmente pelo trabalho de excelência.",
	"option3": "Um escritório com várias coisas cool em algum bairro nobre da sua respectiva cidade",
	"option4": "Apenas falar que ele é bom no que faz.",
	"answer": "1"
}, {
	"question": "Quais as principáis qualidades de um coach:",
	"option1": "Humildade",
	"option2": "Positividade",
	"option3": "Dançar HAKA",
	"option4": "Nenhuma das alternativas",
	"answer": "3"
}, {
	"question": "Como um coach deve agir caso seu cliente apresente um problema que não seja da área da sua respectiva atuação",
	"option1": "Deve ser honesto e sincero com o cliente e orienta-lo a procurar alguém capacitado para ajudar em seu problema,",
	"option2": "Deve tentar resolver o problema do cliente não importa o que seja",
	"option3": "Fala que que é só baixo astral, que é preciso emanar energias positivas",
	"option4": "Dizer ao cliente que ele é atrai o que transmite",
	"answer": "3"
}, 
];

//javaScript for functionality

var currentQuestion = 0;
var score = 0;
var totQuestions = questions.length;

var container = document.getElementById("quizContainer");
var questionEl = document.getElementById("question");
var opt1 = document.getElementById("opt1");
var opt2 = document.getElementById("opt2");
var opt3 = document.getElementById("opt3");
var opt4 = document.getElementById("opt4");
var nextButton = document.getElementById("nextButton");
var prevButton = document.getElementById("prevButton");
var resultBox = document.getElementById("result");
var resultCont = document.getElementById("score-result");

function loadQuestion(questionIndex) {
  var q = questions[questionIndex];
  questionEl.textContent = questionIndex + 1 + ". " + q.question;
  opt1.textContent = q.option1;
  opt2.textContent = q.option2;
  opt3.textContent = q.option3;
  opt4.textContent = q.option4;

  opt1.previousSibling.previousSibling.checked = true;
}

function loadNextQuestion() {
  var selectedOption = document.querySelector("input[type=radio]:checked");
  if (!selectedOption) {
    alert("Não trapaceie, responda a pergunta!");
    return;
  }

  var answer = selectedOption.value;
  if (questions[currentQuestion].answer == answer) {
    score += 5;
  }
  selectedOption.checked = false;
  currentQuestion++;
  if (currentQuestion == totQuestions - 1) {
    nextButton.textContent = "Finish";
  }
  if (currentQuestion == totQuestions) {
    container.style.display = "none";
    resultBox.style.display = "";
    resultCont.textContent = score;
    return;
  }
  prevButton.disabled = false;
  loadQuestion(currentQuestion);
}

function loadPreviousQuestion() {
  if (currentQuestion >= 1) {
    console.log(currentQuestion);
    currentQuestion--;
    loadQuestion(currentQuestion);
    if (currentQuestion == 0) {
      prevButton.disabled = true;
    }
  }
}
loadQuestion(currentQuestion);