import { Controller } from '@hotwired/stimulus'
import 'bootstrap'

export default class extends Controller {
    connect = () => {
        this.modal = new bootstrap.Modal(this.element)
        this.modal.show()
    }

    hideBeforeRender = e => {
        if (this.isOpen) {
            e.preventDefault()

            this.element.addEventListener(
                'hidden.bs.modal',
                event.detail.resume,
            )
            this.modal.hide()
        }
    }

    isOpen = () => this.element.classList.contains('show')
}
