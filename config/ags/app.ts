import app from "ags/gtk3/app"
import style from "./style.scss"
import Bar from "./widget/Bar"
import Launcher from "./widget/Launcher"

app.start({
    instanceName: "ags",
    css: style.toString(),
    requestHandler(request, res) {
        res("ok")
    },
    main: () => {
        app.add_window(Bar({ monitor: 0 }))
        app.add_window(Launcher())
    },
})
