
$(function(){
  console.log('document is ready ...')
  console.log('houses.js is loaded ...')
  listenForClick()
  listenForNewHouseFormClick()
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

     document.getElementById(`details-button-${houseId}`).addEventListener("click", function(event){
        detailsButtonOnClick(houseId);
      })

  })
}

function detailsButtonOnClick() {
  console.log("See full details is clicked...")
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

function listenForNewHouseFormClick(){
  $('button#ajax-new-house').on('click', function(event){
    event.preventDefault()
    let newHouseForm = House.newHouseForm()
    document.querySelector('div#new-house-form-div').innerHTML = newHouseForm
  })
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

  static newHouseForm(){
    return(`
      <br><br>
    <strong>***** New House Form *****</strong>
      <form>
        <label>Name of the house: </label><input id='name' type='text' name='name'></input><br>
        <label>Price Per Night: $</label><input id = 'price_per_night' name='price_per_night' type='text'></input><br>
        <label>City: </label><input id='city' name='city' type='text'></input><br>
        <label>Max # of guests: </label><input id='max_guests' name='max_guests' type='text'></input><br>
        <input type="hidden" id="pets_allowed" name="pets_allowed" value="false">
        <label>Pets Allowed? Yes if checked:</label><input id='pets_allowed' name='pets_allowed' type='checkbox'></input><br>
        <label>Description: </label><input id='description' name='description' type='text'></input><br>
        <label>Amenities: </label><input id='amenities' name='amenities' type='text'></input><br>
        <input type="hidden" id="owner_id" name="owner_id" value=${this.owner_id}/>
        <input type='submit'/>
      </form>
    `)
  }
}



House.prototype.postHTML = function(){
  return(`
    <div>
      <p><strong>The Space:</strong> ${this.description}</p>
      <p><strong>Amenities:</strong> ${this.amenities}</p>
      <p><strong>City:</strong> ${this.city}</p>
      <button id="hide-button-${this.id}">Hide ^</button>
      <button id="details-button-${this.id}">See full details</button>
    </div>
  `)
}
