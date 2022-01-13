/**
 * 轮询配置列表
 * @param data
 * @returns {Promise<*>}
 */
async function getDevicePollPageList(data) {
    return await axios.post(ctx + '/backstage/vm/devicePoll/getPageList', data)
}

/**
 * 轮询配置名称
 * @returns {Promise<*>}
 */
async function getDevicePollNamesList() {
    return await axios.post(ctx + '/backstage/vm/devicePoll/getNamesList')
}

/**
 * 新增轮询配置
 * @param data
 * @returns {Promise<*>}
 */
async function saveDevicePoll(data) {
    return await axios.post(ctx + '/backstage/vm/devicePoll/save', data)
}

/**
 * 修改轮询配置
 * @param data
 * @returns {Promise<*>}
 */
async function updateDevicePoll(data) {
    return await axios.post(ctx + '/backstage/vm/devicePoll/update', data)
}

/**
 * 删除轮询配置
 * @param data
 * @returns {Promise<*>}
 */
async function deleteDevicePoll(data) {
    return await axios.post(ctx + '/backstage/vm/devicePoll/delete', data)
}
