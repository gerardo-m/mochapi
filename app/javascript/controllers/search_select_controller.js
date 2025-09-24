import { Controller } from "@hotwired/stimulus"
import "tom-select"

export default class extends Controller {
  connect() {
    new TomSelect(this.element, {
      plugins: [ 'dropdown_input' ],
      sortField: {
        field: "text",
        direction: "asc"
      }
    });
  }
}
