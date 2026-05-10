import { Astal, Gtk, Gdk } from "ags/gtk3"
import astalApp from "ags/gtk3/app"
import { createState } from "ags"
import Apps from "gi://AstalApps"

function AppItem({ app }: { app: Apps.Application }) {
    return <button
        class="AppItem"
        onClicked={() => {
            app.launch()
            astalApp.get_window("launcher")?.hide()
        }}>
        <box spacing={8}>
            <icon icon={app.iconName || ""} />
            <box vertical valign={Gtk.Align.CENTER}>
                <label class="name" label={app.name} halign={Gtk.Align.START} />
                {app.description && <label class="description" label={app.description} halign={Gtk.Align.START} />}
            </box>
        </box>
    </button>
}

export default function Launcher() {
    const apps = new Apps.Apps()
    const [text, setText] = createState("")

    return <window
        name="launcher"
        application={astalApp}
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
        visible={false}
        keymode={Astal.Keymode.EXCLUSIVE}
        onKeyPressEvent={(self, event: Gdk.Event) => {
            if (event.get_keyval()[1] === Gdk.KEY_Escape) {
                self.hide()
            }
        }}>
        <box class="LauncherWindow" vertical>
            <entry
                placeholderText="Search"
                onChanged={(self) => setText(self.text)}
                onActivate={() => {
                    const list = apps.fuzzy_query(text())
                    if (list[0]) {
                        list[0].launch()
                        astalApp.get_window("launcher")?.hide()
                    }
                }}
            />
            <scrollable heightRequest={400}>
                <box vertical>
                    {text((t) => apps.fuzzy_query(t).map(app => (
                        <AppItem app={app} />
                    )))}
                </box>
            </scrollable>
        </box>
    </window>
}
