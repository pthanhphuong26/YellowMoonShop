/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$('.card-input').each(function () {
    $(this).on('blur', function () {
        if ($(this).val().trim() != "") {
            $(this).addClass('has-val');
        } else {
            $(this).removeClass('has-val');
        }
    })
});

var btnUpload = $("#upload_file"), btnOuter = $(".button_outer");
if (btnUpload.attr("value") !== "") {
    btnOuter.addClass("file_uploading");
    btnOuter.addClass("file_uploaded");
    var uploadedFile = btnUpload.attr("value");
    $("#uploaded_view").append('<img src="' + uploadedFile + '" />').addClass("show");
}
btnUpload.on("change", function (e) {
    btnOuter.addClass("file_uploading");
    setTimeout(function () {
        btnOuter.addClass("file_uploaded");
    }, 1000);
    $("#uploaded_view").hide();
    var uploadedFile = URL.createObjectURL(e.target.files[0]);
    setTimeout(function () {
        $("#uploaded_view").append('<img src="' + uploadedFile + '" />').addClass("show");
    }, 2000);
});

$(".file_remove").on("click", function (e) {
    $("#uploaded_view").removeClass("show");
    $("#uploaded_view").find("img").remove();
    btnOuter.removeClass("file_uploading");
    btnOuter.removeClass("file_uploaded");
});


//choose quantity to shopping
var inputQuantity = $("#input-quantity");
var qty = +inputQuantity.val();

$("#qty-minus-btn").on("click", function (e) {
    if (qty > 1)
        qty -= 1;
    inputQuantity.attr("value", qty);
});
$("#qty-plus-btn").on("click", function (e) {
    qty += 1;
    inputQuantity.attr("value", qty);
});