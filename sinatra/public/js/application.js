var GitBro = {};

$(function(){
  $('#dropdown li.headlink ul li').last().css("border-bottom", "1px solid #66A3D2")

  $('#dropdown li.headlink').hover(
    function(){$(ul, this).css('display', 'block');},
    function(){$(ul, this).css('display', 'none');}
  );
});
