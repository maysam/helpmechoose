import { Controller } from "stimulus"
import { Button } from 'antd'

var i = 1
export default class extends Controller {
  static targets = ["output"]

  hello() {
    this.outputTarget.textContent = "Hello World! " + i++
  }
}
