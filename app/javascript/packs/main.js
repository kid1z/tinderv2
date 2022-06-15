let inputCheckbox = document.querySelectorAll("input[type='checkbox'")
inputCheckbox.forEach((e, idx) => {
    e.onchange = function (event) {
        console.log(event.target.checked)
        document.getElementById(`${event.target.id}`).disabled = !event.target.checked;
    }
});