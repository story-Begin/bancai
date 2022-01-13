/**
 * 用户组织分页列表
 */
async function getUserGroupPageList(data) {
    return await axios.post(ctx + "/backstage/pz/userGroupDevice/getUserGroupAllList", data)
}

/**
 *
 */
async function searchDevicePageListByUserGroupId(data) {
    return await axios.post(ctx + "/backstage/pz/userGroupDevice/getDeviceList", data)
}

/**
 * 弹框内用户组列表
 */
async function getUserGroupAllList(data) {
    return await axios.post(ctx + "/backstage/pz/userGroupDevice/getUserGroupAllList", data)
}

/**
 * 新增用户组设备信息
 */
async function saveUserGroup(data) {
    return await axios.post(ctx + "/backstage/pz/userGroupDevice/save", data)
}

/**
 * 删除用户组设备信息
 */
async function deleteUserGroup(data) {
    return await axios.post(ctx + "/backstage/pz/userGroupDevice/delete", data)
}

