var GitBro = {};

$(function(){
  $('#dropdown li.headlink').hover(
    function(){$(ul, this).css('display', 'block');},
    function(){$(ul, this).css('display', 'none');}
  );
});
