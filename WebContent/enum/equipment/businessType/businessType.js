/**
 *业务类型
 *
 * huang
 * @type {number}
 */
const ONE_Type = 1
const TWO_Type = 2

const BUSINESS_TYPE = [
    {'label': 'ONE_Type', 'value': ONE_Type},
    {'label': 'TWO_Type', 'value': TWO_Type}
]

function getBusinessType() {
    return BUSINESS_TYPE
}

function getBusinessTypeName(type) {
    if (type == ONE_Type) {
        return 'ONE_Type'
    }
    if (type == TWO_Type) {
        return 'TWO_Type'
    }
    return '未知'
}
