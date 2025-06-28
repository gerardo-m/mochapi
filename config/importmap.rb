# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "codejar-setup", to: "codejar-setup.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "codejar" # @4.2.0
pin "highlight.js" # @11.11.1
pin "tom-select", to: "tom-select.js" # @2.3.0
