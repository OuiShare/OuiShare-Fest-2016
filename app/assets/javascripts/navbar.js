/*
 * Change Navbar color while scrolling
*/

$(window).scroll(function(){
  handleTopNavAnimation();
});

$(window).load(function(){
  handleTopNavAnimation();
});

function handleTopNavAnimation() {
  var top=$(window).scrollTop();

  if(top>10){
    $('#site-nav').removeClass('navbar-solid'); 
    // alert('test');
  }
  else{
    $('#site-nav').addClass('navbar-solid'); 
    // alert('pouet');
  }
}