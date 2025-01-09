import {Controller} from "@hotwired/stimulus"

export default class extends Controller{

  static targets=["source", "list"]
  static values= {url: String}

  connect() {
    this.pathEdited();
  }


  pathEdited(){
    let v = this.sourceTarget.value;
    fetch(this.urlValue+"?"+"path="+v)
      .then(response => response.text())
      .then(html => this.listTarget.innerHTML= html);
  }
}