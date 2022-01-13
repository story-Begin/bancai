/**
 * 设备列表
 * @param data
 * @returns {Promise<*>}
 */
async function getCameraDataPageList(data) {
    return await axios.post(ctx + "/backstage/equipment/camera/cameraDataList", data)
}

/**
 * 设备添加
 * @param data
 * @returns {Promise<*>}
 */
async function saveCameraData(data) {
    return await axios.post(ctx + "/backstage/equipment/camera/save", data)
}

/**
 * 设备修改
 * @param data
 * @returns {Promise<*>}
 */
async function updateCameraData(data) {
    return await axios.post(ctx + "/backstage/equipment/camera/update", data)
}

/**
 * 设备删除
 * @param data
 * @returns {Promise<*>}
 */
async function deleteCameraData(data) {
    return await axios.post(ctx + "/backstage/equipment/camera/delete", data)
}

/**
 * 更新数据
 * @param data
 * @returns {Promise<*>}
 */
async function flashCameraData() {
    return await axios.post(ctx + "/backstage/equipment/camera/flashCameraData")
}


/**
 * 设备、组织分页列表
 * @param data
 * @returns {Promise<*>}
 */
async function getPageDevOrganization(data) {
    return await axios.post(ctx + "/backstage/equipment/camera/pageDevOrganization", data)
}

/**
 * 批量修改设备、组织
 * @param data
 * @returns {Promise<*>}
 */
async function updatePageDevOrganization(data) {
    return await axios.post(ctx + "/backstage/equipment/camera/updateBatch", data)
}

/**
 * 设备类型下拉框
 * @param data
 * @returns {Promise<*>}
 */
async function selectCodeTypeValue() {
    return await axios.get(ctx + "/backstage/equipment/camera/selectDevCodeTypeValue")
}

/**
 * 设备类型状态下拉框
 * @param data
 * @returns {Promise<*>}
 */
async function selectDevStatusCodeTypeValue() {
    return await axios.get(ctx + "/backstage/equipment/camera/selectDevStatusCodeTypeValue")
}



