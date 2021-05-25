window.addEventListener('load', () => {
  const targetElement = document.querySelectorAll(".animationTarget");
  document.addEventListener("scroll", function(){
    for(let i = 0; i < targetElement.length; i++ ){
      const getElementDistance = targetElement[i].getBoundingClientRect().top + targetElement[i].clientHeight * .2
      if(window.innerHeight > getElementDistance) {
        targetElement[i].classList.add("show");
      }
    };
  });
});