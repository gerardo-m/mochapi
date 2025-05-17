import {Controller} from "@hotwired/stimulus"

// The idea for this is to "listen" to the code editor and
// update the hidden input field value, once updated it will
// detect when the user stopped typing and make a submition

export default class extends Controller{

  static targets=["text", "hinput"]

  initialize(){
    
  }

  connect(){

  }

  handleTextareaSubmit(textarea) {
    const form = textarea.closest('form');
    if (form) {
      form.submit();
    }
  }

  debounceSubmit(){
    const nValue = this.textTarget.textContent;
    this.hinputTarget.value = nValue;
    this.debounce(this.handleTextareaSubmit(this.textTarget), 2000);
  }

  debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
  }
}