import {Controller} from "@hotwired/stimulus"

export default class extends Controller{

  static targets=["dropdown", "button"]

  connect(){
    console.log("toggle dropdown controller connected");
  }

  toggleDropdown(){
    const dropdown = this.dropdownTarget;
    dropdown.classList.toggle('hidden');
    // Close dropdown when clicking outside
    const button = this.buttonTarget;
    document.addEventListener('click', function closeDropdown(e) {
      console.log("closeDropdown", this);
      if (!button.contains(e.target)) {
        dropdown.classList.add('hidden');
        document.removeEventListener('click', closeDropdown);
      }
    });
  }
}