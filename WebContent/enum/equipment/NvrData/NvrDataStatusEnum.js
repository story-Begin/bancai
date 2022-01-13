/**
 *录像机管理状态
 *
 * xu
 * @type {number}
 */
const PENDING = 1
const PROCESSED = 2

const NVR_DATA_STATUS = [
    {'label': '是', 'value': PENDING},
    {'label': '否', 'value': PROCESSED}
]

function getNvrDataStatus() {
    return NVR_DATA_STATUS
}

function getNvrDataStatusType(status) {
    if (status == PENDING) {
        return '是'
    }
    if (status == PROCESSED) {
        return '否'
    }
    return '未知'
}
