'use strict'

let filter = document.getElementById("filter-input")
let container = document.getElementById("filter");

function updateFilter() {
  if (filter.value === '') {
    container.classList.remove('filter--active')
  } else {
    container.classList.add('filter--active')
  }

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

let navKeys = ['Tab', 'Shift', 'Enter', 'ArrowUp', 'ArrowDown']

document.addEventListener('keydown', (event) => {
  if (navKeys.includes(event.key)) {
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
