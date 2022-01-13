/**
 *业务类型
 *
 * huang
 * @type {number}
 */
const IN_VIDEO = 0
const NO_VIDEO = 1

const STATUS_TYPE = [
    {'label': 'IN_VIDEO', 'value': IN_VIDEO},
    {'label': 'NO_VIDEO', 'value': NO_VIDEO}
]

function RecordStatusType() {
    return STATUS_TYPE
}

function getStatusType(status) {
    if (status == IN_VIDEO) {
        return '正在录像'
    }
    if (status == NO_VIDEO) {
        return '未在录像'
    }
    return '未知'
}
