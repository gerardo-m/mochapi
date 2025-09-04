import {Controller} from "@hotwired/stimulus"

export default class extends Controller{

  static targets=["source", "list", "curl"]
  static values= {url: String, curlUrl: String}

  initialize() {
    this.debouncedPathEdit = this.debounce(() => {
      this.pathEdited();
    }, 300);
  }

  connect() {
    this.pathEdited();
  }


  pathEdited(){
    let v = this.sourceTarget.value;
    fetch(this.urlValue+"?"+"path="+v)
      .then(response => response.text())
      .then(html => this.listTarget.innerHTML= html);
    fetch(this.curlUrlValue+"?"+"path="+v)
      .then(response => response.text())
      .then(html => this.curlTarget.value=html);
  }

  debounceSubmit() {
    this.debouncedPathEdit();
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