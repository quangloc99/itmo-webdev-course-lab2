export function createValidator({targetSelector, messageSelector, onValidate,
                                    hideMessageOn = [], showMessageClass = 'show', invalidClass = 'invalid'}) {
    const targetElements = Array.from(document.querySelectorAll(targetSelector));
    const messageElements = Array.from(document.querySelectorAll(messageSelector));

    const hide = () => {
        targetElements.forEach(elm => elm.classList.remove(invalidClass));
        messageElements.forEach(elm => elm.classList.remove(showMessageClass));
    };
    const show = () => {
        targetElements.forEach(elm => elm.classList.add(invalidClass));
        messageElements.forEach(elm => elm.classList.add(showMessageClass));
    };

    for (const elm of targetElements) {
        for (const event of hideMessageOn) {
            elm.addEventListener(event, hide);
        }
    }

    return (...arg) => {
        const message = onValidate(targetElements, ...arg);
        if (message) {
            for (const elm of messageElements) {
                elm.innerHTML = message;
            }
            show();
            return false;
        } else {
            hide();
            return true;
        }
    };
}
