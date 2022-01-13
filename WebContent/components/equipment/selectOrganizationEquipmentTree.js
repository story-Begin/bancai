Vue.component('select-check-tree', {
    template: `
<div id="tree">
    <el-tree
            ref="organizationTreeRef"
            style="height: 100%;"
            class="tree"
            lazy
            :show-checkbox="showCheckBox"
            highlight-current
            :load="getOrganizationEquipmentTree"
            node-key="id"
            :props="defaultProps"
            :default-expanded-keys="[0]"
            :default-checked-keys="defaultNodeKeys"
            :default-expand-all="expandAll"
            @check-change="handleCheck"
            @node-click="handleOrganizationTreeClick">
                <span class="custom-tree-node" slot-scope="{ node, data }" style="font-size: 13px;">
                    <span>
                        <i :class="data.icon"></i> {{ data.organizationName }}
                    </span>          
                </span>
            </el-tree>
</div>`,
    props: {
        showCheckBox: {type: Boolean},
        defaultKeys: {type: Array},
        expandAll: {type: Boolean}
    },
    watch: {
        defaultKeys(newVal) {
            this.$refs.organizationTreeRef.setCheckedKeys([])
            this.defaultNodeKeys = newVal
        }
    },
    data: function () {
        return {
            defaultNodeKeys: [],
            defaultProps: {
                label: 'organizationName',
                children: 'children',
                icon: 'nodeType',
                isLeaf: function (data, node) {
                    if (data && data.leaf) {
                        return true
                    }
                    return false
                }
            },

            isInit: false,
            highlight: true,
            defaultExpandedKeys: [0],
            organizationTreeLoading: false,
            queryContent: '',
            rootNode: {
                id: 0,
                organizationName: '马钢（合肥）板材',
                isLeaf: false,
                icon: 'magang-font icon-changfang' // 厂房
            },
            loading: false,
            revertTreeData: []
        }
    },

    methods: {
        /**
         * 机构树
         */
        getOrganizationEquipmentTree(node, resolve) {
            const queryData = {}
            if (node.level == 0) {
                this.getEquipmentCount();
                return resolve([this.rootNode]);
                this.organizationTreeLoading = true
            } else {
                queryData.id = node.data.id;
                queryData.status = node.data.status
            }
            axios.post(ctx + '/backstage/equipment/organization/organizationEquipmentTree', queryData)
                .then(res => {
                    res.data.data.forEach(it => {
                        if (it.deviceType == 1) {
                            if (it.status == 1) {
                                it.icon = "magang-font icon-qiangji" // 枪机
                            } else {
                                it.icon = "magang-font icon-qiangji2" // 离线
                            }
                        } else if (it.deviceType == 2) {
                            if (it.status == 1) {
                                it.icon = "magang-font icon-banqiuji" // 球机
                            } else {
                                it.icon = "magang-font icon-banqiuji2" // 离线
                            }
                        } else if ( it.deviceType == 2) {
                            if (it.status == 1) {
                                it.icon = "magang-font icon-banqiuji" // 球机
                            } else {
                                it.icon = "magang-font icon-banqiuji2" // 离线
                            }
                        }
                    })
                    resolve(res.data.data)
                    this.organizationTreeLoading = false
                }).catch(err => {
                console.log(err)
                this.organizationTreeLoading = false
            })
        },

        /**
         * 统计设备总数
         */
        getEquipmentCount() {
            let formData = new FormData();
            formData.append("id", this.rootNode.id);
            axios.post(ctx + '/backstage/equipment/organization/getCameraDataCount', formData)
                .then(res => {
                    console.log(res)
                    this.rootNode.organizationName = this.rootNode.organizationName
                        + "【" + res.data.data.onLine + "/" + res.data.data.sumOnLine + "】";
                }).catch(err => {
                console.log("设备总数获取异常！")
                console.log(err)
            })
        },

        handleCheck(data, change) {
            let nodes = this.$refs.organizationTreeRef.getCheckedNodes().concat(this.$refs.organizationTreeRef.getHalfCheckedNodes())
            // 过滤出叶子节点数据
            let filterNodes = nodes.filter(node => {
                    return node.deviceType !== undefined && node.deviceType !== null
                }
            )
            this.$emit('checkbox-data', filterNodes)
        },

        handleOrganizationTreeClick(node) {
            this.$emit('organization-equipment-tree-click', node)
        },
    }

});









