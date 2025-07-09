
window.addEventListener('load', () => {
let billTotal = document.getElementById('amountBox');
let tipPercent = document.getElementById('tipPercent');
let tipDollars = document.getElementById('tipDollars');
let output = document.getElementById('quickSplit-output');
let numPeople = document.getElementById('numPeople');
let form = document.getElementById('quickSplit-form');
let lastUsed = 0;
output.value = 0;
tipPercent.addEventListener('input', function() {
    tipDollars.value = (billTotal.value * (tipPercent.value / 100)).toFixed(2)
    lastUsed = 1;
})
tipDollars.addEventListener('input', function() {
    tipPercent.value = ((tipDollars.value / billTotal.value) * 100).toFixed(1)
    lastUsed = 2;
})
form.addEventListener('input', () => {
    if(lastUsed === 1) {
        tipDollars.value = (billTotal.value * (tipPercent.value / 100)).toFixed(2)
    } else if(lastUsed === 2) {
        tipPercent.value = ((tipDollars.value / billTotal.value) * 100).toFixed(1)
    }

    if(tipDollars.value && billTotal.value) {
        output.value = ((parseFloat(billTotal.value) + parseFloat(tipDollars.value)) / numPeople.value).toFixed(2);
    } else if(billTotal.value && numPeople.value > 0) {
        output.value = ((parseFloat(billTotal.value)) / numPeople.value).toFixed(2);
    }
})

})
