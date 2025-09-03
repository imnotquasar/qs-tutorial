$(document).ready(function () {
    let canContinue = false;

    const alreadyShowedTutorial = localStorage.getItem("already_showed_tutorial");

    $.post('https://qs-tutorial/init', JSON.stringify({ alreadyShowedTutorial }));

    window.addEventListener("message", function (event) {
        if (event.data.action === "showTutorial") {
            localStorage.setItem("already_showed_tutorial", "true");
            $("#tutorial-container").fadeIn(500);
        } else if (event.data.action === "updateTutorial") {
            $("#tutorial-image, #tutorial-text").fadeOut(500, function () {
                $("#tutorial-image").attr("src", "images/" + event.data.image);
                $("#tutorial-text").text(event.data.text);
                $("#continue-button").html(event.data.button);

                $("#tutorial-image, #tutorial-text").fadeIn(500, function () {
                    if (event.data.vibrate) {
                        $("#tutorial-image").addClass("vibrate");
                        setTimeout(() => {
                            $("#tutorial-image").removeClass("vibrate");
                        }, 600);
                    }
                });
            });

            $("#continue-button").hide();
            canContinue = false;

            setTimeout(function () {
                $("#continue-button").fadeIn(500);
                canContinue = true;
            }, 2000);
        } else if (event.data.action === "hideTutorial") {
            $("#tutorial-container").fadeOut(500);
        }
    });

    $("#continue-button").click(function () {
        if (canContinue) {
            $.post('https://qs-tutorial/continue');
            $("#continue-button").fadeOut(500);
            canContinue = false;
        }
    });
});

window.addEventListener("message", function (event) {
    if (event.data.action === "resetTutorial") {
        localStorage.removeItem("already_showed_tutorial");
    }
});