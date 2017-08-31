$(function () {
  $('#post_tag_list').selectize({
    delimeter: ",",
    persist: false,
    create: function (input) {
      return {
        value: input,
        text: input
      }
    }
  });
})
(function($, window, document, undefined) {
"use strict";

  var el= $('.readmore'),
      clone= el.clone(),
      originalHtml= clone.html(),
      originalHeight= el.outerHeight(),
      Trunc = {
    moreLink: '<a href="#" class="readmore-toggle" data-read="more">Read More<span class="icon-arrow-bottom"</span></a>',
    lessLink: '<a href="#" class="readmore-toggle" data-read="less">Moins <span class="icon-arrow-top"></span></a>',
    addTrigger : function(){
      $('.article-readmore').append(this.moreLink);
    },
    truncateText : function( textBlock ) {
      while (textBlock.text().length > 20 ) {
        textBlock.text(function(index, text) {
          return text.replace(/\W*\s(\S)*$/, '...');
        });
      }
    },
    replaceText: function ( textBlock, original ){
      return textBlock.html(original).height(originalHeight);
    }

  };
  Trunc.addTrigger();
  Trunc.truncateText(el);

  $(document).on('click', '[data-read]', function(e){
    e.preventDefault();

    if ($(this).data('read') == 'more'){
      Trunc.replaceText(el, originalHtml);
      $(this).replaceWith(Trunc.lessLink);

    } else if ($(this).data('read') == 'less') {
      Trunc.truncateText(el);
      $(this).replaceWith(Trunc.moreLink);
      el.css('height', '100%');
    }

  });

})(jQuery, window, document, undefined);
