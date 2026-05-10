import { Astal, Gtk, Gdk } from "ags/gtk3"
import app from "ags/gtk3/app"
import { createBinding as bind } from "ags"
import { createPoll } from "ags/time"
import Battery from "gi://AstalBattery"
import Wp from "gi://AstalWp"
import Network from "gi://AstalNetwork"
import Hyprland from "gi://AstalHyprland"
import Tray from "gi://AstalTray"
import Mpris from "gi://AstalMpris"
import Notifd from "gi://AstalNotifd"

function Notifications() {
    const notifd = Notifd.get_default()

    return <box class="Notifications" visible={bind(notifd, "notifications").as(n => n.length > 0)}>
        <label label="󰵚" />
        <label label={bind(notifd, "notifications").as(n => n.length.toString())} />
    </box>
}

function Media() {
    const mpris = Mpris.get_default()

    return <box class="Media">
        {bind(mpris, "players").as(ps => ps[0] ? (
            <box>
                <label label="󰝚" />
                <label label={bind(ps[0], "title").as(t => t || "Unknown")} />
            </box>
        ) : "")}
    </box>
}

function SysTray() {
    const tray = Tray.get_default()

    return <box class="SysTray">
        {bind(tray, "items").as(items => items.map(item => (
            <menubutton
                tooltipMarkup={bind(item, "tooltipMarkup")}
                usePopover={false}
                actionGroup={bind(item, "actionGroup").as(ag => ["dbusmenu", ag])}
                menuModel={bind(item, "menuModel")}>
                <icon gicon={bind(item, "gicon")} />
            </menubutton>
        )))}
    </box>
}

function Workspaces() {
    const hypr = Hyprland.get_default()

    return <box class="Workspaces">
        {bind(hypr, "workspaces").as(wss => wss
            .sort((a, b) => a.id - b.id)
            .map(ws => (
                <button
                    class={bind(hypr, "focusedWorkspace").as(fw =>
                        fw === ws ? "focused" : "")}
                    onClicked={() => ws.focus()}>
                    <label label={ws.id.toString()} />
                </button>
            ))
        )}
    </box>
}

function BatteryLevel() {
    const bat = Battery.get_default()

    return <box class="Battery" visible={bind(bat, "isPresent")}>
        <label label="󰁹" />
        <label label={bind(bat, "percentage").as(p => `${Math.floor(p * 100)}%`)} />
    </box>
}

function Volume() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker

    return <box class="Volume">
        {speaker && <label label="󰕾" />}
        {speaker && <label label={bind(speaker, "volume").as(v => `${Math.floor(v * 100)}%`)} />}
    </box>
}

function Wifi() {
    const { wifi } = Network.get_default()

    return <box class="Wifi" visible={bind(wifi, "enabled")}>
        <label label="󰖩" />
        <label label={bind(wifi, "ssid")} />
    </box>
}

function Launcher() {
    return <button
        class="Launcher"
        onClicked={() => {
            const win = app.get_window("launcher")
            if (win) win.visible = !win.visible
        }}>
        <label label="󰣆" />
    </button>
}

export default function Bar({ monitor }: { monitor: number }) {
    const time = createPoll("", 1000, "date +'%H:%M'")

    return <window
        name={`bar-${monitor}`}
        class="Bar"
        monitor={monitor}
        application={app}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}>
        <centerbox>
            <box halign={Gtk.Align.START} spacing={8}>
                <Launcher />
                <Workspaces />
                <Media />
            </box>
            <box>
                <label class="Time" label={time} />
            </box>
            <box halign={Gtk.Align.END} spacing={12}>
                <Notifications />
                <SysTray />
                <Wifi />
                <Volume />
                <BatteryLevel />
            </box>
        </centerbox>
    </window>
}
