
$(function () {
    var i;
    console.log($(document).height());
    console.log($(window).height());
    for(i=0;i<10;i++){
        $("#image_body_left").append("<div id='image_body_left_content'>"
            +"<a class='a_image_body_left_title'>" +
            "<p class='image_body_left_content_p font_color2'>2016年08月08日</p>" +
            "<img class='image_body_left_content_img' src='img/xiala.png' width='10px' height='10px'>" +
            "<p class='image_body_left_content_p font_color1'>1张</p>" +
            "<div class='image_body_left_content_div font_color1'>" +
            "<input type='checkbox'>全选</div></a><ul><li>" +
            "<img class='ul_li_img' src='img/20160808_1.jpg'>" +
            "<div></div></li></ul></div>");
    }
    $(window).scroll(function () {
        if($(document).scrollTop>(130*5)){
            alert("hello");
        }
    })
})