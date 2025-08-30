import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    if (this.hasInputTarget) {
      this.inputTarget.addEventListener('input', this.filterWhitespace.bind(this))
      this.inputTarget.addEventListener('keydown', this.preventWhitespace.bind(this))
    }
  }

  disconnect() {
    if (this.hasInputTarget) {
      this.inputTarget.removeEventListener('input', this.filterWhitespace.bind(this))
      this.inputTarget.removeEventListener('keydown', this.preventWhitespace.bind(this))
    }
  }

  filterWhitespace(event) {
    const input = event.target
    const filteredValue = input.value.replace(/\s/g, '')
    
    if (input.value !== filteredValue) {
      input.value = filteredValue
      // Trigger input event to notify other controllers (like text-autosave)
      input.dispatchEvent(new Event('input', { bubbles: true }))
    }
  }

  preventWhitespace(event) {
    // Prevent space key and other whitespace characters
    if (event.key === ' ' || event.key === 'Tab' ) {
      event.preventDefault()
    }
  }
}
