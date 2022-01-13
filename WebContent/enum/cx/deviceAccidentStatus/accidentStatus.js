/**
 * 突发事件处理状态
 *
 * huang
 * @type {string}
 */
const UNTREATED = "0"
const PROCESSED = "1"


const DEVICE_ACCIDENT_STATUS = [
    {'label': '未处理', 'value': UNTREATED},
    {'label': '已处理', 'value': PROCESSED}
]

function getDeviceAccidentStatus() {
    return DEVICE_ACCIDENT_STATUS
}

function getDeviceAccidentStatusName(status) {
    if (status == UNTREATED) {
        return '未处理'
    }
    if (status == PROCESSED) {
        return '已处理'
    }
    return '未知'
}
