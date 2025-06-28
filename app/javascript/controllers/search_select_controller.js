import { Controller } from "@hotwired/stimulus"
import "tom-select"

export default class extends Controller {
  connect() {
    console.log(this.element);
    console.log("connected");
    new TomSelect(this.element, {
      sortField: {
        field: "text",
        direction: "asc"
      }
    });
  }
}
