/**
 * 报警级别
 *
 * huang
 * @type {number}
 */
const A_GRADE = "1"
const B_GRADE = "2"
const C_GRADE = "3"
const D_GRADE = "4"
const E_GRADE = "5"


const CALL_POLICE_GRADE_TYPE = [
    {'label': 'A_GRADE', 'value': A_GRADE},
    {'label': 'B_GRADE', 'value': B_GRADE},
    {'label': 'C_GRADE', 'value': C_GRADE},
    {'label': 'D_GRADE', 'value': D_GRADE},
    {'label': 'E_GRADE', 'value': E_GRADE}
]

function getCallPoliceGrade() {
    return CALL_POLICE_GRADE_TYPE
}

function getCallPoliceGradeName(type) {
    if (type == A_GRADE) {
        return 'A_GRADE'
    }
    if (type == B_GRADE) {
        return 'B_GRADE'
    }
    if (type == C_GRADE) {
        return 'C_GRADE'
    }
    if (type == D_GRADE) {
        return 'D_GRADE'
    }
    if (type == E_GRADE) {
        return 'E_GRADE'
    }
    return '未知'
}
