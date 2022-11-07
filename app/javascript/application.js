// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from '@hotwired/turbo-rails'
import 'popper'
import 'bootstrap'
import 'trix'
import '@rails/actiontext'
import LocalTime from 'local-time'

import 'controllers'

window.Turbo = Turbo

document.addEventListener('turbo:load', () => {
    // Enable popovers
    const popoverTriggerList = document.querySelectorAll(
        '[data-bs-toggle="popover"]',
    )
    const popoverList = [...popoverTriggerList].map(
        popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl),
    )

    // Enable tooltips
    const tooltipTriggerList = document.querySelectorAll(
        '[data-bs-toggle="tooltip"]',
    )
    const tooltipList = [...tooltipTriggerList].map(
        tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl),
    )

    LocalTime.start()
})
