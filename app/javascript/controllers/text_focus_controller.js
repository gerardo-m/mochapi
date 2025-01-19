import {Controller} from "@hotwired/stimulus"

export default class extends Controller{

  static targets=["text"]

  connect(){
    this.textTarget.focus();
    this.textTarget.select();
  }
}