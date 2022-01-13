Vue.component('select-recursive-check-tree', {
    template: `
<div class="select-tree" v-loading="organizationTreeLoading" >
    <el-tree
            :data="rootNode"
            ref="organizationTreeRef"
            style="height: 100%;"
            class="tree"
            :show-checkbox="showCheckBox"
            highlight-current
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
            this.defaultNode = newVal;
            setTimeout(() => {
                this.defaultNodeKeys = newVal
            }, 3000);

        }
    },
    data: function () {
        return {
            defaultProps: {
                label: 'organizationName',
                children: 'children',
                icon: 'nodeType'
            },

            isInit: false,
            highlight: true,
            defaultExpandedKeys: [0],
            defaultNodeKeys: [],
            defaultNode: [],
            organizationTreeLoading: false,
            queryContent: '',
            rootNode: [{
                id: 0,
                organizationName: '马钢（合肥）板材',
                isLeaf: false,
                icon: 'magang-font icon-changfang',// 厂房
                children: []
            }],
            loading: false,
            revertTreeData: []
        }
    },
    created: function () {
        this.getOrganizationEquipmentTree();
    },
    methods: {

        /**
         * 机构树
         */
        getOrganizationEquipmentTree() {
            const queryData = {
                organizationParentId: this.rootNode[0].id
            }
            if (this.rootNode[0].children.length > 0) {
                return;
            }
            this.organizationTreeLoading = true;
            this.getEquipmentCount();
            axios.post(ctx + '/backstage/equipment/organization/getOrganizationEquipmentAllTree', queryData)
                .then(res => {
                    console.log(res.data.data)
                    this.recursive(res.data.data);
                    setTimeout(() => {
                        this.defaultNodeKeys = this.defaultNode;
                    }, 1000);
                    // this.rootNode[0].children = res.data.data;
                    this.organizationTreeLoading = false
                }).catch(err => {
                console.log(err)
                this.organizationTreeLoading = false
            })
        },

        recursive(data) {
            data.forEach(it => {
                if (it.deviceType === 0) {
                    if (it.status == 1) {
                        it.icon = "magang-font icon-qiangji" // 枪机
                    } else {
                        it.icon = "magang-font icon-qiangji2" // 离线
                    }
                } else if (it.deviceType == 1) {
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
                if (it.children) {
                    this.recursive(it.children)
                }
            });
            this.rootNode[0].children = data;
        },

        /**
         * 统计设备总数
         */
        getEquipmentCount() {
            let formData = new FormData();
            formData.append("id", this.rootNode[0].id);
            axios.post(ctx + '/backstage/equipment/organization/getCameraDataSumNum', formData)
                .then(res => {
                    this.rootNode[0].organizationName = this.rootNode[0].organizationName
                        + "【" + res.data.data.onLine + "/" + res.data.data.sumOnLine + "】";
                }).catch(err => {
                console.log("设备总数获取异常！")
                console.log(err)
            })
        },

        /**
         * 复选框选择
         *
         * @param data
         * @param change
         */
        handleCheck(data, change) {
            let nodes = this.$refs.organizationTreeRef.getCheckedNodes().concat(this.$refs.organizationTreeRef.getHalfCheckedNodes());
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









