/**
 * 组织机构树
 * @param data
 * @returns {Promise<*>}
 */
async function getOrganizationTreeList(data) {
    return await axios.post(ctx + '/backstage/equipment/organization/organizationTree', data)
}

/**
 * 组织机构列表
 * @param data
 * @returns {Promise<*>}
 */
async function organizationEquipmentTree(data) {
    return await axios.post(ctx + '/backstage/equipment/organization/organizationEquipmentTree', data)
}

/**
 * 组织机构列表
 * @param data
 * @returns {Promise<*>}
 */
async function getOrganizationList(data) {
    return await axios.post(ctx + '/backstage/equipment/organization/getPageList', data)
}


/**
 * 新增组织机构
 * @param data
 * @returns {Promise<*>}
 */
async function saveOrganization(data) {
    return await axios.post(ctx + '/backstage/equipment/organization/save', data)
}

/**
 * 修改组织机构
 * @param data
 * @returns {Promise<*>}
 */
async function updateOrganization(data) {
    return await axios.post(ctx + '/backstage/equipment/organization/update', data)
}

/**
 * 删除组织机构
 * @param data
 * @returns {Promise<*>}
 */
async function deleteOrganization(data) {
    return await axios.post(ctx + '/backstage/equipment/organization/delete', data)
}
