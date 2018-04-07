'use strict'

let filter = document.getElementById("filter")

function updateFilter() {
  let apps = document.getElementsByClassName("app")
  for (var i=0; i<apps.length; i++) {
    let app = apps[i]
    if (fuzzysearch(filter.value, app.dataset.name)) {
      app.dataset.hidden = 'false'
    } else {
      app.dataset.hidden = 'true'
    }
  }
}

document.addEventListener('keydown', (event) => {
  if (event.key === 'Tab' || event.key === 'Shift') {
    return
  } else if (event.key === 'Escape') {
    filter.value = ''
    filter.blur()
  } else {
    filter.focus()
  }
}, false);

document.addEventListener('keyup', (event) => {
  updateFilter()
  if (event.target === filter) {
    return
  }
}, false);
