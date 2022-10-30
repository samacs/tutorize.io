// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import AOS from 'aos'
import 'popper'
import 'bootstrap'
import Swiper from 'swiper'
import PureCounter from '@srexi/purecounterjs'

import 'controllers'

document.addEventListener('turbo:load', () => {
    AOS.init()

    new PureCounter()
})
