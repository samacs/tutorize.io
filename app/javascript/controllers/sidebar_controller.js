import { Controller } from '@hotwired/stimulus'
import { patch } from '@rails/request.js'

export default class extends Controller {
    static values = { settingsUrl: { type: String, default: '/settings' } }
    static targets = ['sidebar', 'menuOpener', 'menuCloser']

    toggle = async e => {
        e.preventDefault()

        this.sidebarTarget.classList.toggle('d-none')
        this.isExpanded = !this.isExpanded
        this.menuOpenerTarget.classList.toggle('d-none')
        this.menuCloserTarget.classList.toggle('d-none')

        await patch(this.settingsUrlValue, {
            body: { preferences: { sidebar_open: this.isExpanded } },
            contentType: 'application/json',
            responseKind: 'json',
        })
    }

    set isExpanded(value) {
        this.sidebarTarget.setAttribute('aria-expanded', value)
    }

    get isExpanded() {
        return (
            this.sidebarTarget.hasAttribute('aria-expanded') &&
            this.sidebarTarget.getAttribute('aria-expanded') !== 'false'
        )
    }
}
