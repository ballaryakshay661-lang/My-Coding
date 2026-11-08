const studentForm = document.getElementById("studentForm");
const message = document.getElementById("message");

studentForm.addEventListener("submit", function(event) {

    event.preventDefault();

    const studentName = document.getElementById("studentName").value;

    message.textContent = "Registration successful, " + studentName + "!";

    studentForm.reset();

});