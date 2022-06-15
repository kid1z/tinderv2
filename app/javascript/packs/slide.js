let next = document.querySelector('#next')
let previous = document.querySelector('#previous')
let slideItem = document.querySelectorAll('.info')
let slides = document.querySelector(".slides")
let length = slideItem.length
let index = 0
let csrfToken = document.getElementsByName("csrf-token")[0].content
let buttonInteract = document.querySelectorAll(".react div button")
slideItem[0].classList.add("active")

function onNextClick() {
  for (let i = 0; i < slideItem.length; i++) { //remove all active class in loop for each click
    slideItem[i].classList.remove("active")
  }
  if (index == length - 1) {
    buttonInteract[1].disabled = true;
    slideItem[length - 1].classList.add("active")
  }
  else {
    index += 1
    slideItem[index].classList.add("active")
  }
  let widthImage = `${350*index}px`; //width of img div is 350px
  slides.style.transform = `translateX(-${widthImage})`
}
function onPreviousClick() {
  index -= 1
  for (let i = 0; i < slideItem.length; i++) {
    slideItem[i].classList.remove("active")
  }
  if (index <= -1) {
    index = length - 1
    slideItem[index].classList.add("active")
  }
  let widthImage = `${350*index}px`;
  slides.style.transform = `translateX(-${widthImage})`
  slideItem[index].classList.add("active")
  if (index == length) {
    index = 0
  }
}
// skip user function
function likedUser() {
  let notice = document.querySelector('.notice')
  let data = `<div class="action like">
                <div class="toast__content">
                  <div class="before before--success"></div>
                  <div class="check check--success">V</div>
                  <div class="text">
                    <p>You liked this user</p>
                  </div>
                </div>
              </div>`
  notice.insertAdjacentHTML("beforeend",data)
  setTimeout(function(){
    notice.removeChild(notice.childNodes[0])
  },3500)
}
function skipUser() {
  let notice = document.querySelector('.notice')
  let data = `<div class="action skip">
                <div class="toast__content">
                  <div class="before"></div>
                  <div class="check ">X</div>
                  <div class="text">
                    <p>You skipped this user </p>
                  </div>
                </div>
              </div>`
  notice.insertAdjacentHTML("beforeend",data)
  onNextClick()
  setTimeout(function(){ //remove data variable after 3.5s
    notice.removeChild(notice.childNodes[0])
  },3500)
}

function transferDataFromJs() {
  slideItem.forEach((e, idx) => {
    idx = parseInt(e.dataset.id) // get data-id attribute in info class in the the file app.html.erb,
    if(e.classList.contains("active")) {
      console.log(idx + " da tym")
      var data = new FormData(); //pass data idx to file session_controller.rb
      data.append('user_id', idx);
      var xhttp = new XMLHttpRequest();
      xhttp.open("POST", "/app/" + idx, true);
      xhttp.setRequestHeader('X-CSRF-Token', csrfToken)
      xhttp.send(data);
    }
  });
  likedUser()
  onNextClick()
}
// --button next and previous slide. Currently, it was hidden
// next.addEventListener("click", onNextClick);
// previous.addEventListener("click", onPreviousClick);
buttonInteract[0].addEventListener("click",transferDataFromJs)
buttonInteract[1].addEventListener("click", skipUser)