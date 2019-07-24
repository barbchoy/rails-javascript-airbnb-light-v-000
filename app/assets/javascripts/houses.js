
$(function(){
  console.log('document is ready ...')
  console.log('houses.js is loaded ...')
  listenForClick()

  $('#new_house').submit(function(event) {
    //prevent form from submitting the default way
    event.preventDefault();

    var values = $(this).serialize();

    var posting = $.post('/houses', values);

    posting.done(function(data) {
      // TODO: handle response
      $("#form-container").html("")
      const newHouse = new House(data)
      const htmlToAdd = newHouse.formatHouse()
      $("#form-container").html(htmlToAdd)

    });
  });
})



function listenForClick(){
  console.log("listening for click...")
  $(document).on("click", ".house-details-div a", function(event){
      href=$(this).attr("href")
      event.preventDefault()
      getPosts(href)
    })
}

function getPosts(href) {
  $.ajax({
    url: `http://0.0.0.0:3000${href}`,
    method: 'get',
    dataType: 'json'
  }).done(function(data){
    console.log("the data is", data)
    let myHouse = new House(data)
    let myHouseHTML = myHouse.postHTML()
    let houseId = myHouse.id
    document.getElementById(`details-div-${houseId}`).innerHTML = myHouseHTML

    document.getElementById(`hide-button-${houseId}`).addEventListener("click", function(event){
       hideDetailsOnClick(houseId);
     })

  })
}



function hideDetailsOnClick(houseId){
  console.log("Hide button is clicked...")
  var detailsDiv = document.getElementById(`details-div-${houseId}`);
  detailsDiv.innerHTML = ""
  var a = document.createElement('a');
  var linkText = document.createTextNode("Read more about the space");
  a.setAttribute("class", "house-details");
  a.setAttribute("href", `/houses/${houseId}`);
  a.appendChild(linkText);
  detailsDiv.appendChild(a);
}


class House {
  constructor(obj){
    this.name = obj.name
    this.price_per_night = obj.price_per_night
    this.city = obj.city
    this.max_guests = obj.max_guests
    this.pets_allowed = obj.pets_allowed
    this.owner_id = obj.owner_id
    this.id = obj.id
    this.description = obj.description
    this.amenities = obj.amenities
  }


}


House.prototype.postHTML = function(){
  return(`
    <div>
      <p><strong>The Space:</strong> ${this.description}</p>
      <p><strong>Amenities:</strong> ${this.amenities}</p>
      <p><strong>City:</strong> ${this.city}</p>
      <button id="hide-button-${this.id}">Hide ^</button>
      <a href="/houses/${this.id}">See full details</a>
      <br><br>
    </div>
  `)
}

House.prototype.formatHouse = function(){
  let houseHTML = `
    <h3>${this.name}</h3>
    <p id="housePrice">Price Per Night: $${this.price_per_night}</p>
    <p id="houseCity">City: ${this.city}</p>
    <p id="houseMaxGuests">Max # of Guests: ${this.max_guests}</p>
    <p id="housePets">Pets Allowed? ${this.pets_allowed}</p>
    <p id="houseDescription">Description: ${this.description}</p>
    <p id="houseAmenities">Amenities: ${this.amenities}</p>
  `
  return houseHTML
}
