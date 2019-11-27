// Side bar
$(document).ready(function () {
    $('.sidenav').sidenav();
});

// Modal
$(document).ready(function () {
    $('.modal').modal();
});

// Select
$(document).ready(function () {
    $('select').formSelect();
});

// Select Required Alert
$("select[required]").css({
    display: "block",
    height: 0,
    padding: 0,
    width: 0,
    position: 'absolute',
    left: "50%",
    top: "100%"
});

// Tooltips
$(document).ready(function () {
    $('.tooltipped').tooltip();
});

// Input Character Counter
$(document).ready(function () {
    $('input#input_text, textarea#textarea2').characterCounter();
});

// Card Action ShortCut
var cardAnchor = document.querySelector(".card-action a");

if (cardAnchor) {
    document.onkeypress = handleCardAnchor;
}

function handleCardAnchor(event) {
    if (event && event.keyCode === 13) {
        location.href = cardAnchor.href;
    }
}

// Submit Button & Solution ShortCut
var button = document.querySelector(".question-submit");
var solution = document.querySelector(".solution-trigger");

if (button) {
    document.onkeydown = handleButtonSubmit;
}

function handleButtonSubmit(event) {
    if (event && (event.altKey || event.metaKey) && event.keyCode === 13) {
        button.click();
    }
}

// Focus on Answer
var answer = document.querySelector(".question-wrapper__answer");
if (answer) {
    answer.focus();
}

// Warning To Explorer
function browser() {
    var agent = navigator.userAgent.toLowerCase();
    if ((navigator.appName == 'Netscape' && agent.indexOf('trident') != -1) || (agent.indexOf("msie") != -1)) {
        alert("본 사이트는 익스플로러를 지원하지 않습니다.");
    }
}

// Init
function init() {
    handleCardAnchor();
    handleButtonSubmit();
    browser();
}

init();


















