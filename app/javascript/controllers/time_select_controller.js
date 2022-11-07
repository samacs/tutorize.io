import { Controller } from '@hotwired/stimulus'
import { TempusDominus } from '@eonasdan/tempus-dominus'

export default class extends Controller {
    connect = () => {
        new TempusDominus(this.element, {
            display: {
                viewMode: 'clock',
                components: {
                    decades: false,
                    year: false,
                    month: false,
                    date: false,
                    hours: true,
                    minutes: true,
                    seconds: false,
                    useTwentyfourHour: true,
                },
                icons: {
                    time: 'bi bi-clock',
                    up: 'bi bi-arrow-up',
                    down: 'bi bi-arrow-down',
                },
            },
            stepping: 15,
        })
    }
}
