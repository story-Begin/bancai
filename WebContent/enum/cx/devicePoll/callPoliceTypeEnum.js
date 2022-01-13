/**
 * 报警类型
 *
 * huang
 * @type {number}
 */
const A_TYPE = "1"
const B_TYPE = "2"
const C_TYPE = "3"
const D_TYPE = "4"
const E_TYPE = "5"


const CALL_POLICE_TYPE = [
    {'label': 'A_TYPE', 'value': A_TYPE},
    {'label': 'B_TYPE', 'value': B_TYPE},
    {'label': 'C_TYPE', 'value': C_TYPE},
    {'label': 'D_TYPE', 'value': D_TYPE},
    {'label': 'E_TYPE', 'value': E_TYPE}
]

function getCallPoliceType() {
    return CALL_POLICE_TYPE
}

function getCallPoliceTypeName(type) {
    if (type == A_TYPE) {
        return 'A_TYPE'
    }
    if (type == B_TYPE) {
        return 'B_TYPE'
    }
    if (type == C_TYPE) {
        return 'C_TYPE'
    }
    if (type == D_TYPE) {
        return 'D_TYPE'
    }
    if (type == E_TYPE) {
        return 'E_TYPE'
    }
    return '未知'
}
