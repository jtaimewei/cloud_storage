$(function () {
    $("#ul_body_left li").click(function () {
        $(this).siblings().removeClass("li_bgcolor");
        $(this).siblings().children().removeClass("li_color");
        $(this).addClass("li_bgcolor");
        $(this).children().addClass("li_color");
    })
})