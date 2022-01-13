/**
 * 突发事件列表
 * @param data
 * @returns {Promise<*>}
 */
async function getAccidentPageList(data) {
    return await axios.post(ctx + '/cx/accident/queryPageList', data)
}

/**
 * 未审批的突发事件
 * @param data
 * @returns {Promise<*>}
 */
async function querySelfActivity(data) {
    return await axios.post(ctx + '/cx/accident/querySelfActivity', data)
}

/**
 * 突发事件列表
 * @param data
 * @returns {Promise<*>}
 */
async function getAccidentAllPageList(data) {
    return await axios.post(ctx + '/cx/accident/queryAllPageList', data)
}

/**
 * 新增突发事件
 * @param data
 * @returns {Promise<*>}
 */
async function saveAccidentPageList(data) {
    return await axios.post(ctx + '/cx/accident/fileUpload', data)
}

/**
 * 删除突发事件
 * @param data
 * @returns {Promise<*>}
 */
async function deleteAccident(data) {
    return await axios.post(ctx + '/cx/accident/deleteList', data)
}

/**
 * 审批突发事件工作流
 * @param data
 * @returns {Promise<*>}
 */
async function examineActivity(data) {
    return await axios.post(ctx + '/cx/accident/examineActivity', data)
}


