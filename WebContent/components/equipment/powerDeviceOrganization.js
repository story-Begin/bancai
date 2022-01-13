Vue.component('power-organization-equipment-tree', {
    template: `
<div id="tree">
<el-input clearable style="width:90%; padding-left:5%;  margin-top: 10px;" size="mini" 
    placeholder="请输入【名称】进行搜索" v-model="filterText"></el-input>
    <el-tree
        :data="rootNode"
        ref="organizationTreeRef"
        style="height: 100%;"
        class="tree"
        highlight-current
        node-key="id"
        :props="defaultProps"
        :default-expanded-keys="[0]"
        :filter-node-method="filterNode"
        :default-checked-keys="defaultExpandedKeys"
        @node-click="handleOrganizationTreeClick">
         <span class="custom-tree-node" slot-scope="{ node, data }" style="font-size: 13px;">
                    <span>
                        <i :class="data.icon"></i> {{ data.organizationName }}
                    </span>          
                </span>
            </el-tree>
</div>`,
    data: function () {
        return {
            // 树
            defaultProps: {
                label: 'organizationName',
                children: 'children',
                icon: 'nodeType'
            },
            isInit: false,
            highlight: true,
            defaultExpandedKeys: [0],
            organizationTreeLoading: false,
            queryContent: '',
            rootNode: [{
                id: 0,
                organizationName: '马钢（合肥）板材',
                isLeaf: false,
                icon: 'magang-font icon-changfang', //厂房
                children: []
            }],
            loading: false,
            revertTreeData: [],
            filterText: null,
            currentNode: null,
            treeNodeList: [],
            editTreeNodeList: [],
            treeClickCount: 0
        }
    },
    created: function () {
        this.getOrganizationEquipmentTree();
    },
    watch: {
        filterText(val) {
            this.$refs.organizationTreeRef.filter(val);
        }
    },
    methods: {
        /**
         * 机构树
         */
        getOrganizationEquipmentTree() {
            this.getEquipmentCount();
            const queryData = {
                organizationParentId: this.rootNode[0].id
            }
            axios.post(ctx + '/backstage/equipment/organization/powerOrganizationEquipmentTree', queryData)
                .then(res => {
                    this.recursive(res.data.data);
                    this.organizationTreeLoading = false;
                }).catch(err => {
                console.log(err);
                this.organizationTreeLoading = false;
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
            console.log(data)
            this.rootNode[0].children = data;
        },

        /**
         * 统计设备总数
         */
        getEquipmentCount() {
            let formData = new FormData();
            formData.append("id", this.rootNode[0].id);
            axios.post(ctx + '/backstage/equipment/organization/getCameraDataCount', formData)
                .then(res => {
                    this.rootNode[0].organizationName = this.rootNode[0].organizationName
                        + "【" + res.data.data.onLine + "/" + res.data.data.sumOnLine + "】";
                }).catch(err => {
                console.log("设备总数获取异常！")
                console.log(err)
            })
        },

        filterNode(value, data) {
            if (!value) return true;
            return data.organizationName.indexOf(value) !== -1;
        },

        /*initCurrentKey(node) {
            if (!this.isInit) {
                this.isInit = true
                if (node && node.length > 0) {
                    this.$nextTick(() => {
                        this.$refs.organizationTreeRef.setCurrentKey(node[0].id);
                });
                    this.handleOrganizationTreeClick(node)
                }
            }
        },*/


        handleOrganizationTreeClick(node, data) {
            console.log(data)
            this.currentNode = data;
            this.$emit('organization-equipment-tree-click', node);

        }
    }

});









