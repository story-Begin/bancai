/**
 * 报警列表
 * @param data
 * @returns {Promise<*>}
 */
async function getDeviceAlarmPageList(data) {
    return await axios.post(ctx + '/backstage/cx/deviceAlarm/getPageList', data)
}

/**
 * 新增报警信息
 * @param data
 * @returns {Promise<*>}
 */
async function saveDeviceAlarm(data) {
    return await axios.post(ctx + '/backstage/cx/deviceAlarm/save', data)
}

/**
 * 修改报警信息
 * @param data
 * @returns {Promise<*>}
 */
async function updateDeviceAlarm(data) {
    return await axios.post(ctx + '/backstage/cx/deviceAlarm/update', data)
}

/**
 * 删除报警信息
 * @param data
 * @returns {Promise<*>}
 */
async function deleteDeviceAlarm(data) {
    return await axios.post(ctx + '/backstage/cx/deviceAlarm/delete', data)
}

/**
 * 下载
 */
async function downloadExcel() {
    return await axios.get(ctx + '/backstage/cx/deviceAlarm/downloadsExcelDown',{responseType:'blob'})
}

/**
 * 报警类型下拉列表
 * @param data
 * @returns {Promise<*>}
 */
async function selectCallPoliceType() {
    return await axios.get(ctx + '/backstage/cx/deviceAlarm/selectCallPoliceType')
}

