import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.classList.add("show")
    
    setTimeout(() => {
      this.element.classList.remove("show")
      this.element.classList.add("hide")
    }, 7700);

    setTimeout(() => {
      this.dismiss();
    }, 10000);
  }

  dismiss() {
    this.element.remove();
  }
}
