export class CoordinatesConverter {
    constructor(maxAreaSize, maxDisplaySize, areaOrigin = {x: 0, y: 0}, displayOrigin = {x: 0, y: 0}) {
        this.maxAreaSize = maxAreaSize;
        this.maxDisplaySize = maxDisplaySize;
        this.areaOrigin = areaOrigin;
        this.displayOrigin = displayOrigin;
    }

    displaySizeToAreaSize(val) {
        return val / this.maxDisplaySize * this.maxAreaSize;
    }

    areaSizeToDisplaySize(val) {
        return val / this.maxAreaSize * this.maxDisplaySize;
    }

    areaCoordinatesToDisplay({x, y}) {
        return {
            x: this.areaSizeToDisplaySize(x - this.areaOrigin.x) + this.displayOrigin.x,
            y: this.areaSizeToDisplaySize(y - this.areaOrigin.y) + this.displayOrigin.y
        }
    }
}