/**
 * 获取视频通道状态
 * @param data
 * @returns {Promise<void>}
 */
async function getVideoAisleList(data) {
    return await axios.post(ctx + '/maintainService/getVideoAisleList', data)
}

/**
 * 获取录像信息
 * @param data
 * @returns {Promise<void>}
 */
async function getVideoRecordList(data) {
    return await axios.post(ctx + '/maintainService/getVideoRecordList', data)
}

/**
 * 获取磁盘信息
 * @param data
 * @returns {Promise<void>}
 */
async function getDeviceDiskList(data) {
    return await axios.post(ctx + '/maintainService/getDeviceDiskList', data)
}

/**
 * 获取设备状态
 * @param data
 * @returns {Promise<void>}
 */
async function getDeviceStatusList(data) {
    return await axios.post(ctx + '/maintainService/getDeviceStatusList', data)
}

/**
 * 获取设备在离线历史记录
 * @param data
 * @returns {Promise<void>}
 */
async function getDeviceHistoryList() {
    return await axios.post(ctx + '/maintainService/getDeviceHistoryList')
}

/**
 * 获取平台状态
 * @param data
 * @returns {Promise<void>}
 */
async function getPlatformDomainList(data) {
    return await axios.post(ctx + '/maintainService/getPlatformDomainList', data)
}

/**
 * 获取服务状态
 * @param data
 * @returns {Promise<void>}
 */
async function getServerStatusList(data) {
    return await axios.post(ctx + '/maintainService/getServerStatusList', data)
}
