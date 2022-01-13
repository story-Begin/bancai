/**
 * 录像机列表
 * @param data
 * @returns {Promise<*>}
 */
async function getNvrDataPageList(data) {
    return await axios.post(ctx + "/backstage/equipment/nvr/nvrDataList", data)
}

/**
 * 录像机添加
 * @param data
 * @returns {Promise<*>}
 */
async function saveNvrData(data) {
    return await axios.post(ctx + "/backstage/equipment/nvr/save", data)
}

/**
 * 录像机修改
 * @param data
 * @returns {Promise<*>}
 */
async function updateNvrData(data) {
    return await axios.post(ctx + "/backstage/equipment/nvr/update", data)
}

/**
 * 录像机删除
 * @param data
 * @returns {Promise<*>}
 */
async function deleteNvrData(data) {
    return await axios.post(ctx + "/backstage/equipment/nvr/delete", data)
}
