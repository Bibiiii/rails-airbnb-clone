var fixmeTop = $('.fixme').offset().top;
var booking_width = $('.panel').width()
$(window).scroll(function() {
    var currentScroll = $(window).scrollTop();
    if (currentScroll >= fixmeTop) {
        $('.fixme').css({
            'position': 'fixed',
            'top': '50px',
            'z-index': 90,
            'width': String(booking_width) + 'px'
        });
    } else {
        $('.fixme').css({
            position: 'static'
        });
    }
});
