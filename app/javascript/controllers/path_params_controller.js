import {Controller} from "@hotwired/stimulus"

export default class extends Controller{

  static targets=["source", "list", "curl"]
  static values= {url: String, curlUrl: String}

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
}