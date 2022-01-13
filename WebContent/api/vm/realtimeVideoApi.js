/**
 * 云台获取token
 * @param data
 * @returns {Promise<*>}
 */
async function getToken() {
    return await axios.post(ctx + "/backstage/vm/realtimeVideo/getToken")
}
