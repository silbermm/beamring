// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let Hooks = {}
Hooks.ToggleColorMode = {
  mounted() {
    var btn = this.el
    if (btn.id === "dark-mode") {
      if (localStorage.theme === 'dark') {
        btn.classList.add("!bg-violet-400", "!text-black")
      }
    } else if (btn.id === "light-mode") {
      if (localStorage.theme === 'light') {
        btn.classList.add("!bg-violet-400", "!text-black")
      }
    } else {
      if (!localStorage.theme) {
        btn.classList.add("!bg-violet-400", "!text-black")
      }
    }

    btn.addEventListener("click", e => {
      if (btn.id === "dark-mode") {
        localStorage.theme = 'dark'
      } else if (btn.id === "light-mode") {
        localStorage.theme = 'light'
      } else {
        localStorage.removeItem('theme')
      }

      window.location.reload();
    })
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

