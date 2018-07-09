
const activate = (oni) => {
    oni.input.unbind("<C-P>");
}

module.exports = {
    activate,

    // change configuration values here:
    "oni.useDefaultConfig": false,
    "oni.loadInitVim": true,
    "editor.fontSize": "14px",
    "editor.fontFamily": "Monaco",
    "editor.completions.enabled": true
}
