# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'popper', to: 'popper.js', preload: true
pin 'bootstrap', to: 'bootstrap.min.js', preload: true
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.6/src/index.js"
pin "local-time", to: "https://ga.jspm.io/npm:local-time@2.1.0/app/assets/javascripts/local-time.js"
pin "@eonasdan/tempus-dominus", to: "https://ga.jspm.io/npm:@eonasdan/tempus-dominus@6.2.6/dist/js/tempus-dominus.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.6/lib/index.js"
