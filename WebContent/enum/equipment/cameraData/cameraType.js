/**
 *设备类型
 *
 * huang
 * @type {number}
 */
const BOLT = 0
const HEMISPHERE = 1
const FAST_BALL = 2

const CAMERA_TYPE = [
    {'label': '枪机', 'value': BOLT},
    {'label': '半球', 'value': HEMISPHERE},
    {'label': '快球', 'value': FAST_BALL}
]

function getCameraType() {
    return CAMERA_TYPE;
}

function getCameraTypeName(type) {
    if (type == BOLT) {
        return '枪机'
    }
    if (type == HEMISPHERE) {
        return '半球'
    }
    if (type == HEMISPHERE) {
        return '快球'
    }
    return '未知'
}
