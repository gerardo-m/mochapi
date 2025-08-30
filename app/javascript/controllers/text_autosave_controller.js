import {Controller} from "@hotwired/stimulus"

// The idea for this is to "listen" to the code editor and
// update the hidden input field value, once updated it will
// detect when the user stopped typing and make a submition

// const debounce = (func, wait) =>{
//   let timeout;
//   return function executedFunction(...args) {
//       const later = () => {
//           clearTimeout(timeout);
//           func(...args);
//       };
//       clearTimeout(timeout);
//       timeout = setTimeout(later, wait);
//   };
// }

export default class extends Controller {
  static targets = ["text", "hinput"]

  initialize() {
    this.debouncedSubmit = this.debounce(() => {
      if (this.hasHinputTarget){
        const nValue = this.textTarget.textContent;
        this.hinputTarget.value = nValue;
      }
      this.handleTextareaSubmit(this.textTarget);
    }, 1000);
  }

  connect() {
    
  }

  handleTextareaSubmit(textarea) {
    const form = textarea.closest('form');
    if (form) {
      form.requestSubmit();
    }
  }

  debounceSubmit() {
    this.debouncedSubmit();
  }

  debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout);
        func.apply(this, args);
      };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  }
}