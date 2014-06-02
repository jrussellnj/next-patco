$(document).ready(function() {
  hookUpCarousel();
});

function hookUpCarousel() {
  $('.upcoming-trains.to-phila').carouFredSel({
    auto: {
      play: false
    },
    circular: false,
    infinite: false,
    items: 2,
    next: {
      button: $('.to-phila .next')
    },
    prev: {
      button: $('.to-phila .previous')
    },
    scroll: {
      items: 1
    }
  });

  $('.upcoming-trains.to-lindenwold').carouFredSel({
    auto: {
      play: false
    },
    circular: false,
    infinite: false,
    items: 2,
    next: {
      button: $('.to-lindenwold .next')
    },
    prev: {
      button: $('.to-lindenwold .previous')
    },
    scroll: {
      items: 2
    }
  });
}
