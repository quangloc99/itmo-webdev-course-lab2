export class HiddenForm {
    constructor(url, method='get') {
        this._form = document.createElement('form');
        this._form.method = method;
        this._form.action = url;
    }

    add(dictionary) {
        for (let [key, value] of Object.entries(dictionary)) {
            let elm = document.createElement('input');
            elm.name = key;
            elm.value = value;
            this._form.appendChild(elm);
        }
    }

    send() {
        document.body.appendChild(this._form);
        this._form.submit();
        this._form.remove();
    }
}