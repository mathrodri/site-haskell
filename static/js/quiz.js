function startQuiz() {
    var formQuiz = document.querySelector('#quiz-form');
    var quizStepsContainer = document.querySelector('#quiz-steps-container');

    formQuiz.className = 'invisible';
    quizStepsContainer.removeAttribute('class');
}

function nextStep() {
    var totalSteps = Array.from(
        document.querySelectorAll('.quiz-step')
    );
    var actualStep = document.querySelector('.quiz-step.visible');
    var actualStepIndex = parseInt(actualStep.dataset.step, 10);
    var nextStepIndex = parseInt(actualStep.dataset.step, 10) + 1;

    var actualForm = new FormData(document.querySelector(`#question-form-${actualStepIndex}`));
    var actualAnswer = actualForm.get(`question-${actualStepIndex}`);

    window.localStorage.setItem(`question-${actualStepIndex}`, actualAnswer);

    if(nextStepIndex <= totalSteps.length) {
        var nextStep = totalSteps.find(function(step) {
            return parseInt(step.dataset.step, 10) == nextStepIndex;
        });

        actualStep.className = actualStep.className.replace('visible', '').trim();
        nextStep.className = nextStep.className + ' visible';
    } else {
        var quizStepsContainer = document.querySelector('#quiz-steps-container');

        nextStepIndex = 1;
        actualStep.className = actualStep.className.replace('visible', '').trim();
        quizStepsContainer.setAttribute('class', 'invisible');

        showResult();
    }
}

function prevStep() {}

function showResult() {
    answersAssociation = {
        '0': 'Infelizmente você errou todas as perguntas, isso significa que você provavelmente se importa com as pessoas, então não está pronto para ser coach.',
        '1': 'Por incrível que pareça existem pessoas piores que você, mas esse resultado indica que você ainda possui amor no coração com as pessoas, ainda falta um longo caminho para ser coach.',
        '2': 'Bom, não foi dos piores mas você ainda tem coisas para aprender, não desista e um dia você irá conseguir.',
        '3': 'Dava para ser melhor, você será um coach mediano, mas com experiência e prática você chega la.',
        '4': 'Quase um resultado perfeito, você não é o melhor, porém dará um belo coach, parabéns.',
        '5': 'Parabéns, você acertou todas as perguntas com maestria, não existrira nenhum coach igual a você ! (se é que me entende)',
    };

    var resultContainer = document.querySelector('#quiz-result-container');
    resultContainer.removeAttribute('class');

    var answers = [];

    for(let i = 1; i <= 5; i++) {
        var questionAnswer = window.localStorage.getItem(`question-${i}`);
        answers.push(questionAnswer);
    }

    var rightAnswers = answers.filter(function(answer) {
        return answer == 'true';
    });

    var name = window.localStorage.getItem('name');

    var quizResult = document.querySelector('#quiz-result');
    var quizText = document.querySelector('#quiz-result-text');

    quizResult.innerHTML = `${name}, você acertou ${rightAnswers.length} de ${answers.length} perguntas.`;
    quizText.innerHTML = answersAssociation[rightAnswers.length];
}

function addStartButtonEvent() {
    var startButton = document.querySelector('#start-quiz-button');
    startButton.addEventListener('click', function() {
        var inputName = document.querySelector('#input-name');
        var name = inputName.value;

        window.localStorage.setItem('name', name);

        startQuiz();
    });
}

function addNextButtonEvent() {
    var nextButtons = Array.from(
        document.querySelectorAll('.next-step-button')
    );

    nextButtons.forEach(function(nextButton) {
        nextButton.addEventListener('click', function() {
            nextStep();
        });
    });
}

function addEvents() {
    addStartButtonEvent();
    addNextButtonEvent();
}

addEvents();