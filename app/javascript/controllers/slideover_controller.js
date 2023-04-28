import { Controller } from "@hotwired/stimulus";
import { enter, leave } from "el-transition";

// slideover
export default class extends Controller {
  static targets = ["menu", "backdrop", "closeButton", "container", "menuIcon"];

  connect() {
    this.hide();
  }

  show() {
    this.containerTarget.classList.remove("hidden");
    enter(this.backdropTarget);
    enter(this.closeButtonTarget);
    enter(this.menuTarget);
  }

  hide() {
    Promise.all([
      leave(this.backdropTarget),
      leave(this.closeButtonTarget),
      leave(this.menuTarget),
    ]).then(() => {
      this.containerTarget.classList.add("hidden");
      this.menuIconTarget.classList.remove("hidden");
    });
  }
}

