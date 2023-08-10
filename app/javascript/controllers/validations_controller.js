import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "email", "errors", "password" ];
  
  validate_email() {
    const regex = /^[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/
    const email = this.emailTarget
    const errors = this.errorsTarget
    
    if (!regex.test(email))
    {
      const error = document.createElement("div")
      
      if (!errors.querySelector(".email_error")) {
        error.classList.add("email_error")
        error.textContent = "Invalid email"
        error.style.fontSize = "14px"
        error.style.color = "#cc241d"
        errors.prepend(error)
      }
    }
  }

  validate_password() {
    const password = this.passwordTarget
    const errors = this.errorsTarget

    const regex = {
      "upper":  /(!=.*[A-Z])/,
      "lower":  /(!=.*[a-z])/,
      "number": /(!=.*[\d])/,
      "special":/(!=.*[@#$%!_])/
    }
    
    const errors_messages = {
      "upper": {
        "class": "missing_upper_error",
        "message": "Password must contain at least 1 upper letter"
      },
      "lower": {
        "class": "missing_lower_error",
        "message": "Password must contain at least 1 lower letter"
      },
      "number": {
        "class": "missing_number_error",
        "message":"Password must contain at least 1 number letter"
      },
      "special": {
        "class": "missing_special_error",
        "message": "Password must contain at least 1 special character (@#$%!_)"
      },
    }

    if (password.value != "")
    {
      for (const [key, value] of Object.entries(regex)) {
        if (!value.test(password.value))
        {
          if (!errors.querySelector(`.${errors_messages[key]["class"]}`)) {
            const error = document.createElement("div")
            error.classList.add(errors_messages[key]["class"])
            error.textContent = errors_messages[key]["message"]
            error.style.fontSize = "14px"
            error.style.color = "#cc241d"
            errors.append(error)
          }
        }
      }
    }
    else
    {
      if (errors.childNodes.length === 1) {
        const error = document.createElement("div")
        error.textContent = "Please enter a password"
        error.style.fontSize = "14px"
        error.style.color = "#cc241d"
        errors.append(error)
      }
    }
  }
}
