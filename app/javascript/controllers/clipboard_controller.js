import {Controller} from "@hotwired/stimulus"

export default class extends Controller{

  static targets=["source", "button"]

  copy(){
    navigator.clipboard.writeText(this.sourceTarget.value)
    this.buttonTarget.innerText="Copied!"
    setTimeout(() => {
      this.buttonTarget.innerText="Copy"
    }, 3000)
  }
}