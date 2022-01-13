/**
 *设备管理状态
 *
 * huang
 * @type {number}
 */
const NONE_GROUP = 0
const ALREADY_GROUP = 1

const GROUP_STATUS = [
    {'label': '未分组', 'value': NONE_GROUP},
    {'label': '已分组', 'value': ALREADY_GROUP}
]

function getGroupStatus() {
    return CAMERA_DATA_STATUS
}

function getGroupStatusName(status) {
    if (status == NONE_GROUP) {
        return '是'
    }
    if (status == ALREADY_GROUP) {
        return '否'
    }
    return '未知'
}
