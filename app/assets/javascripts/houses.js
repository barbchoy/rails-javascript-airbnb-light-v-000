

  console.log('document is ready ...')
  console.log('houses.js is loaded ...')
  listenForClick()




// function listenForClick(){
//   $('button#post-data').on('click', function(event){
//     event.preventDefault()
//     getPosts()
//   })
// }

function listenForClick(){
  document.getElementById("view").addEventListener("click", function(event){
      event.preventDefault()
      getPosts()
    })
}

function getPosts() {
  $.ajax({
    url: 'http://localhost:3000/houses',
    method: 'get',
    dataType: 'json'
  }).done(function(data){
    console.log("the data is", data)
    debugger
    let myHouse = newHouse(data[0])
    let myPostHTML = myHouse.postHTML()
    document.getElementById('ajax-houses').innerHTML += myHouseHTML
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
  }

  static newHouseForm(){
    return(`
    <strong>New House Form</strong>
      <form>
        <label>Name of the house: </label><input id='name' type='text' name='name'></input><br>
        <label>Price Per Night: $</label><input id = 'price_per_night' name='price_per_night' type='text'></input><br>
        <label>City: </label><input id='city' name='city' type='text'></input><br>
        <label>Max # of guests: </label><input id='max_guests' name='max_guests' type='text'></input><br>
        <input type="hidden" id="pets_allowed" name="pets_allowed" value="false">
        <label>Pets Allowed? Yes if checked:</label><input id='pets_allowed' name='pets_allowed' type='checkbox'></input><br>
        <input type="hidden" id="owner_id" name="owner_id" value=${this.owner_id}/>
        <input type='submit'/>
      </form>
    `)
  }
}

House.prototype.postHTML = function(){
  return(`
    <div>
      <h3>$(this.name)</h3>
      <p>Price Per Night: ${this.price_per_night}</p>
      <p>City: ${this.city}</p>
      <p>Max # of Guests: ${this.max_guests}</p>
      <p>Pets Allowed? ${this.pets_allowed}</p>
  `)
}
